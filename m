Return-Path: <SRS0=hNPF=AV=aosc.io=icenowy@kernel.org>
Date: Wed, 20 Sep 2017 16:04:02 +0800
In-Reply-To: <20170920075223.jaeswlhcqgu4yhse@flea.home>
References: <20170914145251.21784-1-icenowy@aosc.io> <20170914145251.21784-2-icenowy@aosc.io> <20170918073336.j7finend3g76chsu@flea.lan> <310CE549-B8CE-4C0C-95B1-B545E38BDAF5@aosc.io> <20170918083045.7bfiialtbm7w6i7j@flea.lan> <e73ead447af89031749e85207cac1e69@aosc.io> <20170920075223.jaeswlhcqgu4yhse@flea.home>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [linux-sunxi] Re: [PATCH v4 1/6] dt-bindings: update the Allwinner GPADC device tree binding for H3
To: maxime.ripard@free-electrons.com,Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Lee Jones <lee.jones@linaro.org>,Rob Herring <robh+dt@kernel.org>,Chen-Yu Tsai <wens@csie.org>,Jonathan Cameron <jic23@kernel.org>,Quentin Schulz <quentin.schulz@free-electrons.com>,devicetree@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-kernel@vger.kernel.org,linux-iio@vger.kernel.org,linux-sunxi@googlegroups.com
From: Icenowy Zheng <icenowy@aosc.io>
Message-ID: <27449039-F0D4-4663-B596-C95D4408D471@aosc.io>
List-ID: <linux-iio@vger.kernel.org>



=E4=BA=8E 2017=E5=B9=B49=E6=9C=8820=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=883=
:52:23, Maxime Ripard <maxime=2Eripard@free-electrons=2Ecom> =E5=86=99=E5=
=88=B0:
>On Mon, Sep 18, 2017 at 03:47:25PM +0000, icenowy@aosc=2Eio wrote:
>> =E5=9C=A8 2017-09-18 16:30=EF=BC=8CMaxime Ripard =E5=86=99=E9=81=93=EF=
=BC=9A
>> > On Mon, Sep 18, 2017 at 03:36:43PM +0800, Icenowy Zheng wrote:
>> > > =E4=BA=8E 2017=E5=B9=B49=E6=9C=8818=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=
=8D=883:33:36, Maxime Ripard
>> > > <maxime=2Eripard@free-electrons=2Ecom> =E5=86=99=E5=88=B0:
>> > > >On Thu, Sep 14, 2017 at 10:52:46PM +0800, Icenowy Zheng wrote:
>> > > >> Allwinner H3 features a thermal sensor like the one in A33,
>but has
>> > > >its
>> > > >> register re-arranged, the clock divider moved to CCU
>(originally the
>> > > >> clock divider is in ADC) and added a pair of bus clock and
>reset=2E
>> > > >>
>> > > >> Update the binding document to cover H3=2E
>> > > >>
>> > > >> Signed-off-by: Icenowy Zheng <icenowy@aosc=2Eio>
>> > > >> Reviewed-by: Chen-Yu Tsai <wens@csie=2Eorg>
>> > > >> ---
>> > > >> Changes in v4:
>> > > >> - Add nvmem calibration data (not yet used by the driver)
>> > > >> Changes in v3:
>> > > >> - Clock name changes=2E
>> > > >> - Example node name changes=2E
>> > > >> - Add interupts (not yet used by the driver)=2E
>> > > >>
>> > > >>  =2E=2E=2E/devicetree/bindings/mfd/sun4i-gpadc=2Etxt        | 30
>> > > >++++++++++++++++++++--
>> > > >>  1 file changed, 28 insertions(+), 2 deletions(-)
>> > > >>
>> > > >> diff --git
>a/Documentation/devicetree/bindings/mfd/sun4i-gpadc=2Etxt
>> > > >b/Documentation/devicetree/bindings/mfd/sun4i-gpadc=2Etxt
>> > > >> index badff3611a98=2E=2E6c470d584bf9 100644
>> > > >> --- a/Documentation/devicetree/bindings/mfd/sun4i-gpadc=2Etxt
>> > > >> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc=2Etxt
>> > > >> @@ -4,12 +4,26 @@ The Allwinner SoCs all have an ADC that can
>also
>> > > >act as a thermal sensor
>> > > >>  and sometimes as a touchscreen controller=2E
>> > > >>
>> > > >>  Required properties:
>> > > >> -  - compatible: "allwinner,sun8i-a33-ths",
>> > > >> +  - compatible: must contain one of the following
>compatibles:
>> > > >> +		- "allwinner,sun8i-a33-ths"
>> > > >> +		- "allwinner,sun8i-h3-ths"
>> > > >>    - reg: mmio address range of the chip,
>> > > >>    - #thermal-sensor-cells: shall be 0,
>> > > >>    - #io-channel-cells: shall be 0,
>> > > >>
>> > > >> -Example:
>> > > >> +Optional properties:
>> > > >> +  - nvmem-cells: A phandle to the calibration data provided
>by a
>> > > >nvmem device=2E
>> > > >> +                 If unspecified default values shall be used=2E
>> > > >> +  - nvmem-cell-names: Should be "calibration-data"
>> > > >
>> > > >I'd prefer to have which sensor it applies to here=2E It wouldn't
>change
>> > > >anything for the H3, but it definitely does for example for the
>A83t
>> > > >that has two sensors, one for each cluster, and one for the GPU,
>each
>> > > >with calibration data=2E
>> > > >
>> > > >What about cluster0-calibration?
>>=20
>> I prefer sensor0-calibration to sensor3-calibration now=2E
>> (Theortically the new generation THS can support up to 4 sensors)
>
>The mapping that explains what sensor0 means can change in the
>future=2E It's better to be explicit here, and just say upfront what
>it's about=2E

I think for some SoC (e=2Eg=2E A64) there's no clear explain on
the functions of the sensors=2E

In addition, in the THS controller the sensors has a
explicit sequence, and when referencing it in the DT
the number is still needed (in thermal zones)=2E

>
>Maxime
