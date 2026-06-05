Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B193F825E;
	Fri,  5 Jun 2026 11:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660419; cv=none; b=VDM24XZjyuL5F+gigx7dn/LfLmRMFbZ9ZEEQpXCq3hPVdsie1aNAYYT/TUwr4fm8Sx/lTOEYlhlpmE2kbIJbg7uKauavGZ+Koed4pdwkuFtUS3blzrYdZ3ErIKBRXavTg8zKDnQvr5qW0E6iniln3eoNUIKfNAKKBztr5dpkISA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660419; c=relaxed/simple;
	bh=wZ0PApAQIp/ARhdjZK3fiA5s9UijCfxrwVNjoOOCqwo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dEXPEZmjLEo5fBSCmmqwSps8Qzon+quBiUkyEFG7sgbeP0gsoL+cDlbQ5Y54xCmHs1+NTDIUCaGyw5v6jOfhq8IOqSH21Te+ZCbdKcu2P562os1ACpK0xqEMKau2zd6+t4auqHU8aSxPEBe6Iw7tvc7QkUR1VVilHG7J72NiBbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zd9IXFGF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zd9IXFGF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1815D1F00893;
	Fri,  5 Jun 2026 11:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780660418;
	bh=5aIKpvnTj3sLnXmmm5ahROVi2ECJn3r11IRBWH+G2kw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Zd9IXFGFSOxCCMsNKbeIAqurvUBmzIvJ8L5EOqZeczbLkPAniMb6IXIijhZWV2MRl
	 ck6bfgYgZYkHLSLB6SLVyN1dwXbi1vjVPjlwpeVbcgFtyh/TmONJ36c6zG1YLBYVUP
	 eK6ljMovMrcGuf5NDn/SNSzeLJbFzzIdL8aLkaTqv0wHFhbN2EaWCjmrOUGGHRhDlS
	 QaBf6rmY+iVfadO+G4KJHF544V80c7AGd/xQ2I8NQVBwMFy4wQy/dTRTSGbnGYbE4C
	 tn9qGOKmIqxh37+jkzuuqivvCv1U8dMPIhXlJLe4oAZzGfCzFUBKMmylDGTOelzTdM
	 y0StRH0Z9OSeg==
Date: Fri, 5 Jun 2026 12:53:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Wil Stark
 <wil_stark@keysight.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: ti,tmp117: add binding for the
 TMP119
Message-ID: <20260605125332.151b92f8@jic23-huawei>
In-Reply-To: <20260605-tmp119-v1-1-349f45f17d12@bootlin.com>
References: <20260605-tmp119-v1-0-349f45f17d12@bootlin.com>
	<20260605-tmp119-v1-1-349f45f17d12@bootlin.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 05 Jun 2026 11:01:35 +0200
Romain Gantois <romain.gantois@bootlin.com> wrote:

> The TMP119 has the same register layout as the TMP117, and a better local
> sensor accuracy.

Sounds like (and the driver changes pretty much confirm) that this could
use a fallback compatible to the tmp117.

The second patch then just resolves the print that would happen on older
kernels using that fallback due to ID mismatch.  That's fine but nice
if older kernels can work with this part.

Thanks,

Jonathan

	
> 
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
>  Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> index fbba5e934861c..9f3b74274b16e 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> +++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> @@ -7,10 +7,11 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: TI TMP117 - Digital temperature sensor with integrated NV memory
>  
>  description: |
> -    TI TMP116/117 - Digital temperature sensor with integrated NV memory that
> -    supports I2C interface.
> +    TI TMP116/117/119 - Digital temperature sensor with integrated NV memory
> +    that supports I2C interface.
>        https://www.ti.com/lit/gpn/tmp116
>        https://www.ti.com/lit/gpn/tmp117
> +      https://www.ti.com/lit/gpn/tmp119
>  
>  maintainers:
>    - Puranjay Mohan <puranjay12@gmail.com>
> @@ -20,6 +21,7 @@ properties:
>      enum:
>        - ti,tmp116
>        - ti,tmp117
> +      - ti,tmp119
>  
>    reg:
>      maxItems: 1
> 

