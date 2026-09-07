Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1471799F;
	Mon,  7 Sep 2026 01:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788744351; cv=none; b=ROknl1G91oCVim1WefS+VQ5N8RiUEZcqeIMoR8u+DzdE6FaI4/wJ03ejPuSd7gqPHV3V9HJk2OhbbXxBzYheau3th6IzDDMXNUDGcgRwhv/4uJkvElQKn5cdxmWYY/7Mc3qw1gf2x7ck8d5sR0QecIIjLoK+Y4E4yJ9lGztloTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788744351; c=relaxed/simple;
	bh=BAIprrP5MeDC3fqjYpzg5Ckn33j74jleGVhsD6UFIvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvSHfFQoYOPI2HiLSjCMty+PAS8hm6oKeAYHlj+ZwemNIcAdxGP2nktLcpfYeolK0w8gn2nQnfObOF5MiZbRdOMNJS64jYykBM7SNdinWVOMGFrDwlDJQe0aQVP0JwObJdpsd1re/76CMX4S7Mb/n9gILhFbOnuARm9CrJ8ldB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tj5wrueP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tj5wrueP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7981F00A3A;
	Mon,  7 Sep 2026 01:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788744349;
	bh=fOQblbTKMym1vkWUJZ1/4Dkf3Tf+X0YUsSk0lTju2zY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Tj5wruePaaqzN7mthMBMxqg0V3ZedCaYuNs7E3LogjpLPjCIzILvO2TRDLgR805SO
	 pBFD6BpFelU9RR1sQThR/rIkbbhtZiDejYKzv4yxVZdYDc5pWGdxOuqhDNd+rkuGCp
	 jWD1mSXhVk8ddpw0Szwy9OQwMU9+TN7GNiB30aSSFqHqGMBgCkLRgvvQuEBiiF9h3u
	 O/U0p6M6YISG8RHiCm9ZxFpOEQgL6SavPyzHGozZIaWbJvZvbN6iWMDl+gjs5Vrvc8
	 aLftqWjnC6Rh3nJJ5o96qWN6r/wv4YkW90m3EqyvPWNzaRcDCQUGjpb/H68J3lA9Vm
	 oxNtJRHhWg4eg==
Date: Mon, 7 Sep 2026 02:25:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Song Qiang <songqiang1304521@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Abhash Jha <abhashkumarjha123@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: vl53l0x-i2c: claim direct mode for raw
 reads
Message-ID: <20260907022543.09b544c8@jic23-huawei>
In-Reply-To: <20260901152126.533902-1-donggeunyoo.kernel@gmail.com>
References: <20260901152126.533902-1-donggeunyoo.kernel@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Sep 2026 00:21:26 +0900
Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:

> vl53l0x_read_raw() starts a single-shot ranging measurement and reads
> back the result. Once the triggered buffer is enabled the sensor runs in
> continuous mode and its data-ready interrupt is routed to the trigger,
> so a concurrent in_distance_raw read disturbs the streaming setup and
> never gets its completion, returning -ETIMEDOUT.
> 
> The original submission claimed direct mode here, but it was dropped
> during review because the driver had no buffer support at the time [1].
> Continuous (buffered) mode was later added without restoring the
> claim [2], reintroducing the conflict.
> 
> Reject direct reads while buffered capture is active by claiming direct
> mode around the measurement, as the vl53l1x sibling already does.
> 
> Fixes: 762186c6e7b1 ("iio: proximity: vl53l0x-i2c: Added continuous mode support")
> Link: https://lore.kernel.org/linux-iio/20180911160300.GA9212@himanshu-Vostro-3559/ [1]
> Link: https://lore.kernel.org/linux-iio/20240909101508.263085-3-abhashkumarjha123@gmail.com/ [2]
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
> Only compile-tested; I don't have VL53L0X hardware to exercise the race
> yet. The change mirrors the existing vl53l1x sibling.
> 
>  drivers/iio/proximity/vl53l0x-i2c.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> index 9fe14ceb8be7..173e69753df7 100644
> --- a/drivers/iio/proximity/vl53l0x-i2c.c
> +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> @@ -219,7 +219,10 @@ static int vl53l0x_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
>  		ret = vl53l0x_read_proximity(data, chan, val);
> +		iio_device_release_direct(indio_dev);
>  		if (ret < 0)
>  			return ret;
>  

