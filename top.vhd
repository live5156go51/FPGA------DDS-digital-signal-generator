-------------------------------------------------------------------------------
-- Title      : DDS�����ļ�
-- Project    : 
-------------------------------------------------------------------------------
-- File       : top.vhd
-- Author     :   <junstrix@gmail.com>
-- Company    : 
-- Created    : 2010-09-10
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
-- 2010-09-10  1.0      Yuweijia Lijunpeng       Created
-------------------------------------------------------------------------------
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.STD_LOGIC_ARITH.all;

entity top is
  
  port (
    clr : in std_logic;
    clk : in std_logic;

    WAVE     : in std_logic_vector(1 downto 0);  --��������ѡ�񣡣�������
    MODE_SEL : in std_logic_vector(1 downto 0);  --��������ѡ��(��ѹ/Ƶ��/ռ�ձ�)������
    bn1      : in std_logic;
    bn2      : in std_logic;
    bn3      : in std_logic;
    bn4      : in std_logic;

    wave_dout : out std_logic_vector(7 downto 0);
    v_dout    : out std_logic_vector(7 downto 0);

    a_to_g : out std_logic_vector(6 downto 0);
    an     : out std_logic_vector(3 downto 0);
    dp     : out std_logic);

end top;

architecture behav_top of top is
-------------------------------------------------------------------------------
--��Ƶ  
  component clkdiv
    port (
      clk_in    : in  std_logic;
      clk_out   : out std_logic;
      clk_5hz   : out std_logic;
      clk_190hz : out std_logic);
  end component;
-------------------------------------------------------------------------------
--�������� clk=5hz
  component freq_byte
    port (
      clr           : in  std_logic;
      clk           : in  std_logic;
      bn1           : in  std_logic;
      bn2           : in  std_logic;
      bn3           : in  std_logic;
      bn4           : in  std_logic;
      -------------------------------------------
      MODE_sel      : in  std_logic_vector (1 downto 0);  --V or F or T-->MODE_sel<1><0>sw3/sw2 = p20/p26 ->to top!
      t_sel_out     : out std_logic_vector (4 downto 0);  --����ռ�ձ�  (to "wave_top")
      t_sel_led     : out std_logic_vector(13 downto 0);  --����ռ�ձ���ʾ
      am_wave_fix_Q : out std_logic_vector(10 downto 0);  --����0.2V��1V
      -------------------------------------------
      dout_dds      : out std_logic_vector(23 downto 0);  --dao lei jia qi
      dout_led      : out std_logic_vector(13 downto 0);
      am_dout_dds   : out std_logic_vector(7 downto 0);  --dao tiao ya ji cun qi
      am_dout_led   : out std_logic_vector(13 downto 0);

      dp_sel : out std_logic_vector(1 downto 0)  -- dian liang xiao shu dian!!
      );
  end component;
-------------------------------------------------------------------------------
--�������� clk=5hz

--Ƶ����ֵ�Ĵ棡
  component reg
    port (
      clk  : in  std_logic;             --5Hz
      din  : in  std_logic_vector(23 downto 0);
      dout : out std_logic_vector(23 downto 0));
  end component;

--����ռ�ձȼĴ棡
  component Fangbo_t_reg
    port (
      clk  : in  std_logic;             --5Hz
      din  : in  std_logic_vector (4 downto 0);
      dout : out std_logic_vector (4 downto 0)
      );
  end component;

--��ѹ��ֵ�Ĵ棡
  component am_reg
    port (
      clk  : in  std_logic;             --5Hz
      din  : in  std_logic_vector(7 downto 0);
      dout : out std_logic_vector(7 downto 0)
      );
  end component;

  component mux2t
    port (
      t_din    : in  std_logic_vector(13 downto 0);
      v_din    : in  std_logic_vector(13 downto 0);
      f_din    : in  std_logic_vector(13 downto 0);
      MODE_SEL : in  std_logic_vector(1 downto 0);
      dout     : out std_logic_vector(13 downto 0)
      );
  end component;
