Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:54160 "EHLO
        smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755550AbcHXOZr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Aug 2016 10:25:47 -0400
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
        by smtpfb2-g21.free.fr (Postfix) with ESMTP id 05945D1A912
        for <linux-iio@vger.kernel.org>; Wed, 24 Aug 2016 16:25:42 +0200 (CEST)
Subject: Re: [PATCH] iio: dac: AD8801: add Analog Devices AD8801/AD8803
 support
To: Lars-Peter Clausen <lars@metafoo.de>,
        Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>,
        linux-iio@vger.kernel.org
References: <20160824135301.6263-1-gwenhael.goavec-merou@trabucayre.com>
 <20160824135301.6263-2-gwenhael.goavec-merou@trabucayre.com>
 <121a7e50-e17c-5865-52ae-ca5abc176a6e@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Paul Cercueil <paul.cercueil@analog.com>,
        Gwenhael <gwe@trabucayre.com>
From: gwenhael <gwenj@trabucayre.com>
Message-ID: <bc91330b-48a9-e2ce-29fe-f94c231c5159@trabucayre.com>
Date: Wed, 24 Aug 2016 16:25:17 +0200
MIME-Version: 1.0
In-Reply-To: <121a7e50-e17c-5865-52ae-ca5abc176a6e@metafoo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 24/08/2016 16:09, Lars-Peter Clausen wrote:
> Hi,
>
> Thanks for the patch, very good work. Looks mostly good, a few comments inline.
>
> Also please run the patch through scripts/checkpatch.pl there are a couple
> of whitespace issues here and there (extra space at the end of the line, etc.).
Thanks for your review. It's strange, on my computer no warnings about 
whitespace
are displayed by checkpatch.pl. I need to check by hand.

Gwenhael
> On 08/24/2016 03:53 PM, Gwenhael Goavec-Merou wrote:
>> From: Gwenhael <gwe@trabucayre.com>
>>
>> Add support for Analog Devices AD8801/AD8803, 8 channels 8bits, Digital to Analog
>> converters.
>>
>> Signed-off-by: Gwenhael <gwe@trabucayre.com>
> Signed-off-by and from usually should be your full name.
>
>
> [...]
>> +
>> +#include <linux/iio/iio.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_gpio.h>
> The driver does not seem to make use of the of.h or of_gpio.h APIs
>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/sysfs.h>
>> +#define AD8801_CHANNEL(chan) {		\
>> +	.type = IIO_VOLTAGE,			\
>> +	.indexed = 1,				\
>> +	.output = 1,				\
>> +	.channel = (chan + 1),			\
> Channel numbers should start at 0, even if the hardware device starts
> numbering at 1. There is the datasheet_field where you can store the name
> listed in the datasheet. E.g. in this case "O1", "O2", ...
>
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
>> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |  \
>> +		BIT(IIO_CHAN_INFO_OFFSET), \
>> +	.address = chan,			\
>> +}
>> +
>> +const struct iio_chan_spec ad8801_channels[] = {
> Should be static since it is not used outside of the driver.
>
>> +	AD8801_CHANNEL(0),
>> +	AD8801_CHANNEL(1),
>> +	AD8801_CHANNEL(2),
>> +	AD8801_CHANNEL(3),
>> +	AD8801_CHANNEL(4),
>> +	AD8801_CHANNEL(5),
>> +	AD8801_CHANNEL(6),
>> +	AD8801_CHANNEL(7),
>> +};
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

