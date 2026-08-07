Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5EB3C457D;
	Fri,  7 Aug 2026 07:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786087664; cv=none; b=gB76I2yO+y+p/d+DnfF43q0nOpCG6JqMOmhF/dHyUBfuWmwwS1eiKS6Lcpj9L8Ykk537UvqJ5D8yEv5uTJ//PyqPdCkFdPBVnJMq+SpLGCVKzo/lEISG3ZJ+meOnW9YtT08xvf7YyhYk5HqvDz0o1xGiIjEsFady8DfUFmMe3Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786087664; c=relaxed/simple;
	bh=Aog2Ut7LD4S+Um1s5g9WJEnSkln1mw075/FMX/NDj2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bj8oo6lpSt0yKGV8CVyrPFdGfC3Ny+I+UkKw/hz2MYmFQBAAf7LZCGUQ1TEfxn2IkGT1AG6l1pfuK/nRN1d8smHdHbKreCD3XuXBdimWNn9ecweZuI1Q72pnoQqWR543g/3cwgcDg7kIndKBKdngAJiJZ3AhL9X38uLSIWV84mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6Lx5SM+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6Lx5SM+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3FA1F000E9;
	Fri,  7 Aug 2026 07:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786087660;
	bh=Rf2beZcl9yWU11eO4KDNx5gmas3zaF8gFschCgphPcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C6Lx5SM+iELUCrDDutx1/WR2hCoopoptyQGRytPS4EGOD3Vs2dVdC/6bxnq/CRTF+
	 2nzc9L9TsJDNSla37Mj8uKqdcmgdQEfwD8MHq3xYLyO4u00nSo9WedPHvz8HwRqBbJ
	 NI3GIpzgw/z/1Ohm7YNHDieP2C6r8oe2gsxMuZmde0oLJZE+ZrYkg4QWBrbP3YP8pR
	 q4hyA09bE2gTQLHirLZzkXXWt3TLwS+n1w/EXPGpWFf/dQY41KbcIaGCIiu0hfem4f
	 5fsYh3ulliShoOQfP0EJaPACOkkbrSL4LrUrs2mDJ+TvYVNqioUCGrf8rsBMY/Hh3H
	 UtworTQL4sBsQ==
Date: Fri, 7 Aug 2026 09:27:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: proximity: add Sharp GP2AP070S
 proximity sensor
Message-ID: <20260807-aggressive-exceptional-macaw-cfaabe@quoll>
References: <20260807-gp2ap070s-v4-0-74f6a67b6272@disroot.org>
 <20260807-gp2ap070s-v4-1-74f6a67b6272@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807-gp2ap070s-v4-1-74f6a67b6272@disroot.org>

On Fri, Aug 07, 2026 at 01:18:41AM +0530, Kaustabh Chakraborty wrote:
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Voltage supply for the internal circuitry
> +
> +  vled-supply:
> +    description: Voltage supply for the IR LED
> +
> +  proximity-near-level: true

Same comment.

Best regards,
Krzysztof

