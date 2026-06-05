Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6E53254BB;
	Fri,  5 Jun 2026 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780663328; cv=none; b=gFOk7e5H7MQFshONnwFoufjszzGcPhZ1yGD4ro985s24fRByJf2v9YgtS0nKwf1BB/wkDVAgnUzY9Aq9VZclwuzimIdSBcOW7R+5i0nJ5ZQmvMG6kJ2E59329VJJqd8OJIcdEUxn8/ZS8kC7vDX7Y6SrdNoRxtbSAKsix2egPls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780663328; c=relaxed/simple;
	bh=grhD6ZZ80tsEqBiN9309vf4U+ONqahh5j6/dC7egn/k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lBnpoWD4R0tIlGsfAHWTQ27zKKXX6LhEKbYQZ+d9Bq7/iDeih9ekhdBKyf7lR4RpNO3Rnds9UTSSwd6ha09uEXRlB65MqwIUcgVUk61u/gD7g1RXa50CUt+2u/PUtlbjP+gM2EA5HILdKe0M3BBXSqn/XPTkkivn3bmDCMyBFuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKvuikJW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKvuikJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5636B1F00898;
	Fri,  5 Jun 2026 12:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780663327;
	bh=eAD+LLmR4G64ZR5qeHv3/mXuFWpmM/vK/8GbtCFU9to=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LKvuikJWvsAS4Ubc/tIGTDzY/LQFUz1aBgAUzkT2rBEe8ZtyNMTGIrDS8WUXS16ET
	 gCRJqftu+ZA0BBJ5mKb0AFPFzlkyXraJUryMeoV3yLvrRAxJLuDnRDO4gxVBe9LE+A
	 ItvxTnIQcXDZbizG4O1cm83iSJU3HuxKmHqhN96qB+HA2b8z30t5bkFziRfvB5pXNW
	 Ddxf/F/wKzLAVEm79XRoN8Uhoy280Gls2kdslO0iM4+pbPDLh5pvFQJypdVKSS9M0M
	 2JsjEsfRcPJbZuyHDnPyb4eRF4FmIlgXKmNpbFTnWLnElHwamKOzcs8ZdJ45cuAe5T
	 1Oe4yHP9j/2Bg==
Date: Fri, 5 Jun 2026 13:41:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: linusw@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050: read gyro samples via FIFO in
 IIO_CHAN_INFO_RAW
Message-ID: <20260605134158.501fac37@jic23-huawei>
In-Reply-To: <81c02804b9ae3bc194ef1da95f58da4c5e19b609.1780648724.git.github.com@herrie.org>
References: <cover.1780648724.git.github.com@herrie.org>
	<81c02804b9ae3bc194ef1da95f58da4c5e19b609.1780648724.git.github.com@herrie.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jun 2026 10:46:21 +0200
Herman van Hazendonk <github.com@herrie.org> wrote:

> The direct gyro register file (XOUT_H..ZOUT_L) returns stale data on
> at least the HP TouchPad (apq8060): X high byte is stuck at 0xFF and
Hi Herman,

That doesn't sound stale, rather just corrupted.

> Z reads as 0x0000 even when the chip is otherwise sampling and the
> userspace i2c-dev path returns sensible values for the same chip from
> the same registers. Y reads correctly, suggesting the issue is in how
> the on-die register file responds to back-to-back two-byte reads at
> specific offsets after the reset / PLL settle that
> mpu3050_set_8khz_samplerate() performs immediately before the read.
> 
> The chip's on-chip FIFO does not have this hazard because the sample
> assembly is performed inside the chip and the host only reads a fully
> formed frame from FIFO_R.

This feels like a heavy weight solution to what I think you are suggesting
is possibly just an instability after the samplerate set?  The sysfs
read path is slow anyway, so have you tried a short sleep to see if things
stabilise?   There is already a sleep in the call to start sampling,
perhaps that is too short, or perhaps we should wait for the 2nd sample?



> 
> Add a small mpu3050_fifo_read_one() helper that:
> 
>   - lowers DLPF/SMPLRT to ~250 Hz so exactly one fresh sample lands
>     in the FIFO during the wait loop (at the previously-set 8 kHz the
>     FIFO accumulates a sample every 125 us and races the FIFO_COUNT_H
>     / FIFO_R bulk reads, producing per-axis byte hazards even though
>     the oldest 6 bytes are nominally a clean frame);

