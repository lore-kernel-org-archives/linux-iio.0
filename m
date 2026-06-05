Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637B53E4C85;
	Fri,  5 Jun 2026 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653804; cv=none; b=YEpghyngria+goNjWG9zGw67gftg/mL0lW24washiPXRhRLqQuPIxYKoDM93aPxP3iol+WZrEpKi92OkM1L/7F90r2owdxAfYnzkR0/GdSVDMacrR81KrUa2tkGOF4fOMdphUAJFBM089EXQz0cPQi9fZUa2kG4/QpnzLyXYJ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653804; c=relaxed/simple;
	bh=VLwp8fH4ZG7f8zXVPmp53g3+/ajhfCm3ZoMUcZBkgBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKDn77lGdgWr6t5zG/sKZXYERop/MTdl3kFd/qpslf5YJI8xnZZ8B14xHlaVGYJw3TvS2XDmzKsFV56MsNXSvFn6KBpIUDfSKGhIjf1d29lnOF8JFCzJhdmEMYY+XeEzu9Rfvh1FOLEd3pgrgEO+UaiBJHfsLDJHkTsSYcWE1C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eg8GsaXu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eg8GsaXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9D31F00893;
	Fri,  5 Jun 2026 10:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780653803;
	bh=S7BMO8cpcnRmf/pdVAVdW2RAssH+EVoJVhCq/grmx9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eg8GsaXu63euOYEvi0ZAFb3GboTIFgfUUQgee2nHiYbTzEsCdsvBfif7HlHFW2ZBA
	 AInNaXOsSRkuXAlaX4doBl36un7RRwUvI7kVKqd6aMegM7zfLAsv/diHk2T6vE1OXe
	 G+JyftXGdvDsuVAt6o4rd/jUkV2Pxphfj/uP9BP++8TkJUdv/AbWCUsRViN8GlyejZ
	 +53PeGzULhrUnWKpC1AWDmMCV9P/TEFA7fmpdCEKMcR8XC6hGfyhRPeTNE4LPxhgPT
	 hIUSmaLnxQF3L27J/FqFWFXvqIhdEa3gSGM9JG51D4qci2OzOHTXCsWe4bylYzr0wK
	 h9h+/xvu1VncA==
Date: Fri, 5 Jun 2026 12:03:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com, 
	dlechner@baylibre.com, jic23@kernel.org, jean-baptiste.maneyrol@tdk.com, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org, 
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com, 
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V10 2/9] dt-bindings: iio: imu: icm42600: Add icm42607
Message-ID: <20260605-big-auk-of-progress-c99b3a@quoll>
References: <20260604201832.60656-1-macroalpha82@gmail.com>
 <20260604201832.60656-3-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260604201832.60656-3-macroalpha82@gmail.com>

On Thu, Jun 04, 2026 at 03:18:24PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add the ICM42607 and ICM42607P inertial measurement unit.
> 
> This device is functionally very similar to the icm42600 series with a
> very different register layout. The driver does not require an
> interrupt for these specific chip revisions.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  .../bindings/iio/imu/invensense,icm42600.yaml  | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

