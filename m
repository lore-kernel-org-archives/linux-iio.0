Return-Path: <dan.carpenter@oracle.com>
Date: Wed, 4 Sep 2013 17:36:24 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Juergen Beisert <jbe@pengutronix.de>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        Marek Vasut <marex@denx.de>,
        Fabio Estevam <fabio.estevam@freescale.com>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 2/5] Staging/iio/adc/touchscreen/MXS: separate i.MX28
 specific register bits
Message-ID: <20130904143624.GI6329@mwanda>
References: <1378299706-6742-1-git-send-email-jbe@pengutronix.de>
 <1378299706-6742-3-git-send-email-jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378299706-6742-3-git-send-email-jbe@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Sep 04, 2013 at 03:01:43PM +0200, Juergen Beisert wrote:
> +#define	LRADC_CTRL0_MX28_PLATE_MASK \
> +		LRADC_CTRL0_MX28_YNNSW | LRADC_CTRL0_MX28_YPNSW | \
> +		LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_XNNSW | \
> +		LRADC_CTRL0_MX28_XNPSW | LRADC_CTRL0_MX28_XPPSW

Put parenthesis are this macro.

regards,
dan carpenter
