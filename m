Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57830 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbcGSFgB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2016 01:36:01 -0400
Subject: Re: [PATCH v2 4/4] hwmon: iio: add label for channels read by
 iio_hwmon
To: Quentin Schulz <quentin.schulz@free-electrons.com>,
	jdelvare@suse.com, linux@roeck-us.net, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net,
	maxime.ripard@free-electrons.com, wens@csie.org,
	lee.jones@linaro.org
References: <1468576754-3273-1-git-send-email-quentin.schulz@free-electrons.com>
 <1468576754-3273-5-git-send-email-quentin.schulz@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <aa889446-d68c-a05f-83c1-4d54fe814000@kernel.org>
Date: Mon, 18 Jul 2016 13:24:23 +0100
MIME-Version: 1.0
In-Reply-To: <1468576754-3273-5-git-send-email-quentin.schulz@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/07/16 10:59, Quentin Schulz wrote:
> Currently, iio_hwmon only exposes values of the IIO channels it can read
> but no label by channel is exposed.
> 
> This adds exposition of sysfs files containing label for IIO channels it
> can read based on extended_name field of the iio_chan_spec of the channel.
> If the extended_name field is empty, the sysfs file is not created by
> iio_hwmon.
Hmm. This is not the intent of extended name at all.  That exists to add
a small amount of information to an constructed IIO channel name.
Typically it's used to indicate physically wired stuff like:

in_voltage0_vdd_raw for cases where that channel of the ADC is hard wired
to the vdd.  In this particular case the use might actually work as the
vdd makes it clear it's a voltage - in general that's not the case.

Use of extended_name at all in IIO is only done after extensive review.
It adds nasty custom ABI to a device, so the gain has to be considerable
to use it.

When I read your original suggestion of adding labels, I was expecting the
use of datasheet_name.  That has the advantage of being well defined by
the datasheet (if not it should not be provided) + not being used in
the construction of the IIO channel related attributes.  However, that
may still not correspond well to the expected labelling in hwmon.
Thinking more on this, the label is going to often be a function of how
the board is wired up...  Perhaps it should be a characteristic of the
channel_map (hence from DT or similar) rather than part of the IIO driver
itself?

At first glance hwmon labels appear to be pretty freeform...  However
we need to be very careful here as this is effectively defining a large
chunk of new ABI.

This isn't a thing that I have a particularly clear view on (as you
might be able to tell ;).  Other opinions sought!

