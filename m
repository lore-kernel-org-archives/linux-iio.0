Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF369146D5A;
	Sun, 22 Feb 2026 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771778416; cv=none; b=SrYJc3jsIBgxnFY83OXAE6fTvXJ+AgAHP1MWYHguL26hteUzGdHJLJWSKj8Fa6zFrgAlzUHTXSRJDHAblQ8BYqPQUFv2HS6sJGCK/LcO8UAVN2NyDXTJPMgfbngdTbirLQRu9rNaKcbv9fCqhBlYq69dy/xMfV/fqEkgRNvZYgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771778416; c=relaxed/simple;
	bh=E3ixKOt4+/MXBFEAySnqMQ6zjsbWWE4kIXt5iAQqoWI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6/FGJrU7lv8nXUz38d4RYp3jOvlmag63ht6nW8pVaNmYa1MayfdwkIFYp9Kedc96/g2vusSLSVP4byr4KtcVEoGlCFNxMGwoc7BlIXyXdcsCiBtSAfJxMlO/JvdYVIzGlXm1xb6iKKDtey0w5GPbSOkDohzA+5JpD3p7Sdm4DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAfU5wWS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAfU5wWS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806B1C116D0;
	Sun, 22 Feb 2026 16:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771778416;
	bh=E3ixKOt4+/MXBFEAySnqMQ6zjsbWWE4kIXt5iAQqoWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pAfU5wWSLxFfkC/8Q/vSodTr6WTondA+D1SEOlPFvQdyttFO4AQbUEqk5kx1LALKl
	 lV8KofbrVxNtE/jhUlwFWR9KcWXjd0A7LTCK/XYb+zpPXhz28xKBwd8/yFc8Td9Zzl
	 YK6RWI2ysnypYIHoI3O/6Uq+uPzBYdR/KqmTrPOz1KgVBUXjaMRQE26SupecifhY2/
	 c8iWRNTs4z7EiM8IUAn+LiJryv3C/8om+fO+pN/QUylzqdZiwWv/23a3WZQynWO38v
	 5YMLPJdZfwUHIiHX1XO11giAcojj6wLOVxpQxR9FvpYh27iG8oxKRKNO2snaC/kgyV
	 HQqCKcU0PAzbw==
Date: Sun, 22 Feb 2026 16:40:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Neel Bullywon <neelb2403@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil
 <paul@crapouillou.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/2] iio: pressure: mpl115: add system suspend/resume
 support
Message-ID: <20260222164008.7fed0ff4@jic23-huawei>
In-Reply-To: <20260221172601.77818-1-neelb2403@gmail.com>
References: <20260221172601.77818-1-neelb2403@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Feb 2026 12:26:00 -0500
Neel Bullywon <neelb2403@gmail.com> wrote:

> The driver currently only implements runtime PM callbacks to control
> the shutdown GPIO, but lacks system suspend/resume support. This means
> the device may remain powered during system sleep, wasting energy.
> 
> Add system sleep PM ops using pm_runtime_force_suspend() and
> pm_runtime_force_resume() to properly synchronize the runtime PM state
> across system suspend/resume cycles. This ensures the shutdown GPIO is
> asserted during system sleep when the device has a shutdown GPIO
> configured.
> 
> Signed-off-by: Neel Bullywon <neelb2403@gmail.com>

Interestingly for the non exported version we have
DEFINE_RUNTIME_DEV_PM_OPS()
and the docs for that suggest we should use
EXPORT_RUNTIME_DEV_PM_OPS() but as you've realized that doesn't set the
suspend and resume callbacks. If that was intentional then the documentation
is less than clear (and I don't remember that being the intent)

+CC Paul and Rafael.

We have very few users of these macros, so it should be easy enough to
make the export variants consistent if we want to.

Jonathan

> ---
>  drivers/iio/pressure/mpl115.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
> index 830a5065c008..29794ce53bc6 100644
> --- a/drivers/iio/pressure/mpl115.c
> +++ b/drivers/iio/pressure/mpl115.c
> @@ -244,8 +244,10 @@ static int mpl115_runtime_resume(struct device *dev)
>  	return 0;
>  }
>  
> -EXPORT_NS_RUNTIME_DEV_PM_OPS(mpl115_dev_pm_ops, mpl115_runtime_suspend,
> -			  mpl115_runtime_resume, NULL, IIO_MPL115);
> +EXPORT_NS_GPL_DEV_PM_OPS(mpl115_dev_pm_ops, IIO_MPL115) = {
> +	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> +	RUNTIME_PM_OPS(mpl115_runtime_suspend, mpl115_runtime_resume, NULL)
> +};
>  
>  MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
>  MODULE_DESCRIPTION("Freescale MPL115 pressure/temperature driver");

