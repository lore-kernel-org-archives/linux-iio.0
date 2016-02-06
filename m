Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41181 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbcBFSi4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 6 Feb 2016 13:38:56 -0500
Subject: Re: [PATCH] iio: chemical: select IRQ_WORK for ATLAS ph sensor
To: Matt Ranostay <mranostay@gmail.com>, Arnd Bergmann <arnd@arndb.de>
References: <5127664.OXcBoKUPQO@wuerfel>
 <CAKzfze8b7Q4ZHyXW=wq4K2ETFoMrfERpTci2dSAzSgCCrWpnzg@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56B63DBE.8040507@kernel.org>
Date: Sat, 6 Feb 2016 18:38:54 +0000
MIME-Version: 1.0
In-Reply-To: <CAKzfze8b7Q4ZHyXW=wq4K2ETFoMrfERpTci2dSAzSgCCrWpnzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/02/16 07:55, Matt Ranostay wrote:
> Reviewed-by: Matt Ranostay <mranostay@gmail.com>
> 
> On Tue, Feb 2, 2016 at 6:36 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> The newly added atlas-ph-sensor driver uses irq_work_queue, which
>> may not always be enabled:
>>
>> ERROR: "irq_work_queue" [drivers/iio/chemical/atlas-ph-sensor.ko] undefined!
>>
>> This adds a 'select' statement to Kconfig to ensure it's there
>> when we need it.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Fixes: 27dec00ecf2d ("iio: chemical: add Atlas pH-SM sensor support")
>>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to fail to spot and IRQ_WORK related issues ;)

Thanks,

Jonathan
>> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
>> index ce7cd1370f74..f73290f84c90 100644
>> --- a/drivers/iio/chemical/Kconfig
>> +++ b/drivers/iio/chemical/Kconfig
>> @@ -10,6 +10,7 @@ config ATLAS_PH_SENSOR
>>         select REGMAP_I2C
>>         select IIO_BUFFER
>>         select IIO_TRIGGERED_BUFFER
>> +       select IRQ_WORK
>>         help
>>          Say Y here to build I2C interface support for the Atlas
>>          Scientific OEM pH-SM sensor.
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

