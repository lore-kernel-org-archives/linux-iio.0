Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBAF30C631
	for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2026 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788702940; cv=none; b=Pk/LgTkfnhdi50rqpD4XfQOPVJAkXXDWFQgZJRJ/KCjyJIKynIFGg91vUivzUr/AtkwJPBlYyV5NS6uNxiSRyTmq5Gil/Dje1GM5ztsUIYcyuEJxzjW+6CGZE8IZIF0aOlOvkT2WwmU81Su3J+dJptGDpZSUnP20hvZK9QSgevY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788702940; c=relaxed/simple;
	bh=9AbHtUnyJdSad1+pPE4S5Q1Qe0SJtnb1F3HJ+4VOdHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTf/TdOJNtCNl2ZL9Mc6cgXuD6qqWyBj6CmNzuBw3zLT8CWpSWCJAwPcZlGiVfI87eRtHOkPbpkLLd+Pp0t0/LGB5UX6/Rxjc29oQ2MODEtqIZsiM6QcEmP2TCT4O+MrmtmuDyKcxo7sUQDlXrU565VdbgZkCP6Sty0bwb5x5yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgXjUoWc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgXjUoWc"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49d036e0e99so5930625e9.1
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 06:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788702937; x=1789307737; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AAkt+WsD2x5mubq2SLqxrx2zGJJKOZ40UAK2ergnfnc=;
        b=DgXjUoWcxBUxd79f+URJCQ1Sj6f5u5bxv1RjUbBWyCzCg4klDK2vnn9IDxWc2+Ywo8
         MFi3bduJYfjs1Dw3vBDJ122wcnS3YeU1Uh6bnbh8j1n3f+tUz1lqMrrhFw8nPMM5QmJ6
         bcrBwb5J5y+UZ23Y0upefkVYRkWqxG7HDGl9DDTXG9dq4f3bCwEKwXrL2FJ4ZO65JPld
         kiKw5Nd5bgNUPN/Efrpyy6Yc67Q+bnS8/60HijATD/Uyie28vaNl0GaMVIRe8K/Zc9I2
         sWh9yA3sRdMCrMqPewlZ6Bh+8Oz6tHWd3ROYKTaqdrlKafUc7DBpbfvXL69fxYWgg6i0
         Bddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788702937; x=1789307737;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AAkt+WsD2x5mubq2SLqxrx2zGJJKOZ40UAK2ergnfnc=;
        b=JWvY7SJEeWc0tFzMh0PQ/qTYNlvr4NbOT+Y0XQ81ONQi781FIRLEKxaDiFCYQz1Nez
         S3ONDkJXICryEXqJE7Q6bRUzrxfKarYzCaZCYxv64NYOo2RE7zky0kRvD7BzSkHo94cO
         /2mRP5ZNwlvlAbi2B/KTPuIX/FEbPNYr8VyjXLmz+NA2frmXHblzOp3RmjnriBPHkyzQ
         ClREu2vsRJ4WrY+8DkBfMlD0dv4Eg6r7VMEu0dlqYcUwA8F2mCNidApnn3KORlB4gEyv
         N+027PPOlBl1ZvVBWJpbJbm1/yQcywSXN6qreLvVtB4WGmO/TjwkPNi+IWt+0L6Z9RkV
         K83g==
X-Forwarded-Encrypted: i=1; AKwUvBxxnV0nT0YfvA5NPk6fC/JxmxGJMY0hrgNvBs02JvuJJ8t2Meing6Wckqnp4d0tq751yV+0WYgnAuI=@vger.kernel.org
X-Gm-Message-State: AFuF++k3UWmc8eg4/EIV8vmDfPm5Ats1kAASR5eLFSyEx741BQArOV03
	UB2sOzp+j2H+aKCBzil1nE2IAl/nPR96sfACFhiNo4aicBN/RY5ge4Fc
