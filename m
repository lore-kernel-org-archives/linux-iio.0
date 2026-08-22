Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAE9312825;
	Sat, 22 Aug 2026 22:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787436409; cv=none; b=tlTfH5DLx+TDK5ZhPVg8I9MvGiRGutL/5Kf/I1x5KB9rE26Thwqb4/XrhE8Y/RFsblmv8qfbxpocMuS5YfZRnA6f2Vl9xUSq0R1dL8hdP2acZ0zUIuGSHlYmZ4/4ZrlohlPs7s/P02/gvU7gYta9t+CKKzYC3EXiriQUC9VNOqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787436409; c=relaxed/simple;
	bh=GDCCpVs5qV3XEBNmoQ6NH043wKQJoOEbOeTEbMXvktE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tx0ZYWbGwMMJy97WDcqwCWoSL51oUu+mAD+y8/NodeOp9fiDPB1dN+jEIqm/w/kimMetPoV2ITcbxAzIdNXGEb2XjJUjvjyJQgClSObQypmKQqf94TggGuD21b8v2k/a7f2mlCZRnVUyTbGUoFscv7QdNW6UYZj0b6lReHpNEEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+3rsl9D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+3rsl9D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF01A1F000E9;
	Sat, 22 Aug 2026 22:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787436408;
	bh=dU+vSIiHDjInexD99n8K0nTwnPOnpzLHVqetmqu4Q2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=J+3rsl9Dhwo5hvZaR2eRbU539mTJBifYvdhDQirjUi17CdUDcv1IPjoAFDIuGLpYC
	 4XVnbRFOGLP5Cviio4Ovg90srZhQvZa1ndu1tILghWwaIJncrhDYHEeo4VsNW1DYx4
	 nGhwfYMw4oUx1A954QwDel8j4pCWeBK4E0ZgD04TjcTLMMuF5e8nOGbynN83vRLBV8
	 HuB/RvdmpMRnzXt28xWLonAPgm1uuo8xS6TEnvxjjYr+DIy//w/EOa6Nhut/EXKFEW
	 Pb1LUlxA+c1Um2LrJx0atMK0lmcDYusgpcDOSPZgGqsQrf8tRt8+bmMYVwM4Y+F4qH
	 Je8+FpDugx6KQ==
Date: Sat, 22 Aug 2026 23:06:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 andriy.shevchenko@intel.com, grondon@gmail.com, linusw@kernel.org,
 hexlabsecurity@proton.me, sakari.ailus@linux.intel.com,
 srinivas.pandruvada@linux.intel.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: accel: bmc150: use DMA-safe buffers for
 regmap bulk reads
Message-ID: <20260822230643.2b7e1dc0@jic23-huawei>
In-Reply-To: <20260815175728.99541-3-yashsuthar983@gmail.com>
References: <20260815175728.99541-1-yashsuthar983@gmail.com>
	<20260815175728.99541-3-yashsuthar983@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Aug 2026 23:27:27 +0530
Yash Suthar <yashsuthar983@gmail.com> wrote:

> The FIFO and read_raw buffers are passed to regmap bulk/raw reads
> ,which is not DMA-safe.Moved them into struct bmc150_accel_data

Move the comma up a line.

> after scan, each aligned to IIO_DMA_MINALIGN.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>

My main question here is around locking and whether we need
to space all 3 buffers out in a cache line each. That is painful
on some architectures.  If we ensure that DMA to one of these
never overlaps with the CPU accessing a different one, then we can
just mark the first one as IIO_DMA_MINALIGN.

Jonathan

