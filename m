Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33864 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbcJCEA6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Oct 2016 00:00:58 -0400
Received: by mail-pa0-f66.google.com with SMTP id r9so7214066paz.1
        for <linux-iio@vger.kernel.org>; Sun, 02 Oct 2016 21:00:58 -0700 (PDT)
Date: Mon, 3 Oct 2016 12:00:49 +0800
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: ad7192: implement
 IIO_CHAN_INFO_SAMP_FREQ
Message-ID: <20161003040045.GB2267@Socrates-DK>
References: <1475308164-3461-1-git-send-email-eraretuya@gmail.com>
 <a1258b09-192c-3870-e7b2-057ceeb1dc62@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a1258b09-192c-3870-e7b2-057ceeb1dc62@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Oct 01, 2016 at 12:35:26PM +0100, Jonathan Cameron wrote:
> On 01/10/16 08:49, Eva Rachel Retuya wrote:
> > This driver predates the availability of IIO_CHAN_INFO_SAMP_FREQ attribute
> > wherein usage has some advantages like it can be accessed by in-kernel
> > consumers as well as reduces the code size.
> > 
> > Therefore, use IIO_CHAN_INFO_SAMP_FREQ to implement the sampling_frequency
> > attribute instead of using IIO_DEV_ATTR_SAMP_FREQ() macro.
> > 
> > Move code from the functions associated with IIO_DEV_ATTR_SAMP_FREQ() into
> > respective read and write hooks with the mask set to IIO_CHAN_INFO_SAMP_FREQ.
> > 
> > Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> Given this is heading away from the generic staging fixes and into the
> list of specific IIO tasks, please do make sure to cc the linux-iio
> list.
> 
> (I'd prefer that for all IIO touching patches - but give that's somewhat
> of an oddity for staging I don't really mind that much)
> 

My apologies for that. I will include the linux-iio list in the future
revisions and patch submissions. (cc'ing the list now..)

> Otherwise, almost perfect, but there is a weird corner in this driver.
> 
> Take a look at what write_raw_get_fmt is set to...
> For this write it should return be IIO_VAL_INT;
> 

I had set the return to IIO_VAL_INT already. Can you please point out where
else I had missed?

> Lars / Michael, this driver is only a very small distance from being
> fine to move out of staging.  I'm basically seeing two bits of
> custom ABI that need documenting and review, but otherwise post
> this cleanup looks in pretty good state to me.
> 

By any chance, are you referring to these:
static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
			     in_voltage-voltage_scale_available,
			     S_IRUGO, ad7192_show_scale_available, NULL, 0);

static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
		       ad7192_show_scale_available, NULL, 0);

Can you please guide me as to what to do next on the "documenting" part,
and should I send a patchset instead with this and the documentation bit
put together?

Thanks for the feedback,
Eva