Jonathan
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
> 
> patch added in v2
> 
>  drivers/hwmon/iio_hwmon.c | 77 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 68 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
> index c0da4d9..28d15b2 100644
> --- a/drivers/hwmon/iio_hwmon.c
> +++ b/drivers/hwmon/iio_hwmon.c
> @@ -16,6 +16,7 @@
>  #include <linux/of.h>
>  #include <linux/hwmon-sysfs.h>
>  #include <linux/iio/consumer.h>
> +#include <linux/iio/iio.h>
>  #include <linux/iio/types.h>
>  
>  /**
> @@ -57,12 +58,26 @@ static ssize_t iio_hwmon_read_val(struct device *dev,
>  	return sprintf(buf, "%d\n", result);
>  }
>  
> +static ssize_t iio_hwmon_read_label(struct device *dev,
> +				    struct device_attribute *attr,
> +				    char *buf)
> +{
> +	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
> +	struct iio_hwmon_state *state = dev_get_drvdata(dev);
> +	const char *label = state->channels[sattr->index].channel->extend_name;
> +
> +	if (label)
> +		return sprintf(buf, "%s\n", label);
> +
> +	return 0;
> +}
> +
>  static int iio_hwmon_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct iio_hwmon_state *st;
> -	struct sensor_device_attribute *a;
> -	int ret, i;
> +	struct sensor_device_attribute *a, *b;
> +	int ret, i, j = 0;
>  	int in_i = 1, temp_i = 1, curr_i = 1, humidity_i = 1;
>  	enum iio_chan_type type;
>  	struct iio_channel *channels;
> @@ -92,7 +107,8 @@ static int iio_hwmon_probe(struct platform_device *pdev)
>  		st->num_channels++;
>  
>  	st->attrs = devm_kzalloc(dev,
> -				 sizeof(*st->attrs) * (st->num_channels + 1),
> +				 sizeof(*st->attrs) *
> +				 (2 * st->num_channels + 1),
>  				 GFP_KERNEL);
>  	if (st->attrs == NULL) {
>  		ret = -ENOMEM;
> @@ -107,6 +123,18 @@ static int iio_hwmon_probe(struct platform_device *pdev)
>  		}
>  
>  		sysfs_attr_init(&a->dev_attr.attr);
> +
> +		b = NULL;
> +		if (st->channels[i].channel->extend_name) {
> +			b = devm_kzalloc(dev, sizeof(*b), GFP_KERNEL);
> +			if (b == NULL) {
> +				ret = -ENOMEM;
> +				goto error_release_channels;
> +			}
> +
> +			sysfs_attr_init(&b->dev_attr.attr);
> +		}
> +
>  		ret = iio_get_channel_type(&st->channels[i], &type);
>  		if (ret < 0)
>  			goto error_release_channels;
> @@ -115,35 +143,66 @@ static int iio_hwmon_probe(struct platform_device *pdev)
>  		case IIO_VOLTAGE:
>  			a->dev_attr.attr.name = kasprintf(GFP_KERNEL,
>  							  "in%d_input",
> -							  in_i++);
> +							  in_i);
> +			if (b)
> +				b->dev_attr.attr.name = kasprintf(GFP_KERNEL,
> +								  "in%d_label",
> +								  in_i);
> +			in_i++;
>  			break;
>  		case IIO_TEMP:
>  			a->dev_attr.attr.name = kasprintf(GFP_KERNEL,
>  							  "temp%d_input",
> -							  temp_i++);
> +							  temp_i);
> +
> +			if (b)
> +				b->dev_attr.attr.name = kasprintf(GFP_KERNEL,
> +								  "temp%d_label",
> +								  temp_i);
> +			temp_i++;
>  			break;
>  		case IIO_CURRENT:
>  			a->dev_attr.attr.name = kasprintf(GFP_KERNEL,
>  							  "curr%d_input",
> -							  curr_i++);
> +							  curr_i);
> +
> +			if (b)
> +				b->dev_attr.attr.name = kasprintf(GFP_KERNEL,
> +								  "curr%d_label",
> +								  curr_i);
> +			curr_i++;
>  			break;
>  		case IIO_HUMIDITYRELATIVE:
>  			a->dev_attr.attr.name = kasprintf(GFP_KERNEL,
>  							  "humidity%d_input",
> -							  humidity_i++);
> +							  humidity_i);
> +
> +			if (b)
> +				b->dev_attr.attr.name = kasprintf(GFP_KERNEL,
> +								  "humidity%d_label",
> +								  humidity_i);
> +			humidity_i++;
>  			break;
>  		default:
>  			ret = -EINVAL;
>  			goto error_release_channels;
>  		}
> -		if (a->dev_attr.attr.name == NULL) {
> +		if (a->dev_attr.attr.name == NULL ||
> +		    (b && b->dev_attr.attr.name == NULL)) {
>  			ret = -ENOMEM;
>  			goto error_release_channels;
>  		}
>  		a->dev_attr.show = iio_hwmon_read_val;
>  		a->dev_attr.attr.mode = S_IRUGO;
>  		a->index = i;
> -		st->attrs[i] = &a->dev_attr.attr;
> +		st->attrs[j++] = &a->dev_attr.attr;
> +
> +		if (b) {
> +			b->dev_attr.show = iio_hwmon_read_label;
> +			b->dev_attr.attr.mode = S_IRUGO;
> +			b->index = i;
> +			st->attrs[j++] = &b->dev_attr.attr;
> +		}
>  	}
>  
>  	st->attr_group.attrs = st->attrs;
> 

