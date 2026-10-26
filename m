Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792973359;
	b=SgsXKBJmphy4KfFdGTFgdW4W0avBo7jPB39v7vJ4XZPsyuzQL5QqE4AjkLAA6B8eEZUt
	 31SzMNSY8G1n+io3ZyHEC7OiX0GQYVkaZvWnkATTIW6CQShdOOltj9Jycw7RsFKZu6aZ7
	 BlINFRSzxnFxVeSoqonwmrh4FEv5585B32qYMC+EQM4KY3aEuPhuZ3Sx2iDXkgPV473UL
	 DvzadRpOW5cX8IKBBAi5JgvCbWBe2xAMvONxhQ+UwWe4uQK0UVHuacV+XKgKU3xa1I4Gi
	 m6qffb3w6DjxCub6Kmh+suUg6UaMv+rPYVKLVgaJS43yehB4ZIdGd32u2czNDx+cwSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792973359;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QMeNs2DEy/MEHGHund85xZ1Yt4veb1UtyYvJc7x2dNo=;
	b=Myp8sliR//v4y8k7PIwSjLKPDlcoRASpzu/P9ktqRoeWQDJC4gJMDBLEYsuvWnVJqOBl
	 IhrSHJ4/SIEMvQpTrrOfl3IvBGMfhUwfBYe1ISVXIp0uk1T2/lWUwO53h/prp1+6dTjH+
	 4/UDXfvBEG57vRBnsQ949wO8Ljnk8VK/TQfTonwVEAIq6UHR28oan/v5sWxcYZ1cM/Vxb
	 ik6uOznvOpb0pKBmX57Lsj/IgyWQfPP563ouQ5pSICVjLUyrfehUEvVph6QCf4RKtxgeL
	 DfrlXONUAfs1htWQQiK3ui2Gqpbm84tPi6qlWnB+uJjgZ5dK4RHX8Aq/r7svn7L7TGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e55oCv9U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44862606A31A;
	Mon, 26 Oct 2026 00:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e55oCv9U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61871F01825;
	Mon, 26 Oct 2026 00:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792973358;
	bh=QMeNs2DEy/MEHGHund85xZ1Yt4veb1UtyYvJc7x2dNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e55oCv9UC4XXxE7QpYtamcSCdTrgRR384vDO6/z+HZ6I739gZbI0X2J/PlE5+TIS3
	 pCKAOD2U6xYDkwfAmD672wi0l4m9QLUtEm+P2hB23fdJqawdpLxjRDN7KONUVzQo31
	 9G6EoGYbBTl38Xo2RJDvU4fXB5tjUqkEIg4UAH2ez7VPfYlA9ANBMZnUnNf+syCr7n
	 j4eNPmYqKxCS4v8a/S0mO2P/OJIhOHgrcSBP4MWEPiBk1aI2si8mTTcmxIuOLr9PN+
	 cPJUAVMcUSun0teRNyZ5jGSdDrVumZ8Cx6s6gwGGwR6d+4dM06yT+HsOuRrXZ7cscn
	 YZ53P09omZuHQ==
Date: Mon, 26 Oct 2026 00:09:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux@analog.com
Subject: Re: [PATCH v4 6/8] iio: imu: adis16607: Add FIFO-based
 buffered/triggered capture
Message-ID: <20261026000910.328f6cd8@jic23-hlaptop>
In-Reply-To: <20261023-adis16607-v4-6-a4d541ebfd13@analog.com>
References: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
	<20261023-adis16607-v4-6-a4d541ebfd13@analog.com>
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

