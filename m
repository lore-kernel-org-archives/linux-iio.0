Return-Path: <SRS0=fIpT=MH=electromag.com.au=preid@kernel.org>
Subject: Re: [PATCH 2/2] iio: magnetometer: Add driver support for PNI RM3100
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
  Song Qiang <songqiang1304521@gmail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
  robh+dt@kernel.org, mark.rutland@arm.com, rtresidd@electromag.com.au,
  linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org
References: <20180925031724.21399-1-songqiang1304521@gmail.com>
 <20180925031724.21399-2-songqiang1304521@gmail.com>
 <20180925143054.00007fcb@huawei.com>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <57d8a9d6-c402-068e-0a21-bbd6c20a7816@electromag.com.au>
Date: Tue, 25 Sep 2018 22:36:54 +0800
MIME-Version: 1.0
In-Reply-To: <20180925143054.00007fcb@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 25/09/2018 9:30 PM, Jonathan Cameron wrote:
>> +static irqreturn_t rm3100_trigger_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *indio_dev = pf->indio_dev;
>> +	struct rm3100_data *data = iio_priv(indio_dev);
>> +	struct regmap *regmap = data->regmap;
>> +	u8 buffer[9];
>> +	int ret;
>> +	int i;
>> +
>> +	mutex_lock(&data->lock);
>> +	ret = rm3100_wait_measurement(data);
>> +	if (ret < 0) {
>> +		mutex_unlock(&data->lock);
>> +		goto done;
>> +	}
>> +
>> +	ret = regmap_bulk_read(regmap, RM3100_REG_MX2, buffer, sizeof(buffer));
>> +	mutex_unlock(&data->lock);
>> +	if (ret < 0)
>> +		goto done;
>> +
>> +	/* Convert XXXYYYZZZxxx to XXXxYYYxZZZx. x for padding. */
>> +	for (i = 0; i < 3; i++)
>> +		memcpy(data->buffer + i * 4, buffer + i * 3, 3);
> Firstly X doesn't need copying.
> Secondly the copy of Y actually overwrites the value of Z
> XXXYYYZZZxxx
> XXXxYYYZZxxx
> XXXxYYYxYZZx
> 
> I think...
> 
>> +
>> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>> +			iio_get_time_ns(indio_dev));

memcpy target is a different buffer so should be ok.

But that raises the question of does it need to be?
'buffer' could be 12 bytes long and just shuffle Z then Y.
Do the unused bytes need to be zeroed? or does libiio mask them anyway?



-- 
Regards
Phil Reid
