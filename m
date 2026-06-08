Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7273DCDAF
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931131; cv=none; b=Mv2Sn2eVcbu2XqYuME0o4tzjuv3bhW6/iuW9zHZJ1nlhi2wHAHsfk9b0LdqRJxcWlz78KCMpxOfL9iD7+pEU0qauQc8IsCO1MbQPsU0cqihsMFxx3S8H+QYP/QNNBz/NRumbkxqTxg4vpDmj6qYFk8Jmlu/GSD2W2FZfvrPbn1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931131; c=relaxed/simple;
	bh=RWEsvSAq7ltiLSc4M7S0u33C9h51EmAl0FCKmQlIJrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eiiJNkJm0lriu73RSgZv6juSsvtFoaTcKqG1ON9BhkH76RbTTdNdthWDO7YOX1tP/fI/15ZhNjpOreMoMK5/KivhmYagOeN8XP/00THZ3pdh7AOe7wFAbohxl4E8fKmem7w2oipfR923pvwXFXtjjj/OYomWj8OZygKpZVqseyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2g7NN/Td; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2g7NN/Td"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 34C19C5147B;
	Mon,  8 Jun 2026 15:05:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 25C525FFB7;
	Mon,  8 Jun 2026 15:05:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9E22A106A012C;
	Mon,  8 Jun 2026 17:05:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780931125; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=2iO37rqCp8Bs5CHZkoCFUdRXh+bredeUM2BucmQS/c8=;
	b=2g7NN/TdRn+HON9Qz7VDE8oxJ54eXQ8Xw6enEE3N39Bgcj2RHx9LNzvdVG6G+Kho9qkMki
	lLG7kSQKadxtVi6CCDnm2RxVpDGZTdXmnwgmvCWtPOnMxY/mUAVro3ojwULhBgaar6pG0p
	u3Tfd2Rlwnci14p9HX2QPpFHxC0C6A9YMkpHsxWceCx4d0g6JMwI8DcY1ASf+Fa6UA9N1Y
	azeBHhISVaj8/rE5Cvr5jXWRQYYifLCNGhS0DvgYPNUhhFnih8gEYBBxPTUMeWAKRKvXNM
	KAmcJqqux7555Mv8voJvUcHj4LmYNPNDkxNmnrLW7lyN9tCuSkj6fPM7X7eZwQ==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Wil Stark <wil_stark@keysight.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject:
 Re: [PATCH 1/2] dt-bindings: iio: ti,tmp117: add binding for the TMP119
Date: Mon, 08 Jun 2026 17:05:20 +0200
Message-ID: <0JXKC01fTuif-8VlbZtc5Q@bootlin.com>
In-Reply-To: <20260605152005.4d888f6b@jic23-huawei>
References:
 <20260605-tmp119-v1-0-349f45f17d12@bootlin.com>
 <ft-705oeTSiaftSGNjv94A@bootlin.com> <20260605152005.4d888f6b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPartkwe-YhX2RNmWXg_K9c85Xw";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPartkwe-YhX2RNmWXg_K9c85Xw
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 08 Jun 2026 17:05:20 +0200
Message-ID: <0JXKC01fTuif-8VlbZtc5Q@bootlin.com>
In-Reply-To: <20260605152005.4d888f6b@jic23-huawei>
MIME-Version: 1.0

On Friday, 5 June 2026 16:20:05 CEST Jonathan Cameron wrote:
> On Fri, 05 Jun 2026 14:24:45 +0200
...
> > 
> > > The second patch then just resolves the print that would happen on older
> > > kernels using that fallback due to ID mismatch.  That's fine but nice
> > > if older kernels can work with this part.
> > 
> > Sorry I don't quite understand: since this is a feature patch, I don't
> > expect it would get backported onto older kernels. Therefore why would
> > the second patch resolve the print happening on older kernels?
> 
> The point of a fallback compatible is that we don't have to backport
> anything. New device tree comes along that lists
> 
> compatible = "ti,tmp119", "ti,tmp117"
> 
> will just work. Older kernel will think it has a tmp117 which is fine as
> they are register interface compatible.  It will print a message to say
> that it found an unknown ID but then assume it is what the firmware told
> it, here the tmp117 fallback.  With your second patch in place, that
> harmless message will disappear for new kernels.

Ok I understand, thanks for the explanation.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPartkwe-YhX2RNmWXg_K9c85Xw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmom2jAACgkQKCYAIARz
eA6Kdw/+IvNTcDnK8CkAkEHWwWhIAZQYNqPrbIIAqQUnCoicoZaPGqof3+YMIsbi
jBJlkDj9LXlxB9RvjGBMt48PajUlUcB4jGQDXOGG94nvO8TFj43Nn5yHfJ3L7xZS
p7xbezI1Txhkfb3m8ddZ+XTGOH9lHH1+aBWf9uX0j12cIxfHAkhd21CdwRGZhsnn
MScyK1lCNfWpmShL+wOGK8hfw/fkJrKMKshSBJdNTdx8Nv7Ujj2qoy4rt0PYTadH
CAY87MUT5VMLQsgf+e1GFu5l0Qchb3URYPf6zexy5bPLSIYiAFXA20xUa7yxP64i
BuNR65pgET4JltJKUSULVCgQ97qnNoJuGiJalQ5pJTuvH1oDtJ/lPmpZ7NA2aUO4
XzpeNcPzgOVDfwDkS3OhgoV77cOS0VYTWl/GFZkKdCwr+FAQ0Vic5BvVhDKwCIlS
iONnF22RdMjroHFoer0plYV18k/9Itv72v5DjzQe7LSvHeeq4oh/Wo5SOaAClQwI
paA/fXXxvS/i8KNaaaHEm/UwuAbmEQ6aIgcLhjuelYrF7gg1sm65t6KLmuW/TF4K
Wr8sIn63QHwa6931mPkxUjk4CIXtcMb0BdFgFCrsvwbttyqdJh8CUNFc98fmX8Xv
43wYU6/ZuZZpx3oU4eNjEXEOV7VDOkFRPSfgmSaQGiJS1FnXYWM=
=X4hH
-----END PGP SIGNATURE-----

--nextPartkwe-YhX2RNmWXg_K9c85Xw--