> Thanks,
> 
> Jonathan
> > ---
> > Changes in v2:
> > * Make commit message more detailed
> > * Fix tiny bug about bypassing iio_device_release_direct_mode()
> > * Remove unneeded goto and use break instead
> > 
> >  drivers/staging/iio/adc/ad7192.c       | 75 ++++++++++------------------------
> >  include/linux/iio/adc/ad_sigma_delta.h |  1 +
> >  2 files changed, 22 insertions(+), 54 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> > index 1cf6b79..e6e4505 100644
> > --- a/drivers/staging/iio/adc/ad7192.c
> > +++ b/drivers/staging/iio/adc/ad7192.c
> > @@ -322,57 +322,6 @@ out:
> >  	return ret;
> >  }
> >  
> > -static ssize_t ad7192_read_frequency(struct device *dev,
> > -				     struct device_attribute *attr,
> > -				     char *buf)
> > -{
> > -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -	struct ad7192_state *st = iio_priv(indio_dev);
> > -
> > -	return sprintf(buf, "%d\n", st->mclk /
> > -			(st->f_order * 1024 * AD7192_MODE_RATE(st->mode)));
> > -}
> > -
> > -static ssize_t ad7192_write_frequency(struct device *dev,
> > -				      struct device_attribute *attr,
> > -				      const char *buf,
> > -				      size_t len)
> > -{
> > -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -	struct ad7192_state *st = iio_priv(indio_dev);
> > -	unsigned long lval;
> > -	int div, ret;
> > -
> > -	ret = kstrtoul(buf, 10, &lval);
> > -	if (ret)
> > -		return ret;
> > -	if (lval == 0)
> > -		return -EINVAL;
> > -
> > -	ret = iio_device_claim_direct_mode(indio_dev);
> > -	if (ret)
> > -		return ret;
> > -
> > -	div = st->mclk / (lval * st->f_order * 1024);
> > -	if (div < 1 || div > 1023) {
> > -		ret = -EINVAL;
> > -		goto out;
> > -	}
> > -
> > -	st->mode &= ~AD7192_MODE_RATE(-1);
> > -	st->mode |= AD7192_MODE_RATE(div);
> > -	ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
> > -
> > -out:
> > -	iio_device_release_direct_mode(indio_dev);
> > -
> > -	return ret ? ret : len;
> > -}
> > -
> > -static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
> > -		ad7192_read_frequency,
> > -		ad7192_write_frequency);
> > -
> >  static ssize_t
> >  ad7192_show_scale_available(struct device *dev,
> >  			    struct device_attribute *attr, char *buf)
> > @@ -471,7 +420,6 @@ static IIO_DEVICE_ATTR(ac_excitation_en, S_IRUGO | S_IWUSR,
> >  		       AD7192_REG_MODE);
> >  
> >  static struct attribute *ad7192_attributes[] = {
> > -	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> >  	&iio_dev_attr_in_v_m_v_scale_available.dev_attr.attr,
> >  	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
> >  	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
> > @@ -484,7 +432,6 @@ static const struct attribute_group ad7192_attribute_group = {
> >  };
> >  
> >  static struct attribute *ad7195_attributes[] = {
> > -	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> >  	&iio_dev_attr_in_v_m_v_scale_available.dev_attr.attr,
> >  	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
> >  	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
> > @@ -536,6 +483,10 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
> >  		if (chan->type == IIO_TEMP)
> >  			*val -= 273 * ad7192_get_temp_scale(unipolar);
> >  		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		*val = st->mclk /
> > +			(st->f_order * 1024 * AD7192_MODE_RATE(st->mode));
> > +		return IIO_VAL_INT;
> >  	}
> >  
> >  	return -EINVAL;
> > @@ -548,7 +499,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
> >  			    long mask)
> >  {
> >  	struct ad7192_state *st = iio_priv(indio_dev);
> > -	int ret, i;
> > +	int ret, i, div;
> >  	unsigned int tmp;
> >  
> >  	ret = iio_device_claim_direct_mode(indio_dev);
> > @@ -572,6 +523,22 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
> >  				break;
> >  			}
> >  		break;
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		if (!val) {
> > +			ret = -EINVAL;
> > +			break;
> > +		}
> > +
> > +		div = st->mclk / (val * st->f_order * 1024);
> > +		if (div < 1 || div > 1023) {
> > +			ret = -EINVAL;
> > +			break;
> > +		}
> > +
> > +		st->mode &= ~AD7192_MODE_RATE(-1);
> > +		st->mode |= AD7192_MODE_RATE(div);
> > +		ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
> > +		break;
> >  	default:
> >  		ret = -EINVAL;
> >  	}
> > diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> > index e7fdec4..5ba430c 100644
> > --- a/include/linux/iio/adc/ad_sigma_delta.h
> > +++ b/include/linux/iio/adc/ad_sigma_delta.h
> > @@ -136,6 +136,7 @@ int ad_sd_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig);
> >  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> >  			BIT(IIO_CHAN_INFO_OFFSET), \
> >  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> >  		.scan_index = (_si), \
> >  		.scan_type = { \
> >  			.sign = 'u', \
> > 
> 
