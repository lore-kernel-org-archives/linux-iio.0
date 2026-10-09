Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9404EBACB;
	Fri,  9 Oct 2026 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557129; cv=none; b=o5Sy8xILy3z6jeaHizSCFCsTrJTSZiuGLCbkeOlaSf2HTnH5wqk5eS96edE8rl+k3hb0yLPhpahMTbuE7guIRWWnNAOoxE8vQ6rYlOiJsKQnTiYEneDvcKRJunhnAlCnsflfWf9vI6UWvJ+SyY2OjbOcOgzqzqXLlkg8DpKKvRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557129; c=relaxed/simple;
	bh=X/invlmn7JQ6QIuT0e3PnTKPO1F+tMIf8Rkh+9cCNoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6titANppfP2/nDV+cFWGNl5njRJV05fXmKMQW3jy2EDBo/SZ2//BSeAOrWL1KB5wjQewzD5Dk0Ej+6nhzdAA0AaxrxrQMGh09dFgxMyYxvqfD8YSrvwTSfMY4RFT+mPwpckarYF4TARrGKuH65nN8nHmrrxKhvzSQy9/ElsQEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSR+BUD/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSR+BUD/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E231F000FF;
	Fri,  9 Oct 2026 14:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791557127;
	bh=X/invlmn7JQ6QIuT0e3PnTKPO1F+tMIf8Rkh+9cCNoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aSR+BUD/VxYmehKWB3W2fep21qhUedou1fwWagVMCtkC1aF0I6QWDv3VSNxmpIZMm
	 NAkCeLRkUTetWkvCI7/c0CAD+dWeLAbiVesYdsKwr/tnSg+9qVVTNT0yBvzpYssJTm
	 lbVeBuC7tk/WgQNK73RnJSFhkppyfAGsLlNziOXIQ3OHQhPxiRPzbkFIiay+t0hQeG
	 D8LV5XlPPyKeOnwwE6wwgzI4WuyghRrCajjNItvQwBTtEeALVVN82ZkqpwbeQaNKqf
	 rfG2etN/utEYndebu11r/aUeSY9zCujngKFP/zFl1NGGFjhUkV3Sl7xmQcc00zIs6P
	 OKpWyj6WG5CCQ==
Date: Fri, 9 Oct 2026 15:45:19 +0100
From: Conor Dooley <conor@kernel.org>
To: andrei.stancovici@analog.com
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Beguin <liambeguin@gmail.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: iio: adc: lltc,ltc2497: add LTC2493
 support
Message-ID: <20261009-20d3498f9746ec383b05c172@squawk>
References: <20261009-submission-ltc2493-support-v1-v1-0-3dad1d4b152a@analog.com>
 <20261009-submission-ltc2493-support-v1-v1-1-3dad1d4b152a@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="06nARaqpCaYiJuAk"
Content-Disposition: inline
In-Reply-To: <20261009-submission-ltc2493-support-v1-v1-1-3dad1d4b152a@analog.com>

--06nARaqpCaYiJuAk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--06nARaqpCaYiJuAk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasj9/gAKCRB4tDGHoIJi
0kh9AP0e00PO/Fuk9Rql3MLtPNs4Wia7c0pspwu2p04CqqiTmAEAox2eRRpgQLZz
pxXKfcGY3ECW98C4KyLf3FCLJVGCKAA=
=IXUP
-----END PGP SIGNATURE-----

--06nARaqpCaYiJuAk--
