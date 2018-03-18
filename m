Return-Path: <SRS0=KREs=GI=gmail.com=john3909@kernel.org>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v2 1/3] staging:iio:meter: Replaces IIO_DEV_ATTR_CH_OFF by
 IIO_DEVICE_ATTR
From: John Syne <john3909@gmail.com>
In-Reply-To: <20180317203037.1093cc11@archlinux>
Date: Sat, 17 Mar 2018 23:11:45 -0700
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 devel@driverdev.osuosl.org,
 Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Hartmut Knaack <knaack.h@gmx.de>,
 daniel.baluta@nxp.com
Message-Id: <A8E3184B-765B-4730-A076-C3FCF487EAE3@gmail.com>
References: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
 <3af0e5a795059a8418cf08ff29f05f8d5e00da9b.1520382753.git.rodrigosiqueiramelo@gmail.com>
 <20180307200730.08ed3c2f@archlinux>
 <20180309003733.aichruo53vqryafg@smtp.gmail.com>
 <20180310151045.4570e85d@archlinux>
 <79D3051B-FF2F-4DD3-AF75-F6A4BAD81838@gmail.com>
 <20180317203037.1093cc11@archlinux>
To: Jonathan Cameron <jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

Here is the complete list of registers for the ADE7878 which I copied =
from the data sheet. I added a column =E2=80=9CIIO Attribute=E2=80=9D =
which I hope follows your IIO ABI. Please make any changes you feel are =
incorrect. BTW, there are several registers that cannot be generalized =
and are used purely for chip configuration. I think we should add a new =
naming convention, namely {register}_{<chip-register-name>}. Also, I see =
in the sys_bus_iio doc
in_accel_x_peak_raw

so shouldn=E2=80=99t the phase be represented as follows:

in_current_A_scale

But for now, I followed your instructions from your reply.

After finalizing this one, I will work on the ADE9000, which as way more =
registers ;-)

Once we can agree on the register naming, I will update the ADE7854 =
driver for Rodrigo, which will go a long way to getting it out of =
staging.

