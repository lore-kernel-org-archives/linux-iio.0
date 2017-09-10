Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750989AbdIJPWV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Sep 2017 11:22:21 -0400
Date: Sun, 10 Sep 2017 16:22:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Dragos Bogdan <dragos.bogdan@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: ad_sigma_delta: Implement a dedicated reset
 function
Message-ID: <20170910162217.63948cf1@archlinux>
In-Reply-To: <0ea75f81-fe63-4d54-6167-463c53dd8fd5@metafoo.de>
References: <20170905121445.26913-1-dragos.bogdan@analog.com>
        <0ea75f81-fe63-4d54-6167-463c53dd8fd5@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 5 Sep 2017 14:16:42 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 09/05/2017 02:14 PM, Dragos Bogdan wrote:
> > Since most of the SD ADCs have the option of reseting the serial
> > interface by sending a number of SCLKs with CS = 0 and DIN = 1,
> > a dedicated function that can do this is usefull.
> > 
> > Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>  
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Applied to the fixes-togreg branch of iio.git and marked
for stable.  I added a note that this was a precursor for
the following patch to justify the stable cc.

Jonathan
> 
> > ---
> >  drivers/iio/adc/ad_sigma_delta.c       | 28 ++++++++++++++++++++++++++++
> >  include/linux/iio/adc/ad_sigma_delta.h |  3 +++
> >  2 files changed, 31 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> > index d10bd0c97233..22c4c17cd996 100644
> > --- a/drivers/iio/adc/ad_sigma_delta.c
> > +++ b/drivers/iio/adc/ad_sigma_delta.c
> > @@ -177,6 +177,34 @@ int ad_sd_read_reg(struct ad_sigma_delta *sigma_delta,
> >  }
> >  EXPORT_SYMBOL_GPL(ad_sd_read_reg);
> >  
> > +/**
> > + * ad_sd_reset() - Reset the serial interface
> > + *
> > + * @sigma_delta: The sigma delta device
> > + * @reset_length: Number of SCLKs with DIN = 1
> > + *
> > + * Returns 0 on success, an error code otherwise.
> > + **/
> > +int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
> > +	unsigned int reset_length)
> > +{
> > +	uint8_t *buf;
> > +	unsigned int size;
> > +	int ret;
> > +
> > +	size = DIV_ROUND_UP(reset_length, 8);
> > +	buf = kcalloc(size, sizeof(*buf), GFP_KERNEL);
> > +	if (!buf)
> > +		return -ENOMEM;
> > +
> > +	memset(buf, 0xff, size);
> > +	ret = spi_write(sigma_delta->spi, buf, size);
> > +	kfree(buf);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(ad_sd_reset);
> > +
> >  static int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
> >  	unsigned int mode, unsigned int channel)
> >  {
> > diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> > index 5ba430cc9a87..1fc7abd28b0b 100644
> > --- a/include/linux/iio/adc/ad_sigma_delta.h
> > +++ b/include/linux/iio/adc/ad_sigma_delta.h
> > @@ -111,6 +111,9 @@ int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
> >  int ad_sd_read_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
> >  	unsigned int size, unsigned int *val);
> >  
> > +int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
> > +	unsigned int reset_length);
> > +
> >  int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
> >  	const struct iio_chan_spec *chan, int *val);
> >  int ad_sd_calibrate_all(struct ad_sigma_delta *sigma_delta,
> >   
> 

