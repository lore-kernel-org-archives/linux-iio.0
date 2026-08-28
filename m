Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A4925B08D;
	Fri, 28 Aug 2026 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787934834; cv=none; b=D70S0REKX77wwPXV0rMS7Cqfl26ox7JPewUQj3/okPqX0dqWqehOgy8kEISUcJC0eGbBfJHo9WuGke5dynAMar/DrgldEha1z9netTVju3XbiqYBtTJzraSvNdNY+V/e4fWRbv53scqtGrmca6NxJuOta6shfZPeo0nN/c+Rtw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787934834; c=relaxed/simple;
	bh=SBU6jsnDKWUfibC77mHJzREMmsFLeFFhuGE43/dhO48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPPbH1159bgyAj2FwFAw5cHp0A536q4Hj0QCz1YXkWzflvBiKbJvgDnJOWgPr5LzIXwSx7tlkoTqYK1+tH8pWulaBzXC7yQ1FXGmYPRpvc9dPwOdkdYKlSfM4qPrWtg7yWzJcbVIoCwChJZEVRQvNQz08w/a46xiGPC/mL/YoyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oht7Sggk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oht7Sggk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCF41F000E9;
	Fri, 28 Aug 2026 16:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787934833;
	bh=SBU6jsnDKWUfibC77mHJzREMmsFLeFFhuGE43/dhO48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oht7SggkQZ+BOUPbsjElOGP8QH2lE9Q9+Ximl3fEVhxizBrlaAMgcKXOqkUeGzbDX
	 ACkCNpUJLSOql/9Z0RRdnarSyKi7KbVJMYcrfem8ENtzA9wNjbWjC8/cZJp/lpGvLQ
	 f3WuiyMPx6y2TgBx1CkY9rBo+V4kUo7SRZns7Mq3OzvcNQKXrnT0rzf1XfGN2IKrVE
	 iBUzse1qimvhb2YpEa/+v+FyRZ/v/hqBvbibEApOc72mKcO5FSsPKjNZymEojc4hTL
	 C2f+GpiwdHovzflyUEsQbJ7e6CW4K0Sg1N9q/6y3r6dZJEuPVxvVxjwM8i26b5PIVx
	 zAsANN1vpH+Cg==
Date: Fri, 28 Aug 2026 17:33:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/10] dt-bindings: adc: add
 excitation-current-chopping property
Message-ID: <20260828-gating-bartender-837320fe9f30@spud>
References: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
 <20260828-ads126x-v4-1-1dc27e9c0260@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t8AZS9rkuKrrOeIp"
Content-Disposition: inline
In-Reply-To: <20260828-ads126x-v4-1-1dc27e9c0260@gmail.com>

--t8AZS9rkuKrrOeIp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--t8AZS9rkuKrrOeIp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapG4bQAKCRB4tDGHoIJi
0gNdAQDLrfYiS5sUT/Ea6W0RQ8Q+bzgjGLStW1Z/NddcpO3veQEAgcVFpkYXyMq1
QMJVyt94blGF028zipF99pEI7DP54A4=
=zbfS
-----END PGP SIGNATURE-----

--t8AZS9rkuKrrOeIp--
