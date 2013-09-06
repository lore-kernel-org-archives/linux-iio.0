Return-Path: <dan.carpenter@oracle.com>
Date: Fri, 6 Sep 2013 15:26:11 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Juergen Beisert <jbe@pengutronix.de>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org, marex@denx.de,
        fabio.estevam@freescale.com, linux-arm-kernel@lists.infradead.org,
        jic23@cam.ac.uk
Subject: Re: [PATCH 4/5] Staging/iio/adc/touchscreen/MXS: add interrupt
 driven touch detection
Message-ID: <20130906122611.GT6329@mwanda>
References: <1378462123-4830-1-git-send-email-jbe@pengutronix.de>
 <1378462123-4830-5-git-send-email-jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378462123-4830-5-git-send-email-jbe@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Sep 06, 2013 at 12:08:42PM +0200, Juergen Beisert wrote:
> +static int mxs_lradc_read_ts_channel(struct mxs_lradc *lradc)
> +{
> +	u32 reg;
> +	int val;
> +
> +	reg = readl(lradc->base + LRADC_CTRL1);
> +
> +	/* only channels 3 to 5 are of interest here */
> +	if (reg & LRADC_CTRL1_LRADC_IRQ(TS_CH_YP)) {
> +		pr_devel("!3");

Gar.  I meant to comment on this the first time this patch was sent.

Please remove the pr_devel() calls.  They are nonsense.

regards,
dan carpenter
