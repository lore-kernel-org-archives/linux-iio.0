Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFAA3CEBA6;
	Fri, 24 Apr 2026 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052705; cv=none; b=fndihd0V8BMcBcMp6L4WYacY1WI3h0sAw7tvmF4cg884JwMqBv5jWV/4Gx+pkfytZjgz3c8wV7FUa2wCxTLbHPlH/gk5ZJBP1unkjHuRmtd864VGpo6PnSE8iXrN5jC1ZIfb3s8FDI6BIuctJvKUbwFlVXjgWluBoHDrUBK6MDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052705; c=relaxed/simple;
	bh=1+efIVr0IPYZv0TKRGx6CfxqlruBvhFjjX61GHEFlNk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbsK4GkWOSz869oYSHHAVRrGhtLmSLm8erymzcweHFLMu4wYGZD6A1a7w5sEmPArwmbtgB/wozAom4hqFrRhnmgjpWSOUq9A00hSKmJyC4KwqBjfSkauY5/ZHNQBEh1L2GEe2gpxroZjb3JtEfzKXvU2UsMz1KdCjPtDvIEatgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZyYWtCG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZyYWtCG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1A2C2BCB0;
	Fri, 24 Apr 2026 17:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777052705;
	bh=1+efIVr0IPYZv0TKRGx6CfxqlruBvhFjjX61GHEFlNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XZyYWtCGzf4VORQ/xnNaAX1Bm9z4WtKGBLzL/PrB9FWkUh831gOT1q/UMTljeQ3ZB
	 8oZAf1yGRnxgjR7I6RjMVROisYFgqk2xPJkEmF/eQq+REU1q/EdmW6xDt29QCgF/fj
	 C21rtsI+Zzegtr62UtlUduqvFJ8T4WYFbaGK2RT9RYxevYQ5UCOMrAHNWF1ewPcaCm
	 8z50NrVDl8kmCHG2K8qYW50BY0arjfSTnkPf3aKk9pY5T3wqVtzGzLL3tCFQF8sOSz
	 1SAStrfh3kzqAdEHbGiybS5o0/urYkiHhufvU1iJQkrNugN9prkP9r8kBZG193W4zq
	 tMXIR32DUUrdA==
Date: Fri, 24 Apr 2026 18:44:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Ariana Lazar <ariana.lazar@microchip.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Conor
 Dooley <conor.dooley@microchip.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: dac: mcp47feb02: Fix I2C address
 in example
Message-ID: <20260424184454.74c3e7be@jic23-huawei>
In-Reply-To: <20260422-magnitude-improve-0266ea916c36@spud>
References: <20260422-mcp47feb02-fix6-v2-1-4ca4d5cfab07@microchip.com>
	<20260422-magnitude-improve-0266ea916c36@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 17:54:25 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Wed, Apr 22, 2026 at 02:56:59PM +0300, Ariana Lazar wrote:
> > Change example reg value from 0 to 0x60 in order to use a valid I2C address
> > 
> > Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> > ---
> > Changes in v2:
> > - drop fixes from commit message
> > - keep just the address fix
> > - Link to v1: https://lore.kernel.org/r/20260420-mcp47feb02-fix6-v1-1-ae1808fea11d@microchip.com  
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable
> 
> This really should be in series with your other patches, so that
> Jonathan doesn't have to figure out which order they apply in.
There doesn't seem to be an order... Either order of this
or the next one is failing. I'll apply them by hand.
Too many things in flight so I'm keen to merge some stuff.

So please check result.

Applied.

> 
> > ---
> >  Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
> > index d2466aa6bda2106a8b695347a0edf38462294d03..350e80e4dbe05dd10e3c6fb00f74d58c56c54bc8 100644
> > --- a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
> > +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
> > @@ -280,9 +280,9 @@ examples:
> >  
> >          #address-cells = <1>;
> >          #size-cells = <0>;
> > -        dac@0 {
> > +        dac@60 {
> >            compatible = "microchip,mcp47feb02";
> > -          reg = <0>;
> > +          reg = <0x60>;
> >            vdd-supply = <&vdac_vdd>;
> >            vref-supply = <&vref_reg>;
> >  
> > 
> > ---
> > base-commit: d2a4ec19d2a2e54c23b5180e939994d3da4a6b91
> > change-id: 20260417-mcp47feb02-fix6-bd6694d84750
> > 
> > Best regards,
> > -- 
> > Ariana Lazar <ariana.lazar@microchip.com>
> >   

