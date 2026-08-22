Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FABB2C032E;
	Sat, 22 Aug 2026 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787435255; cv=none; b=HxzRxhMqC312pZNwqUXWGNRyZyeW9GAt4vMYjtgIz2jd8kFxU4B12Iri8/9A7FxoTp3c9PD5pTzi1Hn2K8fo2Y62vT+2yqt+/bXEmahRIGqaabzgJXZA7m2XPFgMXwhB13lbXOem+Xi08yqadI3eDvBmgBWrRR4lst+rvRj8sAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787435255; c=relaxed/simple;
	bh=0PscWDful/z0+x6Xx0tcPS2138CdAUk0LUA/1+tvGbU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=koVg6+/M3XKvou9o/exIkXpBJTMZvAOLPVlQoX+qizCemjVBIbLrm/aVtm5t1Eca+fu+tjf0q26l2myrn3pojblBsXp3UXbGaQGV9eb0n4Kuscqjmc7p9mPyAJQ73hxaekZRygIwlhrXY77IWm+aS29VYr8u93niqkf/pEIAGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPEsihU5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPEsihU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C5D1F000E9;
	Sat, 22 Aug 2026 21:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787435254;
	bh=j+zqmz8r3ZMflVKR0F/V7SX589Xsk0Iag0Ks27uUKYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HPEsihU5W6o8Ow7A5VaDmoDZ3M0Sz6xP+YlZmqK8wKbX8z7c4ANXziefH0uvRKyF3
	 CcT0nKu01fZ5gorH9WVY+rIEAQyhJFLttzmEnCjL+Khwpj3FJzFnR6IDr4JyIKRQwt
	 2F45/dBVSdONBllzOLqKRsYZpYj6yPgFtcTEoZNR4fEzfWxMWWM5AjTLt1SMI2ka+p
	 O+twPxG0Ca9xqUKHFgPwxZ+nAhlTyCEvMMhj9UjMR1FPUfMhDS2lKn44wfI6VZUn0k
	 mwTolU8p7NMbZZpgGe8GwatPqQGF6zgwxwVsuU0Psm9dL65d8oq+zYTaLkNWUCusEI
	 xl3lttvGx86/w==
Date: Sat, 22 Aug 2026 22:47:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Arka Mondal <arkamondalofficial@gmail.com>
Cc: Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org,
 andriy.shevchenko@intel.com, dlechner@baylibre.com,
 rohitsarkar5398@gmail.com, venkat.prashanth2498@gmail.com,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: adis: fix unprotected debugfs reads
Message-ID: <20260822224729.1d9c09c0@jic23-huawei>
In-Reply-To: <20260815182726.11796-1-arkamondalofficial@gmail.com>
References: <20260815182726.11796-1-arkamondalofficial@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Aug 2026 03:27:23 +0900
Arka Mondal <arkamondalofficial@gmail.com> wrote:

> Four open coded file operations in three ADIS drivers are passed to
> debugfs_create_file_unsafe(). None of them call debugfs_file_get(), so
> debugfs_remove_recursive() does not wait for a read in progress and
> unbind frees the iio_dev underneath it.
> 
> Andy Shevchenko <andriy.shevchenko@intel.com> asked on v1 whether these
> could use DEFINE_DEBUGFS_ATTRIBUTE() instead. They cannot, as it formats
> a single u64, and these handlers print up to four registers, e.g.
> "%.4x%.4x%.4x-%.4x" in adis16136. Converting them would change what the
> files return.
> 
> adis16475 and adis16550 already split this way, using
> debugfs_create_file() for their open coded firmware files and
> debugfs_create_file_unsafe() only for the DEFINE_DEBUGFS_ATTRIBUTE ones.
> This does the same for adis16480, adis16400 and adis16136.

This all makes sense to me, so I've queued this on the fixes-togreg
branch of iio.git and marked them for stable.  Note that branch will be
rebased on rc1 once available.  As such I don't really mind rebasing
it for tags or any feedback that comes in.

Thanks

Jonathan

> 
> Compile tested only; no ADIS hardware available.
> 
> Changes since v1:
> 1. patch 2: changelog rewritten to explain why serial_number cannot use
>    DEFINE_DEBUGFS_ATTRIBUTE(). Code unchanged.
> 2. patches 1 and 3: unchanged, Reviewed-by added.
> 
> Link to v1:
> https://lore.kernel.org/r/20260814090728.965922-1-arkamondalofficial@gmail.com
> 
> Arka Mondal (3):
>   iio: imu: adis16480: fix unprotected debugfs reads
>   iio: imu: adis16400: fix unprotected debugfs reads
>   iio: gyro: adis16136: fix unprotected debugfs reads
> 
>  drivers/iio/gyro/adis16136.c | 2 +-
>  drivers/iio/imu/adis16400.c  | 2 +-
>  drivers/iio/imu/adis16480.c  | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> 
> base-commit: 3d6d817622b0a9721e3cc404df3469171582be13

