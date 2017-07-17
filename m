Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:35753 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbdGQNoj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jul 2017 09:44:39 -0400
MIME-Version: 1.0
In-Reply-To: <763a9b76-e2a4-767c-25a9-73ccc3fd3014@metafoo.de>
References: <20170717123426.25095-1-gehariprasath@gmail.com> <763a9b76-e2a4-767c-25a9-73ccc3fd3014@metafoo.de>
From: hari prasath <gehariprasath@gmail.com>
Date: Mon, 17 Jul 2017 19:14:37 +0530
Message-ID: <CAHHWPbfJopvP_7VREbf9ULyFFQNBDLHufvxzK+_zS7P2b_NF1Q@mail.gmail.com>
Subject: Re: [PATCHv2] staging: iio: adc: add missing of_node references to iio_dev
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I agree that it's initialized in the core IIO driver. Also I have
screwed up the patch.

Regards,
Hari

On 17 July 2017 at 18:47, Lars-Peter Clausen <lars@metafoo.de> wrote:
> Hi,
>
> The patch seems to be reverted?
>
> Also should this part in the IIO core take care of automatically setting the
> of_node of the IIO device? As far as I can see we don't have to initialize
> it manually.
>
>     /* If the calling driver did not initialize of_node, do it here */
>     if (!indio_dev->dev.of_node && indio_dev->dev.parent)
>         indio_dev->dev.of_node = indio_dev->dev.parent->of_node;
>
> - Lars
>
> On 07/17/2017 02:34 PM, Hari Prasath wrote:
>> Adding missing indio_dev->dev.of_node references to allow iio consumers
>> to access the device channels.
>>
>> Signed-off-by: Hari Prasath <gehariprasath@gmail.com>
>> ---
>>       v2: Wrong from mail ID in first version of patch
>> ---
>>  drivers/staging/iio/adc/ad7192.c | 1 -
>>  drivers/staging/iio/adc/ad7780.c | 1 -
>>  2 files changed, 2 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
>> index 78308a5..d11c6de 100644
>> --- a/drivers/staging/iio/adc/ad7192.c
>> +++ b/drivers/staging/iio/adc/ad7192.c
>> @@ -668,7 +668,6 @@ static int ad7192_probe(struct spi_device *spi)
>>       spi_set_drvdata(spi, indio_dev);
>>       st->devid = spi_get_device_id(spi)->driver_data;
>>       indio_dev->dev.parent = &spi->dev;
>> -     indio_dev->dev.of_node = spi->dev.of_node;
>>       indio_dev->name = spi_get_device_id(spi)->name;
>>       indio_dev->modes = INDIO_DIRECT_MODE;
>>
>> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
>> index e38d2ab9..dec3ba6 100644
>> --- a/drivers/staging/iio/adc/ad7780.c
>> +++ b/drivers/staging/iio/adc/ad7780.c
>> @@ -195,7 +195,6 @@ static int ad7780_probe(struct spi_device *spi)
>>       spi_set_drvdata(spi, indio_dev);
>>
>>       indio_dev->dev.parent = &spi->dev;
>> -     indio_dev->dev.of_node = spi->dev.of_node;
>>       indio_dev->name = spi_get_device_id(spi)->name;
>>       indio_dev->modes = INDIO_DIRECT_MODE;
>>       indio_dev->channels = &st->chip_info->channel;
>>
>



-- 
Regards,
G.E.Hari Prasath
