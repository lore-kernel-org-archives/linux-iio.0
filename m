Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50553 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293Ab3KQOWg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Nov 2013 09:22:36 -0500
Message-ID: <5288DF7C.1070506@kernel.org>
Date: Sun, 17 Nov 2013 15:23:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Frank Zago <frank@zago.net>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH V2] iio:accel:kxsd9 fix missing mutex unlock
References: <1384383231-7897-1-git-send-email-jic23@kernel.org> <52841C2B.7080908@zago.net>
In-Reply-To: <52841C2B.7080908@zago.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/14/13 00:41, Frank Zago wrote:
> On 11/13/2013 04:53 PM, Jonathan Cameron wrote:
>> From: Frank Zago <frank@zago.net>
>>
>> This will leave a lock held after reading from the device, preventing
>> any further reads.
>>
>> Signed-off-by: Frank Zago <frank@zago.net>
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>> ---
>>
>> This is Frank's original patch.  As Lars-Peter pointed out, I really didn't
>> think my way through my shortened (and incorrect version).
>>
>> Oops!
>>
>> Frank, just to check, are you fine signing off on this?
> 
> Yes. It's good.
> 
Applied to the fixes-togreg branch of iio.git
Also marked this as for stable.

Thanks,
> Frank.
> 
>>
>>  drivers/iio/accel/kxsd9.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
>> index d72118d1189c..98ba761cbb9c 100644
>> --- a/drivers/iio/accel/kxsd9.c
>> +++ b/drivers/iio/accel/kxsd9.c
>> @@ -112,9 +112,10 @@ static int kxsd9_read(struct iio_dev *indio_dev, u8 address)
>>  	mutex_lock(&st->buf_lock);
>>  	st->tx[0] = KXSD9_READ(address);
>>  	ret = spi_sync_transfer(st->us, xfers, ARRAY_SIZE(xfers));
>> -	if (ret)
>> -		return ret;
>> -	return (((u16)(st->rx[0])) << 8) | (st->rx[1] & 0xF0);
>> +	if (!ret)
>> +		ret = (((u16)(st->rx[0])) << 8) | (st->rx[1] & 0xF0);
>> +	mutex_unlock(&st->buf_lock);
>> +	return ret;
>>  }
>>  
>>  static IIO_CONST_ATTR(accel_scale_available,
>>
> 
