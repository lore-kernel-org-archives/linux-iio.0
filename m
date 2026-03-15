Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1FB214A8B;
	Sun, 15 Mar 2026 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773599821; cv=none; b=ijMY9OjQqoUqmm15kkzfTjm4//nw3n4mibSDmYjRLP33/SL9Wuotq2m22k0LTJN9l+Y9kP81w8ojJ9Yl3FuS251jpAI1VDSWzSmqFKXR15ENDVpFKXPkcRdD4JhPBB3/1Md7goegWaZJYj4JkbqdX5JkEmkxPvVLz/EmSuy/69A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773599821; c=relaxed/simple;
	bh=/zkr9Te5S8wVTK2sWbBXpVgnsFhXcZmLhN2TKIibAW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rtDWU3FQGdK/6C+rBpOj3BUFvIofGe6Gm174ibPbhOSKYicp6FpOHd8Pe/Q8TvW0VLIngytUeUIiVTt6ZXUB1MJxH3g4ovMY9MNwJkNZX/8fl2PiTufWdaMXoiAaWDPUMi3RkSL8fsBZ/lF+DB9Jb6DfEYIsPX9AU2bnJNzo07s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omMMBiXs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omMMBiXs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FA4C4CEF7;
	Sun, 15 Mar 2026 18:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773599820;
	bh=/zkr9Te5S8wVTK2sWbBXpVgnsFhXcZmLhN2TKIibAW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=omMMBiXsFOZZo7fNprdzGpRclwyRkcCFUl6nA4kSUDfk6+ROZgRZzdHSI3ttqzFKS
	 W5tnvNb/PAXyHU3UvOqjMxIaOu51YZGZmRXMqXcbfZvELY9gyys7FRUZN8zxvzVmqY
	 2kIqMAKLqofMYPCRrK7d3usjvCXKL6PyG3WWCTwMVU7oAZXkg8iQFIwvhxBxJB/UZ3
	 5lRg8ttgTaiZ9+507CVxS8DC7lfNCJiCUcyRUaDjMDMzLMysDTNssHlt8N2+306W6D
	 UIIaR6jatmGAY5FssYFQri92o8x5GZT1XxREWsPZuFnCu8QlmXlDW+1GmU1Ef+6Bq3
	 CKSUciiKMvEPQ==
Date: Sun, 15 Mar 2026 18:36:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 kees@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: ssp_sensors: simplify cleanup using __free
Message-ID: <20260315183652.37af83a1@jic23-huawei>
In-Reply-To: <20260311174151.3441429-1-sanjayembedded@gmail.com>
References: <20260311174151.3441429-1-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Mar 2026 23:11:51 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Replace manual cleanup logic with __free attribute from cleanup.h. This
> removes explicit kfree() calls and simplifies the error handling paths.
> 
> No functional change intended for kmalloc().
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com
>
I think it is worth noting this is an ancient driver.  I don't mind
clear improvements but I would suggest perhaps looking for more
recent code to see if this sort of cleanup applies.

Jonathan

> ---
> Changes in v2:
> - split series to individual patch
> - address review comment from Andy Shevchenko
> - Link to v1 https://lore.kernel.org/all/20260310200513.2162018-3-sanjayembedded@gmail.com/
> ---
>  drivers/iio/common/ssp_sensors/ssp_spi.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
> index 6c81c0385fb5..4320061475e0 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_spi.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
> @@ -331,7 +331,6 @@ static int ssp_parse_dataframe(struct ssp_data *data, char *dataframe, int len)
>  /* threaded irq */
>  int ssp_irq_msg(struct ssp_data *data)
>  {
> -	char *buffer;
>  	u8 msg_type;
>  	int ret;
>  	u16 length, msg_options;
> @@ -375,7 +374,7 @@ int ssp_irq_msg(struct ssp_data *data)
>  			 * but the slave should not send such ones - it is to
>  			 * check but let's handle this
>  			 */
> -			buffer = kmalloc(length, GFP_KERNEL | GFP_DMA);
> +			char *buffer __free(kfree) = kmalloc(length, GFP_KERNEL | GFP_DMA);
>  			if (!buffer) {
>  				ret = -ENOMEM;
>  				goto _unlock;
Read the documentation in cleanup.h and make sure you follow it.

> @@ -386,8 +385,6 @@ int ssp_irq_msg(struct ssp_data *data)
>  			if (ret >= 0)
>  				ret = -EPROTO;
>  
> -			kfree(buffer);
> -
>  			dev_err(SSP_DEV, "No match error %x\n",
>  				msg_options);
>  
> @@ -420,22 +417,17 @@ int ssp_irq_msg(struct ssp_data *data)
>  		mutex_unlock(&data->pending_lock);
>  		break;
>  	case SSP_HUB2AP_WRITE:
> -		buffer = kzalloc(length, GFP_KERNEL | GFP_DMA);
> +		char *buffer __free(kfree) = kzalloc(length, GFP_KERNEL | GFP_DMA);

What scope is this cleaning up at the end of?

>  		if (!buffer)
>  			return -ENOMEM;
>  
>  		ret = spi_read(data->spi, buffer, length);
>  		if (ret < 0) {
>  			dev_err(SSP_DEV, "spi read fail\n");
> -			kfree(buffer);
>  			break;
>  		}
>  
> -		ret = ssp_parse_dataframe(data, buffer, length);
> -
> -		kfree(buffer);
> -		break;
> -
> +		return ssp_parse_dataframe(data, buffer, length);
>  	default:
>  		dev_err(SSP_DEV, "unknown msg type\n");
>  		return -EPROTO;

