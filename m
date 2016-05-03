Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34639 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755835AbcECUKD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2016 16:10:03 -0400
Received: by mail-oi0-f48.google.com with SMTP id k142so40758042oib.1
        for <linux-iio@vger.kernel.org>; Tue, 03 May 2016 13:10:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5728E6C2.1050901@gmail.com>
References: <1458825486-17188-1-git-send-email-linus.walleij@linaro.org>
	<1458825486-17188-3-git-send-email-linus.walleij@linaro.org>
	<5728E6C2.1050901@gmail.com>
Date: Tue, 3 May 2016 22:10:01 +0200
Message-ID: <CACRpkdaLc8frud64VZEuQ=dXGpgk+kBj94otoCCC=-Pvoe09tw@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: st_sensors: verify interrupt event to status
From: Linus Walleij <linus.walleij@linaro.org>
To: Crestez Dan Leonard <cdleonard@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, May 3, 2016 at 7:58 PM, Crestez Dan Leonard <cdleonard@gmail.com> wrote:
> On 03/24/2016 03:18 PM, Linus Walleij wrote:
>> This makes all ST sensor drivers check that they actually have
>> new data available for the requested channel(s) before claiming
>> an IRQ, by reading the status register (which is conveniently
>> the same for all ST sensors) and check that the channel has new
>> data before proceeding to read it and fill the buffer.
>>
>> This way sensors can share an interrupt line: it can be flaged
>> as shared and then the sensor that did not fire will return
>> NO_IRQ, and the sensor that fired will handle the IRQ and
>> return IRQ_HANDLED.
>>
(...)
>> +     /* If we have a status register, check if this IRQ came from us */
>> +     if (sdata->sensor_settings->drdy_irq.addr_stat_drdy) {
>> +             u8 status;
>> +
>> +             len = sdata->tf->read_byte(&sdata->tb, sdata->dev,
>> +                        sdata->sensor_settings->drdy_irq.addr_stat_drdy,
>> +                        &status);
>> +             if (len < 0)
>> +                     dev_err(sdata->dev, "could not read channel status\n");
>> +
>> +             /*
>> +              * If this was not caused by any channels on this sensor,
>> +              * return IRQ_NONE
>> +              */
>> +             if (!(status & (u8)indio_dev->active_scan_mask[0]))
>> +                     return IRQ_NONE;
>> +     }
>>
> This seems to break software trigger mode when the timer frequency is
> higher that the device polling frequency. In that case it is possible to
> poll multiple times between updates and the first time this happens
> further updates hang.

OK I understand This is a hard IRQ handler for DRDY.

We need to avoid checking the status register with software triggers.
I guess it's possible to see in struct iio_dev whether we get called
from a software trigger?

Can you give me instructions on how to reproduce the error so I
can verify that I fix it? I never managed to get software triggers
to work :(

> Even with hardware triggers: are you sure this is correct? Shouldn't
> iio_trigger_notify_done still get called even when there is nothing to do?

No then the (hardware) IRQ can have come in from some other
device sharing the line with the peripheral and we need to return
IRQ_NONE. It's not our interrupt.

Yours,
Linus Walleij
