Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF6630C62F;
	Wed, 18 Feb 2026 19:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771442655; cv=none; b=Fr0ZGSItuApoGdTLfKNf3gT9bqFSqeNG1oNPyJHqt1fmf/Dibj1zxQLunY9aD3JRsd1zAwU0H6UJL45fE0bVq/qYpRX7Y15wws2YwCZrN3MTArbt+mtog5lMBpmNU55AVCMxaLxcAadhRb8pUIwODnUGl1KMj1gXJFOiHG6m2Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771442655; c=relaxed/simple;
	bh=gUW7+oyQkRbxJIoY1DXHS6sXT/9VI6la+jhZRRGOX3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3cpayLkWt8G8V+1AReSXVJrcMkbBKzQZrpYwAAdUljNexvEzwluafmPOBafL7p/5KDurd9K1HaOhvvB+ALiDXV4AAopEOIbzqDkVBBMM6EfdvNyR6CnOHerb8P9yWWQNnUguOzTMQ6jcTor1b4qEv8+0FlXBH2WIfQZs9iwV3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MX9k4nCF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MX9k4nCF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771FEC116D0;
	Wed, 18 Feb 2026 19:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771442655;
	bh=gUW7+oyQkRbxJIoY1DXHS6sXT/9VI6la+jhZRRGOX3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MX9k4nCFHilK7NuGpN6keUBI3g5TNOtb4/QqxtC+fY2vEke1YwvRElHogFqKkD3dd
	 N6RQ11+SkzH4puw/vxXAkICxkujx/PqTY42+2WV4nd2nd6UmjbGwJvBUC+rvG4HXlf
	 WnMkDjxG+izvlRAmpGD6bPFgDGZUFZ15oE4itQgLcY71ayU2DOrzMSw0tacDEdIyyy
	 x5cscytMHdSlwKaenTH9rBHYXwZOdevdeQM/wf8EYWvxZDUnfiN9SWAR1pCWdjhiWO
	 0DelkR7L/CcUi5bwKHo1oh8xB6ZCPjKjzIwfwbf2tpRUyZz6h3AwCHh/WZKyEvLUEE
	 9Ph0/SVQiPTzA==
Date: Wed, 18 Feb 2026 19:24:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Tomasz Duszynski <tduszyns@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] iio: chemical: sps30: fix buffer size calculations
Message-ID: <20260218192406.67d7f352@jic23-huawei>
In-Reply-To: <20260212124609.24745-1-antoniu.miclaus@analog.com>
References: <20260212124609.24745-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Feb 2026 14:46:06 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Fix incorrect buffer size calculations in sps30_i2c_read_meas() and
> sps30_serial_read_meas(). Both functions used sizeof(num) which
> evaluates to sizeof(size_t) (8 bytes on 64-bit) instead of
> sizeof(*meas) (4 bytes for __be32), leading to oversized buffer
> requests.
> 
> Antoniu Miclaus (2):
>   iio: chemical: sps30_i2c: fix buffer size in sps30_i2c_read_meas()
>   iio: chemical: sps30_serial: fix buffer size in
>     sps30_serial_read_meas()
> 
>  drivers/iio/chemical/sps30_i2c.c    | 2 +-
>  drivers/iio/chemical/sps30_serial.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

