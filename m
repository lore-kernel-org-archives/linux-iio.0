Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751236AbeCQUge (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Mar 2018 16:36:34 -0400
Date: Sat, 17 Mar 2018 20:36:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "committed@heine.so" <committed@heine.so>
Subject: Re: [PATCH] iio: ad7793: implement IIO_CHAN_INFO_SAMP_FREQ
Message-ID: <20180317203630.0fa495b3@archlinux>
In-Reply-To: <1520846302.2342.3.camel@analog.com>
References: <1520608432-8463-1-git-send-email-committed@heine.so>
        <803717ee54bb11960f5d7e3fc0b72621@heine.so>
        <1520846302.2342.3.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 12 Mar 2018 09:18:24 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Mon, 2018-03-12 at 10:10 +0100, Michael Nosthoff wrote:
> > On 2018-03-09 16:13, Michael Nosthoff wrote:
> > 
> > I noticed I forgot the "v5" in the subject tag. Should I resubmit?  
> 
> From my side, I think it's fine to skip it.
> Let's see if Jonathan has another preference.
It's fine - we all forget this from time to time (well at least
I do anyway)

Applied to the fixes-togreg branch of iio.git and marked for stable.

This may take a little while to go upstream because of where we are
in the cycle and whether I get another pull request out to greg
before the merge window. If not it'll go shortly after the window
closes.

Thanks,

