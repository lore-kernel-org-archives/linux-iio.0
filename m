Return-Path: <lars@metafoo.de>
Message-ID: <51DA7B8A.3060002@metafoo.de>
Date: Mon, 08 Jul 2013 10:42:50 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Hector Palacios <hector.palacios@digi.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "alexandre.belloni@free-electrons.com" <alexandre.belloni@free-electrons.com>,
 "jic23@kernel.org" <jic23@kernel.org>, "marex@denx.de" <marex@denx.de>,
 "fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
Subject: Re: [PATCH 3/4] iio: mxs-lradc: add scale_available file to channels
References: <1373013039-19461-1-git-send-email-hector.palacios@digi.com> <1373013039-19461-4-git-send-email-hector.palacios@digi.com> <51D6A282.4040506@metafoo.de> <51DA77E8.3020803@digi.com>
In-Reply-To: <51DA77E8.3020803@digi.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 07/08/2013 10:27 AM, Hector Palacios wrote:
> Dear Lars,
> 
> On 07/05/2013 12:40 PM, Lars-Peter Clausen wrote:
>> On 07/05/2013 10:30 AM, Hector Palacios wrote:
>> [...]
>>> +#define SHOW_SCALE_AVAILABLE_FUNC(ch)                     \
>>> +static ssize_t mxs_lradc_show_scale_available##ch(struct device *dev,    \
>>> +        struct device_attribute *attr,                 \
>>> +        char *buf)                        \
>>> +{                                     \
>>> +    return c ch);    \
>>> +}
>>
>> No need for a separate function for each channel. Use the address attribute
>> of the iio_dev_attr. E.g.
>>
>> struct iio_dev_attr *iio_attr = to_iio_dev_attr(attr);
>>
>> return mxs_lradc_show_scale_available_ch(dev, attr, buf, iio_attr->address);
>>
>> The last parameter to IIO_DEVICE_ATTR initializes this field.
> 
> Nice, I knew there had to be a better way.
> 
>> But I think you can need less boilerplate code if you use the
>> iio_chan_spec_ext_info feature. Take a look at IIO_ENUM_AVAILABLE and
>> friends to see how it is done.
> 
> I just took a look but don't know how I can use this framework with scales,
> as a scale is an array composed of two numbers (integer and fractional
> parts), not simple strings which is what iio_enum.items expects.

Yes, using iio_enum won't work in this case, but you can use it as an
inspiration for your own solution.

- Lars
