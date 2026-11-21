Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795287703;
	b=dhYtlWZ2DCydvdYycOwG5ymqjkClihWFbf4TmmxNK6iS4H1U0MiiCvfZjQdNaHvweg6n
	 jUfxFKGbqgQti3sKtvJVZfotR06fzgm/JHCNH6XYTcGTw4YASZSI0mk/RzLGqTTiEb0ek
	 G3160X2V4H2mE0DT81BzybrrUo6dHWz2JdPjRA3ELuUs6VkxYX2Jz0p45ocgiUxaOqnFW
	 ha8ieMi/+L9dtubGxpFpRrDNZR+zw3YXNhVpl1H85P9Z3WK+hvHIRHyj8PytfPJNqI3al
	 KsF2Bxy+PeEGK0Q5mfJLfHtmxyvau051rdbni/7/2olKBQfbtIZECBZyFg8k1XPrvqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795287703;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BWcYwG6aYUBcbIFd7axL29ZYREg4eBT0tDh0uF2VbWA=;
	b=EmqoJ/IJ+PCSHvSz3dGt6WnPMiislszytm5LTtVedTtCeWtsqIccA+p2QnwDE9bhlfXn
	 v8QnSebwU5AC8TqbGwqgViib32/qM3C6WUPnByqe4tHAJ4HUKYgXPcDGQplz9nFVavsPc
	 kRdWU9WkpfoJJLQy/O4KTap5Fl0gWVH3WjTQOQMCz2E1EWV4+3b1D3e+gNxsNSIIGS4og
	 g+grwbslcaoPWnwJZRer7o1fEvbnpicLA3AoxugzFEHWm6WKvK1ote+D7JnhjJIgCBYtq
	 LWzhWM+VJXUylo2zBJub6xv+v8E2D0zhcTIyd5nrRqsOjKcyoKeTKaxhGtr8Nk0mjcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lSGjrwz2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BD8606A320;
	Sat, 21 Nov 2026 19:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lSGjrwz2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574D21F000C0;
	Sat, 21 Nov 2026 19:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795287702;
	bh=BWcYwG6aYUBcbIFd7axL29ZYREg4eBT0tDh0uF2VbWA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lSGjrwz2ZCGchBhzRYqIFUmDmqtnPb3JTcKrWTzIf9+IRtzpIBxocqWXRhiULJbuw
	 Bj+jtGEL01EmLnnviJNvMNvoRHtjFXyCB7vHybAmdSwcm3TJEg18ICj6/9IiG+XQAc
	 /YZ8qtauEW0Di/2DPMG+njsDN9xzvo+hdDlZ61W+l1n2/j8qmsNHxscoVs5Sjshyrm
	 54s9TKNiWr60iNNVmz+SN7oZO0aXhf2ROuDTy0TvrgABUfQWi3DuuQ7Jf5zvcSYiuV
	 5LsNqoaq012FSmzqNCK6XzTThQGpB40Rb0kvu0awrwYyGXj4UpReOPx06+9RtNvSzu
	 6fc2nVSCc0ndg==
Date: Sat, 21 Nov 2026 19:01:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: Re: [PATCH v2] iio: pressure: dps310: read the first temperature in
 probe
Message-ID: <20261121190138.7a8f4bd9@jic23-hlaptop>
In-Reply-To: <20261121182527.34489-1-zoone.rupert@gmail.com>
References: <20261121182527.34489-1-zoone.rupert@gmail.com>
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

On Sat, 21 Nov 2026 20:25:27 +0200
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> The first temperature read is in dps310_fifo_interval() instead of
> probe. That function is called with data->lock held and takes it
> again, so enabling the buffer without a trigger deadlocks.
> 
> Move the read to probe.
> 
> Fixes: 903941a9b06a ("iio: pressure: dps310: don't wait for new temperature in trigger handler")
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>

> ---
> v2: return inside the guard scope (Andy)
> v1: https://lore.kernel.org/linux-iio/20261119190827.36947-1-zoone.rupert@gmail.com/
> 
> Based on iio togreg, fine to squash into 903941a9b06a instead.
Squashed and fresh togreg pushed out. 
> 
> Tested on a DPS310 on a BeagleBone Black: enabling the buffer without
> a trigger works.
> 
> Cc: Arnav Kapoor <kapoorarnav43@gmail.com>
> Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
>  drivers/iio/pressure/dps310.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index 9b52cbc2372a..fc727e5fcd59 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -1058,16 +1058,9 @@ static unsigned int dps310_fifo_interval(struct dps310_data *data,
>  {
>  	unsigned int drain_interval_ms, fill_ms, want_ms;
>  	int scan_rate;
> -	int rc;
>  
>  	fill_ms = MSEC_PER_SEC * DPS310_FIFO_DEPTH / (prs_rate + tmp_rate);
>  
> -	/* Pressure compensation needs a temperature from the start */
> -	scoped_guard(mutex, &data->lock)
> -		rc = dps310_read_temp_raw_locked(data);
> -	if (rc)
> -		return rc;
> -
>  	/*
>  	 * There is no hardware watermark, so take it as the number of scans
>  	 * the user will wait for and drain at that rate. Scans come from
> @@ -1478,6 +1471,13 @@ static int dps310_probe(struct i2c_client *client)
>  	if (rc)
>  		return rc;
>  
> +	/* Pressure compensation needs a temperature from the start */
> +	scoped_guard(mutex, &data->lock) {
> +		rc = dps310_read_temp_raw_locked(data);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	/*
>  	 * The device measures continuously in background mode, so a triggered
>  	 * capture is just a read of the latest results. The setup ops run the
> 
> base-commit: 903941a9b06ae445c70646ab061b604c2dea17d3

