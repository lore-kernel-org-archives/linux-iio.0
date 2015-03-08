Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35008 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbbCHLbz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Mar 2015 07:31:55 -0400
Message-ID: <54FC3329.10302@kernel.org>
Date: Sun, 08 Mar 2015 11:31:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Ge Gao <GGao@invensense.com>,
	Viorel Suman <viorel.suman@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2] iio: inv_mpu6050: Clear timestamps fifo while resetting
 hardware fifo
References: <1424282721-3033-1-git-send-email-viorel.suman@gmail.com> <54E8D5D7.7050205@kernel.org> <E7747D604FBC9F43A71AA431AFF4476299AD37A8@IUSEXCH01.invcorp.invensense.com>
In-Reply-To: <E7747D604FBC9F43A71AA431AFF4476299AD37A8@IUSEXCH01.invcorp.invensense.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/02/15 18:35, Ge Gao wrote:
> Look fine to me.
> Thanks.
> 
> Best Regards,
> 
> Ge GAO
> 
Formal Acks preferred ;)

Anyhow, applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> 
> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org] 
> Sent: Saturday, February 21, 2015 11:01 AM
> To: Viorel Suman; linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; Srinivas Pandruvada; Ge Gao
> Subject: Re: [PATCH v2] iio: inv_mpu6050: Clear timestamps fifo while resetting hardware fifo
> 
> On 18/02/15 18:05, Viorel Suman wrote:
>> A hardware fifo reset always imply an invalidation of the existing 
>> timestamps, so we'll clear timestamps fifo on successfull hardware 
>> fifo reset.
>>
>> Signed-off-by: Viorel Suman <viorel.suman@gmail.com>
> Looks sensible to me. Ge / Srinivas?
>> ---
>>   v2: Addressed Jonathan's comment regarding the subject prefix.
>>
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 25 
>> ++++++++++++++-----------
>>  1 file changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c 
>> b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
>> index 0cd306a..ba27e27 100644
>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
>> @@ -24,6 +24,16 @@
>>  #include <linux/poll.h>
>>  #include "inv_mpu_iio.h"
>>  
>> +static void inv_clear_kfifo(struct inv_mpu6050_state *st) {
>> +	unsigned long flags;
>> +
>> +	/* take the spin lock sem to avoid interrupt kick in */
>> +	spin_lock_irqsave(&st->time_stamp_lock, flags);
>> +	kfifo_reset(&st->timestamps);
>> +	spin_unlock_irqrestore(&st->time_stamp_lock, flags); }
>> +
>>  int inv_reset_fifo(struct iio_dev *indio_dev)  {
>>  	int result;
>> @@ -50,6 +60,10 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
>>  					INV_MPU6050_BIT_FIFO_RST);
>>  	if (result)
>>  		goto reset_fifo_fail;
>> +
>> +	/* clear timestamps fifo */
>> +	inv_clear_kfifo(st);
>> +
>>  	/* enable interrupt */
>>  	if (st->chip_config.accl_fifo_enable ||
>>  	    st->chip_config.gyro_fifo_enable) { @@ -83,16 +97,6 @@ 
>> reset_fifo_fail:
>>  	return result;
>>  }
>>  
>> -static void inv_clear_kfifo(struct inv_mpu6050_state *st) -{
>> -	unsigned long flags;
>> -
>> -	/* take the spin lock sem to avoid interrupt kick in */
>> -	spin_lock_irqsave(&st->time_stamp_lock, flags);
>> -	kfifo_reset(&st->timestamps);
>> -	spin_unlock_irqrestore(&st->time_stamp_lock, flags);
>> -}
>> -
>>  /**
>>   * inv_mpu6050_irq_handler() - Cache a timestamp at each data ready interrupt.
>>   */
>> @@ -184,7 +188,6 @@ end_session:
>>  flush_fifo:
>>  	/* Flush HW and SW FIFOs. */
>>  	inv_reset_fifo(indio_dev);
>> -	inv_clear_kfifo(st);
>>  	mutex_unlock(&indio_dev->mlock);
>>  	iio_trigger_notify_done(indio_dev->trig);
>>  
>>
> 

