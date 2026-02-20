Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E43D2D9484;
	Fri, 20 Feb 2026 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771585150; cv=none; b=tEKCpssDUt9GBjtTU/rzvSL39spBiYgc3q3kxUweFg7pa1Xw74c6PQPhsSY6G2RMth1u6kLLUiJv/M/2d2Ah1Ojpd9rZE4W4d9L4Qq+BkuXDveKI7rEMGimz//r6hDVFBpbMudFLjJVY9uIJB+FpIj8/ybTXzZPnJozy43G7Qms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771585150; c=relaxed/simple;
	bh=tMxt/yLKDMlIoo3OWtWivmWDSUECYbP7QUXhZl7pJm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YJIy5u0EubP+A4uUDGM3S50/cRjQxnpsEfZHvmhSCRH6/o4KKEp/YvTW7RIeaIedgTCKf9yN2XwDLkpj1hMAxhUeIiXWapH37cASLo7fF3U3XIffyh9Cdh+W1NQQwxIiroV49z8g7uKhkUHT5tvDRAb5ynS43SMbJV50TxvN1CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/QB6ZXM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/QB6ZXM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E3FC116C6;
	Fri, 20 Feb 2026 10:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771585150;
	bh=tMxt/yLKDMlIoo3OWtWivmWDSUECYbP7QUXhZl7pJm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g/QB6ZXMq7UXJCQiYVCbw7Z8hDyPA+9iFWvRZal+tHKZMGuwOFX3XELNobrooUbzW
	 5T2c5KMK3eYUAWaYRi/CjHaZyrR4YqfYkUh86i1Mazb1dtYnbIa/C7aDavTmvUrvPx
	 mjdFpmjgphtV0RPFP6x20YAB4XVyBC7Cl7/NXsAK1n2Y/5kEemCdNKmfKz4lNGbJRi
	 f+QAlWHfzQjptmMXXt3Mmj5ZlCcROhe48jT4s8SstA1ZssUlp8VYpkQA16pJZL9P7G
	 D4YLsDY5aHsrHC0xyROr1cNZdANMwICNLExhQyiA7gzOEAjSjJZpylw7uh8fsalz7c
	 9NVCOof3mdTGQ==
Date: Fri, 20 Feb 2026 10:59:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] iio: gyro: mpu3050: fix pm_runtime error
 handling
Message-ID: <20260220105900.3932c1dc@jic23-huawei>
In-Reply-To: <cover.1771233915.git.antoniu.miclaus@analog.com>
References: <cover.1771233915.git.antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Feb 2026 11:57:54 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Fix pm_runtime error handling across the mpu3050 driver. The existing
> code uses pm_runtime_get_sync() without checking return values, allowing
> operations to proceed even when the device fails to resume.
> 
> Replace pm_runtime_get_sync() with pm_runtime_resume_and_get() and
> propagate errors appropriately. Unlike pm_runtime_get_sync(), the usage
> count is not incremented on error.
Applied to the fixes-togreg branch of iio.git and marked for
stable.  Thanks

Jonathan

> 
> Changes in v4:
> - Reword commit messages to correctly attribute the unchecked return
>   value to the caller rather than pm_runtime_get_sync() itself
> - Simplify preenable by collapsing the trailing return statements
> 
> Antoniu Miclaus (2):
>   iio: gyro: mpu3050-i2c: fix pm_runtime error handling
>   iio: gyro: mpu3050-core: fix pm_runtime error handling
> 
>  drivers/iio/gyro/mpu3050-core.c | 18 +++++++++++++-----
>  drivers/iio/gyro/mpu3050-i2c.c  |  3 +--
>  2 files changed, 14 insertions(+), 7 deletions(-)
> 