Address	Register	IIO Attribute	R/W	Bit Length	Bit =
Length During Communications	Type	Default Value	Description
0x4380	AIGAIN	in_currentA_scale	R/W	24	32 ZPSE	S	=
0x000000	Phase A current gain adjust.
0x4381	AVGAIN	in_voltageA_scale	R/W	24	32 ZPSE	S	=
0x000000	Phase A voltage gain adjust.
0x4382	BIGAIN	in_currentB_scale	R/W	24	32 ZPSE	S	=
0x000000	Phase B current gain adjust.
0x4383	BVGAIN	in_voltageB_scale	R/W	24	32 ZPSE	S	=
0x000000	Phase B voltage gain adjust.
0x4384	CIGAIN	in_currentC_scale	R/W	24	32 ZPSE	S	=
0x000000	Phase C current gain adjust.
0x4385	CVGAIN	in_voltageC_scale	R/W	24	32 ZPSE	S	=
0x000000	Phase C voltage gain adjust.
0x4386	NIGAIN	in_currentN_scale	R/W	24	32 ZPSE	S	=
0x000000	Neutral current gain adjust (ADE7868 and ADE7878 only).
0x4387	AIRMSOS	in_currentA_rms_offset	R/W	24	32 ZPSE	S	=
0x000000	Phase A current rms offset.
0x4388	AVRMSOS	in_voltageA_rms_offset	R/W	24	32 ZPSE	S	=
0x000000	Phase A voltage rms offset.
0x4389	BIRMSOS	in_currentB_rms_offset	R/W	24	32 ZPSE	S	=
0x000000	Phase B current rms offset.
0x438A	BVRMSOS	in_voltageB_rms_offset	R/W	24	32 ZPSE	S	=
0x000000	Phase B voltage rms offset.
0x438B	CIRMSOS	in_currentC_rms_offset	R/W	24	32 ZPSE	S	=
0x000000	Phase C current rms offset.
0x438C	CVRMSOS	in_voltageC_rms_offset	R/W	24	32 ZPSE	S	=
0x000000	Phase C voltage rms offset.
0x438D	NIRMSOS	in_currentN_rms_offset	R/W	24	32 ZPSE	S	=
0x000000	Neutral current rms offset (ADE7868 and ADE7878 only).
0x438E	AVAGAIN	in_powerapparentA_scale	R/W	24	32 ZPSE	S	=
0x000000	Phase A apparent power gain adjust.
0x438F	BVAGAIN	in_powerapparentB_scale	R/W	24	32 ZPSE	S	=
0x000000	Phase B apparent power gain adjust.
0x4390	CVAGAIN	in_powerapparentC_scale	R/W	24	32 ZPSE	S	=
0x000000	Phase C apparent power gain adjust.
0x4391	AWGAIN	in_powerA_scale	R/W	24	32 ZPSE	S	0x000000	=
Phase A total active power gain adjust.
0x4392	AWATTOS	in_powerA_offset	R/W	24	32 ZPSE	S	=
0x000000	Phase A total active power offset adjust.
0x4393	BWGAIN	in_powerB_scale	R/W	24	32 ZPSE	S	0x000000	=
Phase B total active power gain adjust.
0x4394	BWATTOS	in_powerB_offset	R/W	24	32 ZPSE	S	=
0x000000	Phase B total active power offset adjust.
0x4395	CWGAIN	in_powerC_scale	R/W	24	32 ZPSE	S	0x000000	=
Phase C total active power gain adjust.
0x4396	CWATTOS	in_powerC_offset	R/W	24	32 ZPSE	S	=
0x000000	Phase C total active power offset adjust.
0x4397	AVARGAIN	in_powerreactiveA_scale	R/W	24	32 ZPSE	=
S	0x000000	Phase A total reactive power gain adjust =
(ADE7858, ADE7868, and ADE7878).
0x4398	AVAROS	in_powerreactiveA_offset	R/W	24	32 ZPSE	=
S	0x000000	Phase A total reactive power offset adjust =
(ADE7858, ADE7868, and ADE7878).
0x4399	BVARGAIN	in_powerreactiveB_scale	R/W	24	32 ZPSE	=
S	0x000000	Phase B total reactive power gain adjust =
(ADE7858, ADE7868, and ADE7878).
0x439A	BVAROS	in_powerreactiveB_offset	R/W	24	32 ZPSE	=
S	0x000000	Phase B total reactive power offset adjust =
(ADE7858, ADE7868, and ADE7878).
0x439B	CVARGAIN	in_powerreactiveC_scale	R/W	24	32 ZPSE	=
S	0x000000	Phase C total reactive power gain adjust =
(ADE7858, ADE7868, and ADE7878).
0x439C	CVAROS	in_powerreactiveC_offset	R/W	24	32 ZPSE	=
S	0x000000	Phase C total reactive power offset adjust =
(ADE7858, ADE7868, and ADE7878).
0x439D	AFWGAIN	in_powerA_fundamental_scale	R/W	24	32 ZPSE	=
S	0x000000	Phase A fundamental active power gain adjust. =
Location reserved for ADE7854, ADE7858, and ADE7868.
0x439E	AFWATTOS	in_powerA_fundamental_offset	R/W	24	=
32 ZPSE	S	0x000000	Phase A fundamental active power offset =
adjust. Location reserved for ADE7854, ADE7858, and ADE7868.
0x439F	BFWGAIN	in_powerB_fundamental_scale	R/W	24	32 ZPSE	=
S	0x000000	Phase B fundamental active power gain adjust =
(ADE7878 only).
0x43A0	BFWATTOS	in_powerB_fundamental_offset	R/W	24	=
32 ZPSE	S	0x000000	Phase B fundamental active power offset =
adjust (ADE7878 only).
0x43A1	CFWGAIN	in_powerC_fundamental_scale	R/W	24	32 ZPSE	=
S	0x000000	Phase C fundamental active power gain adjust.
0x43A2	CFWATTOS	in_powerC_fundamental_offset	R/W	24	=
32 ZPSE	S	0x000000	Phase C fundamental active power offset =
adjust (ADE7878 only).
0x43A3	AFVARGAIN	in_powerreactiveA_fundamental_scale	R/W	=
24	32 ZPSE	S	0x000000	Phase A fundamental reactive =
power gain adjust (ADE7878 only).
0x43A4	AFVAROS	in_powerreactiveA_fundamental_offset	R/W	24	=
32 ZPSE	S	0x000000	Phase A fundamental reactive power =
offset adjust (ADE7878 only).
0x43A5	BFVARGAIN	in_powerreactiveB_fundamental_scale	R/W	=
24	32 ZPSE	S	0x000000	Phase B fundamental reactive =
power gain adjust (ADE7878 only).
0x43A6	BFVAROS	in_powerreactiveB_fundamental_offset	R/W	24	=
32 ZPSE	S	0x000000	Phase B fundamental reactive power =
offset adjust (ADE7878 only).
0x43A7	CFVARGAIN	in_powerreactiveC_fundamental_scale	R/W	=
24	32 ZPSE	S	0x000000	Phase C fundamental reactive =
power gain adjust (ADE7878 only).
0x43A8	CFVAROS	in_powerreactiveC_fundamental_offset	R/W	24	=
32 ZPSE	S	0x000000	Phase C fundamental reactive power =
offset adjust (ADE7878 only).
0x43A9	VATHR1	regiister_VATHR1	R/W	24	32 ZP	U	=
0x000000	Most significant 24 bits of VATHR[47:0] threshold used =
in phase apparent power datapath.
0x43AA	VATHR0	register_VATHR0	R/W	24	32 ZP	U	0x000000	=
Less significant 24 bits of VATHR[47:0] threshold used in phase apparent =
power datapath.
0x43AB	WTHR1	register_WTHR1	R/W	24	32 ZP	U	0x000000	=
Most significant 24 bits of WTHR[47:0] threshold used in phase =
total/fundamental active power datapath.
0x43AC	WTHR0	register_WTHR0	R/W	24	32 ZP	U	0x000000	=
Less significant 24 bits of WTHR[47:0] threshold used in phase =
total/fundamental active power datapath.
0x43AD	VARTHR1	register_VARTHR1	R/W	24	32 ZP	U	=
0x000000	Most significant 24 bits of VARTHR[47:0] threshold used =
in phase total/fundamental reactive power datapath (ADE7858, ADE7868, =
and ADE7878).
0x43AE	VARTHR0	register_VARTHR0	R/W	24	32 ZP	U	=
0x000000	Less significant 24 bits of VARTHR[47:0] threshold used =
in phase total/fundamental reactive power datapath (ADE7858, ADE7868, =
and ADE7878).
0x43AF	Reserved		N/A4	N/A4	N/A4	N/A4	0x000000	=
This memory location should be kept at 0x000000 for proper operation.
0x43B0	VANOLOAD	register_VANOLOAD	R/W	24	32 ZPSE	=
S	0x0000000	No load threshold in the apparent power =
datapath.
0x43B1	APNOLOAD	register_APNOLOAD	R/W	24	32 ZPSE	=
S	0x0000000	No load threshold in the total/fundamental =
active power datapath.
0x43B2	VARNOLOAD	register_VARNOLOAD	R/W	24	32 ZPSE	=
S	0x0000000	No load threshold in the total/fundamental =
reactive power datapath. Location reserved for ADE7854.
0x43B3	VLEVEL	register_VLEVEL	R/W	24	32 ZPSE	S	0x000000	=
Register used in the algorithm that computes the fundamental active and =
reactive powers (ADE7878 only).
0x43B4	Reserved		N/A4	N/A4	N/A4	N/A4	0x000000	=
This location should not be written for proper operation.
0x43B5	DICOEFF	register_DICOEFF	R/W	24	32 ZPSE	S	=
0x0000000	Register used in the digital integrator algorithm. If =
the integrator is turned on, it must be set at 0xFF8000. In practice, it =
is transmitted as 0xFFF8000.
0x43B6	HPFDIS	register_HPFDIS	R/W	24	32 ZP	U	0x000000	=
Disables/enables the HPF in the current datapath (see Table 34).
0x43B7	Reserved		N/A4	N/A4	N/A4	N/A4	0x000000	=
This memory location should be kept at 0x000000 for proper operation.
0x43B8	ISUMLVL	register_ISUMLVL	R/W	24	32 ZPSE	S	=
0x000000	Threshold used in comparison between the sum of phase =
currents and the neutral current (ADE7868 and ADE7878 only).
0x43B9 to 0x43BE	Reserved		N/A4	N/A4	N/A4	=
N/A4	0x000000	These memory locations should be kept at =
0x000000 for proper operation.
0x43BF	ISUM	register_ISUM	R	28	32 ZP	S	N/A4	=
Sum of IAWV, IBWV, and ICWV registers (ADE7868 and ADE7878 only).
0x43C0	AIRMS	in_currentA_rms	R	24	32 ZP	S	N/A4	=
Phase A current rms value.
0x43C1	AVRMS	in_voltageA_rms	R	24	32 ZP	S	N/A4	=
Phase A voltage rms value.
0x43C2	BIRMS	in_currentB_rms	R	24	32 ZP	S	N/A4	=
Phase B current rms value.
0x43C3	BVRMS	in_voltageB_rms	R	24	32 ZP	S	N/A4	=
Phase B voltage rms value.
0x43C4	CIRMS	in_currentC_rms	R	24	32 ZP	S	N/A4	=
Phase C current rms value.
0x43C5	CVRMS	in_voltageC_rms	R	24	32 ZP	S	N/A4	=
Phase C voltage rms value.
0x43C6	NIRMS	in_currentN_rms	R	24	32 ZP	S	N/A4	=
Neutral current rms value (ADE7868 and ADE7878 only).
0x43C7 to 0x43FF	Reserved		N/A4	N/A4	N/A4	=
N/A4	N/A4	These memory locations should not be written for proper =
operation.
0xE203	Reserved		R/W	16	16	U	0x0000	=
This memory location should not be written for proper operation.
0xE228	Run	register_Run	R/W	16	16	U	0x0000	=
Run register starts and stops the DSP. See the Digital Signal Processor =
section for more details.
0xE400	AWATTHR	in_energyA_raw	R	32	32	S	=
0x00000000	Phase A total active energy accumulation.
0xE401	BWATTHR	in_energyB_raw	R	32	32	S	=
0x00000000	Phase B total active energy accumulation.
0xE402	CWATTHR	in_energyC_raw	R	32	32	S	=
0x00000000	Phase C total active energy accumulation.
0xE403	AFWATTHR	in_energyA_fundamental_raw	R	32	=
32	S	0x00000000	Phase A fundamental active energy =
accumulation (ADE7878 only).
0xE404	BFWATTHR	in_energyB_fundamental_raw	R	32	=
32	S	0x00000000	Phase B fundamental active energy =
accumulation (ADE7878 only).
0xE405	CFWATTHR	in_energyC_fundamental_raw	R	32	=
32	S	0x00000000	Phase C fundamental active energy =
accumulation (ADE7878 only).
0xE406	AVARHR	in_energyreactiveA_raw	R	32	32	S	=
0x00000000	Phase A total reactive energy accumulation (ADE7858, =
ADE7868, and ADE7878 only).
0xE407	BVARHR	in_energyreactiveB_raw	R	32	32	S	=
0x00000000	Phase B total reactive energy accumulation (ADE7858, =
ADE7868, and ADE7878 only).
0xE408	CVARHR	in_energyreactiveC_raw	R	32	32	S	=
0x00000000	Phase C total reactive energy accumulation (ADE7858, =
ADE7868, and ADE7878 only).
0xE409	AFVARHR	in_energyreactiveA_fundamental_raw	R	32	=
32	S	0x00000000	Phase A fundamental reactive energy =
accumulation (ADE7878 only).
0xE40A	BFVARHR	in_energyreactiveB_fundamental_raw	R	32	=
32	S	0x00000000	Phase B fundamental reactive energy =
accumulation (ADE7878 only).
0xE40B	CFVARHR	in_energyreactiveC_fundamental_raw	R	32	=
32	S	0x00000000	Phase C fundamental reactive energy =
accumulation (ADE7878 only).
0xE40C	AVAHR	in_energyapparentA_raw	R	32	32	S	=
0x00000000	Phase A apparent energy accumulation.
0xE40D	BVAHR	in_energyapparentB_raw	R	32	32	S	=
0x00000000	Phase B apparent energy accumulation.
0xE40E	CVAHR	in_energyapparentC_raw	R	32	32	S	=
0x00000000	Phase C apparent energy accumulation.
0xE500	IPEAK	in_current_peak	R	32	32	U	N/A	=
Current peak register. See Figure 50 and Table 35 for details about its =
composition.
0xE501	VPEAK	in_voltage_peak	R	32	32	U	N/A	=
Voltage peak register. See Figure 50 and Table 36 for details about its =
composition.
0xE502	STATUS0	register_STATUS0	R/W	32	32	U	=
N/A	Interrupt Status Register 0. See Table 37.
0xE503	STATUS1	register_STATUS1	R/W	32	32	U	=
N/A	Interrupt Status Register 1. See Table 38.
0xE504	AIMAV	in_currentA_mav	R	20	32 ZP	U	N/A	=
Phase A current mean absolute value computed during PSM0 and PSM1 modes =
(ADE7868 and ADE7878 only).
0xE505	BIMAV	in_currentB_mav	R	20	32 ZP	U	N/A	=
Phase B current mean absolute value computed during PSM0 and PSM1 modes =
(ADE7868 and ADE7878 only).
0xE506	CIMAV	in_currentC_mav	R	20	32 ZP	U	N/A	=
Phase C current mean absolute value computed during PSM0 and PSM1 modes =
(ADE7868 and ADE7878 only).
0xE507	OILVL	register_OILVL	R/W	24	32 ZP	U	0xFFFFFF	=
Overcurrent threshold.
0xE508	OVLVL	register_OVLVL	R/W	24	32 ZP	U	0xFFFFFF	=
Overvoltage threshold.
0xE509	SAGLVL	register_SAGLVL	R/W	24	32 ZP	U	0x000000	=
Voltage SAG level threshold.
0xE50A	MASK0	register_MASK0	R/W	32	32	U	=
0x00000000	Interrupt Enable Register 0. See Table 39.
0xE50B	MASK1	register_MASK1	R/W	32	32	U	=
0x00000000	Interrupt Enable Register 1. See Table 40.
0xE50C	IAWV	in_currentA_instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of Phase A current.
0xE50D	IBWV	in_currentB_instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of Phase B current.
0xE50E	ICWV	in_currentC_instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of Phase C current.
0xE50F	INWV	in_currentN_instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of neutral current (ADE7868 and =
ADE7878 only).
0xE510	VAWV	in_voltageA_instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of Phase A voltage.
0xE511	VBWV	in_voltageB_instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of Phase B voltage.
0xE512	VCWV	in_voltageC_instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of Phase C voltage.
0xE513	AWATT	in_powerA_instantaneous	R	24	32 SE	S	=
N/A	Instantaneous value of Phase A total active power.
0xE514	BWATT	in_powerB_instantaneous	R	24	32 SE	S	=
N/A	Instantaneous value of Phase B total active power.
0xE515	CWATT	in_powerC_instantaneous	R	24	32 SE	S	=
N/A	Instantaneous value of Phase C total active power.
0xE516	AVAR	in_powerreactiveA_instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of Phase A total reactive power =
(ADE7858, ADE7868, and ADE7878 only).
0xE517	BVAR	in_powerreactiveB_instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of Phase B total reactive power =
(ADE7858, ADE7868, and ADE7878 only).
0xE518	CVAR	in_powerreactiveC_instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of Phase C total reactive power =
(ADE7858, ADE7868, and ADE7878 only).
0xE519	AVA	in_powerapparentA_instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of Phase A apparent power.
0xE51A	BVA	in_powerapparentB_instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of Phase B apparent power.
0xE51B	CVA	in_powerappatentC_instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of Phase C apparent power.
0xE51F	CHECKSUM	register_CHECKSUM	R	32	32	=
U	0x33666787	Checksum verification. See the Checksum Register =
section for details.
0xE520	VNOM	in_voltage_rms_nominal	R/W	24	32 ZP	S	=
0x000000	Nominal phase voltage rms used in the alternative =
computation of the apparent power. When the VNOMxEN bit is set, the =
applied voltage input in the corresponding phase is ignored and all =
corresponding rms voltage instances are replaced by the value in the =
VNOM register.
0xE521 to 0xE52E	Reserved						=
	These addresses should not be written for proper operation.