X-Gm-Gg: AYBFou2w9joAorxDK8ydFTORqYi+qLjjqsgCu4IXG1OR8rQFfM1TLgI9Ha1NwFJt4sk
	HbKLAJWlI8K8umkRbdvE039sazRoCgGSstrMQfGlhI+EF0cKrSkYiDimgPfjF/fCDjEB8xR46Mr
	eF7FYdFFJKvlk7bzI3viROruafHW5NfylwMrOL6fxw++pcY3iMFBZt8JiuU6oEtK8MlNN5SrEw9
	4TEBkUkHr0G97pVMPCZL833jWi+8BZOO4lHKu6r1I1zqogwPNE7DMfVTsbjbYJKpsndsn1gnN1b
	1STTCW6Kt51B7mvWQ5MPoeWNnqNUP2c83nR+svnQb4yuoV25srcsHKgTJ0MQLXzCAkCDL7Tkgsq
	BOtTnpUDmt1IHH22VpWhzn4R6vWs7Izlt0KntuDM9DvgdfTH4a9y4Xf4EG+GFoQb/2810Q4Evk7
	hd0zUe85vCCW/j+Z+1FEfgwu0sj/TK2Hco/6jEJUrk+TrNsRdBWgEZgJeQ7+RrgbxFZR2jFUroJ
	EOJRo5EdV61/nGC47GrkWkHeYs994hUvBBYvNUfb/EUX9pERX9p21RrmfvItr930rKHjy0MTqLT
	ZjZx4G30NFqL5nH8LU3ww+rknvBPbUqCFMSGyWynZhW2/U6a4X5/pvt2MBkpm4tegumDpRK5yoe
	ZgEI8mlzpBmqnBHzEKip52ZjklTpIyF4NOTts/8j53VhkKUBrUg+fq209VrZ+pvUjfNrRbOd4Wv
	2eDXE=
X-Received: by 2002:a05:600c:3550:b0:49d:7fc:5dc5 with SMTP id 5b1f17b1804b1-49d07fc61bdmr62766225e9.1.1788702936623;
        Sun, 06 Sep 2026 06:55:36 -0700 (PDT)
Received: from systembl0wer (78-80-112-223.customers.tmcz.cz. [78.80.112.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d07b371afsm123925615e9.9.2026.09.06.06.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 06:55:36 -0700 (PDT)
Date: Sun, 6 Sep 2026 15:55:32 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Fabio Cesari <fabio.cesari@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Brian Masney <bmasney@redhat.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: isl29028: fix runtime PM reference leak on
 error paths
Message-ID: <20260906155532.35326455@systembl0wer>
In-Reply-To: <20260906131203.125407-1-fabio.cesari@gmail.com>
References: <20260906131203.125407-1-fabio.cesari@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Fabio,

On Sun,  6 Sep 2026 15:11:40 +0200
Fabio Cesari <fabio.cesari@gmail.com> wrote:

...

> Found by auditing IIO drivers for runtime PM acquire/release imbalances
> with a Coccinelle semantic patch that models pm_runtime_resume_and_get()
> and pm_runtime_put_autosuspend() along the control flow graph, flagging
> functions that take a reference and then reach a return without dropping
> it.

I'd put this paragraph under the --- as the Assisted-by tag already mentions
coccinelle.

> Fixes: 2db5054ac28d ("staging: iio: isl29028: add runtime power management support")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5 coccinelle

The standard is to use "Assisted-by: LLM coccinelle" to prevent free
advertising of models.

> Signed-off-by: Fabio Cesari <fabio.cesari@gmail.com>
> ---
> 
> Compile-tested only: arm64 (native) and x86_64 (cross), defconfig plus
> CONFIG_SENSORS_ISL29028=m, with gcc 15.2.0, W=1 and sparse v0.6.5-rc1:
> no warnings. I have no isl29028 hardware, so this is untested at
> runtime.
> 
> I also have a version that takes the runtime PM reference only where it
> is needed: isl29028_write_raw() validates its arguments first, and
> isl29028_read_raw() acquires it only for the reads that reach the
> hardware, the sampling frequency and lux scale being cached. It also
> stops propagating the pm_runtime_put_autosuspend() return value to
> userspace, which fixes a second problem: with CONFIG_PM=n that call
> returns -ENOSYS, so every read and write fails today even when the
> access itself succeeded.

I had a whole paragraph about the functions returning -ENOSYS if PM is
disabled, only then noticing that you already mentioned this... I should
pay more attention :)

...

> @@ -392,12 +392,11 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
>  
>  	mutex_unlock(&chip->lock);
>  
> +	pm_ret = pm_runtime_put_autosuspend(dev);
>  	if (ret < 0)
>  		return ret;
> -
> -	ret = pm_runtime_put_autosuspend(dev);
> -	if (ret < 0)
> -		return ret;
> +	if (pm_ret < 0)
> +		return pm_ret;

I'd suggest rewriting the driver to use the 
PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND macro, as it automatically
increments the refcount on use and decrements the refcount on scope exit,
eliminating the need for multiple _put_autosuspend() calls and manual
checking of the return value of these calls.

-- 
Kind regards,
Joshua Crofts
