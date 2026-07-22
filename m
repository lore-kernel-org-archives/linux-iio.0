Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF15B440A3B;
	Wed, 22 Jul 2026 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738837; cv=none; b=DTBCCJGImBV7Hqo+SvETwKKmcRc22WIUIGRinyvrBjf9m9+K7zzSniiV5o80van7Z8uUkUUijlQgoBwEt8vOXI+XBAwqtrZ87haN2k3fuW5LdeEBcfDx/Gdh1E8k8/e5mTxiK0X88viqL1n1v49wOsfmZaKjdKV8EvEy22zHhEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738837; c=relaxed/simple;
	bh=DY8xqd6SHcOFYoRK1Eoa+dYvqqTIQIJYtPdTm++GS6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwA5OeVlhu5JYsMD4fs+o8FZzQ5wcqcEycpZXrqaB9yMkNPUh4DQBAgfFnDNboAbk/RVGiSfTivLJNQ9UAOz2+UjxvQSDp4juv08xgy5TtH6YDMenKIevOTR/wtbFKcaJD19zsXsnfApzJXr5FK1cMl3Lppgp1O+Xfaf4HnabJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6uU049W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6uU049W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85B61F000E9;
	Wed, 22 Jul 2026 16:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784738827;
	bh=DY8xqd6SHcOFYoRK1Eoa+dYvqqTIQIJYtPdTm++GS6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D6uU049W2W/dEfDdSBt1c6SEql+u3XorFj7vlIIIOa7hd8n4y3VQvd6SE+ao4I8MY
	 7dB8bkdc6rTbg3ZYGc40e9WsIaE8nqPeXNle1Niza/GC1GTy/nNI9mtVFx3v2ID8b7
	 EckOi+MEKhnxPcLIvxwNufazlw03d/qGWY6FEQfXoDWDVGbFAAgQU2No4DdMQzQxEx
	 N3/1bBolbbyKPg2H8616Bf0A1TKtCuJ6rvNLpHDzfQooBwTsmyIAZWaVRF51F4Qnmm
	 KtLwzHcVMzsgsVt66/LucBy15emfqe87YDiWLJ1fQr92+dRFERp8rvSnpizOoobEX5
	 8TwoMM9Dlv2ag==
Date: Wed, 22 Jul 2026 17:47:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: add support for mcp47a1
Message-ID: <20260722-onyx-santa-30a8a9cc4352@spud>
References: <20260721-mcp47a1-add-support-v1-0-da045a2567e3@gmail.com>
 <20260721-mcp47a1-add-support-v1-1-da045a2567e3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BKwGVlM+4GIj4wwD"
Content-Disposition: inline
In-Reply-To: <20260721-mcp47a1-add-support-v1-1-da045a2567e3@gmail.com>

--BKwGVlM+4GIj4wwD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--BKwGVlM+4GIj4wwD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamD0BgAKCRB4tDGHoIJi
0qiLAQCtbK800FzLt5vXrOxe4KdP4DKE82PaUHmzeJShbyXmTQD/YXFTRqj1Czzd
FsmyYIRVxNORaCk5YfQrlwjCGkDr1Qs=
=aMmd
-----END PGP SIGNATURE-----

--BKwGVlM+4GIj4wwD--
