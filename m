Return-Path: <dan.carpenter@oracle.com>
Date: Wed, 4 Sep 2013 17:27:39 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Juergen Beisert <jbe@pengutronix.de>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        Marek Vasut <marex@denx.de>,
        Fabio Estevam <fabio.estevam@freescale.com>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 3/5] Staging/iio/adc/touchscreen/MXS: add i.MX23 support
 to the LRADC driver
Message-ID: <20130904142738.GH6329@mwanda>
References: <1378299706-6742-1-git-send-email-jbe@pengutronix.de>
 <1378299706-6742-4-git-send-email-jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378299706-6742-4-git-send-email-jbe@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Sep 04, 2013 at 03:01:44PM +0200, Juergen Beisert wrote:
> @@ -323,10 +338,17 @@ static int mxs_lradc_ts_touched(struct mxs_lradc *lradc)
>  	uint32_t reg;
>  
>  	/* Enable touch detection. */
> -	writel(LRADC_CTRL0_MX28_PLATE_MASK,
> -		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
> -	writel(LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE,
> -		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
> +	if (lradc->soc == IMX28_LRADC) {
> +		writel(LRADC_CTRL0_MX28_PLATE_MASK,
> +			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
> +		writel(LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE,
> +			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
> +	} else {
> +		writel(LRADC_CTRL0_MX23_PLATE_MASK,
> +			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
> +		writel(LRADC_CTRL0_MX23_TOUCH_DETECT_ENABLE,
> +			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
> +	}

I don't like the way this patch takes the driver and makes every line
an if else statement.  It would be cleaner to do this:

	writel(lradc_plate_mask(lradc),
		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
	writel(lradc_touch_detect_enable(lradc),
		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);

Btw, LRADC_CTRL0_MX23_TOUCH_DETECT_ENABLE just enables the touch screen
to detect touches?  It seems like we could leave the "DETECT_" out of
the name.

Actually it would better yet if there were a function:

static inline void lradc_writel(struct mxs_lradc *lradc, u32 val,
				size_t chan, size_t offset)
{
	writel(val, lradc->base + chan + offset);
}

That way we could do:

	lradc_writel(lradc_enable_touch(lradc), LRADC_CTRL0,
		     STMP_OFFSET_REG_SET);

ACTUALLY!  When I look at it now the third argument is almost always
"set", "clear" or "toggle".

So we could do:

static inline void lradc_reg_set(struct mxs_lradc *lradc, u32 val,
				size_t chan)
{
	writel(val, lradc->base + chan + STMP_OFFSET_REG_SET);
}

So then it would be:

	lradc_reg_clear(lradc_plate_mask(lradc), LRADC_CTRL0);
	lradc_reg_set(lradc_enable_touch(lradc), LRADC_CTRL0);

I've just changed 11 lines of code down to 2 lines of code by hiding the
if statement in the header file.

Please redo this patch along those lines.

regards,
dan carpenter
