Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE253B8BB9;
	Mon, 12 Oct 2026 18:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831466; cv=none; b=rE3ufXzG8a1p/sizIp+ihu04Gep39u6WjywVyB2dpi4ectnM1WTK86D2KQj4KhYwbR4UGePfHxMv5rf2dxPbjwsPl6XjidgPsxnCVkTjONuubCOtKiRoAF76ztsRtzTK1Ka4AMq+9qbtIsqrlsF6Y1dYo3M+u7jbGlg0RfL3+tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831466; c=relaxed/simple;
	bh=17RsMguCR2x3mMSG0HcVG1ZEXRseai+6MNI3JRjpoI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRorLwK6tPVsRFJpcr/kB6cVzvXbvGvYnxqrygpbuld1vFJ0EetrYdyVeEJ2Qo9gfAPZ/CYZrAU7KBbwFvEiVngLQl1Wfjeo0/o+hcvIJsTjNKVLdgRpOzRRi1xvUPgBQhlkHNDklvHM0IfFbzlJyoEpKPGwRDeCVMHhwRlB9xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRdegIyX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRdegIyX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354DC1F0089B;
	Mon, 12 Oct 2026 18:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831464;
	bh=17RsMguCR2x3mMSG0HcVG1ZEXRseai+6MNI3JRjpoI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cRdegIyXiviEW2mQT9dJwZQ8ysTf6cqkEc7/ptVaeBLyDZ2VAF/e3Fk5AltDNGHR4
	 YtweD7EMCYZfwFRwfCTT+9aeLJEQnHCYdU3MBRlo4uiNk2y8eKbxDAKDLj4WgS9Zn3
	 5yPGmjMGBuRTNgbK9dC9y/5rWdYZLi9mhGCJSxyPrIBX6F7+wM6HyWcfnLbN0GBPO2
	 Xanlo0ZYQ4j6dI1Ex6LvCQrYx8hvyRHSoE6e79Y8xhmrxK1sO23W3yXx48zdQqN2v8
	 Z9mt+rLFECgXTLcjhwLWGTgoQP6Elwlb43Ktir+sacR4C6qJ/BUBQDXFPizjtxUkUD
	 D/iuMCYA10Oyg==
Date: Mon, 12 Oct 2026 19:57:40 +0100
From: Conor Dooley <conor@kernel.org>
To: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: iio: pressure: infineon,dps310: Add
 Zilltek ZTS8032
Message-ID: <20261012-figurine-sapling-f9da3ff0b348@spud>
References: <20261012114550.1680054-1-paulius.zaleckas@ui.com>
 <20261012114550.1680054-4-paulius.zaleckas@ui.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8pnGVdZbnK5fRqUd"
Content-Disposition: inline
In-Reply-To: <20261012114550.1680054-4-paulius.zaleckas@ui.com>

--8pnGVdZbnK5fRqUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--8pnGVdZbnK5fRqUd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCas0tpAAKCRB4tDGHoIJi
0iIyAP9n/SIIYFP+FJvQjXD+/n0g5l4U8KF35Z9al0pK/TgCpgD+PMQn1Gcvt6u/
EL3jWkvLW8rNelwIwsV8GaXlhkJmAws=
=lBvd
-----END PGP SIGNATURE-----

--8pnGVdZbnK5fRqUd--
