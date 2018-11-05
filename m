Return-Path: <SRS0=GRG1=NQ=gmail.com=songqiang1304521@kernel.org>
Subject: Re: [PATCH v5 3/3] iio: magnetometer: Add driver support for PNI
 RM3100
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
 mark.rutland@arm.com, preid@electromag.com.au, himanshujha199640@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20181102074209.12620-1-songqiang1304521@gmail.com>
 <20181102074209.12620-4-songqiang1304521@gmail.com>
 <20181103171900.601537e3@archlinux>
From: Song Qiang <songqiang1304521@gmail.com>
Message-ID: <716779d7-4fcc-9914-cf73-0b852902c9bd@gmail.com>
Date: Mon, 5 Nov 2018 09:19:29 +0800
MIME-Version: 1.0
In-Reply-To: <20181103171900.601537e3@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>


On 2018/11/4 上午1:19, Jonathan Cameron wrote:
> On Fri,  2 Nov 2018 15:42:09 +0800
> Song Qiang <songqiang1304521@gmail.com> wrote:
>
>
...
>> +int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
>> +{
>> +	struct iio_dev *indio_dev;
>> +	struct rm3100_data *data;
>> +	unsigned int tmp;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	data = iio_priv(indio_dev);
>> +	data->regmap = regmap;
>> +
>> +	mutex_init(&data->lock);
>> +
>> +	indio_dev->dev.parent = dev;
>> +	indio_dev->name = "rm3100";
>> +	indio_dev->info = &rm3100_info;
>> +	indio_dev->channels = rm3100_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(rm3100_channels);
>> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
>> +	indio_dev->currentmode = INDIO_DIRECT_MODE;
> Huh. That's an interesting one... Looks like a bug in the core to me that
> somehow has never bitten us as no driver has ever done anything other
> than explicitly match against other modes.  No one sets currentmode
> directly so we should be good just putting this in the core as long
> as a device supports direct mode.  I'll look at that when I get a moment.
>
Hi Jonathan,

Last patch series I submit had 'case 0' for threaded function of interrupt 
handler. That's just because of this. I greped INDIO_DIRECT_MODE in iio folder, 
and found out that the iio core only set the driver mode to INDIO_DIRECT_MODE 
when it leaves buffer mode. Originally I thought when I call 
'iio_claim_direct_mode()' the currentmode should be set to INDIO_DIRECT_MODE.

This problem would lead to a potential bug if someone installed the device and 
use single-shot mode before any buffered read(I met this).

Though it seems like not many drivers use the same architecture I'm using, they 
don't need to check current mode, I'll look into more drivers.

st_sensors_core.c:589 seems like to choose to treat this as it's a 
bi-conditional situation with 'if it's in INDIO_BUFFER_TRIGGERED mode, if it's 
not, no matter what value it is, it's in INDIO_DIRECT_MODE.'


yours,

Song Qiang

...
