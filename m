Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7FD30DECC;
	Sat, 26 Sep 2026 01:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790385109; cv=none; b=a/OPgD56YyfeNa5G0zTMtX+E4C7kBW/rwOYJww7XdBBT4Ia6b0XtrAknI0njmPRdT2kvrdDBdXFhbolGIINN3bm3lq8H0PJKx59LDqPjmJP82/he8Prksc0kPgcX5lBC7mAUt0ZfVocpTJce1e6OJIPeuqQokElLurSDqV2C7gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790385109; c=relaxed/simple;
	bh=wz0+oC7L5GbZB/yGvO12KBrjpsvColV1ni81D0psq3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3O9C/K2d4/tdF+mt1GX5oINHeFbBUmOwPkXmsCV+UZZ/2ze4FtDPOsBR7KGyChc6bUHugIpjEQbGCdl00iJeGkCKQO1ZV1wTerRSrCZCnBqim2+bPt258B88qikIOiynIMwxfiUdkaGipgVkqMqUSmXseCTFSg2xKCC1CrEUtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHMpLalj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHMpLalj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261711F000FF;
	Sat, 26 Sep 2026 01:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790385108;
	bh=hDNcCdYwMl9l+sNuXyHxG8QorJS99W4SjBH+NUtA0U4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OHMpLaljyMG3n1l/oFTAKoE0iCM/2J0s7tZhL79Yv8yzlxRWVcdrlnuw3OrRyra5L
	 +po3vkZsZ4CsFmGo2kMegIq5b81TCPh0Ljg79M31uy5H773vAkBhBFcqXZdWf7+bvh
	 3UKOeDPAUqfyGlbxkzDpYZojTTYT5QexVBVYkO7t/foFRamCfqe+ihgOEffhesxatC
	 obT9QD8LI7bJOSFb8Hmo1RoNn6zvB51kN1jqSHT2uGHBTlraCFcVfBZB+ckgfTIFGD
	 sl6dgyv2xmjm3s3ROGj6MgUXE3kv9D6Ld/V2RalWswZCmX+XWP/o+JILqFq5Eggm/5
	 80XenG20Di1Iw==
Date: Sat, 26 Sep 2026 02:11:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jiale Yao <yaojiale02@163.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rodrigo Alencar
 <rodrigo.alencar@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Anshul Dalal <anshulusr@gmail.com>, Antoniu
 Miclaus <antoniu.miclaus@analog.com>, Herve Codina
 <herve.codina@bootlin.com>, "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The
 Capable Hub)" <u.kleine-koenig@baylibre.com>, Shi Hao
 <i.shihao.999@gmail.com>, Linus Walleij <linusw@kernel.org>, Krzysztof
 Kozlowski <krzk@kernel.org>, Angel Iglesias <ang.iglesiasg@gmail.com>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] iio: validate SPI match data before use
Message-ID: <20260926021143.478d5361@jic23-hlaptop>
In-Reply-To: <20260925131738.2200612-1-yaojiale02@163.com>
References: <20260925131738.2200612-1-yaojiale02@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 21:17:29 +0800
Jiale Yao <yaojiale02@163.com> wrote:

> SPI driver_override can bind a device without a matching entry in the
> driver's ID tables.  spi_get_device_match_data() then returns NULL.
> 
> These seven IIO drivers use that result without checking it, causing a
> NULL pointer dereference during probe.  Add the missing checks before
> the match data is used.

I was hoping we'd close this finally by adding a flag to the
drivers to say they should fail a match if driver_override is set.
Given I thought maybe that would happen when Andy looked into this
a while back I've been sitting on this problem for a while.


Unfortunately seems we have to carry on papering over it in the
drivers for now :(

Ah well. Series is fine, so applied and marked for stable.
I'm not going to rush these in though so they can wait for the
next merge window.

Thanks

Jonathan


> 
> Jiale Yao (7):
>   iio: amplifiers: ad8366: reject devices without match data
>   iio: dac: ad5755: validate SPI match data
>   iio: dac: mcp4821: reject devices without match data
>   iio: frequency: adf4377: reject devices without match data
>   iio: imu: adis16400: validate SPI match data
>   iio: potentiometer: x9250: reject devices without match data
>   iio: pressure: bmp280: validate SPI match data
> 
>  drivers/iio/amplifiers/ad8366.c   | 2 ++
>  drivers/iio/dac/ad5755.c          | 3 +++
>  drivers/iio/dac/mcp4821.c         | 7 +++++--
>  drivers/iio/frequency/adf4377.c   | 3 +++
>  drivers/iio/imu/adis16400.c       | 3 +++
>  drivers/iio/potentiometer/x9250.c | 7 ++++++-
>  drivers/iio/pressure/bmp280-spi.c | 2 ++
>  7 files changed, 24 insertions(+), 3 deletions(-)
> 