0xE600	PHSTATUS	in_current_phase_peak	R	16	16	=
U	N/A	Phase peak register. See Table 41.
0xE601	ANGLE0	register_ANGLE0	R	16	16	U	N/A	=
Time Delay 0. See the Time Interval Between Phases section for details.
0xE602	ANGLE1	register_ANGLE1	R	16	16	U	N/A	=
Time Delay 1. See the Time Interval Between Phases section for details.
0xE603	ANGLE2	register_ANGLE2	R	16	16	U	N/A	=
Time Delay 2. See the Time Interval Between Phases section for details.
0xE604 to 0xE606	Reserved						=
	These addresses should not be written for proper operation.
0xE607	PERIOD	register_PERIOD	R	16	16	U	N/A	=
Network line period.
0xE608	PHNOLOAD	register_PHNOLOAD	R	16	16	=
U	N/A	Phase no load register. See Table 42.
0xE609 to 0xE60B	Reserved						=
	These addresses should not be written for proper operation.
0xE60C	LINECYC	register_LINECYC	R/W	16	16	U	=
0xFFFF	Line cycle accumulation mode count.
0xE60D	ZXTOUT	register_ZXTOUT	R/W	16	16	U	0xFFFF	=
Zero-crossing timeout count.
0xE60E	COMPMODE	register_COMPMODE	R/W	16	16	=
U	0x01FF	Computation-mode register. See Table 43.
0xE60F	Gain	register_Gain	R/W	16	16	U	0x0000	=
PGA gains at ADC inputs. See Table 44.
0xE610	CFMODE	register_CFMODE	R/W	16	16	U	0x0E88	=
CFx configuration register. See Table 45.
0xE611	CF1DEN	register_CF1DEN	R/W	16	16	U	0x0000	=
CF1 denominator.
0xE612	CF2DEN	register_CF2DEN	R/W	16	16	U	0x0000	=
CF2 denominator.
0xE613	CF3DEN	register_CF3DEN	R/W	16	16	U	0x0000	=
CF3 denominator.
0xE614	APHCAL	register_APHCAL	R/W	10	16 ZP	S	0x0000	=
Phase calibration of Phase A. See Table 46.
0xE615	BPHCAL	register_BPHCAL	R/W	10	16 ZP	S	0x0000	=
Phase calibration of Phase B. See Table 46.
0xE616	CPHCAL	register__CPHCAL	R/W	10	16 ZP	S	=
0x0000	Phase calibration of Phase C. See Table 46.
0xE617	PHSIGN	register_PHSIGN	R	16	16	U	N/A	=
Power sign register. See Table 47.
0xE618	CONFIG	register_CONFIG	R/W	16	16	U	0x0000	=
ADE7878 configuration register. See Table 48.
0xE700	MMODE	register__MMODE	R/W	8	8	U	0x1C	=
Measurement mode register. See Table 49.
0xE701	ACCMODE	register__ACCMODE	R/W	8	8	U	=
0x00	Accumulation mode register. See Table 50.
0xE702	LCYCMODE	register_LCYCMODE	R/W	8	8	=
U	0x78	Line accumulation mode behavior. See Table 52.
0xE703	PEAKCYC	register_PEAKCYC	R/W	8	8	U	=
0x00	Peak detection half line cycles.
0xE704	SAGCYC	register_SAGCYC	R/W	8	8	U	0x00	=
SAG detection half line cycles.
0xE705	CFCYC	register_CFCYC	R/W	8	8	U	0x01	=
Number of CF pulses between two consecutive energy latches. See the =
Synchronizing Energy Registers with CFx Outputs section.
0xE706	HSDC_CFG	register_HSDC_CFG	R/W	8	8	=
U	0x00	HSDC configuration register. See Table 53.
0xE707	Version	register_Version	R	8	8	U		=
Version of die.
0xEBFF	Reserved			8	8			=
This address can be used in manipulating the SS/HSA pin when SPI is =
chosen as the active port. See the Serial Interfaces section for =
details.
0xEC00	LPOILVL	register_LPOILVL	R/W	8	8	U	=
0x07	"Overcurrent threshold used during PSM2 mode (ADE7868 and =
ADE7878
only). See Table 54 in which the register is detailed."
0xEC01	CONFIG2	register_CONFIG2	R/W	8	8	U	=
0x00	Configuration register used during PSM1 mode. See Table 55.

