Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDF419D07A;
	Fri, 20 Feb 2026 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771583832; cv=none; b=r/jpViDikUvNu8ozt/X+r3q3/LDxohRO9Hyhef6LigsXcz779t2OuFT8lbR2NBtNzyQJGFTevZTI8E+Tgv4xnE0DQ9LNgscJNkGcHPRQDX++kI2n9Y6YvkfMPZF5ajbdDMgMILK+zrCrofn/aQdGa0HY+e4FM2qtMESeKDy4LoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771583832; c=relaxed/simple;
	bh=CcOvDfx8ZPkM3O9CYT74vSNWqQifKiKPaPemsVk3cT4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAXsZs9dp6UKDdOg8aBbtk1rWDYcQhqChF6eDkDC11czJiZg/HeKvnnBc4guxrt0ZPOkjj/vhKwkqmdyrhlk0UwIfXi6FmfQMZaB5/gL98IBq+kwAIhnynHNek1ahrhKkr9Gg3hh454KBl2Ef5j6Txmd/BiHLmgxOJ3DUwkIXks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnibrK+o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnibrK+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDA3C116C6;
	Fri, 20 Feb 2026 10:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771583831;
	bh=CcOvDfx8ZPkM3O9CYT74vSNWqQifKiKPaPemsVk3cT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CnibrK+oVGgdViBSisrEGlNZijCiGVk2d96S4EtfwBk1gPVArQXfhT5Znt0kGUbRd
	 S+3WpnjkURrDoADr30Gck3B8dqU2HTzaDYPNsLQcQZSAzqMYjgCz0KJ4IhyoQSHJ/j
	 iynp4ir7XUo1mGE1lLW4kVoIVpWL5kGHR0eA9/yZcNB6UuJhrEUjWmBynqRow3tYpp
	 kaj2njQbta2ty++FKic0p5WNaO5+E5NJ8siLEfU6HTgTfzyBwTCZv9EjcsWvGIJBIK
	 1j3ABKwl0ol7v+D01mol8It3xUv1uMVBPjWlsH65K8+Vn59hAZVGNmKIN5l9K4XDFi
	 YjLa4L+Ugxebg==
Date: Fri, 20 Feb 2026 10:37:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Neel Bullywon <neelb2403@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v7 2/3] iio: magnetometer: bmc150_magn: replace msleep
 with fsleep
Message-ID: <20260220103700.5acd36c2@jic23-huawei>
In-Reply-To: <20260216015454.61836-3-neelb2403@gmail.com>
References: <20260216015454.61836-1-neelb2403@gmail.com>
	<20260216015454.61836-3-neelb2403@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Feb 2026 20:54:53 -0500
Neel Bullywon <neelb2403@gmail.com> wrote:

> Replace msleep(5) with fsleep(5 * USEC_PER_MSEC) to allow the kernel
> to select the most appropriate delay mechanism based on duration.
> Using USEC_PER_MSEC makes the unit conversion explicit.
> 
> Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

This is independent of patch 1, so I'll pick it up now.
Please base next version of patch 1 on top of the testing branch
of iio.git (or just reorder the patches locally and only post
that one for v8!)

Applied to the testing branch of iio.git.  Note I'll rebase
that on rc1 sometime next week and then it'll go out for linux-next
to pick up.

Thanks,

Jonathan
> ---
>  drivers/iio/magnetometer/bmc150_magn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index ff6196c86e6b..e7f8d118242b 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -683,7 +683,7 @@ static int bmc150_magn_init(struct bmc150_magn_data *data)
>  	 * 3ms power-on time according to datasheet, let's better
>  	 * be safe than sorry and set this delay to 5ms.
>  	 */
> -	msleep(5);
> +	fsleep(5 * USEC_PER_MSEC);
>  
>  	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND,
>  					 false);

#
