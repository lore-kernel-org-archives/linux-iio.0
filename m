Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAED4052B5;
	Wed, 29 Jul 2026 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345293; cv=none; b=laX6Af1gNOQIiu9Pctbk/WVabJbweFcXQ/XlCHvpeBoA6Y4xpXyo3l2eYUakQSQQzgViteowbX1XtoT19P1wDTaTTwJIYkgyn2jHGBsD1KJSWPiVGVzkFLip8WezM6RIsHwcJHmAlNz5cKYJKMSJIYXi8XZKHSMi6D/LMeZByUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345293; c=relaxed/simple;
	bh=SYHfsqLre1VNwCLVMdD9iEa1fyKuVtkoYSnwjEAEpUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qatp7jldbKoarKYObmdpxsOabkBj/jS2v5XSUi3Ue8mwKlP9tGI4ZdpfNNilUQFPyIHE5bpvVxhx531Fb9bChoTRH6cb3FXZDI46n2OQrVUfjsSQSZR/mulo1yDV5IeGr3ZcjeyNP+GrMhlUskkOJHfnV2sDBXXwbxDf3zTuoJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/l7FNn2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/l7FNn2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF041F000E9;
	Wed, 29 Jul 2026 17:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785345288;
	bh=SYHfsqLre1VNwCLVMdD9iEa1fyKuVtkoYSnwjEAEpUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O/l7FNn2wFLiZzwepTKYziAUXH8U/SqldYq/CS1BmllPkQYim7815qKp2QqvyCOQu
	 hmqlaLDeTuth71Dj+AVdahccmDqFU6Elu+8Gc+gv1VZp0ECMMUy2fpko9kA/Y3Tv3P
	 Z6HLq0u2jXWNsjd9R8SE4KJ8Ss8629EPfhneU73xnro2GVju09vwDrh+kZr5UKoc/+
	 ob1Q2Y6icc3m90YWi3HqayB8a2Yu0hpyQj2l0JrN2ChcgmRebcXdTx9t9+LvveELSA
	 gklaNZ+z0PShKimNsQuHf/7kgcpmQPYZGvOiA5USYBqhB4y5d4YpFBj8NWmzcpEjRr
	 3FhiEL0Dslu5Q==
Date: Wed, 29 Jul 2026 18:14:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Luca Weiss <luca.weiss@fairphone.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] dt-bindings: iio: imu: icm42600: add icm42630
Message-ID: <20260729-crepe-finch-b2fdda5cf48d@spud>
References: <20260728184351.75015-1-jorijnvdgraaf@catcrafts.net>
 <20260728184351.75015-4-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OPeCChbmr9OiJaSn"
Content-Disposition: inline
In-Reply-To: <20260728184351.75015-4-jorijnvdgraaf@catcrafts.net>

--OPeCChbmr9OiJaSn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--OPeCChbmr9OiJaSn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamo1AwAKCRB4tDGHoIJi
0nkCAP94ZmpgJ6E6Siskba++0VwApcOJlTVZFj9p/XH8+p40oAD/b/BRsz0fzGxm
GzJXpOk5qJ/yp1nTC63b9Whd8wFDTQg=
=F17L
-----END PGP SIGNATURE-----

--OPeCChbmr9OiJaSn--
