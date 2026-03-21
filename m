Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D044C361679;
	Sat, 21 Mar 2026 20:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774123845; cv=none; b=dwa3EDGuLlO+IKHH+fWc8XIyqgDA+d1vMVf2d5/0e9sp9fBUfMJqmOBf74LGaO7RWm0jCTd6mbmoZSTMJpL6QpVKm9L5zYsy8GJcjZt1ZDdvJ+LnmqIg/kVDMXryAGWZPhYLzO6Kr34zaBwTg241s84wB01iRkaJDL9ymK9/C58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774123845; c=relaxed/simple;
	bh=0Mh1bF1fJ7BUDbmMRB4DLU8HpWGpC1mBFVoWGsREiKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cR8xzgb/tIJbTaBnZAIbVTmKf5osz3bpRza7OsK3PhQ2htoUkdPl+iKiRCpTl0Wvs+P5ebmoutPTfeT+BCVMS9rLwJNBnR+Pzh+lpFu9zv5k3h9L1V4vvveAKQfk8wh8d/4dE2otIk6TnlhRQ3eRtZt20Bbw31lkGZsJRyRLi5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLWCpeug; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLWCpeug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72816C2BCAF;
	Sat, 21 Mar 2026 20:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774123845;
	bh=0Mh1bF1fJ7BUDbmMRB4DLU8HpWGpC1mBFVoWGsREiKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TLWCpeugD4FONvbRSPyE2r0dr4SSTdtISUkBndMdq1e9UeqDleS9bMOIprbbCgirx
	 zIC//exCOdKbNLrk4kpTHYo2eVcnmhY8y9Bjc/ITGldO3y8BQeqkTvtHESkNktOqNb
	 WviTeNuyCnXVTtngZ4XO5/1cHVHlmg/aRMJVecQNaRveRdW2/Cy8tbAZwDVbkD9jdn
	 l4FxN9Mnp4yJ7sh6LZm6ZD0FdpzEAupnUQ+DBstDYoIlG00dxgOtbbSLAe6S/kj1i7
	 bwVMOYkYOgQ/lJgqFNnZkyA/s0zVvFNWZNOneYA5jKwS9oAnKXSUdH6iicIyGZiS0R
	 BfNjhlkZjLnag==
Date: Sat, 21 Mar 2026 20:10:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 kees@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH v4] iio: st_sensors: drop temporary kmalloc buffer and
 reuse buffer_data
Message-ID: <20260321201037.638c7666@jic23-huawei>
In-Reply-To: <20260315121625.840769-1-sanjayembedded@gmail.com>
References: <20260315121625.840769-1-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Mar 2026 17:46:25 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Replace the per-call kmalloc() scratch buffer with the existing
> buffer_data[] field present in struct st_sensor_data. The existing buffer
> is DMA-aligned and sufficiently sized for all channel widths, so using it
> avoids unnecessary dynamic memory allocation on each read.
> 
> This simplifies the code, removes redundant allocation and cleanup.
> No functional change intended.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
I briefly wondered if the locking was strong enough to ensure
this isn't used at the same time as the use of the buffer in
the trigger handler.  I think it's fine though due to the
fact the only path to this function has claimed direct mode.

I haven't completely ruled out a race around the disable path for the
buffer but given the worst that can happen is wrong sensor
data I think we are fine even if there is one.

So with that in mind applied to the testing branch of iio.git which
will become togreg and get picked up by linux-next once the bots
have taken a first look at it.

Thanks,

Jonathan

> ---
> Changes in v4:
> - Rectify commit message review by David Lechner
> - Link to v3 https://lore.kernel.org/all/20260312063424.3846945-1-sanjayembedded@gmail.com/
> Changes in v3:
> - fix variable declartion placement to follow kernel coding style
> - Link to v2 https://lore.kernel.org/all/20260311182050.3467471-1-sanjayembedded@gmail.com/
> Changes in v2:
> - split series to individual patch
> - address review comment from David Lechner and reuse exising buffer instead of allocation
> - Link to v1 https://lore.kernel.org/all/20260310200513.2162018-4-sanjayembedded@gmail.com/
> ---
>  drivers/iio/common/st_sensors/st_sensors_core.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index dac593be5695..dbc5e16fbde4 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -501,14 +501,12 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
>  
>  	byte_for_channel = DIV_ROUND_UP(ch->scan_type.realbits +
>  					ch->scan_type.shift, 8);
> -	outdata = kmalloc(byte_for_channel, GFP_DMA | GFP_KERNEL);
> -	if (!outdata)
> -		return -ENOMEM;
> +	outdata = sdata->buffer_data;
>  
>  	err = regmap_bulk_read(sdata->regmap, ch->address,
>  			       outdata, byte_for_channel);
>  	if (err < 0)
> -		goto st_sensors_free_memory;
> +		return err;
>  
>  	if (byte_for_channel == 1)
>  		*data = (s8)*outdata;
> @@ -517,10 +515,7 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
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

