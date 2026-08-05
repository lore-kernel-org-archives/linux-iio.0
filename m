Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537B93655D7;
	Wed,  5 Aug 2026 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914162; cv=none; b=WIGc4GL6FAGBEvOOlIfIh4irSqXEGjIqKO4vy8vfUfEz5Aw8qaQeV7TlzngezBO/6vxtWNqlsiBWRJxRglKBwWcUlAqtT0Wbw6/9AtLPOEjWPq38cijC0iDmlRYn5HtAu7Ku4YxnF6XRWT7ZO3/Cf5v85V5lTMhEjUrhW1mRR6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914162; c=relaxed/simple;
	bh=jX915Lg04YkUBz9vvZQk+Gj7+dcySZSj9jACrqYApxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c54zRhLvkT+WsL6UMG21QS4E0Ri/c9ZhC8+KWoQ4FBaXlGjk4XM9JWE9AJS2dVNw4Alyf0pQEGYjRTW9FZtTmOlCwyIgRdGyAAOwOXoAjfF7IVi5K+wuyIvEh6yjaQGL9XmYfjH7ComZ3xB/SAZyr6GW9bAujVBrCNB+K+Vsc74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcKXale4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcKXale4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3650A1F000E9;
	Wed,  5 Aug 2026 07:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785914160;
	bh=W/bwk9B0EqXsTv3qaz2+tH5bcoXAfQB25G0ijES/NsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AcKXale4veWr4V0/Py/NLNYjCrRmCiKY8X/69QqHlf18dm1k7hi1GMtyTM8PLlJwz
	 9DFJeMNgPIqXSa50FhNz0djR2MFwcgeNEOHM9oJKSOmvSpjX8tUae8m6/c4PPhfSNl
	 wUCae1GzeHpDzoTLB+mReN9qRt4kvNBfI+hjrxxwjrQWgfp9LrD0kwziOaWKjpV/hR
	 Wf3EM0C6FAIB8tTEfE5tjmu8LKwmmJ0xYS+AJtT9W0dduNHyFRdjQMgwotyx37A0eF
	 iaJZewqgD0S+4gUjrv7UbF7bT3uXtnB/bBBiX8x/f2aPLPkVvNXC5iaV98mp91+6bc
	 JOK6MwRYCJtgA==
Date: Wed, 5 Aug 2026 09:15:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nikita Travkin <nikita@trvn.ru>, Maslov Dmitry <maslovdmitry@seeed.cc>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] dt-bindings: iio: light: ltr501: Add ltr329
 compatible
Message-ID: <20260805-glittering-fuzzy-shrimp-627878@quoll>
References: <20260804-liteon-ltr329-v3-0-c6b768c7c745@geanix.com>
 <20260804-liteon-ltr329-v3-3-c6b768c7c745@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260804-liteon-ltr329-v3-3-c6b768c7c745@geanix.com>

On Tue, Aug 04, 2026 at 07:02:14PM +0200, Esben Haabendal wrote:
> LTR-329ALS-01 is an ambient light sensor similar to LTR-303ALS-01, but
> without interrupt support.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

