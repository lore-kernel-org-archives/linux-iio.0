Return-Path: <dan.carpenter@oracle.com>
Date: Thu, 5 Sep 2013 13:42:56 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: =?iso-8859-1?Q?J=FCrgen?= Beisert <jbe@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        Marek Vasut <marex@denx.de>,
        Fabio Estevam <fabio.estevam@freescale.com>, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 3/5] Staging/iio/adc/touchscreen/MXS: add i.MX23 support
 to the LRADC driver
Message-ID: <20130905104256.GK6329@mwanda>
References: <1378299706-6742-1-git-send-email-jbe@pengutronix.de>
 <1378299706-6742-4-git-send-email-jbe@pengutronix.de>
 <20130904142738.GH6329@mwanda>
 <201309051216.18305.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <201309051216.18305.jbe@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Sep 05, 2013 at 12:16:18PM +0200, Jürgen Beisert wrote:
> I like this simplification, but all the other drivers for the MXS series of 
> SoCs don't use such a method. Do you think this "new style" will be accepted?
> 

My lradc_plate_mask() is basically the same idea as what Marek said
about putting the logic into the define.

LRADC....IRQ_MASK(id) (((id) == MX23) ? 0x1ff : 0x1fff)

I don't know why Marek is complaining about churn though.  This is
linux!  We love churn!  And especially in staging, it's our favorite
thing.  :P

regards,
dan carpenter
