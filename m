Return-Path: <juliana.orod@gmail.com>
Date: Tue, 18 Oct 2016 17:57:25 -0200
From: Juliana Rodrigues <juliana.orod@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: outreachy-kernel@googlegroups.com, lars@metafoo.de,
	michael.hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org
Subject: Re: [RESEND PATCH] iio: gyro: adis16136: implemented
 IIO_CHAN_INFO_SAMP_FREQ
Message-ID: <20161018195725.GC11725@spock>
References: <20161013203831.GA1666@spock>
 <b43090e4-0e18-90cc-3370-3bc7f2194de2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b43090e4-0e18-90cc-3370-3bc7f2194de2@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Oct 15, 2016 at 03:43:36PM +0100, Jonathan Cameron wrote:
> On 13/10/16 21:38, Juliana Rodrigues wrote:
> > Moved functionality from IIO_DEV_ATTR_SAMP_FREQ macro into
> > IIO_CHAN_INFO_SAMP_FREQ. Modified adis16136_read_raw and
> > adis16136_write_raw to allow reading and writing the element.
> > 
> > Signed-off-by: Juliana Rodrigues <juliana.orod@gmail.com>
> Diff certainly made this one more complex to read that it needed to be.
> Ah well, automated tools for you ;)
> 
> Anyhow, a good driver to fixup as a major gain to be had in terms of
> shorter code.
> 
> Few comments inline.
> 
> Jonathan

Hi Jonathan,

Yeah, I moved some functions and ended up with huge chunks of diff
that actually weren't modified. Oh, well...

Again, thank you very much for taking your time to comment on this. I'll
send a new version with your fixes.

Juliana

> > ---
> >  drivers/iio/gyro/adis16136.c | 58 ++++++++++++--------------------------------
> >  1 file changed, 15 insertions(+), 43 deletions(-)
> > 
> > diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
> > index b04faf9..71d282e 100644
> > --- a/drivers/iio/gyro/adis16136.c
> > +++ b/drivers/iio/gyro/adis16136.c
> > @@ -168,11 +168,11 @@ static int adis16136_debugfs_init(struct iio_dev *indio_dev)
> >  
> >  #endif
> >  
> > -static int adis16136_set_freq(struct adis16136 *adis16136, unsigned int freq)
> > +static int adis16136_write_raw_samp_freq(struct adis16136 *adis16136, int *val)
> I'd add a check on whether *val is negative.  Also why pass by pointer?

I did that while debugging and forgot to change it back! Thank you for
spotting.

> >  {
> >  	unsigned int t;
> >  
> > -	t = 32768 / freq;
> > +	t = 32768 / *val;
> >  	if (t < 0xf)
> >  		t = 0xf;
> >  	else if (t > 0xffff)
> > @@ -197,44 +197,19 @@ static int adis16136_get_freq(struct adis16136 *adis16136, unsigned int *freq)
> >  	return 0;
> >  }
> >  
> > -static ssize_t adis16136_write_frequency(struct device *dev,
> > -	struct device_attribute *attr, const char *buf, size_t len)
> > +static int adis16136_read_raw_samp_freq(struct adis16136 *st, int *val)
> Whilst I'd normally prefer the st naming, stick with what is commonly 
> used in the driver.  Better to have consistent style than a mess.

Roger that.

> 
> >  {
> > -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -	struct adis16136 *adis16136 = iio_priv(indio_dev);
> > -	unsigned int val;
> > -	int ret;
> > -
> > -	ret = kstrtouint(buf, 10, &val);
> > -	if (ret)
> > -		return ret;
> > -
> > -	if (val == 0)
> > -		return -EINVAL;
> > -
> > -	ret = adis16136_set_freq(adis16136, val);
> > -
> > -	return ret ? ret : len;
> > -}
> > -
> > -static ssize_t adis16136_read_frequency(struct device *dev,
> > -	struct device_attribute *attr, char *buf)
> > -{
> > -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -	struct adis16136 *adis16136 = iio_priv(indio_dev);
> >  	unsigned int freq;
> >  	int ret;
> >  
> > -	ret = adis16136_get_freq(adis16136, &freq);
> > +	ret = adis16136_get_freq(st, &freq);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	return sprintf(buf, "%d\n", freq);
> > -}
> > +	*val = freq;
> >  
> > -static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
> > -				  adis16136_read_frequency,
> > -				  adis16136_write_frequency);
> > +	return 0;
> > +}
> This last chunk is the most 'interesting' bit of git diff
> output I've seen in a while ;)  Guess a somewhat pathological
> case...

Don't know what you mean by 'interesting' but this shows clearly how
code was changed (and mostly removed). I actually feel a lot relieved to
see that much lines being deleted. One of those weird pleasures... :P


> >  
> >  static const unsigned adis16136_3db_divisors[] = {
> >  	[0] = 2, /* Special case */
> > @@ -322,6 +297,10 @@ static int adis16136_read_raw(struct iio_dev *indio_dev,
> >  		*val = sign_extend32(val32, 31);
> >  
> >  		return IIO_VAL_INT;
> > +
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		return adis16136_read_raw_samp_freq(adis16136, val);
> > +
> >  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> >  		return adis16136_get_filter(indio_dev, val);
> >  	default:
> > @@ -340,6 +319,8 @@ static int adis16136_write_raw(struct iio_dev *indio_dev,
> >  			ADIS16136_REG_GYRO_OFF2, val);
> >  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> >  		return adis16136_set_filter(indio_dev, val);
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> why pass val as a pointer?
> > +		return adis16136_write_raw_samp_freq(adis16136, &val);
> >  	default:
> >  		break;
> >  	}
> > @@ -361,7 +342,7 @@ static const struct iio_chan_spec adis16136_channels[] = {
> >  			BIT(IIO_CHAN_INFO_CALIBBIAS) |
> >  			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> >  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> > -
> > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> >  		.address = ADIS16136_REG_GYRO_OUT2,
> >  		.scan_index = ADIS16136_SCAN_GYRO,
> >  		.scan_type = {
> > @@ -376,6 +357,7 @@ static const struct iio_chan_spec adis16136_channels[] = {
> >  		.channel = 0,
> >  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> >  			BIT(IIO_CHAN_INFO_SCALE),
> > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> >  		.address = ADIS16136_REG_TEMP_OUT,
> >  		.scan_index = ADIS16136_SCAN_TEMP,
> >  		.scan_type = {
> > @@ -388,18 +370,8 @@ static const struct iio_chan_spec adis16136_channels[] = {
> >  	IIO_CHAN_SOFT_TIMESTAMP(2),
> >  };
> >  
> > -static struct attribute *adis16136_attributes[] = {
> > -	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> > -	NULL
> > -};
> > -
> > -static const struct attribute_group adis16136_attribute_group = {
> > -	.attrs = adis16136_attributes,
> > -};
> > -
> >  static const struct iio_info adis16136_info = {
> >  	.driver_module = THIS_MODULE,
> > -	.attrs = &adis16136_attribute_group,
> >  	.read_raw = &adis16136_read_raw,
> >  	.write_raw = &adis16136_write_raw,
> >  	.update_scan_mode = adis_update_scan_mode,
> > 
> 
