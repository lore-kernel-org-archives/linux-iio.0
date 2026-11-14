Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794617847;
	b=ZY56cSOYUUjhebr82Q+cgAn2TW8zAA/4SvbOtatE7Bqd+hx9toxdgqgrwL+y2kLm5mM7
	 XlK7vS30tmmhp0cugy2+E/WfgO7ieCLW6vwP0l9dLlS5Up6oBH9kLHefb5PzjYz0hMaW1
	 nC3yIxV04tJVIHLEUHW/Nba9R4/bD3Tt4A2PBxT/ecEkeI8/LD1aMP+NdwruUSLCYJwOS
	 MJOR3Rf2/72R0jC3HspFmjTpTYMTF2FgJXyZg+X3exB95loQXG1DTGVs86i5vYAJPN6+d
	 vqNQxqwJKVLInLLn8VD/PAI+/ugWEXw43sRco1K4nHDOht4tl7ELocIpiIEGtCxJGXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794617847;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PPPYWCzf+ANEP7FC8+BCXAak4wyH0ARl+srbxehYnpo=;
	b=uzyUYJ1M3lqTFO4Q3K/QwxFwU8QED8M+3kKMp2tsHIUfckKy5AZWEpZPXt5kS2S2ns/M
	 qmtdyzDFLHMLVFv7fP3Vf9Vj2RToMR6yYSgAwU09j/sssez0YsROc5XykJgtrFGSyysYO
	 JrKyqNu8/NJyezkAgdsYXdDxS9p8F6GOLvfakB41hmlicRsCF7mdbv92hMp+n7xNSgdK8
	 h+qG1pIsMfmBuGVCe1plcqlMb4OZLGfxWycC3mUAe1PRM3QldrcKRVxKDTgSLeSLUKKO6
	 DY+0lIUGBLjZsSAr6rXfL8Xd5uR7V8gblFkehhakEgk/un5KC+0KGmwFlrgVCdlGOvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxV3aJdG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE561606A334;
	Sat, 14 Nov 2026 00:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxV3aJdG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691CF1F000C5;
	Sat, 14 Nov 2026 00:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794617847;
	bh=PPPYWCzf+ANEP7FC8+BCXAak4wyH0ARl+srbxehYnpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gxV3aJdGtRr52F3bb/8wg36pJmPqAVKfOIeKOGV3ewsJdqY52n4eO6NtvUIj3RDmt
	 NK+ddC5mFAXxfaUFIBH2Ff3FdW1e8Aw7ggOh6JPcYYRow+V2c3ZObrN9frslQPeXGk
	 jRYclVtoLu7Zvec0rniLAPBtZG0aXYseO8xrgH4ycstE81dwsklhMUGDJ0Q3KkedaZ
	 nL/jR1vgkB34qT0xQ/y9VroF8paLQvr/BsQaaY3n9sirC2rnEAgJ/b0DS7xWAG2B/f
	 AQiZq8qLuYyX6y4F8ScwHmuylEkRq4PSBXndtMvYRg1r4RXf0ASHu/1eumBwe2zJJp
	 dcc83nUholJ5w==
Date: Sat, 14 Nov 2026 00:57:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>, Robert
 Budai <robert.budai@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux@analog.com,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH v6 6/8] iio: imu: adis16607: Add FIFO-based buffered
 capture
Message-ID: <20261114005719.31f5bc06@jic23-hlaptop>
In-Reply-To: <20261113-adis16607-v6-6-3f678719942a@analog.com>
References: <20261113-adis16607-v6-0-3f678719942a@analog.com>
	<20261113-adis16607-v6-6-3f678719942a@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2026 14:33:36 +0200
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add buffered capture via the device's hardware FIFO - the only
> capture mode this driver supports. Popping the FIFO uses a dedicated
> command and payload format (FIFO_DATA_CMD, 52 bytes, no checksum).
> 
> The samples go to a kfifo buffer that a threaded interrupt handler
> fills, with no IIO trigger: the device raises one interrupt per
> watermark, not per sample, so there is nothing to trigger on. The
> watermark-met condition is signaled via DEV_NOK on the device's one
> interrupt pin, which stays asserted until DIAG_STAT is read and
> cleared. The interrupt is therefore level-triggered and oneshot, so
> the line stays masked until the handler has read DIAG_STAT, and it is
> enabled only while the buffer is. DEV_NOK fires on any DIAG_STAT flag,
> not just FIFO_THRESH_MET, so the handler checks that specific bit
> before popping anything. DR_GPIO_MASK stays enabled unconditionally:
> DR pulses drive the FIFO controller's internal sample enqueue,
> independent of pin routing.
> 
> Watermark is configurable via the standard hwfifo_set_watermark
> callback and the usual hwfifo_* sysfs attributes. Changing the sampling
> frequency while the buffer is enabled returns -EBUSY, as the decimation
> can't change during capture.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>