> ---
>  drivers/iio/accel/bmc150-accel-core.c | 14 ++++++--------
>  drivers/iio/accel/bmc150-accel.h      |  5 +++++
>  2 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 89a475ef9a9b..e8d27fd1be3f 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -125,7 +125,6 @@
>  #define BMC150_ACCEL_REG_FIFO_CONFIG0		0x30
>  #define BMC150_ACCEL_REG_FIFO_CONFIG1		0x3E
>  #define BMC150_ACCEL_REG_FIFO_DATA		0x3F
> -#define BMC150_ACCEL_FIFO_LENGTH		32
>  
>  enum bmc150_accel_axis {
>  	AXIS_X,
> @@ -622,7 +621,6 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
>  	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
>  	int axis = chan->scan_index;
> -	__le16 raw_val;
>  
>  	mutex_lock(&data->mutex);
>  	ret = bmc150_accel_set_power_state(data, true);
> @@ -632,14 +630,14 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
>  	}
>  
>  	ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_AXIS_TO_REG(axis),
> -			       &raw_val, sizeof(raw_val));
> +			       &data->regval, sizeof(data->regval));
>  	if (ret < 0) {
>  		dev_err(dev, "Error reading axis %d\n", axis);
>  		bmc150_accel_set_power_state(data, false);
>  		mutex_unlock(&data->mutex);
>  		return ret;
>  	}
> -	*val = sign_extend32(le16_to_cpu(raw_val) >> chan->scan_type.shift,
> +	*val = sign_extend32(le16_to_cpu(data->regval) >> chan->scan_type.shift,
>  			     chan->scan_type.realbits - 1);
>  	ret = bmc150_accel_set_power_state(data, false);
>  	mutex_unlock(&data->mutex);
> @@ -918,7 +916,7 @@ static int bmc150_accel_set_watermark(struct iio_dev *indio_dev, unsigned val)
>   * frame data is discarded.
>   */
>  static int bmc150_accel_fifo_transfer(struct bmc150_accel_data *data,
> -				      char *buffer, int samples)
> +				      void *buffer, int samples)
>  {
>  	struct device *dev = regmap_get_device(data->regmap);
>  	int sample_length = 3 * 2;
> @@ -941,7 +939,6 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
>  	struct device *dev = regmap_get_device(data->regmap);
>  	int ret, i;
>  	u8 count;
> -	u16 buffer[BMC150_ACCEL_FIFO_LENGTH * 3];
>  	int64_t tstamp;
>  	uint64_t sample_period;
>  	unsigned int val;
> @@ -993,7 +990,7 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
>  
>  	count = min_t(u8, count, BMC150_ACCEL_FIFO_LENGTH);
>  
> -	ret = bmc150_accel_fifo_transfer(data, (u8 *)buffer, count);
> +	ret = bmc150_accel_fifo_transfer(data, data->fifo_buff, count);
>  	if (ret)
>  		return ret;
>  
> @@ -1008,7 +1005,8 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
>  
>  		j = 0;
>  		iio_for_each_active_channel(indio_dev, bit)
> -			memcpy(&data->scan.channels[j++], &buffer[i * 3 + bit],
> +			memcpy(&data->scan.channels[j++],
> +			       &data->fifo_buff[i * 3 + bit],
>  			       sizeof(data->scan.channels[0]));
>  
>  		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
> index 9deff256aed5..8f64b24339e4 100644
> --- a/drivers/iio/accel/bmc150-accel.h
> +++ b/drivers/iio/accel/bmc150-accel.h
> @@ -56,6 +56,8 @@ enum bmc150_accel_trigger_id {
>  	BMC150_ACCEL_TRIGGERS,
>  };
>  
> +#define BMC150_ACCEL_FIFO_LENGTH		32
> +
>  struct bmc150_accel_data {
>  	struct regmap *regmap;
>  	int irq;
> @@ -81,6 +83,9 @@ struct bmc150_accel_data {
>  		__le16 channels[3];
>  		aligned_s64 ts;
>  	} scan __aligned(IIO_DMA_MINALIGN);
> +	/* DMA-safe buffers for bulk/raw reads */
> +	__le16 fifo_buff[BMC150_ACCEL_FIFO_LENGTH * 3] __aligned(IIO_DMA_MINALIGN);
> +	__le16 regval __aligned(IIO_DMA_MINALIGN);

This is potentially a lot of padding that might not be necessary.
What locking protects these?  I'd kind of expect all 3 to be used
under a single lock.  If that's the case and locks are held for all
such usage, then we can just force alignment of the first one.


>  };
>  
>  int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,

