Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from david.siemens.de ([192.35.17.14]:51775 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751374AbdEHIjx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 May 2017 04:39:53 -0400
Subject: Re: [PATCH v4] iio: adc: Add support for TI ADC108S102 and ADC128S102
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <8645139f-3ad5-8567-48e5-f2e775fc4da2@siemens.com>
 <CAHp75Ve1JpzhXHeD0Razf-4F53qA6VrFjoWOQcK6phk+1Hkr3Q@mail.gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <483e2618-fbde-0f3d-e715-19fe1358b5a7@siemens.com>
Date: Mon, 8 May 2017 10:39:43 +0200
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve1JpzhXHeD0Razf-4F53qA6VrFjoWOQcK6phk+1Hkr3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-05-08 10:25, Andy Shevchenko wrote:
> On Mon, May 8, 2017 at 10:49 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> This is an upstream port of an IIO driver for the TI ADC108S102 and
>> ADC128S102. The former can be found on the Intel Galileo Gen2 and the
>> Siemens SIMATIC IOT2000. For those boards, ACPI-based enumeration is
>> included.
>>
>> Due to the lack of regulators under ACPI, we hard-code the voltage
>> provided to the VA pin of the ADC to 5 V, the value used on Galileo and
>> IOT2000. For DT usage, the regulator "vref-supply" provides this
>> information. Note that DT usage has not been tested.
>>
>> Original author: Bogdan Pricop <bogdan.pricop@emutex.com>
>> Ported from Intel Galileo Gen2 BSP to Intel Yocto kernel:
>> Todor Minchev <todor@minchev.co.uk>.
>>
> 
>> +static int adc108s102_read_raw(struct iio_dev *indio_dev,
>> +                              struct iio_chan_spec const *chan,
>> +                              int *val, int *val2, long m)
>> +{
>> +       struct adc108s102_state *st = iio_priv(indio_dev);
>> +       int ret;
>> +
>> +       switch (m) {
>> +       case IIO_CHAN_INFO_RAW:
>> +               ret = iio_device_claim_direct_mode(indio_dev);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               ret = adc108s102_scan_direct(st, chan->address);
>> +
>> +               iio_device_release_direct_mode(indio_dev);
>> +
>> +               if (ret < 0)
>> +                       return ret;
>> +
>> +               *val = ADC108S102_RES_DATA(ret);
>> +
>> +               return IIO_VAL_INT;
>> +       case IIO_CHAN_INFO_SCALE:
>> +               if (chan->type == IIO_VOLTAGE) {
>> +                       *val = st->va_millivolt;
>> +                       *val2 = chan->scan_type.realbits;
>> +                       return IIO_VAL_FRACTIONAL_LOG2;
> 
>> +               } else {
> 
> Redundant. and I would rather go with pattern
> 
> if (chan->type != IIO_VOLTAGE)
>  return -EINVAL;
> 
> ...
> return IIO_VAL_FRACTIONAL_LOG2;
> 
> _Or_ use
> 
> break;
> 
> here
> 
>> +                       return -EINVAL;
>> +               }
>> +       default:
>> +               return -EINVAL;
> 
> ...and here.
> 
>> +       }
> 
> ...and
> 
> return -EINVAL;
> 
> in one place.

OK.

> 
>> +}
> 
>> +       if (ACPI_COMPANION(&spi->dev)) {
>> +               st->va_millivolt = ADC108S102_VA_MV_ACPI_DEFAULT;
>> +       } else {
> 
>> +               st->reg = devm_regulator_get(&spi->dev, "vref");
> 
> I'm still not satisfied with this. Why we just can't use _optional()
> unconditionally?

Because - again - the regulator is NOT optional under DT.

> If regulator framework is broken it should be fixed first then.
> 
>> +               if (IS_ERR(st->reg))
>> +                       return PTR_ERR(st->reg);
>> +
>> +               ret = regulator_enable(st->reg);
>> +               if (ret < 0) {
>> +                       dev_err(&spi->dev, "Cannot enable vref regulator\n");
>> +                       return ret;
>> +               }
>> +
>> +               ret = regulator_get_voltage(st->reg);
>> +               if (ret < 0) {
>> +                       dev_err(&spi->dev, "vref get voltage failed\n");
>> +                       return ret;
>> +               }
>> +
>> +               st->va_millivolt = ret / 1000;
>> +       }
> 
>> +       if (!IS_ERR(st->reg))
> 
> I'm wondering why regulator framework does need this check.

Forgotten artifact from previous version, sorry. st->reg is now either
valid or NULL, and both cases are fine for disable.

Jan

> 
>> +               regulator_disable(st->reg);
> 

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