Even though you are going to roll some stuff into the core library
I took a look and gave some initial feedback on what is here.
Main things is you are spending to much effort on data unscrambling
beyond the absolute minimum which is just forcing the alignment.

The rest is a question of correct channel descriptions.
With that stuff being in previous patch rather than here, I've had
to drop the series entirely for now.

Thanks,

Jonathan


> diff --git a/drivers/iio/imu/adis16607.c b/drivers/iio/imu/adis16607.c
> index f5dc37c54191..377e7c46f860 100644
> --- a/drivers/iio/imu/adis16607.c
> +++ b/drivers/iio/imu/adis16607.c

>  
> +/*
> + * FIFO/burst data offsets for each channel (in bytes from the data start,
> + * i.e. after the 4-byte command prefix).
> + * Each 32-bit inertial channel occupies 4 bytes (MSW + LSW), TEMP is 2 bytes.
> + *
> + * FIFO data layout (52 bytes, DATA_CNTR enabled, no checksum):
> + *   Offset 0-3:   ACCEL_X  (32-bit: MSW, LSW)
> + *   Offset 4-7:   ACCEL_Y
> + *   Offset 8-11:  ACCEL_Z
> + *   Offset 12-15: GYRO_X
> + *   Offset 16-19: GYRO_Y
> + *   Offset 20-23: GYRO_Z
> + *   Offset 24-27: DELTVEL_X
> + *   Offset 28-31: DELTVEL_Y
> + *   Offset 32-35: DELTVEL_Z
> + *   Offset 36-39: DELTANG_X
> + *   Offset 40-43: DELTANG_Y
> + *   Offset 44-47: DELTANG_Z
> + *   Offset 48-49: TEMP (16-bit)
> + *   Offset 50-51: DATA_CNTR (16-bit)

Repeated below in a diferent format.


> + *
> + * Each 32-bit value encodes 24-bit sensor data as:
> + *   value_24bit = (MSW << 8) | (LSW >> 8)
Given it's big endian that means they are be24.
Just copy 3 bytes to where you want them and put the shift in
the channel description.

> + */
> +static const u8 adis16607_burst_offsets[] = {
> +	[ADIS16607_SCAN_ACCEL_X] = 0,
> +	[ADIS16607_SCAN_ACCEL_Y] = 4,
> +	[ADIS16607_SCAN_ACCEL_Z] = 8,
> +	[ADIS16607_SCAN_GYRO_X] = 12,
> +	[ADIS16607_SCAN_GYRO_Y] = 16,
> +	[ADIS16607_SCAN_GYRO_Z] = 20,
> +	[ADIS16607_SCAN_DELTVEL_X] = 24,
> +	[ADIS16607_SCAN_DELTVEL_Y] = 28,
> +	[ADIS16607_SCAN_DELTVEL_Z] = 32,
> +	[ADIS16607_SCAN_DELTANG_X] = 36,
> +	[ADIS16607_SCAN_DELTANG_Y] = 40,
> +	[ADIS16607_SCAN_DELTANG_Z] = 44,
> +	[ADIS16607_SCAN_TEMP] = 48,
> +};
> +
> +/*
> + * Pop a single sample from FIFO using FIFO_DATA command (0xA9).
> + * Returns the raw FIFO data in the provided buffer.
> + */
> +static int adis16607_fifo_pop(struct adis16607 *st, u8 *data)
> +{
> +	struct spi_message msg;
> +	struct spi_transfer xfer = {
> +		.tx_buf = st->fifo_buf,
> +		.rx_buf = st->fifo_buf,
> +		.len = ADIS16607_FIFO_DATA_CMD_SIZE + ADIS16607_FIFO_DATA_LEN,
> +	};
> +	int ret;
> +
> +	/* FIFO data command */
> +	st->fifo_buf[0] = ADIS16607_FIFO_DATA_CMD;
> +
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfer, &msg);
> +
> +	ret = spi_sync(st->adis.spi, &msg);
> +	if (ret)
> +		return ret;
> +
> +	/* Copy data starting after command bytes */
> +	memcpy(data, st->fifo_buf + ADIS16607_FIFO_DATA_CMD_SIZE, ADIS16607_FIFO_DATA_LEN);

