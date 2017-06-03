Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750765AbdFCJni (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jun 2017 05:43:38 -0400
Date: Sat, 3 Jun 2017 10:36:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sebastian Reichel <sre@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc: J Keerthy <j-keerthy@ti.com>, linux-iio@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] iio: adc: twl4030: Drop
 twl4030_get_madc_conversion()
Message-ID: <20170603103649.19f6a61d@kernel.org>
In-Reply-To: <4cb8938c-69c2-4881-3061-565a6f479b39@kernel.org>
References: <20170427153012.32310-1-sebastian.reichel@collabora.co.uk>
        <20170427153012.32310-4-sebastian.reichel@collabora.co.uk>
        <4cb8938c-69c2-4881-3061-565a6f479b39@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 30 Apr 2017 17:35:04 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On 27/04/17 16:30, Sebastian Reichel wrote:
> > Drop legacy twl4030_get_madc_conversion() method. It has been
> > used by drivers to get madc data before it conversion to IIO
> > API. There are no users in the mainline kernel anymore.
> > 
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>  
> Acked-by: Jonathan Cameron <jic23@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> > ---
> >  drivers/iio/adc/twl4030-madc.c   | 21 ---------------------
> >  include/linux/i2c/twl4030-madc.h |  1 -
> >  2 files changed, 22 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
> > index 0c74869a540a..88e44066ef82 100644
> > --- a/drivers/iio/adc/twl4030-madc.c
> > +++ b/drivers/iio/adc/twl4030-madc.c
> > @@ -642,27 +642,6 @@ int twl4030_madc_conversion(struct twl4030_madc_request *req)
> >  }
> >  EXPORT_SYMBOL_GPL(twl4030_madc_conversion);
> >  
> > -int twl4030_get_madc_conversion(int channel_no)
> > -{
> > -	struct twl4030_madc_request req;
> > -	int temp = 0;
> > -	int ret;
> > -
> > -	req.channels = (1 << channel_no);
> > -	req.method = TWL4030_MADC_SW2;
> > -	req.active = 0;
> > -	req.raw = 0;
> > -	req.func_cb = NULL;
> > -	ret = twl4030_madc_conversion(&req);
> > -	if (ret < 0)
> > -		return ret;
> > -	if (req.rbuf[channel_no] > 0)
> > -		temp = req.rbuf[channel_no];
> > -
> > -	return temp;
> > -}
> > -EXPORT_SYMBOL_GPL(twl4030_get_madc_conversion);
> > -
> >  /**
> >   * twl4030_madc_set_current_generator() - setup bias current
> >   *
> > diff --git a/include/linux/i2c/twl4030-madc.h b/include/linux/i2c/twl4030-madc.h
> > index 1c0134dd3271..0c919ebb31e0 100644
> > --- a/include/linux/i2c/twl4030-madc.h
> > +++ b/include/linux/i2c/twl4030-madc.h
> > @@ -143,5 +143,4 @@ struct twl4030_madc_user_parms {
> >  };
> >  
> >  int twl4030_madc_conversion(struct twl4030_madc_request *conv);
> > -int twl4030_get_madc_conversion(int channel_no);
> >  #endif
> >   
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

