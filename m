Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:61616 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758456Ab3BKSH5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 11 Feb 2013 13:07:57 -0500
Received: by mail-ee0-f47.google.com with SMTP id e52so3311719eek.20
        for <linux-iio@vger.kernel.org>; Mon, 11 Feb 2013 10:07:54 -0800 (PST)
From: Ge Gao <ggao@invensense.com>
References: <1359764808-20168-1-git-send-email-ggao@invensense.com>
 <5117D94F.3010000@metafoo.de> <5117DCB0.3030809@kernel.org>
In-Reply-To: <5117DCB0.3030809@kernel.org>
MIME-Version: 1.0
Date: Mon, 11 Feb 2013 10:07:51 -0800
Message-ID: <2fae542f3324283c57ccb58fdc3c2fd7@mail.gmail.com>
Subject: RE: [PATCH] [V9] Invensense MPU6050 Device Driver.
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Jonanthan and Lars,
	Thanks for the comments. I am glad it has been accepted and very
thankful for the valuable advice during the process. I will add the
kfifo_in_spinlocked. However, for the kfifo_out, do I need lock? I thought
KFIFO is a two-way FIFO, which usually does not need the locking mechanism
unless it is the reset process, which clear the whole KFIFO.

Best Regards,

Ge GOA


-----Original Message-----
From: Jonathan Cameron [mailto:jic23@kernel.org]
Sent: Sunday, February 10, 2013 9:45 AM
To: Lars-Peter Clausen
Cc: Ge GAO; linux-iio@vger.kernel.org
Subject: Re: [PATCH] [V9] Invensense MPU6050 Device Driver.

On 02/10/2013 05:30 PM, Lars-Peter Clausen wrote:
> On 02/02/2013 01:26 AM, Ge GAO wrote:
>> From: Ge Gao <ggao@invensense.com>
>>
>> --This the basic function of Invensense MPU6050 Deivce driver.
>> --align coding style.
>> --rearrange function from ring to trigger.
>> --other cleanup.
>>
>> Signed-off-by: Ge Gao <ggao@invensense.com>
>
> Looks good to me:
>
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
>
Thanks, added to togreg branch of iio.git. Editted the description a fair
bit as the changes above should be below the --- rather than above it (and
hence not turn up in the eventual description in tree).


