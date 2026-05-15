Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21516337BB0;
	Fri, 15 May 2026 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778854729; cv=none; b=gVXIcTunPeMZSsGM6fdg9GOEHS8HClmk9KDATXm1pwMxd2GX2LIamUdWexUPC77mHC3CiNrG8q5JrhySjZgSgvfFdFKc6H7FDeLs36qeHf6NNuU7DeUEzZcTo9vPV8oGPGj3Br7BZ9LGPzAd+FgnMf0sEyRwrRlvFGoa6AdFgic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778854729; c=relaxed/simple;
	bh=S8sTaCOuLXBTBw5B1SQO164xBq5dUkwincaYQPeUIVo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S81lEh0AkoMOYK7Bm2Mm9ukgTcGxyfZRp70uV1acjstOShNxu170OidbiNO8Nh94BQcoUg/ZiHmazdZXMVw/o/Pcun+ZBlVRS4Y7gh6s1l+XtHfUACZjhU4aOGHgng+5ypFipVRyERoNaKe+mFocVECBgl65GKfrGzmyI/2ilLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TE46AlnE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TE46AlnE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAD7C2BCB7;
	Fri, 15 May 2026 14:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778854728;
	bh=S8sTaCOuLXBTBw5B1SQO164xBq5dUkwincaYQPeUIVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TE46AlnEXk84b5DPS2bKH+H93hQCGBjdmR5QgpOWQfK9opkXxlviYZDGeAbvjT9ci
	 FUDLTHUb+3+TTO4gIKMH+9cQfNCQBNyZSottoSLFNgZrHCi7vXt+5yaFkV0ezgy7dz
	 yd6d8WEbg7IdNg1W920ipABiauVPjvNjmwZOw7HWKYZUweJusm/AIM01b9Yv/bSEJV
	 nBGesVGH94YOYXw0JXB8aa/y11Gs+VoD3OZXvLaOlXuSxoAqnBsZ/HAaQjf7D6hU9m
	 sdsR4g9ecBRbpbEmcftKNb7ZtoQKGxgJx+ZYr6j78HCI2oVM99LMXzV5ZNX7TBT6b2
	 ZOZTU+ZSDyiOA==
Date: Fri, 15 May 2026 15:18:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Tomasz Duszynski <tduszyns@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org (open list:IIO
 SUBSYSTEM AND DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v3] iio: chemical: sps30: Replace manual locking with
 RAII locking
Message-ID: <20260515151840.48a42705@jic23-huawei>
In-Reply-To: <20260515031343.56039-1-m32285159@gmail.com>
References: <20260515031343.56039-1-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 22:13:42 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> Replace manual mutex_lock() and mutex_unlock() calls with the much newer
> guard(mutex)() and scoped_guard() macros to enable RAII patterns,
> modernize the driver, and to increase readability.
> 
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
> v2:
>  - Switch over some scoped_guard()s to guard(mutex)() per David's
>    suggestion.
>  - Remove redundant whitespace per Andy's suggestion.
>  - Add new wrapper sps30_do_meas() per Andy's suggestion (see commit
>    message).
>  - Add Joshua's RB
>    (link: https://lore.kernel.org/linux-iio/CAKqfh0FWig8mRR-xhvnfcFeSinR6RySyPaf9Gbpb6WU+diiiUQ@mail.gmail.com/T/#t)
> 
> v3:
>  - Remove sps30_do_meas() wrapper per Andy's suggestion.
I think this wasn't what Andy meant. I think he meant just
push the guard into the the function you were wrapping.

>  - Remove Joshua's RB (major changes).
> 
>  drivers/iio/chemical/sps30.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
> index a934bf0298dd..9cb201cf0f15 100644
> --- a/drivers/iio/chemical/sps30.c
> +++ b/drivers/iio/chemical/sps30.c
> @@ -5,6 +5,7 @@
>   * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/crc8.h>
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> @@ -111,9 +112,8 @@ static irqreturn_t sps30_trigger_handler(int irq, void *p)
>  		aligned_s64 ts;
>  	} scan;
>  
> -	mutex_lock(&state->lock);
> -	ret = sps30_do_meas(state, scan.data, ARRAY_SIZE(scan.data));
> -	mutex_unlock(&state->lock);
> +	scoped_guard(mutex, &state->lock)
> +		ret = sps30_do_meas(state, scan.data, ARRAY_SIZE(scan.data));
Every call to sps30_do_meas() is done with the lock held just over that call.

So just move the lock (as a guard) into sps30_do_meas().

I think that's what Andy was suggesting in v2 review, but maybe not!


>  	if (ret)
>  		goto err;
>  
