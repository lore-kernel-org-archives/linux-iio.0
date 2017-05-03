Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33115 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752098AbdECIGi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 May 2017 04:06:38 -0400
MIME-Version: 1.0
In-Reply-To: <8e6a0016-175a-8374-76f9-8bef1815f66f@siemens.com>
References: <c0fa84e3-1016-212f-280c-40bb83706895@siemens.com>
 <CAHp75VcG4qQktEOCXKc2saTNzpWo2sjneA4Afb7rHoEqkP8FtQ@mail.gmail.com> <8e6a0016-175a-8374-76f9-8bef1815f66f@siemens.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 3 May 2017 11:06:37 +0300
Message-ID: <CAHp75VeyQ=uU=X3DxcNtVKDqkQV=9wK42nDaxs4ztDBU5iKTRw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: Add support for TI ADC1x8s102
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, May 3, 2017 at 8:35 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 2017-05-02 22:53, Andy Shevchenko wrote:
>> On Tue, May 2, 2017 at 11:02 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>> This is an upstream port of an IIO driver for the TI ADC108S102 and
>>> ADC128S102. The former can be found on the Intel Galileo Gen2 and the
>>> Siemens SIMATIC IOT2000. For those boards, ACPI-based enumeration is
>>> included.

>>> +       cmds = 0;
>>> +       for_each_set_bit(bit, active_scan_mask, ADC108S102_MAX_CHANNELS)
>>> +               st->tx_buf[cmds++] = cpu_to_be16(ADC108S102_CMD(bit));
>>> +
>>> +       /* One dummy command added, to clock in the last response */
>>> +       st->tx_buf[cmds++] = 0x00;
>>> +
>>> +       /* build SPI ring message */
>>
>>> +       st->ring_xfer.tx_buf = &st->tx_buf[0];
>>> +       st->ring_xfer.rx_buf = &st->rx_buf[0];
>>
>> &pointer[0] -> pointer
>
> This is following patterns in other drivers, expressing you want the
> first element here. I'll keep it.

It doesn't sound fully correct. You need a pointer to the beginning of
the buffer.
I remember when Greg asked me to do same change and I agree with him
that time that this expression is kinda noisy.
I would agree with you if it would be indeed *one* element to address.

In any case it's a call of IIO maintainers (as I said it's a nitpick
from my side).

>>> +static int adc108s102_probe(struct spi_device *spi)
>>> +{
>>> +       struct adc108s102_state *st;
>>> +       struct iio_dev *indio_dev;
>>> +       u32 val;
>>> +       int ret;
>>> +
>>> +       indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>>> +       if (!indio_dev)
>>> +               return -ENOMEM;
>>> +
>>> +       st = iio_priv(indio_dev);
>>> +
>>
>>> +       ret = device_property_read_u32(&spi->dev, "ext-vin-microvolt", &val);
>>
>> Why not to read u16 here?
>>
>
> Can I read a property with arbitrary width? Then this would simplify
> things.

device_property_read_u16();

> Or do I have to follow how it was defined in the ACPI or device
> tree world?

For property by the way you have to either follow existing one (by
name and meaning), or you
you need get an Ack from DT people (Rob, for example) to introduce such.

Existing one is called "vref-external". So, definitely you need to
figure out this with DT people.

>>> +       st->ext_vin_mv = (u16)val;
>>
>> Casting is not needed.
>
> "Yes, I do want to cast this down." It's a recommended style for such
> cases.

Can you point to the documentation you are referring to?

> But it will be gone if we can read u16 directly.

Yes, you can do that.

>>> +error_disable_reg:
>>> +       regulator_disable(st->reg);
>>
>> Ditto.
>
> I do not find traces that devm-created regulators are auto-disabled. So
> this remains necessary.

Fair enough.

>>> +static struct spi_driver adc108s102_driver = {
>>> +       .driver = {
>>> +               .name   = "adc108s102",
>>
>>> +               .owner  = THIS_MODULE,
>>
>> This is redundant I'm pretty sure.
>
> Even in 2017, drivers keep being added that carry such assignments. Can
> you explain when it is needed and when not? Otherwise, I will leave it in.

The above I'm 100% sure is not needed. It's needed only in cases when
framework / device core doesn't do this for ya.

In the above case IIRC device core does it once for all.

-- 
With Best Regards,
Andy Shevchenko