That's a pretty nasty bug if there is a race there :(

>   - configures FIFO_EN for gyro X / Y / Z only (the FIFO-captured
>     TEMP slot occasionally returns stale data while gyro words are
>     still consistent; mpu3050_read_raw() reads TEMP_H/L directly
>     instead);
>   - resets the FIFO and enables FIFO read-out in a single
>     USR_CTRL write so the chip atomically resets the write pointer
>     with capture already on (two separate writes leave the FIFO in a
>     brief transient state where the first sample after re-enable can
>     land at a non-zero offset, producing per-byte-shifted frames in
>     the readback);
>   - waits for one 6-byte sample to land with a generous retry loop;
>   - reads one 6-byte X / Y / Z frame from FIFO_R;
>   - tears the FIFO capture down so subsequent buffered/triggered
>     reads aren't confused by stale FIFO_EN bits.
> 
> Route IIO_CHAN_INFO_RAW through this helper for IIO_ANGL_VEL. IIO_TEMP
> keeps its existing direct TEMP_H/L read because that register is not
> affected by the gyro register-file hazard, and the FIFO-captured TEMP
> slot occasionally diverges from the live register by several degrees.

Hmm. This device is full of nasty surprises!

> The triggered-buffer path (mpu3050_trigger_handler()) is unchanged
> and continues to manage the FIFO itself when the hardware interrupt
> trigger is active.
> 
> The chip is left at ~250 Hz when the helper returns; mpu3050->lpf and
> mpu3050->divisor are unchanged so the sysfs in_anglvel_sampling_-
> frequency value resolved via mpu3050_get_freq() keeps reporting the
> user-configured rate. The next caller of mpu3050_set_8khz_samplerate()
> (any subsequent IIO_CHAN_INFO_RAW read, or the buffered-mode enable
> path, or a companion runtime_resume fix sent as a separate patch)
> issues a full chip reset and reprograms the hardware from cached
> state.
> 
> Test results on the HP TouchPad with the chip lying flat, 15
> IIO_CHAN_INFO_RAW reads at 200 ms intervals:
> 
>   Before this patch (direct XOUT_H/YOUT_H/ZOUT_H reads):
>     X = 255             (high byte stuck at 0xFF, permanently)
>     Y = -99             (works)
>     Z = 0               (low/high bytes both 0x00, permanently)
> 
>   After this patch (FIFO read path):
>     X = -95..-156       (span 61, mean -127)
>     Y =  46..80         (span 34, mean  61)
>     Z = -15..23         (span 38, mean   3)
>     TEMP = -13440..-13552  (span 112, stable)
> 
> Steady-state per-read latency is ~89 ms, dominated by the existing
> mpu3050_set_8khz_samplerate() reset + msleep(50) before the FIFO
> helper.

Do you have a usecase that cares that much about the latency of such
a read?  As you say it's dominated by the reset anyway - so I'm just
curious rather than this being important.