-------------------------------------------------------------------------------
--��λ�ۼ���  
  component acc
    port (
      clr      : in  std_logic;
      clk      : in  std_logic;
      din      : in  std_logic_vector(23 downto 0);
      din_buff : in  std_logic_vector(23 downto 0);
      dout     : out std_logic_vector(23 downto 0));
  end component;
-------------------------------------------------------------------------------
--����ѡ�񣬲��α�
  component wave_top
    port (
      WAVE_fix_Q : in  std_logic_vector(10 downto 0);  --����0.2V��1V
      t_sel_in   : in  std_logic_vector(4 downto 0);   -- t: 5%~95%
      data_in    : in  std_logic_vector(23 downto 0);
      w_sel      : in  std_logic_vector(1 downto 0);
      data_out   : out std_logic_vector(7 downto 0));
  end component;
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--���� lock_in=5hz  
  component latch
    port (
      lock_in      : in  std_logic;
      cnt_to_latch : in  std_logic_vector(13 downto 0);
      latch_out    : out std_logic_vector(13 downto 0));
  end component;
-------------------------------------------------------------------------------
--����
  component decoder
    port (
      b : in  std_logic_vector(13 downto 0);
      p : out std_logic_vector(16 downto 0));
  end component;
-------------------------------------------------------------------------------
--�������ʾ
  component dpdpdp
    port (dpin  : in  std_logic_vector (1 downto 0);
          clk   : in  std_logic;
          dpout : out std_logic_vector (1 downto 0)
          );
  end component;

  component x7segbc
    port (
      x      : in  std_logic_vector(15 downto 0);
      cclk   : in  std_logic;
      clr    : in  std_logic;
      a_to_g : out std_logic_vector(6 downto 0);
      an     : out std_logic_vector(3 downto 0);
      dp     : out std_logic;
      dp_en  : in  std_logic_vector (1 downto 0)
      );
  end component;
  
--����ת����
--  component b_cov_c
--    port (
--      clk      : in  std_logic;
--      data_in  :     std_logic_vector(23 downto 0);
--      data_out : out std_logic);
--  end component;

    signal clr_tmp : std_logic;
  signal clkdiv_tmp        : std_logic;  -- 16.7MHz
  signal clk_5hz_tmp       : std_logic;  -- 5hz for freq_byte and latch
  signal clk_190hz_tmp     : std_logic;  -- 190hz for led
  -----------------------------------------------------------------------------
  signal MODE_SEL_tmp      : std_logic_vector(1 downto 0);
  signal freq_byte_out_tmp : std_logic_vector(23 downto 0);  -- Ƶ�ʿ����ֳ���

  signal dout_led_tmp : std_logic_vector(13 downto 0);  -- link to latch

  signal f_led_tmp : std_logic_vector(13 downto 0);
  signal v_led_tmp : std_logic_vector(13 downto 0);
  signal t_led_tmp : std_logic_vector(13 downto 0);

  signal am_out_to_amreg_tmp : std_logic_vector(7 downto 0);   --��ѹ �� �Ĵ���
  signal am_wave_fix_Q_tmp   : std_logic_vector(10 downto 0);  --����0.2V��1V

  signal t_sel_out_to_reg : std_logic_vector(4 downto 0);  --��ռ�ձ� �� �Ĵ���
  signal Fangbo_t_reg_tmp : std_logic_vector(4 downto 0);

  signal dp_in_tmp  : std_logic_vector(1 downto 0);  --С����
  signal dp_out_tmp : std_logic_vector(1 downto 0);
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  signal latch_to_bcd_tmp   : std_logic_vector(13 downto 0);  -- link to bcd
  signal decoder_to_led_tmp : std_logic_vector(16 downto 0);  -- link to led
  -----------------------------------------------------------------------------

  signal reg_out_tmp : std_logic_vector(23 downto 0);  -- ��λ�����Ĵ�������
  signal acc_out_tmp : std_logic_vector(23 downto 0);  -- ��λ�ۼ����������
  
  
