Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-218.synserver.de ([212.40.185.218]:1038 "EHLO
	smtp-out-211.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751531Ab1K1QN6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Nov 2011 11:13:58 -0500
Message-ID: <4ED3B385.1000002@metafoo.de>
Date: Mon, 28 Nov 2011 17:15:01 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, Michael.Hennerich@analog.com,
	manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 04/16] staging:iio: scrap scan_count and ensure all drivers
 use active_scan_mask
References: <1322400825-29400-1-git-send-email-jic23@kernel.org> <1322400825-29400-5-git-send-email-jic23@kernel.org> <4ED3584B.3040603@metafoo.de>
In-Reply-To: <4ED3584B.3040603@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/28/2011 10:45 AM, Lars-Peter Clausen wrote:
> On 11/27/2011 02:33 PM, Jonathan Cameron wrote:
>> From: Jonathan Cameron <jic23@cam.ac.uk>
>>
>> Obviously drivers should only use this for pushing to buffers.
>> They need buffer->scan_mask for pulling from them post demux.
>>
>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>> ---
>>  drivers/staging/iio/accel/adis16201_ring.c      |   10 +++++-----
>>  drivers/staging/iio/accel/adis16203_ring.c      |   10 +++++-----
>>  drivers/staging/iio/accel/adis16204_ring.c      |   10 +++++-----
>>  drivers/staging/iio/accel/adis16209_ring.c      |    5 +++--
>>  drivers/staging/iio/accel/adis16240_ring.c      |    5 +++--
>>  drivers/staging/iio/accel/lis3l02dq_ring.c      |   23 +++++++++++++----------
>>  drivers/staging/iio/adc/ad7192.c                |   10 ++++++----
>>  drivers/staging/iio/adc/ad7298_ring.c           |   12 +++++++-----
>>  drivers/staging/iio/adc/ad7476_ring.c           |    3 ++-
>>  drivers/staging/iio/adc/ad7793.c                |   11 ++++++-----
>>  drivers/staging/iio/adc/ad7887_ring.c           |    8 +++++---
>>  drivers/staging/iio/adc/ad799x_ring.c           |   13 ++++++++-----
>>  drivers/staging/iio/buffer.h                    |    2 --
>>  drivers/staging/iio/gyro/adis16260_ring.c       |    5 +++--
>>  drivers/staging/iio/iio_simple_dummy_buffer.c   |    7 +++++--
>>  drivers/staging/iio/impedance-analyzer/ad5933.c |   14 ++++++++------
>>  drivers/staging/iio/imu/adis16400_ring.c        |   19 +++++++++++--------
>>  drivers/staging/iio/industrialio-buffer.c       |    2 --
>>  drivers/staging/iio/meter/ade7758_ring.c        |    7 ++++---
>>  19 files changed, 99 insertions(+), 77 deletions(-)
>>
>> diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
>> index 936e8cb..68d4b38 100644
>> --- a/drivers/staging/iio/accel/adis16201_ring.c
>> +++ b/drivers/staging/iio/accel/adis16201_ring.c
>> @@ -74,11 +74,11 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
>>  		return -ENOMEM;
>>  	}
>>  
>> -	if (ring->scan_count)
>> -		if (adis16201_read_ring_data(indio_dev, st->rx) >= 0)
>> -			for (; i < ring->scan_count; i++)
>> -				data[i] = be16_to_cpup(
>> -					(__be16 *)&(st->rx[i*2]));
>> +	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength)
>> +	    && adis16201_read_ring_data(indio_dev, st->rx) >= 0)
>> +		for (; i < bitmap_weight(indio_dev->active_scan_mask,
>> +					 indio_dev->masklength); i++)
>> +			data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
>>  
> 
> Does it really make sense to recompute bitmap_weight for each transfer?
> Can't we update scan_count once, when we update the scan_mask?

Also: for chips where we can only read all values at once, should we set
available_scan_masks to ~0 and just let the demuxer handle everything else?

- Lars

