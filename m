Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEABD242D88;
	Sun, 15 Mar 2026 18:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773600395; cv=none; b=IdGGEgesvzk+emNgNlXls8x2BnsXVHomQIYvTHAuJi1uG+UotwMBlcU/uPsGJ2WsiDfmgfehgHriC+5ihXnZv/Isy9RKcfw7nIThMuEuKc3nJ5QbNsWkBaumDpktq5aKkeCMEbbi23vLQ655cYfGjli1VuVyYdqQFeMxK3pNE0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773600395; c=relaxed/simple;
	bh=YOVM3YUKlN3kejUAmEpgFt/P+ftuu9sw2v1vFivpXwI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3a3UJkEnrhVLjYRIom6q9TxE5+HH1eQDSox7P95LdBCP45kW9R95muEWrMxklCWapb4enQYezrlEBVTVWv/fIS98zM9WO4vEt0v43ZwE89cEO/RE9OOHlFMOG9XkWYIdGY62TyAmI8U+MK8M0N1BAI+Bs95jmB5DiY08PW76Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiV7G+hs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiV7G+hs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BFFC4CEF7;
	Sun, 15 Mar 2026 18:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773600395;
	bh=YOVM3YUKlN3kejUAmEpgFt/P+ftuu9sw2v1vFivpXwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HiV7G+hs7FqOsGQeDj2QvVvMZVpB6h1/KzKxVbPCl69KayC0pFkEBBszXb+ZRbluC
	 iU5enwfqxpDaEmK1JsQtVNJ43DLdCgZkj7SbNrRGKN+q1gJOj6UBIkmiXjsM7uqdhl
	 +lqglbXomUp2X0xDcUPinvkK2VTgVp8jAe2zQVonyxhUh7C9v1Ya8nQ06Vs3vqbTPD
	 gXbGHF7i3iDqMpyGqt0BVeCdXegiRJNvbk8JKpTizcjkjsKECkgLrIZFBqTGF3rm6d
	 ZqK4yK6gsg9VGRx8SPkIcSHB+sfaNSSx62Aa03qNXnAsF2gFxq49y0D7x5lLTrkXIt
	 uz8tM/UdNNO2A==
Date: Sun, 15 Mar 2026 18:46:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 kees@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: st_sensors: drop temporary kmalloc buffer and
 reuse buffer_data
Message-ID: <20260315184627.5bca7f73@jic23-huawei>
In-Reply-To: <20260311182050.3467471-1-sanjayembedded@gmail.com>
References: <20260311182050.3467471-1-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Mar 2026 23:50:50 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Replace the per-call kmalloc() scratch buffer with the statically allocated
> buffer_data[] field present in struct st_sensor_data. The existing buffer
> is DMA-aligned and sufficiently sized for all channel widths, so using it
> avoids unnecessary dynamic memory allocation on each read.
> 
> This simplifies the code, removes redundent code and allocation.
> No functional change intended.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
> Changes in v2:
> - split series to individual patch
> - address review comment from David Lechner and reuse exising buffer instead of allocation
> - Link to v1 https://lore.kernel.org/all/20260310200513.2162018-4-sanjayembedded@gmail.com/
> ---
>  drivers/iio/common/st_sensors/st_sensors_core.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index dac593be5695..488e2bf6d117 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -495,20 +495,17 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
>  				     struct iio_chan_spec const *ch, int *data)
>  {
>  	int err;
> -	u8 *outdata;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  	unsigned int byte_for_channel;
>  
>  	byte_for_channel = DIV_ROUND_UP(ch->scan_type.realbits +
>  					ch->scan_type.shift, 8);
> -	outdata = kmalloc(byte_for_channel, GFP_DMA | GFP_KERNEL);
> -	if (!outdata)
> -		return -ENOMEM;
> +	u8 *outdata = (u8 *)sdata->buffer_data;
Why is buffer_data a char array?  It's already implicitly cast to a u8
in one place. I'd see if it actually wants to be a char anywhere in the driver.
If not fix that as a precursor patch to this one.

I'm not sure I'd bother having a local variable for outdata given
it is only used a few times but I don't mind it much (beyond what Andy
pointed out about declaring it here).

Jonathan

>  
>  	err = regmap_bulk_read(sdata->regmap, ch->address,
>  			       outdata, byte_for_channel);
>  	if (err < 0)
> -		goto st_sensors_free_memory;
> +		return err;
>  
>  	if (byte_for_channel == 1)
>  		*data = (s8)*outdata;
> @@ -517,10 +514,7 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
>  	else if (byte_for_channel == 3)
>  		*data = (s32)sign_extend32(get_unaligned_le24(outdata), 23);
>  
> -st_sensors_free_memory:
> -	kfree(outdata);
> -
> -	return err;
> +	return 0;
>  }
>  
>  int st_sensors_read_info_raw(struct iio_dev *indio_dev,

