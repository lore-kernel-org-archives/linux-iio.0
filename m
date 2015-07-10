Return-Path: <shawnguo@kernel.org>
Date: Fri, 10 Jul 2015 16:47:04 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Sanchayan Maity <maitysanchayan@gmail.com>
Cc: jic23@kernel.org, shawn.guo@linaro.org, kernel@pengutronix.de,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	B38611@freescale.com, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stefan@agner.ch
Subject: Re: [PATCH v2 0/2] Implement sample time consideration for Vybrid's
 ADC
Message-ID: <20150710084704.GK23464@tiger>
References: <cover.1435134626.git.maitysanchayan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1435134626.git.maitysanchayan@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jun 24, 2015 at 02:03:39PM +0530, Sanchayan Maity wrote:
> Hello,
> 
> This patchset adds a dt binding for specifying sample time
> for the vybrid adc driver and takes this into account for
> sampling frequency calculation and related configuration in
> the driver.
> 
> The patchset is based on top of Stefan's patches here
> http://lkml.iu.edu/hypermail/linux/kernel/1505.3/02043.html
> 
> which got recently applied. Tested with shawn's for-next
> branch.
> 
> Changes since v1:
> 
> Change from a vendor specific fsl,min-sample-time to non vendor
> specific min-sample-time.

What's the reason for that?  Property without vendor prefix would be
the generic one, which should be defined by generic ADC bindings, not
vf610-adc.txt.

Shawn

> 
> Version 1 of the patchset can be found here
> http://lkml.iu.edu/hypermail/linux/kernel/1506.1/00026.html
> 
> - Sanchayan.
> 
> Sanchayan Maity (2):
>   iio: adc: Determine sampling frequencies by using minimum sample time
>   ARM: dts: vfxxx: Add property for minimum sample time
> 
>  .../devicetree/bindings/iio/adc/vf610-adc.txt      |  6 ++
>  arch/arm/boot/dts/vfxxx.dtsi                       |  2 +
>  drivers/iio/adc/vf610_adc.c                        | 74 ++++++++++++++++++++--
>  3 files changed, 78 insertions(+), 4 deletions(-)
> 
> -- 
> 2.4.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
