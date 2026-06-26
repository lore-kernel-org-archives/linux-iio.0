Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658E9373BE7;
	Fri, 26 Jun 2026 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490260; cv=none; b=AEZ7n+6DNV7Bwt2QC2rKfuN2uz073a6wzP5ZxNaRDHcwrU7BAC/bN3dtJNTVYrRJheA8E/rQqMIL+xxfcPmjYlR5oymRgydGlQtSbFh8l/VcwfuawucQ7G2qrC04fdbBxixkg4OPUNEcAvViauS7WRvIlj5W4FFRy4N3Ij1wC88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490260; c=relaxed/simple;
	bh=2iG9vhZhYfK+VPi5tVXd8XhzAgk9Z9f1StQL7u3uhGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhgWwX2cWhOmNjzIebhz4S2QIJYB4VIEwSsrg+EFw3dq3tKcE4wgy43YosIhqxD0EOhAtjI3/K9Z3ZBYgtDdFdLB6FetpHAOzu2kYUF8W39trdjxS/mvMvX66YWgS+Y95r+0iMrmFDA291tj7yWFGgbs7ZVj/a1r93xfcXl0ueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMPNUbuG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMPNUbuG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAF21F00A3A;
	Fri, 26 Jun 2026 16:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782490258;
	bh=2iG9vhZhYfK+VPi5tVXd8XhzAgk9Z9f1StQL7u3uhGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DMPNUbuG+hH3uTW8pJm/zOT3UW3lxWoOyrsgUf8Bp/2JfYjZcjMOewKFn1+6hI7bK
	 w6UydV+6KAEwohbOXhSa2N6MLvgT6Uq3Ax8/2RXZUoFce38UmMW8M//cPCQcsaEcJz
	 nHGqOabN9pI/ZvtsuXdi22NZTQtApwybkl1GEdaKjjLQL2nsT9FaxJjONouLyjycWD
	 G96HXT1otReg38eM47itl2J2Yn9R9kaqRulL5DI779QEpfgLXlyjUZYmGgXBofx4g4
	 +dJxOZ/++or43jfYviqPKPXxhUXeIYdD5vxp2eOHB1DQRoqQ7nU2KEtaogx6+2jNDM
	 zvVn7cIG9cpgw==
Date: Fri, 26 Jun 2026 17:10:53 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chris Hall <c-hall@ti.com>,
	Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
	Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] dt-bindings: iio: adc: Add excitation current
 sources properties
Message-ID: <20260626-renewably-gothic-4c9e73d715b4@spud>
References: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
 <20260625-iio-adc-ti-ads122c14-v2-2-ceb9b0b561cb@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NcCStJu1Rj27pno6"
Content-Disposition: inline
In-Reply-To: <20260625-iio-adc-ti-ads122c14-v2-2-ceb9b0b561cb@baylibre.com>


--NcCStJu1Rj27pno6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--NcCStJu1Rj27pno6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaj6kjQAKCRB4tDGHoIJi
0keOAP9syTKJgR98U5XVmy4bfNckX/CHeTn0aia0XQT+2KXvEQEAr090F2/1LS3Z
vMZUfZLddHyFwRsbtw6Yw300GmM2fw8=
=pWmP
-----END PGP SIGNATURE-----

--NcCStJu1Rj27pno6--
