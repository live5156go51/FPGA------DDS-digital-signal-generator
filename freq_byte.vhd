-------------------------------------------------------------------------------
-- Title      : 频率控制字输入 f++  f--
-- Project    : 
-------------------------------------------------------------------------------
-- File       : freq_byte.vhd
-- Author     :   <junstrix@gmail.com>
-- Company    : 
-- Created    : 2010-09-09
-- Last update: 2011-09-19
-- Platform   : 
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2010 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author                  Description
-- 2010-09-09  1.0      Yuweijia Lijunpeng       Created
-------------------------------------------------------------------------------
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.STD_LOGIC_ARITH.all;

entity freq_byte is
  port (
    clr       : in  std_logic;
    clk       : in  std_logic;
    -------------------------------------------
    MODE_sel  : in  std_logic_vector (1 downto 0);  --V or F or T-->MODE_sel<1><0>sw3/sw2 = p20/p26 ->to top!
    t_sel_out : out std_logic_vector (4 downto 0);
    t_sel_led : out std_logic_vector(13 downto 0);

    am_wave_fix_Q : out std_logic_vector(10 downto 0);
    -------------------------------------------
    bn1           : in  std_logic;
    bn2           : in  std_logic;
    bn3           : in  std_logic;
    bn4           : in  std_logic;
    dout_led      : out std_logic_vector(13 downto 0);
    dout_dds      : out std_logic_vector(23 downto 0);
    am_dout_led   : out std_logic_vector(13 downto 0);
    am_dout_dds   : out std_logic_vector(7 downto 0);

    dp_sel : out std_logic_vector(1 downto 0)
    );
end freq_byte;

architecture behav_freq_byte of freq_byte is
  constant c_DIS_5v  : std_logic_vector := "00000000110010";  -- 电压显示:5.0
  constant c_DIS_1v  : std_logic_vector := "00000000001010";  -- 电压显示:1.0
  constant c_DIS_02v : std_logic_vector := "00000000000010";  -- 电压显示:0.2

  constant c_CNT_5V : std_logic_vector := "11100001";  --电压调整终值:225
  constant c_CNT_1v : std_logic_vector := "00101101";  --电压调整初值:45

  constant c_AM_FIX_START : std_logic_vector := "10000000000";  --1024
  constant c_AM_FIX_SIGMA : std_logic_vector := "00001100110";  --102

-------------------------------------------------------------------------------
--  signal count          : integer range 0 to 11000       := 10;
  signal count      : integer range 0 to 220000     := 1;  --频率值1~200kHz
  signal int_to_slv : std_logic_vector(23 downto 0);       -- 数据转换
  signal cnt_tmp    : std_logic_vector(13 downto 0) := "00000000000001";  -- 调频率显示01.
--------------------------------------------------------------------------

  signal count_am       : std_logic_vector(7 downto 0)  := c_CNT_5V;  --tiao ya -> 217
  signal am_led_cnt_tmp : std_logic_vector(13 downto 0) := c_DIS_5v;  -- 调幅显示5.0

  signal am_modify_po : std_logic_vector(3 downto 0) := "0000";  -----电压修正标志！！勿改！！
  signal am_modify_ne : std_logic_vector(3 downto 0) := "0000";  -----电压修正标志！！勿改！！

  signal am_wave_fix_Q_tmp : std_logic_vector(10 downto 0) := c_AM_FIX_START;  --1024

--------------------------------------------------------------------------
  signal count_t   : std_logic_vector(4 downto 0)  := "01011";  --占空比初值50%(11级)，级别为 1~20
  signal t_cnt_tmp : std_logic_vector(13 downto 0) := "00000000110010";  -- 调方波t显示50.
-------------------------------------------------------------------------------

  signal dp_tmp : std_logic_vector(1 downto 0);  --tiao zheng xiao shu dian
  
begin  -- behav_freq_byte

-----------------------------------------------------------------------------------------------------------------
------------------------------------------------------WHEN SW3&SW2='00' ------->tiao pin lv  !!!!!!!!!!
  process (clr, clk)
  begin
    if clr = '1' then
--        count <= 10;--10Hz时修正值11,不一定对
      count   <= 1;
      cnt_tmp <= "00000000000001";      --CLEAR, DISPLAY "10."
    else
      if rising_edge(clk) then
        ---------------------------------
        if (MODE_sel = "00") then
          if (bn1 = '0') then
                                        --若频率低于9999则可加1
            if (count < 9999) then
              count   <= count + 1;
              cnt_tmp <= cnt_tmp + 1;
            else null;
            end if;
          elsif (bn2 = '0') then
                                        --若频率高于1则可减1
            if (count > 1) then
              count   <= count - 1;
              cnt_tmp <= cnt_tmp - 1;
            else null;
            end if;
          elsif (bn3 = '0') then
                                        --若频率低于9900则可加100
            if (count < 9900) then
              count   <= count + 100;
              cnt_tmp <= cnt_tmp + 100;
            else null;
            end if;
          elsif (bn4 = '0') then
                                        --若频率高于100则可减100
            if (count > 100) then
              count   <= count - 100;
              cnt_tmp <= cnt_tmp - 100;
            else null;
            end if;
          end if;
        else null;
        end if;
        ---------------------------------
      else null;
      end if;
    end if;
  end process;