On Fri, 23 Oct 2026 12:30:23 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add buffered capture via the device's hardware FIFO - the only
> capture mode this driver supports. Popping the FIFO uses a dedicated
> command and payload format (FIFO_DATA_CMD, 52 bytes, no checksum),
> handled directly rather than through adislib's generic burst-read
> helpers, which assume one fixed-shape read per trigger rather than a
> variable-count drain loop.
> 
> The watermark-met condition is signaled via DEV_NOK on the device's
> one interrupt pin, which stays asserted (level-triggered) until
> DIAG_STAT is read and cleared - matching adislib's has_fifo contract.
> DEV_NOK fires on any DIAG_STAT flag, not just FIFO_THRESH_MET, so the
> trigger handler checks that specific bit before popping anything.
> DR_GPIO_MASK stays enabled unconditionally: DR pulses drive the FIFO
> controller's internal sample enqueue, independent of pin routing.
> 
> Watermark is configurable via the standard hwfifo_set_watermark
> callback and the usual hwfifo_* sysfs attributes.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
>  drivers/iio/imu/adis16607.c | 349 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 346 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16607.c b/drivers/iio/imu/adis16607.c
> index 2dda306d7b54..b1f3667d8ce3 100644
> --- a/drivers/iio/imu/adis16607.c
> +++ b/drivers/iio/imu/adis16607.c

>  /* Self-test registers and masks */
>  #define ADIS16607_REG_SELF_TEST_DATA(x)	((x) + 0x23)
>  #define ADIS16607_SNSR_SELF_TEST_MASK	BIT(6)
> @@ -86,6 +110,11 @@ struct adis16607 {
>  	const struct adis16607_chip_info *info;
>  	unsigned long clk_freq_mhz;
>  	u64 sample_period_ns;
> +	u16 fifo_watermark;
> +	/* Scratch buffer used for FIFO pop operations, see adis16607_fifo_pop() */
> +	u8 fifo_buf[ADIS16607_BURST_CMD_SIZE + ADIS16607_FIFO_DATA_LEN] __aligned(IIO_DMA_MINALIGN);
> +	/* IIO buffer for reordered data - sized for max channels */

That rather implies you never DMA into it.  If so just move it before
the fifo_buf and no need to mark it IIO_DMA_MINALIGN.
I'd also prefer that 64 was sized by maths, not a comment saying
it is big enough. That may include use of IIO_DECLARE_BUFFER_WITH_TS()
to ensure the timestamp spacing is there.


> +	u8 data[64] __aligned(IIO_DMA_MINALIGN);
>  };

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
> +				       u8 *fifo_data, s64 timestamp)
> +{
> +	struct adis16607 *st = iio_priv(indio_dev);
> +	u16 msw, lsw;
> +	s32 val24;
> +	int bit, offset = 0;
> +
> +	memset(st->data, 0, sizeof(st->data));
> +
> +	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength) {
iio_for_each_active_channel()

As sashiko notes, masklength is private.

There are a load of places we need to update to stop accessing these
directly but please don't add another one.

It's on my list to throw some LLM tokens ago once I get out from
under review backlog.

https://sashiko.dev/#/patchset/20261023-adis16607-v4-0-a4d541ebfd13%40analog.com
Check everything else reported.

FWIW there are also some nasty race conditions around active_scan_mask
being available when the buffer is being torn down. You might
want to close those off by claiming buffered mode to prevent
such a transition.

> +		u8 burst_off;
> +
> +		/* Skip the soft timestamp channel - it has no burst offset */
> +		if (bit >= ARRAY_SIZE(adis16607_burst_offsets))
> +			continue;
> +
> +		burst_off = adis16607_burst_offsets[bit];
> +
> +		if (bit == ADIS16607_SCAN_TEMP) {
> +			/* TEMP is 16-bit */
> +			put_unaligned_be16(get_unaligned_be16(&fifo_data[burst_off]),
> +					   &st->data[offset]);
> +			offset += 2;
> +		} else {
> +			/* All other channels are 24-bit stored as 32-bit */
> +			msw = get_unaligned_be16(&fifo_data[burst_off]);
> +			lsw = get_unaligned_be16(&fifo_data[burst_off + 2]);
> +			val24 = sign_extend32(((u32)msw << 8) | (lsw >> 8), 23);
> +			put_unaligned_be32(val24, &st->data[offset]);
> +			offset += 4;
> +		}
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, st->data, timestamp);
Use iio_push_to_buffers_with_ts() as for once in an ADIS driver we actually
have the size of data.  Note that fixing the whole adis library is something
that needs doing though I took a look at it on Friday and decided to leave
it for now!

Jonathan

> +}
