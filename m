Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn3nam01on0078.outbound.protection.outlook.com ([104.47.33.78]:61437
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729479AbeIFSSS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Sep 2018 14:18:18 -0400
From: Manish Narani <MNARANI@xilinx.com>
To: Rob Herring <robh@kernel.org>
CC: "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnaud.pouliquen@st.com" <arnaud.pouliquen@st.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "eugen.hristev@microchip.com" <eugen.hristev@microchip.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "freeman.liu@spreadtrum.com" <freeman.liu@spreadtrum.com>,
        "vilhelm.gray@gmail.com" <vilhelm.gray@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "baolin.wang@linaro.org" <baolin.wang@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Srinivas Goud <sgoud@xilinx.com>,
        Anirudha Sarangi <anirudh@xilinx.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] dt-bindings: iio: adc: Add Xilinx AMS binding
 documentation
Date: Thu, 6 Sep 2018 13:42:30 +0000
Message-ID: <DM6PR02MB52274964865A3F7CE1A8889AC1010@DM6PR02MB5227.namprd02.prod.outlook.com>
References: <1535624539-7839-1-git-send-email-manish.narani@xilinx.com>
 <1535624539-7839-2-git-send-email-manish.narani@xilinx.com>
 <5b8e8a6c.1c69fb81.21d7a.5b20@mx.google.com>
In-Reply-To: <5b8e8a6c.1c69fb81.21d7a.5b20@mx.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Rob,

Thanks for the review. Please see my comments inline.

> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Tuesday, September 4, 2018 6:48 AM
> To: Manish Narani <MNARANI@xilinx.com>
>=20
> On Thu, Aug 30, 2018 at 03:52:17PM +0530, Manish Narani wrote:
> > Xilinx AMS have several ADC channels that can be used for measurement
> > of different voltages and temperatures. Document the same in the bindin=
gs.
> >
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > ---
> >  .../devicetree/bindings/iio/adc/xilinx-ams.txt     | 159
> +++++++++++++++++++++
> >  1 file changed, 159 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
> > b/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
> > new file mode 100644
> > index 0000000..8cc96f0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
> > +AMS device tree subnode:
> > +	- compatible: Should be "xlnx,zynqmp-ams-ps" or "xlnx,zynqmp-ams-pl"
> > +	- reg:  Register space for PS or PL
>=20
> Please split each child node into its own section.

Okay. I will update this in v2.

>=20
> > +
> > +Optional properties:
> > +
> > +Following optional property only valid for PL.
>=20
> property or...

It should be node.  I will update this in v2.