-----------------------------------------------------------------------------------------------------------------
--------------------------------------------- WHEN SW3&SW2='01' ------->tiao dian ya  !!!!!!!!!!
  process(clk, clr)
  begin
    if clr = '1' then                   --CLEAR, DISPLAY "5.0"
      am_led_cnt_tmp    <= c_DIS_5v;
      count_am          <= c_CNT_5V;
      am_wave_fix_Q_tmp <= c_AM_FIX_START;
    else
      if rising_edge(clk) then
        if (MODE_sel = "10" or MODE_sel = "11") then
          --------------------------------
          if (bn1 = '0') then           -- bn1:+
            if (am_led_cnt_tmp < c_DIS_1v) then     ---------小于等于1.0V时调整波形表!!
              am_led_cnt_tmp    <= am_led_cnt_tmp + X"1";
              am_wave_fix_Q_tmp <= am_wave_fix_Q_tmp + c_AM_FIX_SIGMA;  --FIX WAVE ROM with Q=25!!
            elsif (am_led_cnt_tmp < c_DIS_5v) then  -------否则小于5V时可以微??+0.1V
              am_modify_po   <= am_modify_po+"0001";
              count_am       <= count_am + X"05";   --xi tiao: 5 = 0.11V
              am_led_cnt_tmp <= am_led_cnt_tmp + X"1";  --xian shi +01
              if am_modify_po = "0011" then  ------------------------------
                count_am     <= count_am + X"03";   ------每步进4次中补偿一次！
                am_modify_po <= "0000";
              end if;  --------------------------------------------------
            end if;
          elsif (bn2 = '0') then        -- bn2:-
            if (am_led_cnt_tmp > c_DIS_1v) then     --大于1V时可以微调-0.1V
              am_modify_ne   <= am_modify_ne + "0001";
              count_am       <= count_am - X"05";
              am_led_cnt_tmp <= am_led_cnt_tmp - X"1";
              if am_modify_ne = "0011" then  --------------------------------
                count_am     <= count_am - X"03";   ------每步进4次中补偿一次！
                am_modify_ne <= "0000";
              end if;  ----------------------------------------------------
            elsif (am_led_cnt_tmp > c_DIS_02v) then     --否则大于0.2V时调整波形表！！
              am_led_cnt_tmp    <= am_led_cnt_tmp - X"1";
              am_wave_fix_Q_tmp <= am_wave_fix_Q_tmp - c_AM_FIX_SIGMA;  --FIX WAVE ROM with Q=25!!
            end if;

          elsif (bn3 = '0') then
            count_am          <= c_CNT_1v;  --重设电压:1V --> 级数37
            am_led_cnt_tmp    <= c_DIS_1v;
            am_wave_fix_Q_tmp <= c_AM_FIX_START;
          elsif (bn4 = '0') then
            count_am          <= c_CNT_5V;  --重设电压:5.01V --> 级数217
            am_led_cnt_tmp    <= c_DIS_5V;
            am_wave_fix_Q_tmp <= c_AM_FIX_START;
          end if;
          --------------------------------
        else null;
        end if;
      else null;
      end if;
    end if;
  end process;

-----------------------------------------------------------------------------------------------------------------
---------------------------------------------WHEN SW2&SW3='10'------>TIAO ZHAN KONG BI!!!
  process(clk, clr)
  begin  -- process btn1
    if clr = '1' then
      count_t   <= "01011";             --fang bo t=50% !!
      t_cnt_tmp <= "00000000110010";    --CLEAR, DISPLAY "50."
    else
      if rising_edge(clk) then
        
        if (MODE_sel = "01") then
                                               --------------------------------
          if (bn1 = '0') then
            if (count_t < "10101") then        --count_t<21 ==> do it!!
              count_t   <= count_t + 1;        --细调5%
              t_cnt_tmp <= t_cnt_tmp + X"5";
            else null;
            end if;
          elsif (bn2 = '0') then
            if (count_t > "00001") then        --count_t>1 ==> do it!!
              count_t   <= count_t - 1;
              t_cnt_tmp <= t_cnt_tmp - X"5";
            else null;
            end if;
          elsif (bn3 = '0') then
            if (count_t < "10001") then        --count_t<17 ==> do it!!
              count_t   <= count_t + 4;
              t_cnt_tmp <= t_cnt_tmp + X"14";  --粗调20%
            else null;
            end if;
          elsif (bn4 = '0') then
            if (count_t > "00101") then        --count_t>5 ==> do it!!
              count_t   <= count_t - 4;
              t_cnt_tmp <= t_cnt_tmp - X"14";
            else null;
            end if;
          end if;
                                               -------------------------------
        else null;
        end if;
      else null;
      end if;
    end if;
  end process;

----------------------------------------------------------------
---------------------------------------------调小数点位置！勿改！
  process(clk)
  begin
    if rising_edge(clk) then
      case MODE_sel is
        when "00"   => dp_tmp <= "00";  ----xiao shu dian mie!!
        when "01"   => dp_tmp <= "00";  ----tiao zhan kong bi!!
        when "10"   => dp_tmp <= "01";  ----tiao dian ya!!
        when others => dp_tmp <= "01";  --tiao dian ya!!
      end case;
    else null;
    end if;
  end process;
----------------------------------------------------------------

  dp_sel <= dp_tmp;

  int_to_slv <= CONV_STD_LOGIC_VECTOR(count, 24);
  dout_dds   <= int_to_slv;
  dout_led   <= cnt_tmp;

  am_dout_dds   <= count_am;
  am_dout_led   <= am_led_cnt_tmp;
  am_wave_fix_Q <= am_wave_fix_Q_tmp;

  t_sel_out <= count_t;
  t_sel_led <= t_cnt_tmp;
  
end behav_freq_byte;