So copy it once. Then copy it again below?  Why?  Just make the user
aware of the offset into st->fifo.


> +	return 0;
> +}
> +
> +/*
> + * Process a single FIFO sample and push to IIO buffer.
> + * FIFO data format differs from regular burst - no DIAG_STAT, data starts immediately.
> + *
> + * FIFO data layout (52 bytes):
> + *   Offset 0-3:   ACCEL_X (32-bit)
> + *   Offset 4-7:   ACCEL_Y (32-bit)
> + *   Offset 8-11:  ACCEL_Z (32-bit)
> + *   Offset 12-15: GYRO_X (32-bit)
> + *   Offset 16-19: GYRO_Y (32-bit)
> + *   Offset 20-23: GYRO_Z (32-bit)
> + *   Offset 24-27: DELTVEL_X (32-bit)
> + *   Offset 28-31: DELTVEL_Y (32-bit)
> + *   Offset 32-35: DELTVEL_Z (32-bit)
> + *   Offset 36-39: DELTANG_X (32-bit)
> + *   Offset 40-43: DELTANG_Y (32-bit)
> + *   Offset 44-47: DELTANG_Z (32-bit)
> + *   Offset 48-49: TEMP (16-bit)
> + *   Offset 50-51: DATA_CNTR (16-bit)
> + */
> +static void adis16607_fifo_push_sample(struct iio_dev *indio_dev,

Definitely more than one sample.  Probably call it push_scan
to align with terminology I made up many years ago for IIO.

> +				       u8 *fifo_data, s64 timestamp)
> +{
> +	struct adis16607 *st = iio_priv(indio_dev);
> +	u16 msw, lsw;
> +	s32 val24;
> +	int bit, offset = 0;
> +
> +	memset(st->data, 0, sizeof(st->data));
> +
> +	iio_for_each_active_channel(indio_dev, bit) {
> +		u8 burst_off;
> +
> +		/* Skip the soft timestamp channel - it has no burst offset */
> +		if (bit >= ARRAY_SIZE(adis16607_burst_offsets))
> +			continue;

That smells like a sashiko error that I thought it had stopped making.
The timestamp is never set in active channels (assuming it is
a software timestamp at least).  So this check shouldn't be needed.

David had some rework patches to stop the iterator checking the bit
but those haven't gone in yet.


> +
> +		burst_off = adis16607_burst_offsets[bit];
> +
> +		if (bit == ADIS16607_SCAN_TEMP) {
> +			/* TEMP is 16-bit */
> +			put_unaligned_be16(get_unaligned_be16(&fifo_data[burst_off]),
> +					   &st->data[offset]);

That's silly. Just memcpy.

> +			offset += 2;
> +		} else {
> +			/* All other channels are 24-bit stored as 32-bit */
> +			msw = get_unaligned_be16(&fifo_data[burst_off]);
> +			lsw = get_unaligned_be16(&fifo_data[burst_off + 2]);

Friday evening so I may be missing the obvious but isn't that
			val24 = sign_extend32(get_unaligned_be32[burst_off] >> 8, 23);
However, why sign extend?  Which also follows through to why not mempcy()?
No need to actually mess with the data.


> +			val24 = sign_extend32(((u32)msw << 8) | (lsw >> 8), 23);
> +			put_unaligned_be32(val24, &st->data[offset]);

Why would you do that?  Just make the channel type CPU endian.  Or as above, memcpy
untouched.

Note as well that you might want to use the channel shift to deal with that 8
or just put the data in what is the least significant 3 words for BE.  (so highest
addresses).


> +			offset += 4;
> +		}
> +	}
> +
> +	iio_push_to_buffers_with_ts(indio_dev, st->data, sizeof(st->data),
> +				    timestamp);
> +}

