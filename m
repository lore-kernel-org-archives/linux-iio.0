Return-Path: <mark.rutland@arm.com>
Date: Tue, 26 Nov 2013 14:25:34 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Fugang Duan <B38611@freescale.com>
Cc: "jic23@kernel.org" <jic23@kernel.org>,
   "sachin.kamat@linaro.org" <sachin.kamat@linaro.org>,
   "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
   "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
   "b20596@freescale.com" <b20596@freescale.com>,
   "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] iio:adc:imx: add Freescale Vybrid vf610 adc
 driver
Message-ID: <20131126142534.GB5402@e106331-lin.cambridge.arm.com>
References: <1385463394-11157-1-git-send-email-B38611@freescale.com>
 <1385463394-11157-3-git-send-email-B38611@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385463394-11157-3-git-send-email-B38611@freescale.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Nov 26, 2013 at 10:56:33AM +0000, Fugang Duan wrote:
> Add Freescale Vybrid vf610 adc driver. The driver only support
> ADC software trigger.
>
> Signed-off-by: Fugang Duan <B38611@freescale.com>
> ---
>  drivers/iio/adc/Kconfig     |   11 +
>  drivers/iio/adc/Makefile    |    1 +
>  drivers/iio/adc/vf610_adc.c |  744 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 756 insertions(+), 0 deletions(-)

[...]

> +static void vf610_adc_cfg_of_init(struct vf610_adc *info)
> +{
> +       struct device_node *np = info->dev->of_node;
> +
> +       /*
> +        * set default Configuration for ADC controller
> +        * This config may upgrade to require from DT
> +        */
> +       info->adc_feature.clk_sel = ADCIOC_BUSCLK_SET;
> +       info->adc_feature.vol_ref = VF610_ADCIOC_VR_VREF_SET;
> +       info->adc_feature.calibration = true;
> +       info->adc_feature.tri_hw = false;
> +       info->adc_feature.dataov_en = true;
> +       info->adc_feature.ac_clk_en = false;
> +       info->adc_feature.dma_en = false;
> +       info->adc_feature.cc_en = false;
> +       info->adc_feature.cmp_func_en = false;
> +       info->adc_feature.cmp_range_en = false;
> +       info->adc_feature.cmp_greater_en = false;
> +
> +       if (of_property_read_u32(np, "fsl,adc-io-pinctl",
> +                       &info->adc_feature.pctl)) {
> +               info->adc_feature.pctl = VF610_ADC_IOPCTL5;
> +               dev_info(info->dev,
> +                       "Miss adc-io-pinctl in dt, enable pin SE5.\n");
> +       }

Could you elaborate on what this means? What is this doing when pinctrl
is not specified in the DT?

> +
> +       if (info->vref)
> +               info->vref_uv = regulator_get_voltage(info->vref);
> +       else if (of_property_read_u32(np, "fsl,adc-vref", &info->vref_uv))
> +               dev_err(info->dev,
> +                       "Miss adc-vref property or vref regulator in the DT.\n");

Query the regulator instead.

> +
> +       if (of_property_read_u32(np, "fsl,adc-clk-div",
> +                       &info->adc_feature.clk_div_num)) {
> +               info->adc_feature.clk_div_num = 2;
> +               dev_info(info->dev,
> +                       "Miss adc-clk-div in dt, set divider to 2.\n");
> +       }

Why do you need this?

I'd expect the use to request a frequency they wanted to sample at, and
the driver would try its best by fiddling with this and the clock input.

> +
> +       if (of_property_read_u32(np, "fsl,adc-res",
> +                       &info->adc_feature.res_mode)) {
> +               info->adc_feature.res_mode = 12;
> +               dev_info(info->dev,
> +                       "Miss adc-res property in dt, use 8bit mode.\n");

This message does not seem to match the code above it.

Is this a hardware limitation in some instances? Or is it always
possible to select any of the resolutions?

> +
> +       if (of_property_read_u32(np, "fsl,adc-sam-time",
> +                       &info->adc_feature.sam_time)) {
> +               info->adc_feature.sam_time = 4;
> +               dev_info(info->dev,
> +                       "Miss adc-sam-time property in dt, set to 4.\n");
> +       }

This looks like it should be handled at runtime.

> +
> +       info->adc_feature.hw_average = of_property_read_bool(np,
> +                                       "fsl,adc-hw-aver-en");

Is hw average support not always present?

> +       if (info->adc_feature.hw_average &&
> +                of_property_read_u32(np, "fsl,adc-aver-sam-sel",
> +                               &info->adc_feature.hw_sam)) {
> +               info->adc_feature.hw_sam = 4;
> +               dev_info(info->dev,
> +                       "Miss adc-aver-sam-sel property in dt, set to 4.\n");
> +       }

Why not configure this at runtime instead?

> +
> +       info->adc_feature.lpm = of_property_read_bool(np, "fsl,adc-low-power-mode");
> +       info->adc_feature.hs_oper = of_property_read_bool(np, "fsl,adc-high-speed-conv");

Please elaborate on what these mean, and why they need to be in the DT.

Thanks,
Mark.
