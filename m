Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA013E3151;
	Wed,  5 Aug 2026 07:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914104; cv=none; b=Xn470s/x8dm1OIsvCoDsC+WoCVJFSxbI7RGfP41l/q1zWyYcZyYNj9kb6yflB8CUNz6870AKx6f9vv/6XfOi61VDvFRAlm7RIQZB2qw7pYwpWX73eNEwsYlmbhWwQZnHBID2nocMWhs8MW8FVLeVc40m/5e/fe5oXpUD/X2AgI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914104; c=relaxed/simple;
	bh=KxNQRFaIqxTUpEDjynGAOP0HzXd+DRM/biKXTwtnTeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vl3FmZDbi4BSSwMvq+IUlHiZjSVK97WHMR/RSe/PQn2H3IyBuYfPIrSxFJHrT+0v4tOoEXe21Anzj7AjMqBhw4FYa0pKnQzuP/Eextqil6lWaUAhaPqAoNUMZwx3EL5M+I+wVUTAEUWGrFVbYxhdWqPbKsJYpbAHDbolBuPC8+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9jQIysG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9jQIysG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E091F000E9;
	Wed,  5 Aug 2026 07:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785914101;
	bh=UPo2paJHZp68EQfX6oFXYo0NfkSNxyk9gaDrD4U0PRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j9jQIysGTeXxTBPHc5bcLKFOv59jU69x0FFOJRgwF5baoaF4fuMcis9+HrjriIXWY
	 4D46g+hrMnSDJRxag1ddFxVtuvZ7ms72xtbNX7R4Sj2G9EsPIujGR6/RYB21Kbr9dR
	 TTkol/I051VpglkLQFWpnKFkxaAMDZpJ71TRHpqxvEw5x9fGQSrCDPUrJvWklXOqnb
	 ZIcC+jf7wdJyoOwfltFt9nhj7+W4rBsKfwK0Txk/yBi1ICe0NJ6VB5YNkd4yt4xyKT
	 FB+KNvaQYbTgL0uxKvBTr8h5BAO97eBt41Nr45nYQQx3TlqcwuM+50He+urk+PdauG
	 b6mrlDqm12PWw==
Date: Wed, 5 Aug 2026 09:14:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nikita Travkin <nikita@trvn.ru>, Maslov Dmitry <maslovdmitry@seeed.cc>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] dt-bindings: iio: light: ltr501: Add missing
 ltr303 compatible
Message-ID: <20260805-thoughtful-significant-tench-0a135c@quoll>
References: <20260804-liteon-ltr329-v3-0-c6b768c7c745@geanix.com>
 <20260804-liteon-ltr329-v3-2-c6b768c7c745@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260804-liteon-ltr329-v3-2-c6b768c7c745@geanix.com>

On Tue, Aug 04, 2026 at 07:02:13PM +0200, Esben Haabendal wrote:
> When support for ltr303 was back in 2021, the bindings documentation was
> not updated accordingly.
> 
> Fixes: 7d71d289e1ba ("iio: light: ltr501: Added ltr303 driver support")
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