>=20
> > +	- xlnx,ext-channels: List of external channels that are connected to =
the
> > +	                     AMS PL module.
> > +
> > +	  The child nodes of this node represent the external channels which
> > +are
>=20
> node?
>=20
> > +	  connected to the AMS Module. If the property is not present
> > +	  no external channels will be assumed to be connected.
> > +
> > +	  Each child node represents one channel and has the following
> > +	  properties:
> > +		Required properties:
> > +			* reg: Pair of pins the channel is connected to.
> > +				0: VP/VN
> > +				1: VUSER0
> > +				2: VUSER1
> > +				3: VUSER3
> > +				4: VUSER4
> > +				5: VAUXP[0]/VAUXN[0]
> > +				6: VAUXP[1]/VAUXN[1]
> > +				...
> > +				20: VAUXP[15]/VAUXN[15]
> > +			  Note each channel number should only be used at
> most
> > +			  once.
> > +		Optional properties:
> > +			* xlnx,bipolar: If set the channel is used in bipolar
> > +			  mode.
> > +
> > +
> > +Example:
> > +	xilinx_ams: ams@ffa50000 {
> > +		compatible =3D "xlnx,zynqmp-ams";
> > +		interrupt-parent =3D <&gic>;
> > +		interrupts =3D <0 56 4>;
> > +		interrupt-names =3D "ams-irq";
> > +		clocks =3D <&clkc 70>;
> > +		reg =3D <0x0 0xffa50000 0x0 0x800>;
> > +		reg-names =3D "ams-base";
> > +		#address-cells =3D <2>;
> > +		#size-cells =3D <2>;
> > +		ranges;
>=20
> There's no need for 64-bits of addresses and sizes here. Use ranges.

Okay.

> > +
> > +		ams_ps: ams_ps@ffa50800 {
> > +			compatible =3D "xlnx,zynqmp-ams-ps";
> > +			reg =3D <0x0 0xffa50800 0x0 0x400>;
> > +		};
> > +
> > +		ams_pl: ams_pl@ffa50c00 {
> > +			compatible =3D "xlnx,zynqmp-ams-pl";
> > +			reg =3D <0x0 0xffa50c00 0x0 0x400>;
> > +			xlnx,ext-channels {
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <0>;
> > +				channel@0 {
> > +					reg =3D <0>;
> > +					xlnx,bipolar;
> > +				};
> > +				channel@1 {
> > +					reg =3D <1>;
> > +				};
> > +				channel@8 {
> > +					reg =3D <8>;
> > +					xlnx,bipolar;
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +AMS Channels Details:
> > +
> > +Sysmon Block	|Channel|			Details
> 			|Measurement
> > +		 Number
> 			 Type
> > +----------------------------------------------------------------------=
-----------------------------
> ------
> > +AMS CTRL	|0	|System PLLs voltage measurement, VCC_PSPLL.
> 		|Voltage
> > +		|1	|Battery voltage measurement, VCC_PSBATT.
> 		|Voltage
> > +		|2	|PL Internal voltage measurement, VCCINT.
> 		|Voltage
> > +		|3	|Block RAM voltage measurement, VCCBRAM.
> 		|Voltage
> > +		|4	|PL Aux voltage measurement, VCCAUX.
> 		|Voltage
> > +		|5	|Voltage measurement for six DDR I/O PLLs,
> VCC_PSDDR_PLL.	|Voltage
> > +		|6	|VCC_PSINTFP_DDR voltage measurement.
> 			|Voltage
> > +----------------------------------------------------------------------=
-----------------------------
> ------
> > +PS Sysmon	|7	|LPD temperature measurement.
> 			|Temperature
> > +		|8	|FPD Temperature Measurment (REMOTE).
> 			|Temperature
> > +		|9	|VCC PS LPD voltage measurement (supply1).
> 		|Voltage
> > +		|10	|VCC PS FPD voltage measurement (supply2).
> 		|Voltage
> > +		|11	|PS Aux voltage reference (supply3).
> 		|Voltage
> > +		|12	|DDR I/O VCC voltage measurement.
> 		|Voltage
> > +		|13	|PS IO Bank 503 voltage measurement (supply5).
> 			|Voltage
> > +		|14	|PS IO Bank 500 voltage measurement (supply6).
> 			|Voltage
> > +		|15	|VCCO_PSIO1 voltage measurement.
> 		|Voltage
> > +		|16	|VCCO_PSIO2 voltage measurement.
> 		|Voltage
> > +		|17	|VCC_PS_GTR voltage measurement
> (VPS_MGTRAVCC).			|Voltage
> > +		|18	|VTT_PS_GTR voltage measurement
> (VPS_MGTRAVTT).			|Voltage
> > +		|19	|VCC_PSADC voltage measurement.
> 			|Voltage
> > +----------------------------------------------------------------------=
-----------------------------
> ------
> > +PL Sysmon	|20	|PL Temperature measurement.
> 			|Temperature
> > +		|21	|PL Internal Voltage Voltage measurement, VCCINT.
> 		|Voltage
> > +		|22	|PL Auxiliary Voltage measurement, VCCAUX.
> 		|Voltage
> > +		|23	|ADC Reference P+ Voltage measurement.
> 			|Voltage
> > +		|24	|ADC Reference N- Voltage measurement.
> 			|Voltage
> > +		|25	|PL Block RAM Voltage measurement, VCCBRAM.
> 			|Voltage
> > +		|26	|LPD Internal Voltage measurement, VCC_PSINTLP
> (supply4).	|Voltage
> > +		|27	|FPD Internal Voltage measurement, VCC_PSINTFP
> (supply5).	|Voltage
> > +		|28	|PS Auxiliary Voltage measurement (supply6).
> 		|Voltage
> > +		|29	|PL VCCADC Voltage measurement (vccams).
> 		|Voltage
> > +		|30	|Differencial analog input signal Voltage measurment.
> 		|Voltage
> > +		|31	|VUser0 Voltage measurement (supply7).
> 			|Voltage
> > +		|32	|VUser1 Voltage measurement (supply8).
> 			|Voltage
> > +		|33	|VUser2 Voltage measurement (supply9).
> 			|Voltage
> > +		|34	|VUser3 Voltage measurement (supply10).
> 			|Voltage
> > +		|35	|Auxiliary ch 0 Voltage measurement (VAux0).
> 		|Voltage
> > +		|36	|Auxiliary ch 1 Voltage measurement (VAux1).
> 		|Voltage
> > +		|37	|Auxiliary ch 2 Voltage measurement (VAux2).
> 		|Voltage
> > +		|38	|Auxiliary ch 3 Voltage measurement (VAux3).
> 		|Voltage
> > +		|39	|Auxiliary ch 4 Voltage measurement (VAux4).
> 		|Voltage
> > +		|40	|Auxiliary ch 5 Voltage measurement (VAux5).
> 		|Voltage
> > +		|41	|Auxiliary ch 6 Voltage measurement (VAux6).
> 		|Voltage
> > +		|42	|Auxiliary ch 7 Voltage measurement (VAux7).
> 		|Voltage
> > +		|43	|Auxiliary ch 8 Voltage measurement (VAux8).
> 		|Voltage
> > +		|44	|Auxiliary ch 9 Voltage measurement (VAux9).
> 		|Voltage
> > +		|45	|Auxiliary ch 10 Voltage measurement (VAux10).
> 			|Voltage
> > +		|46	|Auxiliary ch 11 Voltage measurement (VAux11).
> 			|Voltage
> > +		|47	|Auxiliary ch 12 Voltage measurement (VAux12).
> 			|Voltage
> > +		|48	|Auxiliary ch 13 Voltage measurement (VAux13).
> 			|Voltage
> > +		|49	|Auxiliary ch 14 Voltage measurement (VAux14).
> 			|Voltage
> > +		|50	|Auxiliary ch 15 Voltage measurement (VAux15).
> 			|Voltage
> > +---------------------------------------------------------------------
> > +------------------------------------
> > --
> > 2.1.1
> >

Thanks,
Manish Narani