begin  -- behav_top

  clr_tmp <= clr;

  U1 : clkdiv port map (
    clk_in    => clk,
    clk_out   => clkdiv_tmp,
    clk_5hz   => clk_5hz_tmp,
    clk_190hz => clk_190hz_tmp);
-------------------------------------------------------------------------------
-------------------------
--����ĵ���ģʽѡ��-----
  MODE_SEL_tmp <= MODE_SEL;
-------------------------
-------------------------

  U2 : freq_byte port map (
    clr      => clr_tmp,
    clk      => clk_5hz_tmp,
    bn1      => bn1,
    bn2      => bn2,
    bn3      => bn3,
    bn4      => bn4,
    ---------------
    MODE_sel => MODE_sel_tmp,  --V or F or T-->MODE_sel<1><0>sw3/sw2 = p20/p26 ->to top!

    dout_dds => freq_byte_out_tmp,      --dao lei jia qi
    dout_led => f_led_tmp,

    t_sel_out => t_sel_out_to_reg,      --to Fangbo_t_reg
    t_sel_led => t_led_tmp,

    am_dout_dds   => am_out_to_amreg_tmp,  --dao tiao ya ji cun qi
    am_dout_led   => v_led_tmp,
    am_wave_fix_Q => am_wave_fix_Q_tmp,
    ---------------
    dp_sel        => dp_in_tmp             --dian liang xiao shu dian !!!!
    );

  U3 : reg port map (
    clk  => clk_5hz_tmp,
    din  => freq_byte_out_tmp,
    dout => reg_out_tmp
    );
--����ռ�ձȼĴ棡
  U_treg : Fangbo_t_reg port map (
    din  => t_sel_out_to_reg,
    dout => Fangbo_t_reg_tmp,           --to wave_top
    clk  => clk_5hz_tmp
    );

  U_amreg : am_reg port map (
    clk  => clk_5hz_tmp,                --5Hz
    din  => am_out_to_amreg_tmp,
    dout => v_dout
    );


  U_mux2t : mux2t port map (
    t_din    => t_led_tmp,
    v_din    => v_led_tmp,
    f_din    => f_led_tmp,
    MODE_SEL => MODE_SEL_tmp,
    dout     => dout_led_tmp
    );

  U5 : wave_top port map (
    WAVE_fix_Q => am_wave_fix_Q_tmp,
    t_sel_in   => Fangbo_t_reg_tmp,
    data_in    => acc_out_tmp,
    w_sel      => WAVE,
    data_out   => wave_dout
    ); 

--------------------------------------------------------------------
  
  Ux1 : latch port map (
    lock_in      => clk_5hz_tmp,
    cnt_to_latch => dout_led_tmp,
    latch_out    => latch_to_bcd_tmp
    );

  Ux2 : decoder port map (
    b => latch_to_bcd_tmp,
    p => decoder_to_led_tmp
    );

  
  Ux33 : dpdpdp port map (
    dpin  => dp_in_tmp,
    clk   => clk_5hz_tmp,
    dpout => dp_out_tmp
    );

  Ux3 : x7segbc port map (
    x      => decoder_to_led_tmp(15 downto 0),
    cclk   => clk_190hz_tmp,
    clr    => clr_tmp,
    a_to_g => a_to_g,
    an     => an,
    dp     => dp,
    dp_en  => dp_out_tmp
    );
  -----------------------------------------------------------------------------
  U4 : acc port map (
    clr      => clr_tmp,
    clk      => clkdiv_tmp,
    din      => reg_out_tmp,
    din_buff => acc_out_tmp,
    dout     => acc_out_tmp
    );

end behav_top;
