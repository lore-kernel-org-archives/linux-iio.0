Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031EC364021;
	Sun, 26 Apr 2026 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214176; cv=none; b=iq6XZ6nInrPLGYMRG8LuDvIkDgzdh9vsTIBj/GcjcKi5qKvsvhJygX/Untl3oxgorTIxAOOxiXndigCz2Fk+7Tw4bfbOwEvBsmJ8RsEfeizySHikPste86KEEXQETCHRXL8i2nEKV0T6FjEgSFNpJVTOqtqm+G2Puzp4ICgRlSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214176; c=relaxed/simple;
	bh=V2NY4ipNSXzNxirr044TNBKy3pvJoGluA5eR4cJ4lZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXCSXHJsKcY3oKx7VPN4p2M8Hjtw3CzMJIfn2JcmxQ0CJzSURQ6ZBfl3BWVy3QNMGJ5w/PN5vYB81my7Tk3njybhLruB0NdrOkcyhazGZQ+JS/BHSM8TLV3bqgryOLYvIwkzg213fI2xG8o1gm86mD0YifAuQvetnrCB6funMgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K22HcwEX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K22HcwEX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D7AC2BCAF;
	Sun, 26 Apr 2026 14:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777214175;
	bh=V2NY4ipNSXzNxirr044TNBKy3pvJoGluA5eR4cJ4lZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K22HcwEXqPp/Rs6rqiQM68KI4+X5SUa6DPswabcNnRtNp70BT5OStF4UojRqeGcDw
	 CsLk0F+LylUWcQZqYt/ETXDi+DrJtslUBFQJGK5xchuhreEIOwO79ZTbwundZNnU4B
	 TIgHipXe9NYnyQXD/d1UvSsP/Q2ueTycLbEkdR6v+FSnKH/DoWvaYYoMfZhh5v43CI
	 Sa8WkBXx8LTayHZAP5YzXNQZ6vsMPkcnhWJPHK2IyGMNQjJSIKVY2enWME7HZAbp5B
	 IcmOY8UynPaueiYiCl3JWZWw16s9UIOMZqut7goAv+bL29l8E6amUwbbcvjcFC9PhL
	 llCniSd0lJzXw==
Date: Sun, 26 Apr 2026 15:36:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: ssp_sensors: cleanup codestyle warning
Message-ID: <20260426153549.43ee3328@jic23-huawei>
In-Reply-To: <20260426105653.3764291-1-sanjayembedded@gmail.com>
References: <20260426105653.3764291-1-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 16:26:53 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Reported by checkpatch:
> FILE: drivers/iio/common/ssp_sensors/ssp_iio.c
> 
> WARNING: Block comments use a trailing */ on a separate line
> +	 * */
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  drivers/iio/common/ssp_sensors/ssp_iio.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c b/drivers/iio/common/ssp_sensors/ssp_iio.c
> index 78ac689de2fe..e83f589fd72c 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_iio.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_iio.c
> @@ -24,9 +24,10 @@ int ssp_common_buffer_postenable(struct iio_dev *indio_dev)
>  	struct ssp_sensor_data *spd = iio_priv(indio_dev);
>  	struct ssp_data *data = dev_get_drvdata(indio_dev->dev.parent->parent);
>  
> -	/* the allocation is made in post because scan size is known in this
> +	/*
> +	 * the allocation is made in post because scan size is known in this
>  	 * moment
> -	 * */
> +	 */
>  	spd->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL | GFP_DMA);

Hmm - I missed this in previous but you dropped a GFP_DMA marking
and it's just possible this platform has restricted DMA addressing and
needs them.

Otherwise it should be easy to cap how big this buffer can get and hence
do similar change to make it fixed size in ssp_sensor_data.

>  	if (!spd->buffer)
>  		return -ENOMEM;

