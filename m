Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B5729C338;
	Wed, 11 Feb 2026 06:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770792588; cv=none; b=WMWb65SlSlo+Fy3V0/SSx2qZAqOgfyTOcfgmZQTo6x6X0B1CP1Ms7aYnAlyynkclB1oER96YHEMtJxrGZToQgUBhH0hVEKz6vcgIvaEi1X0vkesokZdPx0yeTSceYkqwrg9xEt6pDymuKJrIcsLLzeK85DdTfh7aMGios/wIWSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770792588; c=relaxed/simple;
	bh=OYfWQg9thq1Z4lUXJpP4sm0GZngOsXWcnSCX9sggLHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IroTweZ3jxaWkk2ycwcCmWS/kX+f3bRpO7gUK0BRs4RLcOVtJWigSwZ1DPSoInT7zWKXRZfDHI5b+wFMPuoSUWrgFXObNOTNwmwNhaxD6EvMe/V/WoI5rRscqH1DyqX4c5uuvIRpDzh53awBR7KlQ7ZHzXYiCCpz5bMXhWEByoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ig9oYtbX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ig9oYtbX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D97C4CEF7;
	Wed, 11 Feb 2026 06:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770792587;
	bh=OYfWQg9thq1Z4lUXJpP4sm0GZngOsXWcnSCX9sggLHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ig9oYtbXpWKC+pWK3Q8o4bN/RiMJW7ApiMOK/4o9atIkABnbPDmWEK8kW0W1j5qEk
	 OpRtPtX0XR3b5Q1gBYQpwZy+Z1dtLijV3VDKhl9+gQ+P0LpchU4k40edZJFH2LXcrS
	 omwCDD5q3Ku6zcAj7V3uOVCgrdBl4QuT5vER04HdGy0fcUVjd4wZD3xFfJr4/z0+Lj
	 Z1AAurycN6BCwyhuEIC3k+nHOSLHo4kVG662MbgP+KQqVTzx3K4qI8ZWr8VIhjAQy4
	 /3b0hPOmcCSEqwMnpWgbulcmytoYa9Hqzm36niwnXzy+XWbk5UwRP91Os+oToL0lNf
	 h6XCAjl0YEnhg==
Date: Wed, 11 Feb 2026 07:49:44 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: vcnl4000: add Capella
 CM36686 and CM36672P
Message-ID: <20260211-sceptical-frog-of-revolution-fc3cf4@quoll>
References: <20260210-cm36686-v1-0-aef68dd46ad4@gmail.com>
 <20260210-cm36686-v1-1-aef68dd46ad4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260210-cm36686-v1-1-aef68dd46ad4@gmail.com>

On Tue, Feb 10, 2026 at 10:46:10PM +0200, Erikas Bitovtas wrote:
> Capella CM36686 is an ambient light and proximity sensor developed by
> Capella Microsystems, now a subsidiary of Vishay Intertechnology Inc. It
> has an I2C address of 0x60 and is fully compatible with an existing
> driver for VCNL4040. Capella CM36672P is a proximity-only sensor that
> is fully compatible with CM36686, and therefore with VCNL4040. Add
> compatibles for cm36672p and cm36686, with a fallback for cm36686 of
> vcnl4040.

There was CM36686 v1 and v2, so I do not understand versioning here.
Also, lack of any changelog.

And how is it supposed to work for us? Try yourself:

  $ b4 diff 20260210-cm36686-v1-1-aef68dd46ad4@gmail.com
  Could not find lower series to compare against.

Please implement previous feedback.

Best regards,
Krzysztof

