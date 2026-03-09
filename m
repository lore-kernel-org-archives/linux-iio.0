Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738EB3EFD35;
	Mon,  9 Mar 2026 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773084620; cv=none; b=kP40ngM782cWDMKaxEmkrUapX1gzPRCWn7mb1IQzcBCCgNCz1G6L6Hsbhb/Id+xh5vobLrFJS3BJoOESCeaAbUjGt/Fk/R6F27rRIswftIuT7sCUH/i4kxXcYL08ceeDInAG30rUAEtGI6N+pjEd7NkMnbS5+nG0x4zY2XuMuVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773084620; c=relaxed/simple;
	bh=cB+UyMbvsZvzPNcIYf2WMlOCVig23u/3vTBHH4nhJoc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uUPiW26f5vfVGriTtfBuJO9xF5leeDpbUrHD8eY7BB/PtPj9ZdXQL59/D8o5tLAKQ03sE69fiLfRNNpUXle4FQ6M3ogogo29D9xD7Q9i7osT0IbLfwtE59Cu+kkzsxsXxZmeVpv9Z9lJkCdRwG9Lg6TJLmf8ub1Kfbu9AVxMR4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uY6jw0i2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uY6jw0i2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CB7C4CEF7;
	Mon,  9 Mar 2026 19:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773084620;
	bh=cB+UyMbvsZvzPNcIYf2WMlOCVig23u/3vTBHH4nhJoc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uY6jw0i2N9aFyvJf3Ux9BZsQXWW7AHCCNK+PHNsonNGmE3qQiEH+79utVZHb8LC1j
	 dup5MWBeinrOZzxnmViJKa1KG6172UDr371TkQZhdy20qdp0sDmUGJobnonooqM4vp
	 2VncfWGFxMcr6/OgaYtOxBE4e/ji3Seqj0+3Kj7jTXQDmU3MuL526SkQaIx1Orq/QU
	 ROI+ucdNc1ibXeEAXiKtiJG3Xi9zgLbiVNQYszhfRRQbZ/tNgz1KWO+O8OLpjsLbKL
	 WeMiknjFIWB3bEwmGK05FTfObhYYotofFKzoMopf7FYMlOr74oNGVpoUF9LYnKett2
	 /+vEW4PkEUamA==
Date: Mon, 9 Mar 2026 19:30:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 waqar.hameed@axis.com, linusw@kernel.org, sakari.ailus@linux.intel.com,
 harshit.m.mogalapalli@oracle.com, antoniu.miclaus@analog.com,
 andrew.ijano@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: accel: sca3000: convert to guard(mutex)
Message-ID: <20260309193010.104159cb@jic23-huawei>
In-Reply-To: <20260309153408.71512-5-rajveer.chaudhari.linux@gmail.com>
References: <20260309153408.71512-1-rajveer.chaudhari.linux@gmail.com>
	<20260309153408.71512-5-rajveer.chaudhari.linux@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Mar 2026 21:04:08 +0530
Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com> wrote:

> Replace manual mutex_lock/mutex_unlock pair with guard(mutex) in
> sca3000_print_rev(), sca3000_ring_int_process(),
> sca3000_read_event_config(), __sca3000_hw_ring_state_set(),
> sca3000_hw_ring_preenable(), sca3000_hw_ring_postdisable(),
> sca3000_clean_setup(), sca3000_stop_all_interrupts().
> This ensures the mutex is released on all return paths and
> allows returning directly without a goto label.
> 
> Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Hi Rajveer,

This one isn't so simple. May need a couple of steps to get to the
code we want to end up with that takes full advantage of guard()

> ---
> v2: Dropped Header alignment change
> ---
>  drivers/iio/accel/sca3000.c | 97 ++++++++++++++++---------------------
>  1 file changed, 42 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index 4a827be439a2..8a06602ab41c 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/interrupt.h>
>  #include <linux/fs.h>
> +#include <linux/cleanup.h>
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/kernel.h>
> @@ -424,16 +425,16 @@ static int sca3000_print_rev(struct iio_dev *indio_dev)
>  	int ret;
>  	struct sca3000_state *st = iio_priv(indio_dev);
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
> +
>  	ret = sca3000_read_data_short(st, SCA3000_REG_REVID_ADDR, 1);
>  	if (ret < 0)
> -		goto error_ret;
> +		return ret;
> +
>  	dev_info(&indio_dev->dev,
>  		 "sca3000 revision major=%lu, minor=%lu\n",
>  		 st->rx[0] & SCA3000_REG_REVID_MAJOR_MASK,
>  		 st->rx[0] & SCA3000_REG_REVID_MINOR_MASK);
> -error_ret:
> -	mutex_unlock(&st->lock);
>  
>  	return ret;

	return 0;

To make it clear that if we get here it is a good path.


>  }
> @@ -996,13 +997,14 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
>  	struct sca3000_state *st = iio_priv(indio_dev);
>  	int ret, i, num_available;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  
>  	if (val & SCA3000_REG_INT_STATUS_HALF) {
Hmm. This code is unnecessarily complex - Probably written by a younger more foolish me ;)

So I think we really want to head towards something like the following.
Probably break this up though.  guard() patch first, then flip the logic in
a second patch.


