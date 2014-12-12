Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46830 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964856AbaLLKWw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Dec 2014 05:22:52 -0500
Message-ID: <548AC1FA.10704@kernel.org>
Date: Fri, 12 Dec 2014 10:22:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 02/11] staging:iio:sca3000: Don't enable channels by default
References: <1417024517-7564-1-git-send-email-lars@metafoo.de>	<1417024517-7564-3-git-send-email-lars@metafoo.de> <CAEnQRZBYGLyRYo65i2JE0gu3hN0c75V7089xY-bxqPorGOYMQA@mail.gmail.com>
In-Reply-To: <CAEnQRZBYGLyRYo65i2JE0gu3hN0c75V7089xY-bxqPorGOYMQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/12/14 22:51, Daniel Baluta wrote:
> On Wed, Nov 26, 2014 at 7:55 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> The convention for IIO devices is that all channels are disabled by default.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
Applied.
> 
>> ---
>>  drivers/staging/iio/accel/sca3000_core.c | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
>> index e4e5639..cd46a61 100644
>> --- a/drivers/staging/iio/accel/sca3000_core.c
>> +++ b/drivers/staging/iio/accel/sca3000_core.c
>> @@ -1159,11 +1159,6 @@ static int sca3000_probe(struct spi_device *spi)
>>                                   ARRAY_SIZE(sca3000_channels));
>>         if (ret < 0)
>>                 goto error_unregister_dev;
>> -       if (indio_dev->buffer) {
>> -               iio_scan_mask_set(indio_dev, indio_dev->buffer, 0);
>> -               iio_scan_mask_set(indio_dev, indio_dev->buffer, 1);
>> -               iio_scan_mask_set(indio_dev, indio_dev->buffer, 2);
>> -       }
>>
>>         if (spi->irq) {
>>                 ret = request_threaded_irq(spi->irq,
>> --
>> 1.8.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

