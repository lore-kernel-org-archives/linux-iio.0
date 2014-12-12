Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46812 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965365AbaLLKVP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Dec 2014 05:21:15 -0500
Message-ID: <548AC199.7060009@kernel.org>
Date: Fri, 12 Dec 2014 10:21:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 01/11] staging:iio:ad5933: Don't enable channels by default
References: <1417024517-7564-1-git-send-email-lars@metafoo.de>	<1417024517-7564-2-git-send-email-lars@metafoo.de> <CAEnQRZC=kF4J3+qSwucW3Mk_Z3JgogAzN6hY9q08JcmOC6OVVA@mail.gmail.com>
In-Reply-To: <CAEnQRZC=kF4J3+qSwucW3Mk_Z3JgogAzN6hY9q08JcmOC6OVVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/12/14 22:51, Daniel Baluta wrote:
> On Wed, Nov 26, 2014 at 7:55 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> The convention for IIO devices is that all channels are disabled by default.
To be fair - it wasn't the convention when these were written ;)
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the togreg branch of iio.git.
It's just much easier to ensure their are no bugs and
everything is predictable.  This way we don't end up with
people relying on a particular set of channels being enabled.
> 
>> ---
>>  drivers/staging/iio/impedance-analyzer/ad5933.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
>> index b6bd609..aa6a368 100644
>> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
>> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
>> @@ -757,10 +757,6 @@ static int ad5933_probe(struct i2c_client *client,
>>         if (ret)
>>                 goto error_unreg_ring;
>>
>> -       /* enable both REAL and IMAG channels by default */
>> -       iio_scan_mask_set(indio_dev, indio_dev->buffer, 0);
>> -       iio_scan_mask_set(indio_dev, indio_dev->buffer, 1);
>> -
>>         ret = ad5933_setup(st);
>>         if (ret)
>>                 goto error_uninitialize_ring;
>> --
>> 1.8.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

