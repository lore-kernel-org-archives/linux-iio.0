Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD015478D;
	Sun, 19 Apr 2026 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776616459; cv=none; b=RORSXT8X3USlHdiJTkPjPnYme85eIZmQ3q3b2WVWtxr9pKugYk2iNokIgFN48fhOSZT3k0AqwcivkxM8g+SWnkgCKT5Ny8NRVk7diFIAlu6RICaq9zb7abfOMpqqRuwwlAlM8IuJeFa16txAy2nUbhwIcrw8W9Tgq2I9ong2zkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776616459; c=relaxed/simple;
	bh=h4RkHO96BK7LoSw6tLGh2J6H83pq3bsB6xmRty3H440=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGGddYkYaGREmM3WI14tuATeHafhtsop3j2sBf+rIRNvlY8w69eMBN/IlFu+rJ5XpVO+X+dbdcApmuX1sLQnAvyb4+q8zNPVI0GXkUG5aBThdWj69+IbuTF8qYjwVjeLiiFMrV8Zo9IK5irjj0d/vEakaXvjlT66dmxDNxCQ7RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDrW26Sh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDrW26Sh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59921C2BCB5;
	Sun, 19 Apr 2026 16:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776616458;
	bh=h4RkHO96BK7LoSw6tLGh2J6H83pq3bsB6xmRty3H440=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CDrW26Shd3P7e4HtfYdMdVF7glvR4wXtrXmldL4lMTARqlSL6AqMQ0fV/Sf4h0Ljj
	 FMBVz/ThLUObKGVlPavYFkAKFFceuXk6CnHzYPZZ1vr+uGRxETq2fpXJ6pLFrY7bWB
	 uyOlHwLu8jWxGnwBt0D0oBeJMoB2ykP8skwAErNtAKpx8lFj1fBhbWO0Vx3bd+8Jcp
	 r13b1qXbAR3GcpjlYLHNqsnhh0dRUXOMUqviyGlj7prA++AxVHieQroSUEJgN18Qu7
	 rLyBo1HLO0eQpFDq6b/6k8yx2fVZW1khQ3UJtRbStSHnSC1s880lzLUZQUSX2FYgL+
	 a57w4wQGGg5nw==
Date: Sun, 19 Apr 2026 17:34:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, puranjay@kernel.org,
 cosmin.tanislav@analog.com, marcelo.schmitt@analog.com,
 antoniu.miclaus@analog.com, ramona.gradinariu@analog.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: accel: small cleanups and error-handling
 improvements
Message-ID: <20260419173408.0d17995a@jic23-huawei>
In-Reply-To: <20260417124924.353189-1-sanjayembedded@gmail.com>
References: <20260417124924.353189-1-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Apr 2026 18:19:16 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Hi all,
> 
> This series contains a few small cleanups and robustness improvements to
> adxl313, adxl380, adxl355, adxl367 and adxl372 IIO accelerometer drivers.

0/2  in patch title? It's fine for that bit to change from version to version.

Anyhow, I tweaked as Andy suggested whilst applying and picked up the lot.

Note however, that the advantage of devm_mutex_init() is minor at best,
which is why we didn't bother with mutex_destroy() most of the time
before this convenient way of calling it existed.  Combined with
dev_err_probe() being nice but minor cleanup, I'd generally reserved these
sorts of changes for when someone is otherwise working on a driver or
doing a more thorough modernisation.

I don't mind people doing this sort of thing for one of their first
few patches, so what you have here is fine, but it's not suitable material
for a mass cleanup of the whole subsystem!

Thanks,

Jonathan

> 
> The changes modernize mutex handling using devm-managed helpers.
> In addition, error handling during probe is cleaned up by switching to
> dev_err_probe() to better handle deferred probing.
> 
> Changes in v2:
> - Drop guard() changes as it's already available in iio/testing.
> - Rebase changes on top of iio/testing with guidance from Andy.
> - Added new change for additional iio accel drivers.
> 
> No functional changes are intended.
> 
> Testing:
>   - Compiled with W=1
>   - Build-tested on QEMU x86_64
> 
> Thanks,
> Sanjay Chitroda
> 
> Sanjay Chitroda (8):
>   iio: accel: adxl313_core: Use devm-managed mutex initialization
>   iio: accel: adxl313: Use dev_err_probe
>   iio: accel: adxl380: Use devm-managed mutex initialization
>   iio: accel: adxl355_core: Use devm-managed mutex initialization
>   iio: accel: adxl355: Use dev_err_probe
>   iio: accel: adxl367: Use devm-managed mutex initialization
>   iio: accel: adxl372: Use devm-managed mutex initialization
>   iio: accel: adxl372: Use dev_err_probe
> 
>  drivers/iio/accel/adxl313_core.c | 10 +++++-----
>  drivers/iio/accel/adxl313_i2c.c  | 10 ++++------
>  drivers/iio/accel/adxl313_spi.c  | 10 ++++------
>  drivers/iio/accel/adxl355_core.c | 28 +++++++++++-----------------
>  drivers/iio/accel/adxl355_i2c.c  | 11 ++++-------
>  drivers/iio/accel/adxl355_spi.c  | 11 ++++-------
>  drivers/iio/accel/adxl367.c      |  4 +++-
>  drivers/iio/accel/adxl372.c      | 10 +++++-----
>  drivers/iio/accel/adxl380.c      |  4 +++-
>  9 files changed, 43 insertions(+), 55 deletions(-)
> 
> 
> base-commit: 0ccdcdc698b7ba52f2c9bc09bfdf9f020ca0e6e6