> 
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
> ---
>  drivers/iio/gyro/mpu3050-core.c | 162 ++++++++++++++++++++++++++++++--
>  1 file changed, 152 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index d84e04e4b431..be87053dba54 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -260,6 +260,141 @@ static int mpu3050_set_8khz_samplerate(struct mpu3050 *mpu3050)
>  	return ret;
>  }
>  
> +/*
> + * mpu3050_fifo_read_one() - capture and return one combined sample frame
> + *
> + * The MPU-3050's direct gyro register file (XOUT_H..ZOUT_L) exhibits a
> + * stale-byte hazard on at least the apq8060 i2c controller path: on
> + * many devices the first byte of the X high register and the entire Z
> + * pair return constant 0xFF / 0x0000 even when the chip is otherwise
> + * sampling and the userspace i2c-dev path returns sensible values.
> + *
> + * The chip's on-chip FIFO does not have this problem because the
> + * sample assembly happens inside the chip and the host only reads a
> + * fully-formed frame from FIFO_R. Configure the FIFO to capture TEMP

Looks like you don't capture temp.

> + * plus all three gyro axes (8 bytes per sample, no footer), drain any
> + * stale data with a FIFO reset, wait one sample period, then read a
> + * single complete frame.
> + */
> +/*
> + * Size of one FIFO sample frame captured by mpu3050_fifo_read_one():
> + * three big-endian s16 gyro words (X, Y, Z). Temperature is read
> + * separately from its register file because the FIFO-captured TEMP
> + * occasionally returns a stale/partial value while gyro words remain
> + * consistent.
> + */
> +#define MPU3050_FIFO_FRAME_BYTES	6
> +
> +static int mpu3050_fifo_read_one(struct mpu3050 *mpu3050, __be16 frame[3])
> +{
> +	__be16 raw_count;
> +	u16 fifocnt;
> +	int retries;
> +	int cleanup_err;
> +	int ret;
> +
> +	/*
> +	 * Slow the chip down to 250 Hz for the duration of this read so
> +	 * exactly one fresh sample lands in the FIFO during the wait below.

You can't guaranteed that as sleeps can always be longer than requested.

> +	 * At the previously-set 8 kHz the FIFO accumulates a sample every
> +	 * 125 us and can race the bulk_read of FIFO_COUNT_H / FIFO_R,
> +	 * producing per-axis byte hazards in the readback even though the
> +	 * oldest 8 bytes are nominally a clean frame.
> +	 *
> +	 * The chip is left at 250 Hz when this function returns; the next
> +	 * caller will run mpu3050_set_8khz_samplerate() again (which does
> +	 * a full chip reset) so there is nothing to restore here.
> +	 * mpu3050->lpf and mpu3050->divisor remain the user-configured
> +	 * values across this function, so sysfs
> +	 * in_anglvel_sampling_frequency continues to report the right
> +	 * thing via mpu3050_get_freq().
> +	 */
> +	ret = regmap_write(mpu3050->map, MPU3050_DLPF_FS_SYNC,
> +			   mpu3050->fullscale << MPU3050_FS_SHIFT |

Even though rest of driver isn't using it, for new code FIELD_PREP() and
use the mask rather than the sift macro.  Ultimately ripping out the SHIFT
macros from here is something we should do.

> +			   MPU3050_DLPF_CFG_20HZ);
> +	if (ret)
> +		goto disable;
> +	ret = regmap_write(mpu3050->map, MPU3050_SMPLRT_DIV, 3);
> +	if (ret)
> +		goto disable;
> +
> +	/*
> +	 * Capture only gyro X, Y, Z into the FIFO. The temperature slot
> +	 * is deliberately omitted: the chip occasionally writes a stale
> +	 * TEMP_H/L pair into the FIFO that differs from the live register
> +	 * by ~7C, and there's no obvious sync the host can use to detect
> +	 * which samples are affected. Reading TEMP straight from the
> +	 * register file (which mpu3050_read_raw() does for IIO_TEMP) does
> +	 * not have this hazard.
> +	 */
> +	ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN,
> +			   MPU3050_FIFO_EN_GYRO_XOUT |
> +			   MPU3050_FIFO_EN_GYRO_YOUT |
> +			   MPU3050_FIFO_EN_GYRO_ZOUT);
> +	if (ret)
> +		goto disable;
> +
> +	/*
> +	 * Enable FIFO read-out and assert FIFO_RST in a single write so the
> +	 * chip atomically resets the write pointer with capture already on.
> +	 * Two separate writes (FIFO_RST then FIFO_EN) leave the FIFO in a
> +	 * brief transient state where the first sample after re-enable can
> +	 * land at a non-zero offset, producing per-byte-shifted frames in
> +	 * the readback below. This matches the mpu3050_trigger_handler()
> +	 * pattern.
> +	 */
> +	ret = regmap_write(mpu3050->map, MPU3050_USR_CTRL,
> +			   MPU3050_USR_CTRL_FIFO_EN |
> +			   MPU3050_USR_CTRL_FIFO_RST);
> +	if (ret)
> +		goto disable;
> +
> +	/*
> +	 * Wait for at least one sample to land. At 250 Hz that's nominally
> +	 * 4 ms; the retry loop gives a generous margin so a stretched i2c
> +	 * clock or NEW sample-rate-change settle time doesn't trip the
> +	 * timeout.
> +	 */
> +	for (retries = 0; retries < 10; retries++) {
> +		usleep_range(2000, 4000);

fsleep()

> +		ret = regmap_bulk_read(mpu3050->map, MPU3050_FIFO_COUNT_H,
> +				       &raw_count, sizeof(raw_count));
> +		if (ret)
> +			goto disable;
> +		fifocnt = be16_to_cpu(raw_count);
> +		if (fifocnt >= MPU3050_FIFO_FRAME_BYTES)
> +			break;
> +	}
> +
> +	if (fifocnt < MPU3050_FIFO_FRAME_BYTES) {

This is the timeout path, so clearer as
	if (retries == 10) //define for 10 probably makes sense
rather than checking the early exit condition wasn't true.

> +		dev_dbg(mpu3050->dev, "FIFO timeout (%u bytes)\n", fifocnt);
> +		ret = -ETIMEDOUT;
> +		goto disable;
> +	}
> +
> +	ret = regmap_bulk_read(mpu3050->map, MPU3050_FIFO_R, frame,
> +			       MPU3050_FIFO_FRAME_BYTES);
> +
> +disable:
> +	/*
> +	 * Tear FIFO capture down so the next _raw read starts clean and a
> +	 * subsequent buffered/triggered mode setup isn't confused by stale
> +	 * FIFO_EN bits. Cleanup write failures are logged but not
> +	 * propagated: we prefer to return the original read error (if
> +	 * any) rather than mask it with a teardown error, and there is no
> +	 * useful recovery path from a transport failure here anyway.

I'd rather we returned an error anyway.  Recovery path would likely be driver rebind.

> +	 */
> +	cleanup_err = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
> +	if (cleanup_err)
> +		dev_dbg(mpu3050->dev,
> +			"FIFO_EN teardown write failed: %d\n", cleanup_err);
> +	cleanup_err = regmap_write(mpu3050->map, MPU3050_USR_CTRL, 0);
> +	if (cleanup_err)
> +		dev_dbg(mpu3050->dev,
> +			"USR_CTRL teardown write failed: %d\n", cleanup_err);
> +	return ret;
> +}
> +
>  static int mpu3050_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int *val, int *val2,
> @@ -267,6 +402,7 @@ static int mpu3050_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
>  	int ret;
> +	__be16 frame[3];
>  	__be16 raw_val;
>  
>  	switch (mask) {
> @@ -333,6 +469,13 @@ static int mpu3050_read_raw(struct iio_dev *indio_dev,
>  
>  		switch (chan->type) {
>  		case IIO_TEMP:
> +			/*
> +			 * TEMP_H/L is read directly from the register file.
> +			 * The FIFO-captured TEMP slot occasionally returns
> +			 * stale data while gyro words are still consistent,
> +			 * so we deliberately do not pipe TEMP through the
> +			 * FIFO path used by IIO_ANGL_VEL below.
> +			 */
>  			ret = regmap_bulk_read(mpu3050->map, MPU3050_TEMP_H,
>  					       &raw_val, sizeof(raw_val));
>  			if (ret) {
> @@ -340,25 +483,24 @@ static int mpu3050_read_raw(struct iio_dev *indio_dev,
>  					"error reading temperature\n");
>  				goto out_read_raw_unlock;
>  			}
> -
>  			*val = (s16)be16_to_cpu(raw_val);
>  			ret = IIO_VAL_INT;
> -
>  			goto out_read_raw_unlock;
>  		case IIO_ANGL_VEL:
> -			ret = regmap_bulk_read(mpu3050->map,
> -				       MPU3050_AXIS_REGS(chan->scan_index-1),
> -				       &raw_val,
> -				       sizeof(raw_val));
> +			ret = mpu3050_fifo_read_one(mpu3050, frame);
>  			if (ret) {
>  				dev_err(mpu3050->dev,
> -					"error reading axis data\n");
> +					"error reading sample frame from FIFO: %d\n",
> +					ret);
>  				goto out_read_raw_unlock;
>  			}
> -
> -			*val = be16_to_cpu(raw_val);
> +			/*
> +			 * frame[0..2] = XOUT/YOUT/ZOUT in the order the chip
> +			 * packs gyro words into the FIFO. scan_index is 1..3
> +			 * for X/Y/Z so subtract one to land on the frame.
> +			 */
> +			*val = (s16)be16_to_cpu(frame[chan->scan_index - 1]);
>  			ret = IIO_VAL_INT;
> -
>  			goto out_read_raw_unlock;
>  		default:
>  			ret = -EINVAL;

