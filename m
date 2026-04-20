Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6446034E746;
	Mon, 20 Apr 2026 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776697279; cv=none; b=kPE7laCu/a/PVtc/mwEfIsevfprNCI7eOR3RD60MkjMaH2lFgrOpIZPw5WwnpWxgcT0QaIJrbWpqe2DZQSaGw/1uOfkykKI9WD2nYtOsdNkiWGTaxfbIEiZ8R6hrnp92uQfkekhd5sVc39IJ8FNt5KyzyrLsJ5GZl+06vxsWjJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776697279; c=relaxed/simple;
	bh=0+jyjM0Uy5qmCUUkrw0ZUslYImT7Dy2hq65NWqQk5pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6vmPlIvxLq7IUUDDNcO5pG3B2g/zYWNZBTnT93z5JCOv8JiK/H1H7iGr4Ja+VUEtipQqYZgKOzHWc4Z7QfLBghFVIgSmgcnItze4V6E9OqgPbz7QukgkD/a0bmwxkmIls+UO6wdNINLIFbO96pFwH7Ex8XKJ+M3cojRXgwbzys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuPRO6I9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuPRO6I9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B9FC2BCB6;
	Mon, 20 Apr 2026 15:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776697279;
	bh=0+jyjM0Uy5qmCUUkrw0ZUslYImT7Dy2hq65NWqQk5pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HuPRO6I9Q84sN/XKi57ht0RX5uGSAYGttTfsI5s8DYy36r8oqbuIzsI8aDYLNpQ/o
	 uOvt2qA8Ph5X+u/rfvor/UlOvplH25DGdv7OZuHWoXLzBAIrscRIXzv4ATd3ubC4UQ
	 AxXnd5tH6IlRKkEQdSC58qkbNN2NthZxqWEu5WCzcvNKMomB5k9gQf0xOUXyKW6RFg
	 kOYSN6KRNPmGk4Hg21Fbz46W7SE0glufuj2NyK7FncF2vWV7noelKHKD1uFU8ijl+V
	 XAas1LRvLVTAAmDHIBv22c37MN1d9PvHz8E/R+vk+Q9FrGMZOe1t1zLbH7Pw2n4V1Z
	 Ayl6q9YAhiUUw==
Date: Mon, 20 Apr 2026 10:01:16 -0500
From: Rob Herring <robh@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: dac: mcp47feb02: Fix maxItems value
 for reg property
Message-ID: <20260420150116.GA2486072-robh@kernel.org>
References: <20260417-mcp47feb02-fix5-v2-1-6592ea499cce@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417-mcp47feb02-fix5-v2-1-6592ea499cce@microchip.com>

On Fri, Apr 17, 2026 at 04:38:29PM +0300, Ariana Lazar wrote:
> Change maxItems value from 8 to 1 for the channel number reg property.
> 
> Fixes: 4ba12d304175 ("dt-bindings: iio: dac: adding support for Microchip MCP47FEB02")
> Link: https://lore.kernel.org/all/20260403-speed-childless-1360de358229@spud/
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
> Changes in v2:
> - keep just maxItems value update in this patch
> - remove Reported-by from commit message
> - Link to v1: https://lore.kernel.org/r/20260416-mcp47feb02-fix5-v1-1-9656c2fed6d2@microchip.com
> ---
>  Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
> index d2466aa6bda2106a8b695347a0edf38462294d03..f2efa0ccbaa32482dcdc69d98c1565518538793f 100644
> --- a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
> @@ -161,8 +161,7 @@ patternProperties:
>      properties:
>        reg:
>          description: The channel number.
> -        minItems: 1
> -        maxItems: 8
> +        maxItems: 1

Perhaps there are 8 channels and 'maximum: 8' is what was intended?

Rob
