Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233D33BB9E1;
	Sun, 27 Sep 2026 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531476; cv=none; b=Yr1Y/kD1Uqbn9szHoXNSlK/97a6n694aokgGjOZ27SsPPcNVeIB9RYmSSVWfKy4xrFuR4lp4pYFeS6ZMz7APNFS0WCUTgDkoWexazF9KySetpMxQvReqsLiewXnhvZoyJzEonWxcQPEFJ0A9NFsVvH8DzQDW7j5JGS4vZKO2+ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531476; c=relaxed/simple;
	bh=VfM6UmvEhfbNot76OVLRuRNCPOGX2wN8VlSKsx1Xm00=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2FccZiiDLux7WbyjFST9f+rtzzfUp/0uaLuHpfZW+/1ZZIkoSh7TMiSIVUv0ejSUnkew3JSQiZ4c0hOHPMxwF/XDdwlaWGYO0xaHtXcvaShcZ9EfdeJi8MLI1xv3wU5cRrqfL3+rG71aKIJU3MsANE2X431j2whuWBvLu6WRtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJY1gOGA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJY1gOGA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4930C1F000FF;
	Sun, 27 Sep 2026 17:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790531474;
	bh=pXPRnOWTIh1TqTP0A8DjKdZlUDvhkRpGbQwXS8tDHmM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JJY1gOGAq9dF4bfpuvKfW8hI3ygtCXzOQKlYgSzLGFq3C92byn+Wis+ZAEgRAAEa9
	 E55jqWEFaF1lwT7w5WkOVC4nMI54mwnlXvmrAM5VW5jGBlmjvcErT/rs6ir8lJJ3ru
	 y64+qYscZD+sPuBmd4fhMrsOPoySio4rTNpiCQC8T1xTUWjEl4EVei7ITTbbWqVjjB
	 sSbFCbfA6C5F30m+KAdphjKUOdXJNMRb0izofWy3mN8TkY1IthfbDu4LgTvzQlZiK2
	 IEbZ45Y/vgzGaQ+VK8Cg4HcbDGnpWA3BEqUHWRVAs3HyU8dE4t7q4JVsExp6t5x4gE
	 Haj/R+xbCjccg==
Date: Sun, 27 Sep 2026 18:51:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jiale Yao <yaojiale02@163.com>
Cc: Lucas Stankus <lucas.p.stankus@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Harshit Mogalapalli
 <harshit.m.mogalapalli@oracle.com>, Linus Walleij <linusw@kernel.org>, "Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] iio: accel: reject SPI devices without match data
Message-ID: <20260927185111.0ca9f238@jic23-hlaptop>
In-Reply-To: <20260925124332.2090895-1-yaojiale02@163.com>
References: <20260925124332.2090895-1-yaojiale02@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 20:43:27 +0800
Jiale Yao <yaojiale02@163.com> wrote:

> SPI driver_override can bind a device to a driver without a matching OF
> entry or SPI device ID. In that case, spi_get_device_match_data() returns
> NULL.
> 
> The ADXL313, ADXL372, ADXL380, and SCA3000 SPI probe paths assume that the
> returned chip information is present and later dereference it. Reject
> devices without match data before the pointer is used, following the
> handling added to the AD5686 bus frontends by commit 572a00852635 ("iio:
> dac: ad5686: missing NULL check on match data").
> 
> Each patch fixes one driver and can be applied independently.
Applied.

Thanks,

Jonathan

> 
> Jiale Yao (4):
>   iio: accel: adxl313: reject devices without match data
>   iio: accel: adxl372: reject devices without match data
>   iio: accel: adxl380: reject devices without match data
>   iio: accel: sca3000: reject devices without match data
> 
>  drivers/iio/accel/adxl313_spi.c | 2 ++
>  drivers/iio/accel/adxl372_spi.c | 2 ++
>  drivers/iio/accel/adxl380_spi.c | 2 ++
>  drivers/iio/accel/sca3000.c     | 2 ++
>  4 files changed, 8 insertions(+)
> 
> base-commit: 93f51579e7df248780214094418f205253383cc5

