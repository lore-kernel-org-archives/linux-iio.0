Return-Path: <SRS0=oeOV=MY=gmail.com=songqiang1304521@kernel.org>
Subject: Re: [PATCH v4 3/3] iio: magnetometer: Add driver support for PNI
 RM3100
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 robh+dt@kernel.org, mark.rutland@arm.com, preid@electromag.com.au,
 himanshujha199640@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20181002143812.3661-1-songqiang1304521@gmail.com>
 <20181012073536.20339-1-songqiang1304521@gmail.com>
 <20181012073536.20339-4-songqiang1304521@gmail.com>
From: Song Qiang <songqiang1304521@gmail.com>
Message-ID: <436097c6-b32b-42e4-e704-a15280e13cb0@gmail.com>
Date: Fri, 12 Oct 2018 16:36:01 +0800
MIME-Version: 1.0
In-Reply-To: <20181012073536.20339-4-songqiang1304521@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 2018年10月12日 15:35, Song Qiang wrote:
> PNI RM3100 is a high resolution, large signal immunity magnetometer,
> composed of 3 single sensors and a processing chip with a MagI2C
> interface.
>
...
> +static irqreturn_t rm3100_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	unsigned long scan_mask = *indio_dev->active_scan_mask;
> +	unsigned int mask_len = indio_dev->masklength;
> +	struct rm3100_data *data = iio_priv(indio_dev);
> +	struct regmap *regmap = data->regmap;
> +	int ret, i, bit;
> +
> +	mutex_lock(&data->lock);
> +	switch (scan_mask) {
> +	case BIT(0) | BIT(1) | BIT(2):
> +		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 9);
> +		mutex_unlock(&data->lock);
> +		if (ret < 0)
> +			goto done;
> +	break;
> +	case BIT(0) | BIT(1):
> +		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 6);
> +		mutex_unlock(&data->lock);
> +		if (ret < 0)
> +			goto done;
> +	break;
> +	case BIT(1) | BIT(2):
> +		ret = regmap_bulk_read(regmap, RM3100_REG_MY2, data->buffer, 6);
> +		mutex_unlock(&data->lock);
> +		if (ret < 0)
> +			goto done;
> +	break;
Hi Jonathan,

I just noticed that these three breaks are not proper aligned.

yours,
Song Qiang
