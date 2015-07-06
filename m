Return-Path: <fugang.duan@freescale.com>
From: Duan Andy <fugang.duan@freescale.com>
To: Sanchayan Maity <maitysanchayan@gmail.com>, "jic23@kernel.org"
	<jic23@kernel.org>
CC: "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk"
	<ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org"
	<galak@codeaurora.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stefan@agner.ch" <stefan@agner.ch>
Subject: RE: [PATCH v2 0/2] Implement sample time consideration for Vybrid's
 ADC
Date: Mon, 6 Jul 2015 01:26:30 +0000
Message-ID: <BLUPR03MB37345F397DFF130F8FAFC58F5930@BLUPR03MB373.namprd03.prod.outlook.com>
References: <cover.1435134626.git.maitysanchayan@gmail.com>
In-Reply-To: <cover.1435134626.git.maitysanchayan@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

From: Sanchayan Maity <maitysanchayan@gmail.com> Sent: Wednesday, June 24, =
2015 4:34 PM
> To: jic23@kernel.org
> Cc: shawn.guo@linaro.org; kernel@pengutronix.de; robh+dt@kernel.org;
> pawel.moll@arm.com; mark.rutland@arm.com; ijc+devicetree@hellion.org.uk;
> galak@codeaurora.org; Duan Fugang-B38611; devicetree@vger.kernel.org;
> linux-iio@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; stefan@agner.ch; Sanchayan Maity
> Subject: [PATCH v2 0/2] Implement sample time consideration for Vybrid's
> ADC
>=20
> Hello,
>=20
> This patchset adds a dt binding for specifying sample time for the vybrid
> adc driver and takes this into account for sampling frequency calculation
> and related configuration in the driver.
>=20
> The patchset is based on top of Stefan's patches here
> http://lkml.iu.edu/hypermail/linux/kernel/1505.3/02043.html
>=20
> which got recently applied. Tested with shawn's for-next branch.
>=20
> Changes since v1:
>=20
> Change from a vendor specific fsl,min-sample-time to non vendor specific
> min-sample-time.
>=20
> Version 1 of the patchset can be found here
> http://lkml.iu.edu/hypermail/linux/kernel/1506.1/00026.html
>=20
> - Sanchayan.
>=20
> Sanchayan Maity (2):
>   iio: adc: Determine sampling frequencies by using minimum sample time
>   ARM: dts: vfxxx: Add property for minimum sample time
>=20
>  .../devicetree/bindings/iio/adc/vf610-adc.txt      |  6 ++
>  arch/arm/boot/dts/vfxxx.dtsi                       |  2 +
>  drivers/iio/adc/vf610_adc.c                        | 74
> ++++++++++++++++++++--
>  3 files changed, 78 insertions(+), 4 deletions(-)

The patch set looks fine. Thanks Sanchayan add this new interface for user =
that is more options for user case.

Acked-by: Fugang Duan <B38611@freescale.com>
