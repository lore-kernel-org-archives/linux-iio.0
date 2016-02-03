Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33422 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbcBCOUl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Feb 2016 09:20:41 -0500
Received: by mail-wm0-f65.google.com with SMTP id r129so7649823wmr.0
        for <linux-iio@vger.kernel.org>; Wed, 03 Feb 2016 06:20:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1602031122350.12205@pmeerw.net>
References: <1454494947-9073-1-git-send-email-daniel.baluta@intel.com>
	<alpine.DEB.2.02.1602031122350.12205@pmeerw.net>
Date: Wed, 3 Feb 2016 16:20:40 +0200
Message-ID: <CAEnQRZDxQ4KCX_paZCf0iGjZ1rp-qeF1BGKgWoQZOhUYk_fi1g@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: Add TI ADS1015 ADC driver support
From: Daniel Baluta <daniel.baluta@intel.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Feb 3, 2016 at 12:34 PM, Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:
> On Wed, 3 Feb 2016, Daniel Baluta wrote:
>
>> The driver has sysfs readings with runtime PM support for power saving.
>> It also offers buffer support that can be used together with IIO software
>> triggers.
>
> comments below

Hi Peter,

Thanks a lot for review. See comments inline.

<snip>

>> +
>> +       This driver can also be built as a module. If so, the module will be
>> +       called ti-ads1015.
>> +
>
> extra newline
Ack. Will fix.

<snip>

>> +#define ADS1015_V_CHAN(_chan, _addr) {                               \
>> +     .type = IIO_VOLTAGE,                                    \
>> +     .indexed = 1,                                           \
>> +     .address = _addr,                                       \
>> +     .channel = _chan,                                       \
>> +     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |          \
>> +                             BIT(IIO_CHAN_INFO_SCALE) |      \
>> +                             BIT(IIO_CHAN_INFO_SAMP_FREQ),   \
>
> really separate _SCALE, _SAMP_FREQ; probably _by_type

This is a good suggestion. Anyhow I want to keep this driver
"compatbile" with hwmon DT attributes where scale and samp_freq
are configurable per channel.


>
>> +     .scan_index = _addr,                                    \
>> +     .scan_type = {                                          \
>> +             .sign = 's',                                    \
>> +             .realbits = 12,                                 \
>> +             .storagebits = 16,                              \
>> +             .shift = 4,                                     \
>> +             .endianness = IIO_CPU,                          \
>
> I don't see the code for endianness conversion, I guess it should be _BE
> (also below)

Conversion register is _BE but I think here is better to use IIO_CPU.
regmap_read() encapsulates a lot of magic, it actually does the endianness
conversion.

regmap_config has val_format_endian field which tells the core how it should
treat the registers read/writes regarding endianness. By default is big endian,
like our conversion register.

Also, after each regmap_read operation there is a call to parse_val() which
converts the value read from reg endianess to cpu endianness (in our case
there is a transparent call  to b16_to_cpu).

<snip>

>> +     ret = regmap_read(data->regmap, ADS1015_CONV_REG, val);
>
> just
> return regmap_read(...);

Ack. Will fix.

>
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     return 0;
>> +}
>> +
>> +static irqreturn_t ads1015_trigger_handler(int irq, void *p)
>> +{
>> +     struct iio_poll_func *pf = p;
>> +     struct iio_dev *indio_dev = pf->indio_dev;
>> +     struct ads1015_data *data = iio_priv(indio_dev);
>> +     s16 buf[3]; /* 1 x s16 ADC reading + 2 x s16 timestamp */
>
> should be
> s16 buf[8] (1x s16 + 3x s16 padding + 4x s16 timestamp)

You are right. I must be smoking something really good :D.

<snip>

>> +
>> +             /* 12 bit res, D0 is bit 4 in conversion register */
>
> need endianness conversion here

As explained above this is already converted by regmap core.

<snip>

>> +
>> +     switch (mask) {
>> +     case IIO_CHAN_INFO_SCALE:
>> +             mutex_lock(&data->lock);
>
> locking could be outside of switch

Hmm, ok.

>
>> +             ret = ads1015_set_scale(data, chan->address, val, val2);


thanks,
Daniel.
