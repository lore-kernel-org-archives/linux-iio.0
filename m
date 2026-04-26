Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783ED1A6810;
	Sun, 26 Apr 2026 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777213021; cv=none; b=YkGDKP1BpY5wZM2bX11mYVsyt3FFSbwDI0EEgTDJ5N+VC1hfqThzOrOIj2uUWwIqwL7CQKsci/1ZxmF6wZZk3BF9xhV96R6XcxrIkEYXNNI7Qfo+qFDKq2n/WRaOLkLswIdh8w83WmCDCpTBAxqxliD/VncxX8PjA4q18yxKfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777213021; c=relaxed/simple;
	bh=1RqAm4BZX4s6bcQKzf86NrlxfpcEiZmzRYP1zhLyCj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyjA7kEwNlTkpXZrNklAHu5yhd1e314k/rHkp+xKuO7Y+wGO49FxKR46kqsUsuEh6KeFRISbPn4lm7clE0gB9hLDngS4KsgjanXvkBAXjB7UaAJVBDFW7PVqUS+yj2Aqwj2ayL8x9cowQoydCkdWqBz5/wfvRozt+RcfOK8G41Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4h3+4gx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4h3+4gx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D8FC2BCAF;
	Sun, 26 Apr 2026 14:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777213021;
	bh=1RqAm4BZX4s6bcQKzf86NrlxfpcEiZmzRYP1zhLyCj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O4h3+4gx/SbJxV8FFOQktog+eYFNa4+FXF1NfoBRY+IG5Y8WhEKO1HTGElMBnXYuW
	 iag0XJn/oexxjdH3C0X3E4Zzb2ayB0jM8aZYCPX+TTVJd+/anY7+BXtpp6H94sKISx
	 AyLsV5IzSAx6q1l74r+FG5VEpJRAydh6xAP6Tx1mE44Rft6NpPc+SMHovUBpp6C1Ea
	 uqzQTROpQzAoE6rh1gVEO7cEnlpXy3Lz/OgaW16OInpcaNsCNuimXFM5qdcsUlD4u+
	 DYNVkacSeCW02hxozm0Eu3yXmgn2UyRPzw4L/X4aYmM31H78NgzIsJhEFCcUloLizx
	 3kCsnV8AMl8xw==
Date: Sun, 26 Apr 2026 15:16:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 mingo@kernel.org, christophe.jaillet@wanadoo.fr,
 nabijaczleweli@nabijaczleweli.xyz, kees@kernel.org,
 kyungmin.park@samsung.com, k.wrona@samsung.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/9] iio: ssp_sensors: use local struct device
Message-ID: <20260426151651.48a690c9@jic23-huawei>
In-Reply-To: <20260426091710.3722035-6-sanjayembedded@gmail.com>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
	<20260426091710.3722035-6-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 14:47:06 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Introduce a struct device *dev derived from &spi->dev to improve
> readability and reorder variable(s) to follow reversed xmas tree style.
It's really minor reordering but generally I'd not do that in a patch
that does anything else.  So here I'd have put the new variables
in as close to correct location as possible, then followed with
a reorder if it was worth the churn that results. I'm not sure it is
in this particular case.

> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>

> @@ -579,9 +580,9 @@ static int ssp_probe(struct spi_device *spi)
>  	mutex_destroy(&data->pending_lock);
>  	mutex_destroy(&data->comm_lock);
>  err_setup_spi:
> -	mfd_remove_devices(&spi->dev);
> +	mfd_remove_devices(dev);
>  
> -	dev_err(&spi->dev, "Probe failed!\n");
> +	dev_err(dev, "Probe failed!\n");

Drop this one.  It's easy to find out if a driver probe succeeded
so we don't need a print for it given meaningful errors generated
messages anyway.

>  
>  	return ret;
>  }

