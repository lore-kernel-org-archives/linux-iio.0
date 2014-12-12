Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46884 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759315AbaLLK3L (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Dec 2014 05:29:11 -0500
Message-ID: <548AC375.7070100@kernel.org>
Date: Fri, 12 Dec 2014 10:29:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 04/11] staging:iio:sca3000: Register same channels for
 device and buffer
References: <1417024517-7564-1-git-send-email-lars@metafoo.de> <1417024517-7564-5-git-send-email-lars@metafoo.de> <5488CA94.3000406@gmx.de>
In-Reply-To: <5488CA94.3000406@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/12/14 22:35, Hartmut Knaack wrote:
> Lars-Peter Clausen schrieb am 26.11.2014 um 18:55:
>> In preparation for moving the buffer registration to the core make sure to
>> register the same channel array for the device and the buffer. Currently
>> the temperature channel is not registered for the buffer, setting its scan
>> index to -1 will make sure that it is skipped for the buffer.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Adjusted the indentation as Hartmut requested and applied to the togreg
branch of iio.git - pushed out as testing.
>> ---
>>  drivers/staging/iio/accel/sca3000_core.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
>> index cd46a61..9eedb93 100644
>> --- a/drivers/staging/iio/accel/sca3000_core.c
>> +++ b/drivers/staging/iio/accel/sca3000_core.c
>> @@ -459,6 +459,7 @@ static const struct iio_chan_spec sca3000_channels_with_temp[] = {
>>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
>>  			BIT(IIO_CHAN_INFO_OFFSET),
>> +		.scan_index = -1,
>>  	},
>>  };
>>  
>> @@ -1154,9 +1155,8 @@ static int sca3000_probe(struct spi_device *spi)
>>  	if (ret < 0)
>>  		return ret;
>>  
>> -	ret = iio_buffer_register(indio_dev,
>> -				  sca3000_channels,
>> -				  ARRAY_SIZE(sca3000_channels));
>> +	ret = iio_buffer_register(indio_dev, indio_dev->channels,
>> +		indio_dev->num_channels);
> Indentation could be better here, otherwise looking good to me (including
> previous patches in this series).
>>  	if (ret < 0)
>>  		goto error_unregister_dev;
>>  
>>
> 