Regards,
John





> On Mar 17, 2018, at 1:30 PM, Jonathan Cameron <jic23@kernel.org> =
wrote:
>=20
> On Wed, 14 Mar 2018 23:12:02 -0700
> John Syne <john3909@gmail.com> wrote:
>=20
>> Hi Jonathan,
>>=20
>> I have been looking at the IIO ABI docs and if I understand
>> correctly, the idea is to use consistent naming conventions? So for
>> example, looking at the ADE7854 datasheet, the naming matching the
>> ADE7854 registers would be as follows:
>=20
> Welcome to one of the big reasons no one tidied these drivers
> up originally.  Still we have moved on somewhat since then
> so similar circumstances have come up in other types of sensor.
>=20
>>=20
>> {direction}_{type}_{index}_{modifier}_{info_mask}
>>=20
>> AIGAIN	-	In_current_a_gain
> Other than the fact that gain isn't an ABI element and that index
> doesn't have
> _ before it that is right.
> in_voltageA_scale
>=20
> That was a weird quirk a long time back which we should probably
> not have done (copied it from hwmon)
>=20
>> AVGAIN	-	in_voltage_a_gain
>> BIGAIN	-	in_current_b_gain
>> BVGAIN	-	in_voltage_b_gain
>> =E2=80=94
>> How do we represent the rms and offset
>> AIRMSOS	-	in_current_a_rmsoffset
>> AVRMSOS	-	in_voltage_a_rmsoffset
>=20
> Right now we can't unfortunately though this one is easier to fix.
> We already have modifiers for multi axis devices doing sum_squared
> so add one of those for root_mean_square - this one is well known
> enough that rms is fine in the string.
>=20
> It's a effectively a different channel be it one derived from a simple
> one.  This is going to get tricky however as we would normally use
> modifier to specialise a channel type - thoughts on this below.
>=20
>> =E2=80=94
>> Here I don=E2=80=99t understand how to represent both the phase and =
the active/reactive/apparent power components. Do we combine the phase =
and quadrature part like this
>> AVAGAIN		-	in_power_a_gain				=
/* apparent power */
>> =E2=80=94
>> AWGAIN		-	in_power_ai_gain				=
/* active power */
> And that is the problem.  How do we represent the various power types.
> Hmm. We could do it with modifiers but above we show that we have =
already used them.
>=20
> It would be easy enough to add yet another field to the channel spec =
to specify
> this but there is a problem - Events.  The event format is already =
pretty full
> so where do we put this extra element if we need to define a channel =
separated
> only by it.
>=20
> One thought is we could instead define these as different top level
> IIO_CHAN_TYPES in a similar fashion to we do for relative humidity vs
> the proposed absolute humidity.
>=20
> in_powerreactiveA_scale
> in_poweractivceA_scale
> (or in_powerrealA_scale to match with what I got taught years ago?)
>=20
> I presume we keep in_powerA_scale etc for the apparent power and
> modify any docs to make that clear.
>=20
>> =E2=80=94
>> AVARGAIN	-	in_power_aq_gain				=
/* reactive power */
>> =E2=80=94
>> Now here it becomes more complicated. Not sure how this gets handled.=20=

