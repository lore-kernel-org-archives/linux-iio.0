Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42633 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932141AbaKENpU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Nov 2014 08:45:20 -0500
Message-ID: <545A29EF.9010204@kernel.org>
Date: Wed, 05 Nov 2014 13:45:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>,
	George McCollister <george.mccollister@gmail.com>,
	mranostay@gmail.com
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: as3935: allocate correct iio_device size
References: <1414770263-13146-1-git-send-email-george.mccollister@gmail.com> <54594840.3050302@gmx.de>
In-Reply-To: <54594840.3050302@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/11/14 21:42, Hartmut Knaack wrote:
> George McCollister schrieb am 31.10.2014 16:44:
>> Signed-off-by: George McCollister <george.mccollister@gmail.com>
> Acked-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
>> ---
>>  drivers/iio/proximity/as3935.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
>> index 5e780ef..8349cc0 100644
>> --- a/drivers/iio/proximity/as3935.c
>> +++ b/drivers/iio/proximity/as3935.c
>> @@ -330,7 +330,7 @@ static int as3935_probe(struct spi_device *spi)
>>  		return -EINVAL;
>>  	}
>>  
>> -	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(st));
>> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>>  	if (!indio_dev)
>>  		return -ENOMEM;
>>  
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
