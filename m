Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36787 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755163AbdEULPd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 May 2017 07:15:33 -0400
Subject: Re: [PATCH v5 7/9] iio: light: rpr0521 proximity offset read/write
To: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-iio@vger.kernel.org
References: <1495109577-29596-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <1495109577-29596-8-git-send-email-mikko.koivunen@fi.rohmeurope.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ed7f2290-7780-de7d-971f-47d9bba7f348@kernel.org>
Date: Sun, 21 May 2017 12:15:31 +0100
MIME-Version: 1.0
In-Reply-To: <1495109577-29596-8-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/05/17 13:12, Mikko Koivunen wrote:
> Add sysfs read/write proximity offset feature. Offset is read/write from
> sensor registers. Values are proximity raw 10-bit values. After applying
> offset value, output values will be (measured_raw - offset_value). Output
> values are unsigned so offset value doesn't make output negative.
> 
> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Applied.  Thanks
> ---
> Patch v1->v2 changes:
> read/write_ps_offset() rewritten with:
>   -  static, __le16, cpu_to_le16(), sizeof()
> Patch v2->v3 changes:
> RPR0521_*REG_*PS_OFFSET_LSB
> removed RPR0521_REG_PS_OFFSET_MSB
> Whitespace changes
> 
> checkpatch.pl OK
> Tested on LeMaker HiKey with AOSP7.1 kernel 4.4.
> Builds ok with torvalds/linux feb 27.
> 
>   drivers/iio/light/rpr0521.c |   52 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
> 
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index 0aac4bc..83b24d1 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -30,6 +30,7 @@
>   #define RPR0521_REG_PXS_DATA		0x44 /* 16-bit, little endian */
>   #define RPR0521_REG_ALS_DATA0		0x46 /* 16-bit, little endian */
>   #define RPR0521_REG_ALS_DATA1		0x48 /* 16-bit, little endian */
> +#define RPR0521_REG_PS_OFFSET_LSB	0x53
>   #define RPR0521_REG_ID			0x92
>   
>   #define RPR0521_MODE_ALS_MASK		BIT(7)
> @@ -218,6 +219,7 @@ static const struct iio_chan_spec rpr0521_channels[] = {
>   		.type = IIO_PROXIMITY,
>   		.address = RPR0521_CHAN_PXS,
>   		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_OFFSET) |
>   			BIT(IIO_CHAN_INFO_SCALE),
>   		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>   	}
> @@ -431,6 +433,40 @@ static int rpr0521_write_samp_freq_common(struct rpr0521_data *data,
>   		i);
>   }
>   
> +static int rpr0521_read_ps_offset(struct rpr0521_data *data, int *offset)
> +{
> +	int ret;
> +	__le16 buffer;
> +
> +	ret = regmap_bulk_read(data->regmap,
> +		RPR0521_REG_PS_OFFSET_LSB, &buffer, sizeof(buffer));
> +
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Failed to read PS OFFSET register\n");
> +		return ret;
> +	}
> +	*offset = le16_to_cpu(buffer);
> +
> +	return ret;
> +}
> +
> +static int rpr0521_write_ps_offset(struct rpr0521_data *data, int offset)
> +{
> +	int ret;
> +	__le16 buffer;
> +
> +	buffer = cpu_to_le16(offset & 0x3ff);
> +	ret = regmap_raw_write(data->regmap,
> +		RPR0521_REG_PS_OFFSET_LSB, &buffer, sizeof(buffer));
> +
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Failed to write PS OFFSET register\n");
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
>   static int rpr0521_read_raw(struct iio_dev *indio_dev,
>   			    struct iio_chan_spec const *chan, int *val,
>   			    int *val2, long mask)
> @@ -490,6 +526,15 @@ static int rpr0521_read_raw(struct iio_dev *indio_dev,
>   
>   		return IIO_VAL_INT_PLUS_MICRO;
>   
> +	case IIO_CHAN_INFO_OFFSET:
> +		mutex_lock(&data->lock);
> +		ret = rpr0521_read_ps_offset(data, val);
> +		mutex_unlock(&data->lock);
> +		if (ret < 0)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +
>   	default:
>   		return -EINVAL;
>   	}
> @@ -518,6 +563,13 @@ static int rpr0521_write_raw(struct iio_dev *indio_dev,
>   
>   		return ret;
>   
> +	case IIO_CHAN_INFO_OFFSET:
> +		mutex_lock(&data->lock);
> +		ret = rpr0521_write_ps_offset(data, val);
> +		mutex_unlock(&data->lock);
> +
> +		return ret;
> +
>   	default:
>   		return -EINVAL;
>   	}
> 

