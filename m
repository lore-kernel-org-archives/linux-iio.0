Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753117AbeCQUox (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Mar 2018 16:44:53 -0400
Date: Sat, 17 Mar 2018 20:44:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: <linux-iio@vger.kernel.org>, <michael.hennerich@analog.com>,
        <lars@metafoo.de>
Subject: Re: [PATCH 1/2] iio: adc: ad7791: remove sample freq sysfs
 attributes
Message-ID: <20180317204449.0badb8b0@archlinux>
In-Reply-To: <20180312120654.1806-1-alexandru.ardelean@analog.com>
References: <20180312120654.1806-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 12 Mar 2018 14:06:53 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> In the current state, these attributes are broken, because they are
> registered already, and the kernel throws a warning.
> The first registration happens via the `IIO_CHAN_INFO_SAMP_FREQ` flag from
> the `ad_sigma_delta` driver.
> 
> In this commit these attrs are removed, and in the following the
> IIO_CHAN_INFO_SAMP_FREQ behavior will be implemented, which replaces these
> hooks.
> 
> This is done to make things a bit easier to review as there is a bit of
> overlap in the patch if it's done all at once.
> 
> Fixes: a13e831fcaa7 ("staging: iio: ad7192: implement
> IIO_CHAN_INFO_SAMP_FREQ")
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
I'm going to apply any more of this type via the slow route of the next
merge windows.  I'll mark them for stable though so they make it back
to older to trees after the merge window.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7791.c | 49 ------------------------------------------------
>  1 file changed, 49 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
> index 70fbf92f9827..03a5f7d6cb0c 100644
> --- a/drivers/iio/adc/ad7791.c
> +++ b/drivers/iio/adc/ad7791.c
> @@ -244,58 +244,9 @@ static int ad7791_read_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> -static const char * const ad7791_sample_freq_avail[] = {
> -	[AD7791_FILTER_RATE_120] = "120",
> -	[AD7791_FILTER_RATE_100] = "100",
> -	[AD7791_FILTER_RATE_33_3] = "33.3",
> -	[AD7791_FILTER_RATE_20] = "20",
> -	[AD7791_FILTER_RATE_16_6] = "16.6",
> -	[AD7791_FILTER_RATE_16_7] = "16.7",
> -	[AD7791_FILTER_RATE_13_3] = "13.3",
> -	[AD7791_FILTER_RATE_9_5] = "9.5",
> -};
> -
> -static ssize_t ad7791_read_frequency(struct device *dev,
> -	struct device_attribute *attr, char *buf)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ad7791_state *st = iio_priv(indio_dev);
> -	unsigned int rate = st->filter & AD7791_FILTER_RATE_MASK;
> -
> -	return sprintf(buf, "%s\n", ad7791_sample_freq_avail[rate]);
> -}
> -
> -static ssize_t ad7791_write_frequency(struct device *dev,
> -	struct device_attribute *attr, const char *buf, size_t len)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ad7791_state *st = iio_priv(indio_dev);
> -	int i, ret;
> -
> -	i = sysfs_match_string(ad7791_sample_freq_avail, buf);
> -	if (i < 0)
> -		return i;
> -
> -	ret = iio_device_claim_direct_mode(indio_dev);
> -	if (ret)
> -		return ret;
> -	st->filter &= ~AD7791_FILTER_RATE_MASK;
> -	st->filter |= i;
> -	ad_sd_write_reg(&st->sd, AD7791_REG_FILTER, sizeof(st->filter),
> -			st->filter);
> -	iio_device_release_direct_mode(indio_dev);
> -
> -	return len;
> -}
> -
> -static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
> -		ad7791_read_frequency,
> -		ad7791_write_frequency);
> -
>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("120 100 33.3 20 16.7 16.6 13.3 9.5");
>  
>  static struct attribute *ad7791_attributes[] = {
> -	&iio_dev_attr_sampling_frequency.dev_attr.attr,
>  	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>  	NULL
>  };

