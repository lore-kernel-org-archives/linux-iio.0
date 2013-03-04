Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60094 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756679Ab3CDVCf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Mar 2013 16:02:35 -0500
Message-ID: <51350BE8.8040002@kernel.org>
Date: Mon, 04 Mar 2013 21:02:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 37/67] iio:imu:adis16400 move to info_mask_(shared_by_type/separate)
References: <1362241044-3534-1-git-send-email-jic23@kernel.org> <1362241044-3534-38-git-send-email-jic23@kernel.org> <5134EC79.5060004@metafoo.de>
In-Reply-To: <5134EC79.5060004@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/04/2013 06:48 PM, Lars-Peter Clausen wrote:
> On 03/02/2013 05:16 PM, Jonathan Cameron wrote:
>> The original info_mask is going away in favour of the broken out versions.
>>
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>> cc: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>>  drivers/iio/imu/adis16400_core.c | 47 ++++++++++++++++++++--------------------
>>  1 file changed, 23 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
>> index b7f215e..2111068 100644
>> --- a/drivers/iio/imu/adis16400_core.c
>> +++ b/drivers/iio/imu/adis16400_core.c
>> @@ -484,8 +484,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
>>  	.indexed = 1, \
>>  	.channel = 0, \
>>  	.extend_name = name, \
>> -	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
>> -		IIO_CHAN_INFO_SCALE_SEPARATE_BIT, \
>> +	.info_mask_separate = IIO_CHAN_INFO_RAW | IIO_CHAN_INFO_SCALE, \
> 
> BIT is missing.
> 
>> @@ -587,9 +587,8 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
>>  	.type = IIO_TEMP, \
>>  	.indexed = 1, \
>>  	.channel = 0, \
>> -	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
>> -		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT | \
>> -		IIO_CHAN_INFO_SCALE_SEPARATE_BIT, \
>> +	.info_mask_separate = IIO_CHAN_INFO_RAW | IIO_CHAN_INFO_OFFSET | \
>> +		IIO_CHAN_INFO_SCALE, \
> 
> BIT is missing.
> 
Thanks, updated tree with this fixed in the info_mask_separate branch.