> A few minor things inline, but these can all be fixed in a follow up
patch.
>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-iio-mpu6050  |   14 +
>>  drivers/iio/imu/Kconfig                          |    2 +
>>  drivers/iio/imu/Makefile                         |    2 +
>>  drivers/iio/imu/inv_mpu6050/Kconfig              |   13 +
>>  drivers/iio/imu/inv_mpu6050/Makefile             |    6 +
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c       |  786
++++++++++++++++++++++
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h        |  247 +++++++
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c       |  194 ++++++
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c    |  153 +++++
>>  include/linux/platform_data/invensense_mpu6050.h |   32 +
>>  10 files changed, 1449 insertions(+), 0 deletions(-)  create mode
>> 100644 Documentation/ABI/testing/sysfs-bus-iio-mpu6050
>>  create mode 100644 drivers/iio/imu/inv_mpu6050/Kconfig
>>  create mode 100644 drivers/iio/imu/inv_mpu6050/Makefile
>>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
>>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
>>  create mode 100644 include/linux/platform_data/invensense_mpu6050.h
>>
> [...]
>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
>> b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
>> new file mode 100644
>> index 0000000..e1deee4
>> --- /dev/null
>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
>> @@ -0,0 +1,194 @@
>> +/*
>> + *  inv_mpu6050_irq_handler() - Cache a timestamp at each data ready
interrupt.
>> + */
>> +irqreturn_t inv_mpu6050_irq_handler(int irq, void *p) {
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *indio_dev = pf->indio_dev;
>> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>> +	s64 timestamp;
>> +
>> +	timestamp = iio_get_time_ns();
>> +	spin_lock(&st->time_stamp_lock);
>> +	kfifo_in(&st->timestamps, &timestamp, 1);
>> +	spin_unlock(&st->time_stamp_lock);
>
>
> There is kfifo_in_spinlocked, which takes a pointer to the lock as the
> last parameter and takes care of the locking.
>
>> +
>> +	return IRQ_WAKE_THREAD;
>> +}
>> +
>> +/*
>> + *  inv_mpu6050_read_fifo() - Transfer data from hardware FIFO to
KFIFO.
>> + */
>> +irqreturn_t inv_mpu6050_read_fifo(int irq, void *p) {
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *indio_dev = pf->indio_dev;
>> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>> +	size_t bytes_per_datum;
>> +	int result;
>> +	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
>> +	u16 fifo_count;
>> +	s64 timestamp;
>> +	u64 *tmp;
>> +
>> +	mutex_lock(&indio_dev->mlock);
>> +	if (!(st->chip_config.accl_fifo_enable |
>> +		st->chip_config.gyro_fifo_enable))
>> +		goto end_session;
>> +	bytes_per_datum = 0;
>> +	if (st->chip_config.accl_fifo_enable)
>> +		bytes_per_datum += INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
>> +
>> +	if (st->chip_config.gyro_fifo_enable)
>> +		bytes_per_datum += INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
>> +
>> +	/* read fifo_count register to know how many bytes inside FIFO
>> +	   right now */
>> +	result = i2c_smbus_read_i2c_block_data(st->client,
>> +				       st->reg->fifo_count_h,
>> +				       INV_MPU6050_FIFO_COUNT_BYTE, data);
>> +	if (result != INV_MPU6050_FIFO_COUNT_BYTE)
>> +		goto end_session;
>> +	fifo_count = be16_to_cpup((__be16 *)(&data[0]));
>> +	if (fifo_count < bytes_per_datum)
>> +		goto end_session;
>> +	/* fifo count can't be odd number, if it is odd, reset fifo*/
>> +	if (fifo_count & 1)
>> +		goto flush_fifo;
>> +	if (fifo_count >  INV_MPU6050_FIFO_THRESHOLD)
>> +		goto flush_fifo;
>> +	/* Timestamp mismatch. */
>> +	if (kfifo_len(&st->timestamps) >
>> +		fifo_count / bytes_per_datum + INV_MPU6050_TIME_STAMP_TOR)
>> +			goto flush_fifo;
>> +	while (fifo_count >= bytes_per_datum) {
>> +		result = i2c_smbus_read_i2c_block_data(st->client,
>> +						       st->reg->fifo_r_w,
>> +						       bytes_per_datum,
data);
>> +		if (result != bytes_per_datum)
>> +			goto flush_fifo;
>> +
>> +		result = kfifo_out(&st->timestamps, &timestamp, 1);
>
> Do you need to take the timestamp lock while reading from the fifo?
>
>> +		/* when there is no timestamp, put timestamp as 0 */
>> +		if (0 == result)
>> +			timestamp = 0;
>> +
>> +		tmp = (u64 *)data;
>> +		tmp[DIV_ROUND_UP(bytes_per_datum, 8)] = timestamp;
>> +		result = iio_push_to_buffers(indio_dev, data);
>> +		if (result)
>> +			goto flush_fifo;
>> +		fifo_count -= bytes_per_datum;
>> +	}
>> +
>> +end_session:
>> +	mutex_unlock(&indio_dev->mlock);
>> +	iio_trigger_notify_done(indio_dev->trig);
>> +
>> +	return IRQ_HANDLED;
>> +
>> +flush_fifo:
>> +	/* Flush HW and SW FIFOs. */
>> +	inv_reset_fifo(indio_dev);
>> +	inv_clear_kfifo(st);
>> +	mutex_unlock(&indio_dev->mlock);
>> +	iio_trigger_notify_done(indio_dev->trig);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
>> b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
>> new file mode 100644
>> index 0000000..6f62caf
>> --- /dev/null
>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
>> @@ -0,0 +1,153 @@
> [...]
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio"
> in the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html
>