>> AFWATTOS	-	in_power_a_active/fundamental/offset
> Yeah, some of these are getting odd.
> If I read this correctly this is the active power estimate based on =
only
> the fundamental frequency - so no harmonics?
>=20
> Hmm.  This then becomes a separate channel with additional properties
> specifying it is only the fundamental.  This feels a bit like a filter
> be it an unusual one?  Might just be necessary to add a =
_fundamental_only
> element on the end (would be info_mask if this is common enough to
> justify that rather than using the extended methods to define it.).
>=20
>=20
>> =E2=80=94
>> AWATTHR	-	in_energy_ai_accumulation
> Great, just when I thought we had gone far enough they define reactive
> energy which is presumably roughly the same as reactivepower * time?
> In that case we need types for that as well.
> in_energyreactiveA_*
> in_energyactiveA_*
>=20
>> =E2=80=94
>> AVARHR		-	in_energy_aq_accumulation
>> =E2=80=94
>> IPEAK		-	in_current_peak
> That one is easy as we have an info_mask element for peak and one
> for peak_scale that has always been a bit odd but was needed =
somewhere.
>=20
>> =E2=80=94
>>=20
>> I=E2=80=99ll leave it there, because there are some even more =
complicated register naming issues.
> Something to look forward to.  Gah, I always hated power engineering
> though I taught it very briefly (I really pity those students :(
>=20
> Jonathan
>=20
>>=20
>> Regards,
>> John
>>=20
>>=20
>>=20
>>=20
>>=20
>>> On Mar 10, 2018, at 7:10 AM, Jonathan Cameron <jic23@kernel.org> =
wrote:
>>>=20
>>> On Thu, 8 Mar 2018 21:37:33 -0300
>>> Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
>>>=20
>>>> On 03/07, Jonathan Cameron wrote: =20
>>>>> On Tue, 6 Mar 2018 21:43:47 -0300
>>>>> Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
>>>>>=20
>>>>>> The macro IIO_DEV_ATTR_CH_OFF is a wrapper for IIO_DEVICE_ATTR, =
with a
>>>>>> tiny change in the name definition. This extra macro does not =
improve
>>>>>> the readability and also creates some checkpatch errors.
>>>>>>=20
>>>>>> This patch fixes the checkpatch.pl errors:
>>>>>>=20
>>>>>> staging/iio/meter/ade7753.c:391: ERROR: Use 4 digit octal (0777) =
not
>>>>>> decimal permissions
>>>>>> staging/iio/meter/ade7753.c:395: ERROR: Use 4 digit octal (0777) =
not
>>>>>> decimal permissions
>>>>>> staging/iio/meter/ade7759.c:331: ERROR: Use 4 digit octal (0777) =
not
>>>>>> decimal permissions
>>>>>> staging/iio/meter/ade7759.c:335: ERROR: Use 4 digit octal (0777) =
not
>>>>>> decimal permissions
>>>>>>=20
>>>>>> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>   =
=20
>>>>>=20
>>>>> Hmm. I wondered a bit about this one. It's a correct patch in of
>>>>> itself but the interface in question doesn't even vaguely conform
>>>>> to any of defined IIO ABI.  Anyhow, it's still and improvement so
>>>>> I'll take it.   =20
>>>>=20
>>>> I am not sure if I understood the comment about the ABI. The meter
>>>> interface is wrong because it uses things like IIO_DEVICE_ATTR? It
>>>> should use iio_info together with *write_raw and *read_raw. Right? =
Is it
>>>> the ABI problem that you refer? =20
>>> The ABI is about the userspace interface of IIO.  It is defined
>>> in Documentation/ABI/testing/sysfs-bus-iio*
>>> So this documents the naming of sysfs attributes and (more or less)
>>> describes a consistent interface to userspace across lots of =
different
>>> types of devices.
>>>=20
>>> A lot of these older drivers in staging involve a good deal of ABI =
that
>>> was not reviewed or discussed.  That is one of the biggest reasons =
we
>>> didn't take them out of staging in the first place.
>>>=20
>>> In order for generic userspace programs to have any idea what to do
>>> with these devices this all needs to be fixed.
>>>=20
>>> There may well be cases where we need to expand the existing ABI to
>>> cover new things.   That's fine, but it has to be done with full
>>> review of the relevant documentation patches.
>>>=20
>>> Incidentally if you want an easy driver to work on moving out of =
staging
>>> then first thing to do is to compare what it shows to userspace with =
these
>>> docs.  If it's totally different then you have a big job on your =
hands
>>> as often ABI can take a lot of discussion and a long time to =
establish
>>> a consensus.
>>>=20
>>> Jonathan
>>>=20
>>>=20
>>>>=20
>>>> Thanks :)
>>>>=20
>>>>> Applied to the togreg branch of iio.git and pushed out as testing
>>>>> for the autobuilders to play with it.
>>>>>=20
>>>>> I also added the removal of the header define which is no
>>>>> longer used.
>>>>>=20
>>>>> Please note, following discussions with Michael, I am going to =
send
>>>>> an email announcing an intent to drop these meter drivers next
>>>>> cycle unless someone can provide testing for any attempt to
>>>>> move them out of staging.  I'm still taking patches on the basis
>>>>> that 'might' happen - but I wouldn't focus on these until we
>>>>> have some certainty on whether they will be around long term!
>>>>>=20
>>>>> Jonathan
>>>>>=20
>>>>>> ---
>>>>>> drivers/staging/iio/meter/ade7753.c | 18 ++++++++++--------
>>>>>> drivers/staging/iio/meter/ade7759.c | 18 ++++++++++--------
>>>>>> 2 files changed, 20 insertions(+), 16 deletions(-)
>>>>>>=20
>>>>>> diff --git a/drivers/staging/iio/meter/ade7753.c =
b/drivers/staging/iio/meter/ade7753.c
>>>>>> index c44eb577dc35..275e8dfff836 100644
>>>>>> --- a/drivers/staging/iio/meter/ade7753.c
>>>>>> +++ b/drivers/staging/iio/meter/ade7753.c
>>>>>> @@ -388,14 +388,16 @@ static IIO_DEV_ATTR_VPERIOD(0444,
>>>>>> 		ade7753_read_16bit,
>>>>>> 		NULL,
>>>>>> 		ADE7753_PERIOD);
>>>>>> -static IIO_DEV_ATTR_CH_OFF(1, 0644,
>>>>>> -		ade7753_read_8bit,
>>>>>> -		ade7753_write_8bit,
>>>>>> -		ADE7753_CH1OS);
>>>>>> -static IIO_DEV_ATTR_CH_OFF(2, 0644,
>>>>>> -		ade7753_read_8bit,
>>>>>> -		ade7753_write_8bit,
>>>>>> -		ADE7753_CH2OS);
>>>>>> +
>>>>>> +static IIO_DEVICE_ATTR(choff_1, 0644,
>>>>>> +			ade7753_read_8bit,
>>>>>> +			ade7753_write_8bit,
>>>>>> +			ADE7753_CH1OS);
>>>>>> +
>>>>>> +static IIO_DEVICE_ATTR(choff_2, 0644,
>>>>>> +			ade7753_read_8bit,
>>>>>> +			ade7753_write_8bit,
>>>>>> +			ADE7753_CH2OS);
>>>>>>=20
>>>>>> static int ade7753_set_irq(struct device *dev, bool enable)
>>>>>> {
>>>>>> diff --git a/drivers/staging/iio/meter/ade7759.c =
b/drivers/staging/iio/meter/ade7759.c
>>>>>> index 1decb2b8afab..c078b770fa53 100644
>>>>>> --- a/drivers/staging/iio/meter/ade7759.c
>>>>>> +++ b/drivers/staging/iio/meter/ade7759.c
>>>>>> @@ -328,14 +328,16 @@ static IIO_DEV_ATTR_ACTIVE_POWER_GAIN(0644,
>>>>>> 		ade7759_read_16bit,
>>>>>> 		ade7759_write_16bit,
>>>>>> 		ADE7759_APGAIN);
>>>>>> -static IIO_DEV_ATTR_CH_OFF(1, 0644,
>>>>>> -		ade7759_read_8bit,
>>>>>> -		ade7759_write_8bit,
>>>>>> -		ADE7759_CH1OS);
>>>>>> -static IIO_DEV_ATTR_CH_OFF(2, 0644,
>>>>>> -		ade7759_read_8bit,
>>>>>> -		ade7759_write_8bit,
>>>>>> -		ADE7759_CH2OS);
>>>>>> +
>>>>>> +static IIO_DEVICE_ATTR(choff_1, 0644,
>>>>>> +			ade7759_read_8bit,
>>>>>> +			ade7759_write_8bit,
>>>>>> +			ADE7759_CH1OS);
>>>>>> +
>>>>>> +static IIO_DEVICE_ATTR(choff_2, 0644,
>>>>>> +			ade7759_read_8bit,
>>>>>> +			ade7759_write_8bit,
>>>>>> +			ADE7759_CH2OS);
>>>>>>=20
>>>>>> static int ade7759_set_irq(struct device *dev, bool enable)
>>>>>> {   =20
>>>>>=20
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe =
linux-iio" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html =20=

>>>=20
>>> _______________________________________________
>>> devel mailing list
>>> devel@linuxdriverproject.org
>>> =
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel =
=20
>>=20
>=20
