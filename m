Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3073D493646;
	Sat, 22 Aug 2026 22:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787436153; cv=none; b=qw6l2h2aiJ4DBgcjHor8PxAo5ULPfbQOVeWjlVo5hrAQ7dGqabE9XkHutKsW7JBNDpGoFryK+lBTYtht06SyqOJfdLFfJ/YR+k2Ucx9rAhlr9swZHWW2B/x2sqyZMdtH1o7lBPOdt+pLIG/sbOevxm/QvQQZ8T37ANH9/EUr1Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787436153; c=relaxed/simple;
	bh=dRfMhllsnQ9SZOHLOxbikYljTYB0NsRp2HBh7gWrIno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qM+2U4mkcETFbBMXANvysp5Wo4ffyuu2aObmRf1nFneCVSuK4KanaKDJOwNcjoCUYdwzVazFbVvcwf0mMVWekQJyQ65s7o0atJORsZld8CyQyZn6aP8bwMERaddPkCeI1QDlh/Ck3nbhrVjfgloII9SmZ7VoR1FuBhxzugLbDnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8HuF5b0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8HuF5b0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8261F000E9;
	Sat, 22 Aug 2026 22:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787436151;
	bh=1Kv9MWBpRI7LNKdLWjtILDfex2lnjgxnNLMe2mhsttg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V8HuF5b0MRIhy8iPZnR9Nesbf3+xZ2gV2JtsMPEk2g8gpibdk7jklAiKoWzrR/3MN
	 rN8RFLyuhvW89pZAZN7u8clnYcTHE76DZ1z++vx9CQfSRDkLpc9GTP6llCkyJFwvEU
	 bIUWOPFo4fCN8TP3FqaaLmCwij89coupUBHTlB2+4FMShL5xoMU/HPutOKc/Ot1r6W
	 FPnVpN2LdlrHNLUuRkZtxhWkjuP0Dua8hsoZ3b/RygXjWnwJnvEKQ7RXK0+H0fr2ie
	 wVS13BHL7fOaQrrhL/Lo5Kj6dHT2yhnz/3vLRmawOem0mqw+DWiSbdsta0gYve9rCn
	 ycI/iOQh8dIpA==
Date: Sat, 22 Aug 2026 23:02:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 andriy.shevchenko@intel.com, grondon@gmail.com, linusw@kernel.org,
 hexlabsecurity@proton.me, sakari.ailus@linux.intel.com,
 srinivas.pandruvada@linux.intel.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: accel: bmc150: use aligned scan buffer for
 both trigger and fifo
Message-ID: <20260822230227.6fafb565@jic23-huawei>
In-Reply-To: <20260815175728.99541-2-yashsuthar983@gmail.com>
References: <20260815175728.99541-1-yashsuthar983@gmail.com>
	<20260815175728.99541-2-yashsuthar983@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Aug 2026 23:27:26 +0530
Yash Suthar <yashsuthar983@gmail.com> wrote:

> Drop buffer as duplicate and s16 is not correct we needed __le16 as little
> endian, keep scan at the end of the bmc150_accel_data struct with
> IIO_DMA_MINALIGN, and use it for both paths.
> 
> Fixes: bd7fe5b71918 ("iio: accel: BMC150 accel support")
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
> ---
>  drivers/iio/accel/bmc150-accel-core.c |  4 ++--
>  drivers/iio/accel/bmc150-accel.h      | 14 +++++---------
>  2 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index dc8a6285cf3d..89a475ef9a9b 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -1191,12 +1191,12 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
>  
>  	mutex_lock(&data->mutex);

Relevant to the next patch - what is this lock actually protecting?
At first glance I'd assume the buffer, but then we drop the lock before
we are done with that.


>  	ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_REG_XOUT_L,
> -			       data->buffer, AXIS_MAX * 2);
> +			       data->scan.channels, AXIS_MAX * 2);
>  	mutex_unlock(&data->mutex);
>  	if (ret < 0)
>  		goto err_read;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,

This is still using scan, but the lock has been released.

>  					   pf->timestamp);
>  err_read:
>  	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
> index e8f26198359f..9deff256aed5 100644
> --- a/drivers/iio/accel/bmc150-accel.h
> +++ b/drivers/iio/accel/bmc150-accel.h
> @@ -64,15 +64,6 @@ struct bmc150_accel_data {
>  	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
>  	struct mutex mutex;
>  	u8 fifo_mode, watermark;
> -	s16 buffer[8];
> -	/*
> -	 * Ensure there is sufficient space and correct alignment for
> -	 * the timestamp if enabled
> -	 */
> -	struct {
> -		__le16 channels[3];
> -		aligned_s64 ts;
> -	} scan;
>  	u8 bw_bits;
>  	u32 slope_dur;
>  	u32 slope_thres;
> @@ -85,6 +76,11 @@ struct bmc150_accel_data {
>  	void (*resume_callback)(struct device *dev);
>  	struct delayed_work resume_work;
>  	struct iio_mount_matrix orientation;
> +	/* Ensure correct alignment of timestamp and DMA safety */
> +	struct {
> +		__le16 channels[3];
> +		aligned_s64 ts;
> +	} scan __aligned(IIO_DMA_MINALIGN);
>  };
>  
>  int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,

