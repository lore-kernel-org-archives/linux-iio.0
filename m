Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9361A6838;
	Fri,  2 Oct 2026 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790933662; cv=none; b=f36ZqQi9Y2qtl7bWusBee1+kold4svriGzl6JryCZSiiP9gh0zbi0SBoNDsTZHt9e13Ch8CinLt2D66RbvkHnct3cQFj1hxrKoUFEy3WOyMWPdtu3r3bHU27U4TDp9eU+nZi+EsjuP6xdPAkZABVMWY8YWLtGY2ps3ICfnhLyOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790933662; c=relaxed/simple;
	bh=VaJzlyrYQP8BCnCdnU7d3C5mkzgvQ4iZBdFm9OjPk5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M50NST7T8uUe5lElZaI2faqMmfSgv/3qICRgcOxLIkkfbiu4EgJvj4wLx1vrdHSAsWWcPb/7/5nZj8wff92bcB413IaappqqcQQdrL1s886+3KAzlh3Vho92VJN/w1t2dwug2nKHv+63cKzxjbkiCWDg/C/J8q8b3/W57tAY0X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GChv5trb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GChv5trb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C9C1F000FF;
	Fri,  2 Oct 2026 09:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790933660;
	bh=tn7CHjIH+1k2SDeXvJO8L54oXnvTAvyTElqOzEbIrww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GChv5trbPWXmac1WVDsUKpEfwxsbWGChc/pylUfyr0NwBtdUVxVK3h50hdtBefj7H
	 HoL8yZRynoxcn0lJ8sfRYEoLANdujYIfydUvknoSL6ozr+dIaxqoHSKDVcHccO9Gkn
	 VRl7XibOYY1ZCGWhrC586RbpGiMwdOxTUPsYyi8mUeQmTKeIZNXmowhDh7Ihioxs/8
	 VO3ZKPD/ApwU1U0w6rcZS4j2vd6SA/PcCllGKOSx8+ZDLAkLcxn8tUR3MsQ5q1wU9Z
	 Vi6LzeiKvJmnUqldA5NGk5wgFQ6+Jv8JL4eLg1BNovXluj3+gM1XnCsuYzg1q3tuwx
	 7UGCoyBHVRXBg==
Date: Fri, 2 Oct 2026 11:34:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: add bindings for stm32 mdf
 filter
Message-ID: <20261002-observant-gleaming-koel-4dc04c@quoll>
References: <20261001145702.2628429-1-olivier.moysan@foss.st.com>
 <20261001145702.2628429-2-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261001145702.2628429-2-olivier.moysan@foss.st.com>

On Thu, Oct 01, 2026 at 04:56:45PM +0200, Olivier Moysan wrote:
> +  clock-output-names:
> +    description: |
> +      CCK0 and CCK1 are optional output clocks, which share the same clock frequency,
> +      but can be gated independently to save power.
> +    minItems: 1
> +    maxItems: 2
> +    oneOf:
> +      - items:
> +          - const: cck0
> +      - items:
> +          - const: cck1
> +      - items:
> +          - const: cck0
> +          - const: cck1

Use simpler notation:
minItems: 1
items:
  - enum
  - const

> +
> +  clock-frequency:
> +    description: |

Drop | when not needed.

> +      Common clock frequency (Hz) for CCK0 and CCK1 output clocks.
> +      The frequency must be a multiple of the "ker_ck" clock frequency.
> +    maximum: 25000000

So here is the clock-frequency. No, these are output clocks as written
above, so consumer sets it, not the provider. Or use existing assigned
properties. This is even mentioned on DTS101 slides, really...

Best regards,
Krzysztof