Val is a parameter so the test can be outside the lock.  Also, we can just
exit early if the bit isn't set, reducing the indent considerably.
	
	if (!(val & SCA3000_REG_INT_STATUS_HALF))
		return;

	guard(mutex)(&st->lock);

	ret = sca3000_read_data_short(st, SCA3000_REG_BUF_COUNT_ADDR,  1);
	if (ret)
		return;

	num_available = st->rx[0];
	/*
	 * num_available is the total number of samples available
	 * i.e. number of time points * number of channels.
	 */
	ret = sca3000_read_data(st, SCA3000_REG_RING_OUT_ADDR, st->rx,
				num_available * 2);
	if (ret)
		return;

	for (i = 0; i < num_available / 3; i++) {
		/*
		 * Dirty hack to cover for 11 bit in fifo, 13 bit direct reading.
		 *
		 * In theory the bottom two bits are undefined. In reality they
		 * appear to always be 0.
		 */
		iio_push_to_buffers(indio_dev, st->rx + i * 3 * 2);
	}

>  		ret = sca3000_read_data_short(st, SCA3000_REG_BUF_COUNT_ADDR,
>  					      1);
>  		if (ret)
> -			goto error_ret;
> +			return;
> +
>  		num_available = st->rx[0];
>  		/*
>  		 * num_available is the total number of samples available
> @@ -1011,7 +1013,8 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
>  		ret = sca3000_read_data(st, SCA3000_REG_RING_OUT_ADDR, st->rx,
>  					num_available * 2);
>  		if (ret)
> -			goto error_ret;
> +			return;
> +
>  		for (i = 0; i < num_available / 3; i++) {
>  			/*
>  			 * Dirty hack to cover for 11 bit in fifo, 13 bit
> @@ -1023,8 +1026,6 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
>  			iio_push_to_buffers(indio_dev, st->rx + i * 3 * 2);
>  		}
>  	}
> -error_ret:
> -	mutex_unlock(&st->lock);
>  }
>  
>  /**
> @@ -1110,11 +1111,11 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
>  	struct sca3000_state *st = iio_priv(indio_dev);
>  	int ret;
>  	/* read current value of mode register */
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  
>  	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
>  	if (ret)
> -		goto error_ret;
> +		return ret;
>  
>  	switch (chan->channel2) {
>  	case IIO_MOD_X_AND_Y_AND_Z:
> @@ -1134,7 +1135,7 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
With a return where there is currently a ret = 0; just above here you can drop
the else and reduce the indent of this code.

>  			ret = sca3000_read_ctrl_reg(st,
>  						SCA3000_REG_CTRL_SEL_MD_CTRL);
>  			if (ret < 0)
> -				goto error_ret;
> +				return ret;
>  			/* only supporting logical or's for now */
>  			ret = !!(ret & sca3000_addresses[chan->address][2]);
Can return here too. It's a 'good' path but that's fine.

There are a couple above here as well that aren't in the context.

>  		}
> @@ -1143,9 +1144,6 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
>  		ret = -EINVAL;
return there.
>  	}
>  
> -error_ret:
> -	mutex_unlock(&st->lock);
> -
And ultimately there should be no way of getting here, so this can go.

>  	return ret;
>  }
>  
> @@ -1277,10 +1275,12 @@ int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
>  	struct sca3000_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
> +
>  	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
>  	if (ret)
> -		goto error_ret;
> +		return ret;
> +
>  	if (state) {
>  		dev_info(&indio_dev->dev, "supposedly enabling ring buffer\n");
>  		ret = sca3000_write_reg(st,
return in both these legs. No point in having the reader have to look down
to see if anything else happens if we just end up with return ret;

> @@ -1290,8 +1290,6 @@ int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
>  		ret = sca3000_write_reg(st,
>  			SCA3000_REG_MODE_ADDR,
>  			(st->rx[0] & ~SCA3000_REG_MODE_RING_BUF_ENABLE));
> -error_ret:
> -	mutex_unlock(&st->lock);
>  
>  	return ret;
>  }
>  static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
> @@ -1342,17 +1334,15 @@ static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
>  		return ret;
>  
>  	/* Disable the 50% full interrupt */
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  
>  	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
>  	if (ret)
> -		goto unlock;
> -	ret = sca3000_write_reg(st,
> +		return ret;
> +
> +	return sca3000_write_reg(st,
>  				SCA3000_REG_INT_MASK_ADDR,

Check indentation. I suspect this is all 1 space too little now.

>  				st->rx[0] & ~SCA3000_REG_INT_MASK_RING_HALF);
> -unlock:
> -	mutex_unlock(&st->lock);
> -	return ret;
>  }


>  
>  static const struct iio_info sca3000_info = {
> @@ -1504,18 +1492,17 @@ static int sca3000_stop_all_interrupts(struct sca3000_state *st)
>  {
>  	int ret;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
> +
>  	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
>  	if (ret)
> -		goto error_ret;
> -	ret = sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
> +		return ret;
> +
> +	return sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
>  				(st->rx[0] &
As above. Indentation needs an update.

>  				 ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
>  				   SCA3000_REG_INT_MASK_RING_HALF |
>  				   SCA3000_REG_INT_MASK_ALL_INTS)));
> -error_ret:
> -	mutex_unlock(&st->lock);
> -	return ret;
>  }
>  
>  static void sca3000_remove(struct spi_device *spi)