Jonathan
> 
> >   
> > > This commit is a follow-up to changes made to ad_sigma_delta.h
> > > in staging: iio: ad7192: implement IIO_CHAN_INFO_SAMP_FREQ
> > > which broke ad7793 as it was not altered to match those changes.
> > > 
> > > This driver predates the availability of IIO_CHAN_INFO_SAMP_FREQ
> > > attribute wherein usage has some advantages like it can be accessed by
> > > in-kernel consumers as well as reduces the code size.
> > > 
> > > Therefore, use IIO_CHAN_INFO_SAMP_FREQ to implement the
> > > sampling_frequency attribute instead of using IIO_DEV_ATTR_SAMP_FREQ()
> > > macro.
> > > 
> > > Move code from the functions associated with IIO_DEV_ATTR_SAMP_FREQ()
> > > into respective read and write hooks with the mask set to
> > > IIO_CHAN_INFO_SAMP_FREQ.
> > > 
> > > Fixes: a13e831fcaa7 ("staging: iio: ad7192: implement 
> > > IIO_CHAN_INFO_SAMP_FREQ")
> > > 
> > > Signed-off-by: Michael Nosthoff <committed@heine.so>
> > > ---
> > > Changes in v5:
> > > 
> > >   - fixed checkpatchi.pl warnings for line-length
> > > 
> > >  drivers/iio/adc/ad7793.c | 75 
> > > ++++++++++++++++--------------------------------
> > >  1 file changed, 24 insertions(+), 51 deletions(-)
> > > 
> > > diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> > > index 801afb6..d4bbe5b 100644
> > > --- a/drivers/iio/adc/ad7793.c
> > > +++ b/drivers/iio/adc/ad7793.c
> > > @@ -348,55 +348,6 @@ static const u16 ad7793_sample_freq_avail[16] =
> > > {0, 470, 242, 123, 62, 50, 39,
> > >  static const u16 ad7797_sample_freq_avail[16] = {0, 0, 0, 123, 62, 50, 
> > > 0,
> > >  					33, 0, 17, 16, 12, 10, 8, 6, 4};
> > > 
> > > -static ssize_t ad7793_read_frequency(struct device *dev,
> > > -		struct device_attribute *attr,
> > > -		char *buf)
> > > -{
> > > -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > > -	struct ad7793_state *st = iio_priv(indio_dev);
> > > -
> > > -	return sprintf(buf, "%d\n",
> > > -	       st->chip_info->sample_freq_avail[AD7793_MODE_RATE(st->mode)]);
> > > -}
> > > -
> > > -static ssize_t ad7793_write_frequency(struct device *dev,
> > > -		struct device_attribute *attr,
> > > -		const char *buf,
> > > -		size_t len)
> > > -{
> > > -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > > -	struct ad7793_state *st = iio_priv(indio_dev);
> > > -	long lval;
> > > -	int i, ret;
> > > -
> > > -	ret = kstrtol(buf, 10, &lval);
> > > -	if (ret)
> > > -		return ret;
> > > -
> > > -	if (lval == 0)
> > > -		return -EINVAL;
> > > -
> > > -	for (i = 0; i < 16; i++)
> > > -		if (lval == st->chip_info->sample_freq_avail[i])
> > > -			break;
> > > -	if (i == 16)
> > > -		return -EINVAL;
> > > -
> > > -	ret = iio_device_claim_direct_mode(indio_dev);
> > > -	if (ret)
> > > -		return ret;
> > > -	st->mode &= ~AD7793_MODE_RATE(-1);
> > > -	st->mode |= AD7793_MODE_RATE(i);
> > > -	ad_sd_write_reg(&st->sd, AD7793_REG_MODE, sizeof(st->mode), 
> > > st->mode);
> > > -	iio_device_release_direct_mode(indio_dev);
> > > -
> > > -	return len;
> > > -}
> > > -
> > > -static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
> > > -		ad7793_read_frequency,
> > > -		ad7793_write_frequency);
> > > -
> > >  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
> > >  	"470 242 123 62 50 39 33 19 17 16 12 10 8 6 4");
> > > 
> > > @@ -424,7 +375,6 @@ static 
> > > IIO_DEVICE_ATTR_NAMED(in_m_in_scale_available,
> > >  		ad7793_show_scale_available, NULL, 0);
> > > 
> > >  static struct attribute *ad7793_attributes[] = {
> > > -	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> > >  	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> > >  	&iio_dev_attr_in_m_in_scale_available.dev_attr.attr,
> > >  	NULL
> > > @@ -435,7 +385,6 @@ static const struct attribute_group
> > > ad7793_attribute_group = {
> > >  };
> > > 
> > >  static struct attribute *ad7797_attributes[] = {
> > > -	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> > >  	&iio_const_attr_sampling_frequency_available_ad7797.dev_attr.attr,
> > >  	NULL
> > >  };
> > > @@ -505,6 +454,10 @@ static int ad7793_read_raw(struct iio_dev 
> > > *indio_dev,
> > >  			*val -= offset;
> > >  		}
> > >  		return IIO_VAL_INT;
> > > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > > +		*val = st->chip_info
> > > +			       ->sample_freq_avail[AD7793_MODE_RATE(st->mode)];
> > > +		return IIO_VAL_INT;
> > >  	}
> > >  	return -EINVAL;
> > >  }
> > > @@ -542,6 +495,26 @@ static int ad7793_write_raw(struct iio_dev 
> > > *indio_dev,
> > >  				break;
> > >  			}
> > >  		break;
> > > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > > +		if (!val) {
> > > +			ret = -EINVAL;
> > > +			break;
> > > +		}
> > > +
> > > +		for (i = 0; i < 16; i++)
> > > +			if (val == st->chip_info->sample_freq_avail[i])
> > > +				break;
> > > +
> > > +		if (i == 16) {
> > > +			ret = -EINVAL;
> > > +			break;
> > > +		}
> > > +
> > > +		st->mode &= ~AD7793_MODE_RATE(-1);
> > > +		st->mode |= AD7793_MODE_RATE(i);
> > > +		ad_sd_write_reg(&st->sd, AD7793_REG_MODE, sizeof(st->mode),
> > > +				st->mode);
> > > +		break;
> > >  	default:
> > >  		ret = -EINVAL;
> > >  	}  
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > N_____r__y____b_X____v_^_)__{.n_+____{__*"__^n_r___z___h_____&___G___h_(_______j"___m______z______f___h___~_  

