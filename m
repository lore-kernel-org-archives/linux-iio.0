Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56439 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652AbaINT0u (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Sep 2014 15:26:50 -0400
Message-ID: <5415EBF9.3050103@kernel.org>
Date: Sun, 14 Sep 2014 20:26:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: Re: [PATCH v2 10/11] iio:bma180: Implement _available sysfs attribute
 dynamically
References: <1408488206-2633-1-git-send-email-pmeerw@pmeerw.net> <1408488206-2633-11-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1408488206-2633-11-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/08/14 23:43, Peter Meerwald wrote:
> makes it easier to add more chip variants and removes redundancy:
> scales and frequencies are now stated just once
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Applied.
> ---
>  drivers/iio/accel/bma180.c | 54 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 43 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 6e940b0..9fbc81f 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -83,12 +83,6 @@ struct bma180_part_info {
>  #define BMA180_DEF_BW		20
>  #define BMA180_DEF_SCALE	2452
>  
> -/* Available values for sysfs */
> -#define BMA180_FLP_FREQ_AVAILABLE \
> -	"10 20 40 75 150 300"
> -#define BMA180_SCALE_AVAILABLE \
> -	"0.001275 0.001863 0.002452 0.003727 0.004903 0.009709 0.019417"
> -
>  struct bma180_data {
>  	struct i2c_client *client;
>  	struct iio_trigger *trig;
> @@ -347,13 +341,51 @@ err:
>  	dev_err(&data->client->dev, "failed to disable the chip\n");
>  }
>  
> -static IIO_CONST_ATTR(in_accel_filter_low_pass_3db_frequency_available,
> -		BMA180_FLP_FREQ_AVAILABLE);
> -static IIO_CONST_ATTR(in_accel_scale_available, BMA180_SCALE_AVAILABLE);
> +static ssize_t bma180_show_avail(char *buf, const int *vals, unsigned n,
> +				 bool micros)
> +{
> +	size_t len = 0;
> +	int i;
> +
> +	for (i = 0; i < n; i++) {
> +		if (!vals[i])
> +			continue;
> +		len += scnprintf(buf + len, PAGE_SIZE - len,
> +			micros ? "0.%06d " : "%d ", vals[i]);
> +	}
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static ssize_t bma180_show_filter_freq_avail(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct bma180_data *data = iio_priv(dev_to_iio_dev(dev));
> +
> +	return bma180_show_avail(buf, data->part_info->bw_table,
> +		data->part_info->num_bw, false);
> +}
> +
> +static ssize_t bma180_show_scale_avail(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct bma180_data *data = iio_priv(dev_to_iio_dev(dev));
> +
> +	return bma180_show_avail(buf, data->part_info->scale_table,
> +		data->part_info->num_scales, true);
> +}
> +
> +static IIO_DEVICE_ATTR(in_accel_filter_low_pass_3db_frequency_available,
> +	S_IRUGO, bma180_show_filter_freq_avail, NULL, 0);
> +
> +static IIO_DEVICE_ATTR(in_accel_scale_available,
> +	S_IRUGO, bma180_show_scale_avail, NULL, 0);
>  
>  static struct attribute *bma180_attributes[] = {
> -	&iio_const_attr_in_accel_filter_low_pass_3db_frequency_available.dev_attr.attr,
> -	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
> +	&iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.
> +		dev_attr.attr,
> +	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
>  	NULL,
>  };
>  
> 
