Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6323CEB89
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 19:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921639; cv=none; b=nsURAE6Eqr8fZ+RtCWeLocDhXtzjauCb3QpoqJMXIrmlHU8OnS7SDlSuRFWNsxGOBpgBHWivqC9yJuGX5NlCTYt+WnPSbMF8Pky6VuMoq2gO90OW+ilbYnJk7kide3C8R19AcdMYXD5j/kvqly8Ea54PePTZEJy5D234f9W5Mtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921639; c=relaxed/simple;
	bh=MaQA2bax7/HY1atZX8vJcrsP81L6v3RpRcc08f4rofE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vy8BOlba1hXu722hT4vNY+nkauzeFdoQJg0fOhiWJjXhTNmJYyDJcfC3JOW5+8BO6mK/DKyQvCtTazeITn+UIQwTzWi2pNMSvWZfMFjzTOoazFYxi562uiHDXAFW/8xOU3lxqNykdHzEgYbjiUSZCZuCp4dS99Fapye8A7U4NSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=DvdNEBc6; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="DvdNEBc6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Uc7K
	iCSBEwHsX9SXU/HfsX5c6hv1GOLfiIT/62l6d+A=; b=DvdNEBc6JE/1QIc0NxDg
	DwS+B6BOSQcwRc02daEg6DydT8vURep2Fwq8sY/Jeyly6nJi33ELoNMnIF2NhZQG
	ZgoBeR0j414aQ0CodJbFfYrgEeJ+cZMET3OKkE0oTqwJigohy7iyYsZECvSMDuFv
	noOXd1MtwSZUgvKJnPnGJMBnKL/LaMnHmvYXf++h5hC+HIvp9zo7RrXHz5PYrnIi
	X9Tmb1RrrY8QYo32nsC1cKmppPJIICmtj8zXOkpvq9BLqQHgVhhz6Uh29BiHojNM
	emMLLHoOjGd8uLBKaW+mJFLVqfD8lH0pUWA9EfNjjl+1q1UHHyeoO/62/9IS6+UU
	4g==
Received: (qmail 2337909 invoked from network); 4 May 2026 21:07:12 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 May 2026 21:07:12 +0200
X-UD-Smtp-Session: l3s3148p1@GOlSowJRYLcujnvR
Date: Mon, 4 May 2026 21:07:10 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Peter Rosin <peda@lysator.liu.se>
Cc: Peter Rosin <peda@axentia.se>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Linux I2C <linux-i2c@vger.kernel.org>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update mail for Peter Rosin
Message-ID: <afjuXkgkhnRX6DDu@ninjato>
References: <7ddc5b09-b6c9-99f9-d951-6b3ef96f8c1f@axentia.se>
 <afhUW7anAEURM0Gz@ninjato>
 <e8f64a4f745ebfac9395906f19d1b586@lysator.liu.se>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T9P4MEZC1fQfA9L0"
Content-Disposition: inline
In-Reply-To: <e8f64a4f745ebfac9395906f19d1b586@lysator.liu.se>


--T9P4MEZC1fQfA9L0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peter,

> Thanks! If anything, I should have more time to spend on the kernel going
> forward.

That would be awesome! Your in-depth knowledge about I2C muxes is much
appreciated!

> However, right now it feels like everything is in a state of
> flux...

Good luck!

> It would be convenient for me if you could take it, thanks!

Sure thing. Applied to for-current!

Happy hacking,

   Wolfram

--T9P4MEZC1fQfA9L0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmn47loACgkQFA3kzBSg
KbZtthAAtMtusLip7WFJMBrt8R4FeVkWpjlX27g3idAb5JELMhDs1K1Dd5Ygv8o7
WVXpMxHgdpppH1VAwZPUGCy5XWnZyn4l3OccfiW+gD9c4NLRj+vr7WcNKUIeynzX
1/hCZp4b1lCT/n5buNUDKx+aQiv5v2w19KqPClC7ZvjPBTThp8WjSD0+oBmxPN0I
8quZT5CqXBumUWzaSH2nSrzVJk8J5fH8L2I85NXiHzWNywlIVXgL5IxZtcznWfhT
f7wU3Vc4DCR8ex7TmzmoN6V+bIKoGAMKagn1M4h79Q3ZUfQeX79HTBEBQXJSig1C
L+EZXTwY8Zy9xTHT+dpcvXQ4gF6Z6b6t9tDW3A+eQ2XhMHGpjmbmrCJdYeOKPDYK
I+2t27xtE5rXMG9UJ1pzwoNvMqHmwXdBcx2vZBLlM47QNXkP0EGEv/5+gZLGBIoo
xTt7PjKq13QIJjCjvbrJQH2zxj+SoB3vgi1io1ttmdb7K0YnZhEiMDyphD+q/7Bp
RJKOHh2IlG1NYK+WDJAtEdJP/SkYmuzmteOkzb14GHAlkElJsY461ZSPY/A4tN1F
BOOVIKJjVZGEObZZrqIylBxrrJxC/fl4VeFtfoau9st7mBVOSpurog5cQlpZ85t2
24T6j1RjXySBnPtDbMWyMWz/+rvI+CRNKLp8puqqJrUov8884k0=
=ojwD
-----END PGP SIGNATURE-----

--T9P4MEZC1fQfA9L0--
