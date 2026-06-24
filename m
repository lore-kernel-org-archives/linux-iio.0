Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961503ACF0C;
	Wed, 24 Jun 2026 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782295453; cv=none; b=hZtX/E0BfyxanooFp+H2pSEiuchh+BTL2eBj1x/bSdYHK5uvdeZqAwPrpYkPbKBHITWerbOuHdg7AB8W11VcUhtzRyVKuAUDnrIqdpT/Tmz+aalqku3I7vs6OLJRRx0S/dlFp8xRWlnZBIRjoJYye8c6G4nT4wlBwZW7X1375xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782295453; c=relaxed/simple;
	bh=V2xL5spx0Bw3nq5DCJ41peJmadVLewOTsGrgOweshTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWaKp0a6zrRlU3U2qj8oDx3o9v/BtDCltoxRH5S/ucFHhM+GSJUHA+8gvn+1EBGapOksYwFNQXkYsxxxA/Lz6ZH1KQKCUw++BBhbZtF78cQhGWB35MBru6512bhhWv/tIcEWyz1EHxy795Ih591uJN9uizXFZnFascGTLIcrVEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsA3GFLl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsA3GFLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A861F000E9;
	Wed, 24 Jun 2026 10:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782295451;
	bh=V2xL5spx0Bw3nq5DCJ41peJmadVLewOTsGrgOweshTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WsA3GFLl8oEmpAYbgnyy1sjrM/OUy2YwTdbA/HqXIeqPekL7nXV49/ZuidyAKBwPH
	 b2o6jJmsLjpQ5C9zJtcxp8RZYzMMzJnfUlXTjpi5uGVBGKvKZXSYrDnoDtPzO1dIF3
	 3tIgGnYSoMsYA0EB/t39Xs+pi9D5mnU4h6HZsmduygKi8RJUfYVZLKnaa2Lj/7AJSr
	 oCAbG+le+GIESH1CSeluTfX1vYETQ3ItuVytwI73SRDxptQf1MJ7Cn/DZmJhvb9Y7T
	 obs0HgGFzpf7ZO0ARQ7Bwyu/PVVFbP7bHWGMJ27W12lwEuWKeM4POnqHCYPlvyTqD+
	 p8PrGXZThNp2A==
Date: Wed, 24 Jun 2026 11:04:03 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 14/14] video: leds: backlight: lm3533: Support getting
 LED sources from DT
Message-ID: <ajurk9wOxHh6rOH-@aspen.lan>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-15-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617080031.99156-15-clamor95@gmail.com>

On Wed, Jun 17, 2026 at 11:00:31AM +0300, Svyatoslav Ryhel wrote:
> Add Control Bank to HVLED/LVLED muxing support based on the led-sources
> defined in the device tree.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