> +/*
> + * Drain the device FIFO. Triggered by the DEV_NOK interrupt, which fires on
> + * any DIAG_STAT flag, not just FIFO_THRESH_MET - the DIAG_STAT read below
> + * both checks which flag(s) raised the interrupt and clears the latched
> + * status, and must happen before any FIFO pop, or we'd pop for nothing on
> + * an unrelated flag.
> + */
> +static void adis16607_fifo_drain(struct iio_dev *indio_dev, s64 irq_timestamp)
> +{
> +	struct adis16607 *st = iio_priv(indio_dev);
> +	u8 fifo_sample[ADIS16607_FIFO_DATA_LEN];
> +	u16 diag_stat, word_cnt, sample_cnt;
> +	u64 period_ns;
> +	s64 timestamp;
> +	int ret;
> +
> +	adis_dev_auto_lock(&st->adis);
> +
> +	ret = __adis_read_reg_16(&st->adis, ADIS16607_REG_DIAG_STAT, &diag_stat);
> +	if (ret)
> +		return;
> +
> +	/* Check if FIFO threshold is met */
> +	if (!(diag_stat & ADIS16607_FIFO_THR_MET_MASK))
> +		return;

If it wasn't us - so a different interrupt and we didn't handle it should
be returning IRQ_NONE.  Might be a spurious interrupt.
Note that only applies for definitely not what we expected
rather than a failure to read or similar.


> +
> +	/* Read FIFO word count */
> +	ret = __adis_read_reg_16(&st->adis, ADIS16607_REG_FIFO_WORD_CNT, &word_cnt);
> +	if (ret)
> +		return;
> +
> +	/* Calculate number of complete samples */
> +	sample_cnt = word_cnt / ADIS16607_FIFO_WORDS_PER_SAMPLE;
> +	if (!sample_cnt)
> +		return;
> +
> +	/*
> +	 * irq_timestamp is the IRQ-fire time, i.e. when the newest (last
> +	 * enqueued) sample tipped the FIFO over watermark. The FIFO pops
> +	 * oldest-first, so back-date the first popped sample's timestamp by
> +	 * the batch duration - the loop then counts back up to irq_timestamp
> +	 * for the newest sample, instead of projecting past it.

This is optimistically simple!  You might want to take a look at the
timestamp help library for the invensense parts in
drivers/iio/common/inv_sensors/inv_sensors_timestamp.c

Fifo timestamps are hard to get right. See the fixes that have merged
recently!  Note that by the time you get here, there may be samples
after the irq timestamp you captured for example.

Assuming the sampling period is particularly accurate is also rather
optimistic - that will bunch timestamp period difference errors
just after the last fifo read out.

+CC Jean-Baptiste who might give some general guidance on pitfalls to
    avoid!


> +	 */
> +	period_ns = adis16607_sample_period_ns(st);
> +	timestamp = irq_timestamp - (s64)(sample_cnt - 1) * period_ns;
> +
> +	/* Pop and process each sample */
> +	for (unsigned int i = 0; i < sample_cnt; i++) {
> +		ret = adis16607_fifo_pop(st, fifo_sample);
> +		if (ret)
> +			return;
> +
> +		adis16607_fifo_push_sample(indio_dev, fifo_sample, timestamp);
> +		timestamp += period_ns;
> +	}
> +}
> +
> +static irqreturn_t adis16607_irq_thread(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +
> +	adis16607_fifo_drain(indio_dev, iio_get_time_ns(indio_dev));
> +
> +	return IRQ_HANDLED;
> +}



>  static const char * const adis16607_status_error_msgs[] = {
> @@ -792,6 +1183,8 @@ static int adis16607_probe(struct spi_device *spi)
>  	indio_dev->info = &adis16607_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> +	st->fifo_watermark = ADIS16607_MAX_FIFO_WM;
> +
>  	st->adis.ops = &adis16607_ops;
>  
>  	ret = devm_regulator_get_enable(dev, "vdd");
> @@ -830,6 +1223,23 @@ static int adis16607_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	ret = devm_iio_kfifo_buffer_setup_ext(dev, indio_dev, &adis16607_buffer_ops,
> +					      adis16607_fifo_attributes);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * DEV_NOK is the OR of the DIAG_STAT flags and stays high until
> +	 * DIAG_STAT is read. Use a level interrupt so a flag raised while it
> +	 * is already high is not lost; ONESHOT keeps it masked until the
> +	 * handler has read DIAG_STAT. It is enabled along with the buffer.

I'm assuming to way to mask it out device side? That to me is the key
bit to state in this comment if so.

> +	 */
> +	ret = devm_request_threaded_irq(dev, spi->irq, NULL, adis16607_irq_thread,
> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT | IRQF_NO_AUTOEN,
> +					indio_dev->name, indio_dev);
> +	if (ret)
> +		return ret;
> +
>  	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret)
>  		return ret;
> 

