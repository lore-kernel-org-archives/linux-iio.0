Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDF42D77F7;
	Wed, 25 Mar 2026 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469981; cv=none; b=CN/tpMeVCW2zuXBRz5FPOaswRyjJ8ZDnpLeR1iUB3vHb2pshUDPsZn0bb/OTUejyFFTG0sifBEhnobT9Kk56QkxdOLezXmxj2tDIjIH/hzztnjaH/Gp8uFlJLnLN6+/vugD2wGGawmoEDRTVn3uEALsoPnZQY/P+SgfH+dSz6E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469981; c=relaxed/simple;
	bh=jgQzfu/sLrBxJTRXuCgEBKs76FcL6WFrqDQpgzygZS0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LhjmqinYS6KRBklnmDt45zdUxkzvn6H/+fcDKw6f0QLICpF2ho84XLWnmKiNdQ0cyhkyb2tjFm2hNkDLeHbDygDSvBhVtYYYaqO50mnOASHZUdlPBmlJhXEEjQW9pxxEnHvbgiJC04UvvP2hlKRBdM5BbAGJyaXFjJo/GBAehdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7s6ceXm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7s6ceXm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5DDC4CEF7;
	Wed, 25 Mar 2026 20:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774469980;
	bh=jgQzfu/sLrBxJTRXuCgEBKs76FcL6WFrqDQpgzygZS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t7s6ceXmuStIf+g6jK1WwQ7GkxXnyk1bMnvLVd5OPfz9aaHNehVk4EMDHwQ6qteL5
	 BQLNmBVL5Bp7KKE78SNQdOOVftRZH9OKvXDfKq/A4MSgMS1MivajDCW+uUHsEVHQLe
	 7Q34c7gyhBjIEPY8KF9v9ckbZU4qtdyv2QaELRoYaR7XO04gk45cQpsC3GwqQQbs+T
	 99GvTc5HNO+MKfgkXw6tbchVIC1RWa9fnV3WrooNAlEZfC7ubJfZwszKxKpjNYxkum
	 0tNdVlfRvqpkSDXnBHXsfCYX7h5cYufsE55y9jajH3c9fFF7XnUHW8ysY5mxVG+ytK
	 O+HeuQ+RxD1/Q==
Date: Wed, 25 Mar 2026 20:19:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Carlos Jones Jr <carlosjr.jones@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Liam Beguin
 <liambeguin@gmail.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Tobias Sperling
 <tobias.sperling@softing.com>, Jorge Marques <jorge.marques@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: Re: [PATCH v2 0/4] Add support for LTC2305
Message-ID: <20260325201931.26ca84c1@jic23-huawei>
In-Reply-To: <20260324071331.842-1-carlosjr.jones@analog.com>
References: <20260324071331.842-1-carlosjr.jones@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Mar 2026 15:13:27 +0800
Carlos Jones Jr <carlosjr.jones@analog.com> wrote:

> The LTC2305 is a 2-channel, 12-bit, fast ADC with an I2C interface,
> compatible with the LTC2309 (which has 8 channels).
> 
> This patch adds support for the LTC2305 by introducing a chip_info
> structure to handle the different channel configurations between the two
> variants. The LTC2305 exposes 2 single-ended channels and 2 differential
> combinations.
> 
> Also updates the device tree bindings to include the lltc,ltc2305
> compatible string and documents it in the Kconfig.
> ---

Whilst checking for what comments were in v1, I realized we have
two different people looking at the same thing within a few
weeks of each other. +cc Kyle. 

https://lore.kernel.org/all/20260325-add_ltc2305_driver-v5-0-e0d29daa54f9@gmail.com/#r

I guess this is just a case of neither noticing on the list?
Too many similar part names, so I missed it until now.

Currently I have Kyle's patches queued up.  All else being equal
that seems fair as Kyle started on this last year whereas 
Carlos' work on this is much more recent. 

I'm seeing some small differences. Please could you work together on this.
Ideally send any additional changes on top of Kyle's series.

Thanks,

Jonathan

> Changes in v2:
> - Changed usleep_range() to fsleep()
> - Added missing #include <linux/array_size.h> header
> - Removed explicit .read_delay_us = 0 initialization (implicit zero)
> - Added __counted_by_ptr() annotation to channels pointer
> - Modified ltc2309 struct to store only read_delay_us value instead
>   of full chip_info pointer, reducing memory overhead
> - Alphabetically ordered device entries in ID tables (ltc2305
>   before ltc2309)
> - Reformatted Kconfig help text with explicit bulleted list of
>   supported devices instead of vague "and similar" language
> - Added device names to chip_info structure for proper sysfs
>   identification
> - Split changes into proper preparatory patches before adding
>   new device support
> - Link to v1: https://lore.kernel.org/all/20260320140819.191700-1-carlosjr.jones@analog.com/
> 
> Note:
> The ltc2309_chip_info structure has a 4-byte hole due to alignment
> requirements for the __counted_by_ptr() annotation. The count field
> must precede the pointer field for the bounds checking to work correctly.
> The total structure size remains 32 bytes either way due to required
> padding, so the memory overhead is minimal (8 bytes total for both chip
> variants).
> ---
> Carlos Jones Jr (4):
>   iio: adc: ltc2309: Introduce chip_info structure
>   iio: adc: ltc2309: Use i2c_get_match_data() helper
>   dt-bindings: iio: adc: ltc2497: Add LTC2305 compatible
>   iio: adc: ltc2309: Add LTC2305 support
> 
>  .../bindings/iio/adc/lltc,ltc2497.yaml        |  9 ++-
>  drivers/iio/adc/Kconfig                       |  8 ++-
>  drivers/iio/adc/ltc2309.c                     | 59 ++++++++++++++++---
>  3 files changed, 65 insertions(+), 11 deletions(-)
> 

