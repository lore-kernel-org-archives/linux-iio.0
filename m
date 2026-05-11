Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F922F8E81;
	Mon, 11 May 2026 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516528; cv=none; b=hFd4EL0t8ZJUJu7rhGIpgrWOLAcwnYt+y+JwRAPKFJNPDqb723OZ40ZvXOMj9BeVe2Rl8Gcmf4WoOQHhRkIp0+VBdIaLQaMXmtHi3W/YgXJzpNAjMQhPjRBQVFJbzb098n75N/58eY03Z8sf3IU0DWT0azUcDkzmKrGh5cmnYo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516528; c=relaxed/simple;
	bh=hNI+NwbnCKk3QkTOrW6RJOSqz9IB7LOeVKXUvtRvS/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkEFsjqkT/S/u4ND+rvSs/pHyXNkttWYawe39GwWl3sWaAaEgj15yWDVak2u7MTgoW/qo3q9VomAFvSmhki6r80Igs70ADvFkQXFxGJ7Iq5aETm/ArZYGgiwUCsARLHL28wnhOPpRMneLzIjbKF45IpzvmUpxQQv5KmYGLUxIEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzNetBWg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzNetBWg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9D9C2BCB0;
	Mon, 11 May 2026 16:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778516527;
	bh=hNI+NwbnCKk3QkTOrW6RJOSqz9IB7LOeVKXUvtRvS/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YzNetBWgQLKYDxBTjeq0je/Q2l87GspBOBiiLMsswtk5mEF0Nam5xdkesdfRbJkR5
	 vNYdG2RQPMOo5y5zklTXOv7/RZTgIH1e1Fo+33SN3xwUXucUmZcUF/ZnV7z6d5I4QP
	 SCoIyStu6bpD5xQSxeFsg4iSLDdue0YBpYn9pk1cForcg/XgSCAKELMtFWF0QFnezF
	 2xqe90ZkrYFJw0SACsQTIWSt8I/Yt8QDYhgBv4jA1MJSLdc2VGlC6p7rwAhzY+PE+V
	 TBbSEL8E+z+j+5X1tE21M7y+ucLpSR9bEcklp3ultW6NfuObg8WZ/mQF1XuKJUeLK6
	 mNRdpYTsIfOWg==
Date: Mon, 11 May 2026 17:22:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	skhan@linuxfoundation.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: iio: dac: ad5504: add output-range
 and missing gpios
Message-ID: <20260511-snowbird-exerciser-0f85f207107c@spud>
References: <20260509142047.30302-1-0rayn.dev@gmail.com>
 <20260509142047.30302-2-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w7e434qSKNixQoZF"
Content-Disposition: inline
In-Reply-To: <20260509142047.30302-2-0rayn.dev@gmail.com>


--w7e434qSKNixQoZF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 09, 2026 at 03:20:39PM +0100, Taha Ed-Dafili wrote:
> The AD5504 output range (0-30V or 0-60V) is determined by the R_SEL pin.
>=20
> Use standard output-range-microvolt and range-sel-gpios properties to
> describe the hardware configuration of the R_SEL pin. Ensure mutual
> exclusivity using the not/required logic. Additionally, add missing
> vlogic-supply, clr-gpios, ldac-gpios and datasheet links, and provide
> a complete usage example.
>=20
> Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--w7e434qSKNixQoZF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagICKgAKCRB4tDGHoIJi
0viTAQDniLq9yhFzruNh/kCFZdZLYhei1kSaHfBdkNrJ2SHj6gEAu38xh3/OOzBv
Hr2dGTmx9DibvHKfFlqGWsLU5o1q/wQ=
=AEPN
-----END PGP SIGNATURE-----

--w7e434qSKNixQoZF--
