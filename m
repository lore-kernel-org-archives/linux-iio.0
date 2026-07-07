Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF8D3E5A2F;
	Tue,  7 Jul 2026 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783440704; cv=none; b=tS6RVMiuHIJ74zLSua/GSCtx5QrwR2TPxbQEvGcxlG+essw+nENuPJ/EWst8OMZ1IaWJiiJdhFomYrI148kdjqN+yGDJHmaF65EB7cn0kkkcksAwKlfVhiga10IB8OTvY9mQY12c6zPXVimNNkZMxBU5o8S85iOn5X8+aX0PqHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783440704; c=relaxed/simple;
	bh=j4QRAqlphOVdxlFtfWuqnxqYr3ZFc1O57I0+MMovv4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qf5OG3YZV8TuoRKBOaFRxyKY5IQ94a2bj+JUEznY5QS4mCumUnyF+GuX4Uf8bZq+WD6nwj07p3aKFvIfaoXgAqtjsvfvQYz9NTbqz9FXxBpVLYMDCK7fPW8LRCo9/Wb/EtyORsUbWJOwpeR4ykXvKCzgNiwUA+nDVSpOfIcQplw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MG1lP1W/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MG1lP1W/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBA31F000E9;
	Tue,  7 Jul 2026 16:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783440703;
	bh=6kfZL1bZ61XpWYYJGI0POi3WJq/TiN8givamjNPrHAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MG1lP1W/7uLLeA0rkDghFWu342eAzwAshaZeHgtEZEhDlQkU07rHc1Qj1VcanOwzl
	 yd2TRQjq8RekF5lNl8lJZXBZlEL25v/GwClTDLpI6nlvdS2biAtBeKDqDHItyRPR9c
	 dzVbkPd4za7tuZsAWdDgDmw9Om2K3edWcg1lQmGteIN0wRS5rQZFIgtHHYMwnPFrAx
	 tnaWIlc1wccBs/php+aO7E9zwUClYYN1f6N+XrHn83cyVNBRr9McBKqs+oYCX4340a
	 dQ79VsNNllu4H4dxYNPC4RfbIXsqYfCnCu82e5TAMn4qGLNn1uun0e5Xy1nfr22gbB
	 Tv3J2kvmdM7SA==
Date: Tue, 7 Jul 2026 17:11:37 +0100
From: Conor Dooley <conor@kernel.org>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v7 09/17] dt-bindings: iio: frequency: add ad9910
Message-ID: <20260707-frays-backtrack-2de75efdf7be@spud>
References: <20260707-ad9910-iio-driver-v7-0-a4ec30f63700@analog.com>
 <20260707-ad9910-iio-driver-v7-9-a4ec30f63700@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/httJea6x0BUcb5z"
Content-Disposition: inline
In-Reply-To: <20260707-ad9910-iio-driver-v7-9-a4ec30f63700@analog.com>

--/httJea6x0BUcb5z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 07, 2026 at 03:04:30PM +0100, Rodrigo Alencar via B4 Relay wrote:
> +  adi,pll-enable:
> +    type: boolean
> +    description:
> +      Indicates that a loop filter is connected and the internal PLL is enabled.

Is this wording correct? Does the PLL come on automatically or is it
turned on by hardware? If the property means that the driver must turn
on the PLL, the wording should be adjusted.

Otherwise, I think this looks okay.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> +      Often used when the reference clock is provided by a crystal or by a
> +      single-ended on-board oscillator.

--/httJea6x0BUcb5z
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak0lOQAKCRB4tDGHoIJi
0qANAP9Uk92hW2LOjGog5MGOFzrayer8+G7MEwUnHeEprda1hAEA7JV6ox+YpaU5
0qAb0GHK6iBPbQnP0wV/dBrA1CaH/go=
=aVDG
-----END PGP SIGNATURE-----

--/httJea6x0BUcb5z--
