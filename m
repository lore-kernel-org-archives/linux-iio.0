Return-Path: <dan.carpenter@oracle.com>
Date: Tue, 10 Sep 2013 23:54:44 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: =?iso-8859-1?Q?J=FCrgen?= Beisert <jbe@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        fabio.estevam@freescale.com, jic23@cam.ac.uk
Subject: Re: [PATCH 3/5] Staging/iio/adc/touchscreen/MXS: add i.MX23 support
 to the LRADC driver
Message-ID: <20130910205444.GB6329@mwanda>
References: <1378713801-1182-1-git-send-email-jbe@pengutronix.de>
 <1378713801-1182-4-git-send-email-jbe@pengutronix.de>
 <201309091804.20177.marex@denx.de>
 <201309100936.14562.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <201309100936.14562.jbe@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Sep 10, 2013 at 09:36:14AM +0200, Jürgen Beisert wrote:
> >
> > This patch seems to combine two things -- register access rework AND
> > adjustment of the driver for MX23 touchscreen.
> 
> It reworks the register access to avoid the i.MX23/i.MX28 runtime decision all 
> over the code again and again. This is what Dan has recommended in his 
> comment.

I thought the same as Marek that it would be better as two patches like
the one I sent, but I was also willing to let it slide if no one else
complained.

regards,
dan carpenter
