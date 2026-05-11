Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A473CF660;
	Mon, 11 May 2026 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515768; cv=none; b=Iosp95vIeCjF22MlTUIzJQNomnduCJmq7OOmJRqNXV2BJrNmVyuxKpEfLUjMKtFvnzhHY6hc9qAj0G3l+c+TnN99d7NDoyxTE8fgSttdkv7VD/ePBtmmbSIBrnUnLjEbb3vAtRaT3Ayg6bXY/SM1NX1ZWh6VCid4ZuAJ+hhjU60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515768; c=relaxed/simple;
	bh=RueI/tStFFd9KbXRd/tRjx9kLM4QD6r32gbrO7HC5D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uv05wVEA4DZyNYYeXZvVh8SV/KmTjtqJyxinqUEyb5wct9T3+F4nq+nwWkurbzv3gyfCYnyMt9HBvK1r7qrjdVjWbIWTZX5xd2RJA9jljg8zlCsQZ+DzUObTOMPMTlda3b4qI34wzzrO8WnXTLps4RL5/CaKb7eHeuoHtDfiStA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJJoMx57; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJJoMx57"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44D6C2BCB0;
	Mon, 11 May 2026 16:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778515767;
	bh=RueI/tStFFd9KbXRd/tRjx9kLM4QD6r32gbrO7HC5D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kJJoMx57TjstPM7i1egYz/Hk1Mk0tCmQu3UUnvH1NO5QFf5pL7yBdatk2tAqvwxYg
	 EPXLbee0ApBmYwaFeJZ7+81m3dwgC/WAIM6LnPJjsKMA0GwuonBtwelmphQmq9MPyy
	 /hac5FCYVnR1NaPuvg4r6FzQTyV27vg8Jd2mXc7NKOHb7s0OPpg4HOGndOikvqWhKL
	 lNzIdUsqacQ0eKqGUNRGV2VjE5TMRMXWj7HR0Wj/Nu/N9Xd2M2K62LjD6jchAq9M0Z
	 OOSkz3tRJMVLt50Ps69BjvpaKCEiyoeNJaIivXPIa0ovYs6XoFKohNYzy2uLn7sFOv
	 dAVQsrWdhAIfg==
Date: Mon, 11 May 2026 17:09:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, andriy.shevchenko@intel.com,
	dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 03/11] dt-bindings: iio: adc: hx711: add RATE GPIO
 property
Message-ID: <20260511-arrogant-unsteady-9e74d177ec4c@spud>
References: <20260510194947.31997-1-piyushpatle228@gmail.com>
 <20260510194947.31997-4-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UCondWJZnazZ/d5T"
Content-Disposition: inline
In-Reply-To: <20260510194947.31997-4-piyushpatle228@gmail.com>


--UCondWJZnazZ/d5T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--UCondWJZnazZ/d5T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagH/MwAKCRB4tDGHoIJi
0myPAQDJZ8t5fqvzzZJe3Hxx4FJ3aZ914lly0KuwShE6zl+T3AD9EiqAw6m2sLrs
EtWyOIK6dmAVln1tD/D1xud8wVKILQA=
=cCMo
-----END PGP SIGNATURE-----

--UCondWJZnazZ/d5T--
