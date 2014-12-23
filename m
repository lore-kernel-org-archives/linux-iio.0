Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 2/2] iio: mxs-lradc: check ranges of ts properties
Date: Tue, 23 Dec 2014 14:37:22 +0100
Cc: jic23@kernel.org,
 festevam@gmail.com,
 kristina.martsenko@gmail.com,
 knaack.h@gmx.de,
 kernel@pengutronix.de,
 pawel.moll@arm.com,
 ijc+devicetree@hellion.org.uk,
 robh+dt@kernel.org,
 galak@codeaurora.org,
 mark.rutland@arm.com,
 linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <1419250476-2393-1-git-send-email-stefan.wahren@i2se.com> <1419250476-2393-3-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1419250476-2393-3-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201412231437.22809.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

On Monday, December 22, 2014 at 01:14:36 PM, Stefan Wahren wrote:
> The devicetree binding for mxs-lradc defines ranges for the
> touchscreen properties. In order to avoid unexpected behavior like
> division by zero, we better check these ranges during probe and
> abort in error case.
> 
> Additionally this patch adds an important note from the reference
> manual about the range of sample delay.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/staging/iio/adc/mxs-lradc.c |   44
> +++++++++++++++++++++++++++-------- 1 file changed, 34 insertions(+), 10
> deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
> b/drivers/staging/iio/adc/mxs-lradc.c index f053535..990e945 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -436,7 +436,13 @@ static void mxs_lradc_setup_ts_channel(struct
> mxs_lradc *lradc, unsigned ch) */
>  	mxs_lradc_reg_clear(lradc, LRADC_CH_VALUE_MASK, LRADC_CH(ch));
> 
> -	/* prepare the delay/loop unit according to the oversampling count */
> +	/* prepare the delay/loop unit according to the oversampling count

Very minor coding style flub in this comment above. Multi-line comments should
start with /* and a newline after that ;-)

> +	 * from the datasheet:
> +	 * "The DELAY fields in HW_LRADC_DELAY0, HW_LRADC_DELAY1,
> +	 * HW_LRADC_DELAY2, and HW_LRADC_DELAY3 must be non-zero; otherwise,
> +	 * the LRADC will not trigger the delay group."
> +	 */
>  	mxs_lradc_reg_wrt(lradc, LRADC_DELAY_TRIGGER(1 << ch) |
>  		LRADC_DELAY_TRIGGER_DELAYS(0) |
>  		LRADC_DELAY_LOOP(lradc->over_sample_cnt - 1) |
> @@ -1495,20 +1501,38 @@ static int mxs_lradc_probe_touchscreen(struct
> mxs_lradc *lradc, return -EINVAL;
>  	}
> 
> -	lradc->over_sample_cnt = 4;
> -	ret = of_property_read_u32(lradc_node, "fsl,ave-ctrl", &adapt);
> -	if (ret == 0)
> +	if (of_property_read_u32(lradc_node, "fsl,ave-ctrl", &adapt)) {
> +		lradc->over_sample_cnt = 4;
> +	} else {
> +		if (adapt < 1 || adapt > 32) {

This is just an idea, but do we not have some kind of a 
"of_property_read_u32_range()" thingie, which would include this kind of range 
checking ? Would it be worth implementing such thing ? What do you think
please ?

[...]

Otherwise,

Reviewed-by: Marek Vasut <marex@denx.de>
