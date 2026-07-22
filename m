Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835A53BED5C;
	Wed, 22 Jul 2026 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734938; cv=none; b=ftQzrq9RwUxg1VDqo+1O4Iv7CT4oNSEUKGair3zSFR5GOxQ8vd8gkC+NkAgBab/Q86Gc+VRsg80+3okEVJXMMH0fIad8H/wPlgGhfgsi+N6jiGrZsfsdyc2GNGiosYv1Us3XqPfZ4rMM1YLPe8cAx6zZ+V0Pmmz2oyNzFUYkrlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734938; c=relaxed/simple;
	bh=PdiZa1RNAjXVao0MUUBuy0KKA3XawFjpOQHuC3TZBVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/lg+2bD2Ii4IVcC2gtUE2zZ7WbtsWqkF9BKKzaZ3Elbbh8CyWQbGfILNiva4hYglYR6hUqtoTuc/+W6IIvxi6+ipN6TjZQRVPDy8vaLHQr4xYxMv/WB1b9QmhAsJkXnizscrvMcYpU7y0hE9EYC3P8bJl6mr7bVMvKRPjXzwok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erDD+Rnx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erDD+Rnx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104391F00A3F;
	Wed, 22 Jul 2026 15:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784734936;
	bh=0fHNHgZIff+uZSl+/JrLX5ORSMA5g4ULuVBqg42lr5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=erDD+Rnx0gopJkNeAPZSFyjeN/phXtHJH/DtMOjzd6lZd6iRIX02OD2JKWqFLgHQo
	 4LVbHgokmmogfBtNo2tXleUfm4tLwJHVy4k2RVBv0/aqjnubC4S9cJQWdg9gweYYH+
	 7vft1kRura+MFQDD9TsHFlZUDsw4tM2FPtDetmRDXclx8MV6Lr6s/Sqy3D4ZIjxiyT
	 oYey8CQYnNqgXdFU8s/e8vg3zf8an7ilfyFljPFvj9WXbTtqt+fOdxZSZxOOdl99xQ
	 3q/4/pRJ6/boEjRp55QeVpAKgH73PS2EwoNL6nPAD8mYa254MoBAHaZ7URFR2YnDkM
	 q/OnDanZAjpOw==
Date: Wed, 22 Jul 2026 10:42:13 -0500
From: Rob Herring <robh@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] dt-bindings: counter: add gpio-counter binding
Message-ID: <20260722154213.GA974454-robh@kernel.org>
References: <20260714081709.17846-1-wafgo01@gmail.com>
 <20260714081709.17846-2-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714081709.17846-2-wafgo01@gmail.com>

On Tue, Jul 14, 2026 at 10:17:07AM +0200, Wadim Mueller wrote:
> Add a binding for a generic GPIO-based counter. Two GPIOs (signal-a,
> signal-b) drive two Counts; optional index GPIOs load a preset. The
> counter function (quadrature, pulse-direction, increase/decrease) is
> selected at runtime via the counter sysfs interface.
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> ---
> v7:
>   - index-gpios split into seperate index1-gpios/index2-gpios, so
>     Count 2 can have an index line without a dummy entry for Count 1
>   - dropped Conors Ack since the binding changed
> ---
>  .../bindings/counter/gpio-counter.yaml        | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/gpio-counter.yaml
> 
> diff --git a/Documentation/devicetree/bindings/counter/gpio-counter.yaml b/Documentation/devicetree/bindings/counter/gpio-counter.yaml
> new file mode 100644
> index 000000000000..782cb177ed0b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/counter/gpio-counter.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/counter/gpio-counter.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GPIO-based Counter
> +
> +maintainers:
> +  - Wadim Mueller <wafgo01@gmail.com>
> +
> +description: |
> +  GPIO-based software counter with two Counts:
> +    * Count 1: A + B. Quadrature X1/X2/X4, pulse-direction, inc/dec.
> +    * Count 2: B. Inc / dec.
> +  The function is selected at runtime via the counter sysfs ABI. Each

sysfs is not relevant to bindings.

> +  Count has an optional Index (Z) that loads its preset on rising edge.

I don't have any clue what this h/w is based on *this* patch. Rotary 
encoder was mentioned elsewhere, but this patch needs to stand on its 
own. We already have rotary encoder and GPIO decoder bindings. How is 
this h/w different? The patch needs to answer that.

Rob
