Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795023498;
	b=DL2wPAjnOiEZ97nDSvUEUDMA52LfD//QgQii+34aCOlUANuKUauW+DLbNts9S0KJjpgn
	 HOcq5EpBBKLuu/v6QTau6SFZjdF2cK1k6DCPfbLzP8BTb+TScDorD5KnLGARK4zEH4l7r
	 Vesac6Om9jaJg71RgjnydLMO+kSciioECInttwc7sOTEYBhM6vHciTV1OWxzTWhbKwflv
	 MY4AqFpLfI0NxhlmddwGRJUmdV1UCTdI6oD2sVPp/+eE8UjdjCjLtIdxgQ34C4bTU/VLF
	 +zqgACAkpI5znXhbIpy/ePenfgXStVf2btZFAoE5uUZBTrCgVsQxpRAKg/wW0ZTKTsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795023498;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5jm/rxQr2VvQntcLYkFVPvvN8hpQcPhQsQlNKsoOAXU=;
	b=muiTHSrDrOqNzzj3/mlwe48AKE7hbw3aSc3/K//21MjsMxJuvEy4WKSg9309XELEXJq6
	 RnYsyEqFMQimk5SjfPq5aVotrecQtR3sDo5eR1BnNcfL/aTu5W3FyokwZkXfvBA+c9a+j
	 fIxY8yZn0BxXg+lwvLfl5+5G7D/6wYN7KXyFdt7WwWsD4qjTFoVM/oSxodtB7ekUCii1P
	 cnEbNqmdWhOnhclUa0njlCvkk5t2un1KhbVjnKaUUjNaAoQXvTSmNyVTCJWqkAyxVKAD6
	 feyudD4+CmpUkaPqhl2d5jNUyi1TaXrsQi/PBP9VY7tnGq4gygnDvnVNm7+9E5mbWKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NntEwtNo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A46606A331;
	Wed, 18 Nov 2026 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NntEwtNo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B555C1F000C5;
	Wed, 18 Nov 2026 17:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795023498;
	bh=5jm/rxQr2VvQntcLYkFVPvvN8hpQcPhQsQlNKsoOAXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NntEwtNoQdE7XRlHzBua4AwGqpBeaj5fBM6BuQKsX7QhJtOg4saRzczNC5iK2igyx
	 4yu/h0OKm2+l8D+YSfHxzHCQgVvwF5Fuhca6FLfCRxva855uHzshnnSkedkvt3ad7m
	 eG/lgTAJP1fu2d+3cpBmEfNW496CjEInB7hfpQjGKJOgarpR68QeoOu1Kv55xmnOgC
	 y9jo2OT8W3BD5Uqqt9ZFDxE22D0YPY6/LiNb2kHNwXehnJRcS+MBQepTjX/rqzo6Sr
	 0ss4vx8kW4IzUFqIWgI0+lJ/lbn/S/Adu++JmCWL9gXgtd6yPYwoNVuPd/3YHiymJ4
	 MrFS8vGjE2+lA==
Date: Wed, 18 Nov 2026 17:38:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux@analog.com, jic23@kernel.org,
	Michael.Hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	olivier.moysan@foss.st.com, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 2/5] dt-bindings: iio: adc: Add AXI ADA4355 IP CORE
Message-ID: <20261118-salon-legacy-12c1fd718cc6@spud>
References: <cover.1795003864.git.marcelo.schmitt@analog.com>
 <965f1ed0aee21bf9bb758aba0c89d60bb1e3dca1.1795003864.git.marcelo.schmitt@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tsYAWHTlxYRCfu4s"
Content-Disposition: inline
In-Reply-To: <965f1ed0aee21bf9bb758aba0c89d60bb1e3dca1.1795003864.git.marcelo.schmitt@analog.com>

--tsYAWHTlxYRCfu4s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--tsYAWHTlxYRCfu4s
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCav3ihQAKCRB4tDGHoIJi
0lo4AP9kHQpvzTq6j7K1GzP0zcIFnsaSfdR30McvV1MQdVvnfwEAheb4ZjDaTdUo
ErNuk6KpxjNcjCD/9tdhP2CudtNrTQY=
=ASwu
-----END PGP SIGNATURE-----

--tsYAWHTlxYRCfu4s--
