Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0004D264FBD;
	Wed, 25 Mar 2026 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774470314; cv=none; b=MKo0coRVWamhN86ScbMihaZfeat0ALOm6gxjBEhcNzZEKtI7bcbc7Qun0lXsVakL3zNzfX1IHRek2ndxF9hikNVFURBuTrm50Tr7U2qE/0wFbmNJcvg0UQYS3G5nb/3TJAiiAIeFNYAfYrwISd7RRJJqVXrc0bb85JynycRWl74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774470314; c=relaxed/simple;
	bh=DbQ4KRQGP2Zn275r7dBn9/PZkKVkijuwPewQd8h8h2s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2xzDu2rb0LbeyKgfTvk5gBWe5kbKeyweVs654eup6d/dbwmDJBvCWKsamLH+CUVtasUa9XrQvAIYcyABE4tXzbE/KPScnuCcBDI68EPGMqlwOLa4rGwoLRax+UpT0r2wrBxzP3CG0zpkEiY7Sf90njGdx35wuXsBnbsOWH+hAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+u64U4P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+u64U4P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25055C4CEF7;
	Wed, 25 Mar 2026 20:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774470313;
	bh=DbQ4KRQGP2Zn275r7dBn9/PZkKVkijuwPewQd8h8h2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E+u64U4PywgDVYbSrWc8Dure6lcEglgj2b/VgT6t39DWJDka+xYTyYmUuG5G5acsc
	 ACp6ybtNAoxcMBb7pAazV1GNvGgz/qp7kGHwWlk1lk1cmAC9a2V1025zVHwl0USWD1
	 ma4i6WAXZxdoQyVADyhTilxWB4g+wLZ+UhZ5h6qU7dsv13b6F6iI2rH1hyvG9q1OgT
	 EjigZntGVnSmKrD8xZOnx7yC1z9OF3Fm9b3W9oVUrD7WyyKFAkQEBYn8yR+8G1935s
	 UTQI6UZVDK7ahSceBnzTWeh6yHZ6mGJxzM9p5ObYRdYYZKplEwJclQR2K7dg8ALq/g
	 x+0SmlNS4LaVA==
Date: Wed, 25 Mar 2026 20:25:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Rondon <grondon@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bmc150-accel-core: use sysfs_emit() in show
 functions
Message-ID: <20260325202505.404cbc17@jic23-huawei>
In-Reply-To: <20260323215619.6883-1-grondon@gmail.com>
References: <20260323215619.6883-1-grondon@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Mar 2026 21:56:19 +0000
Gabriel Rondon <grondon@gmail.com> wrote:

> Replace sprintf() with sysfs_emit() in sysfs attribute show
> callbacks. sysfs_emit() is the preferred API as it is aware of the
> sysfs buffer page size limit.
> 
> Signed-off-by: Gabriel Rondon <grondon@gmail.com>
Applied. Note there is more that could be done in these two functions 
(look beyond it if considering doing this). 
> ---
>  drivers/iio/accel/bmc150-accel-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 42ccf0316..2398eb7e1 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -851,7 +851,7 @@ static ssize_t bmc150_accel_get_fifo_watermark(struct device *dev,
>  	wm = data->watermark;
>  	mutex_unlock(&data->mutex);
That mutex is only held for setting local copy of wm.  Should be no problem
in bolding it over the sysfs_emit. So
include cleanup.h if not already and use a guard.

	guard(mutex)(&data->mutex);

	return sysfs_emit(buf, "%d\n", data->watermark);

No need for a local variable.

>  
> -	return sprintf(buf, "%d\n", wm);
> +	return sysfs_emit(buf, "%d\n", wm);
>  }
>  
>  static ssize_t bmc150_accel_get_fifo_state(struct device *dev,
> @@ -866,7 +866,7 @@ static ssize_t bmc150_accel_get_fifo_state(struct device *dev,
>  	state = data->fifo_mode;
>  	mutex_unlock(&data->mutex);
>  
> -	return sprintf(buf, "%d\n", state);
> +	return sysfs_emit(buf, "%d\n", state);
>  }
>  
>  static const struct iio_mount_matrix *

