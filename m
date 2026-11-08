Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794101550;
	b=kh6fooaTJdOp7TFl/aXVk7rPkPq9ryrePnGGrx+8bbRlPZL/LHcFoPvuMCMU7uLmeVrM
	 W5lK1ZwfCxsT2BWQoJE0J16yTL6ujjASaI/LldDyjuVOTn4Sf6eRCGypW68CfnnsukdZ8
	 LI6m98ypFOj3jLkuBNCUEjbxqELkA22OVE3bM6mapyqScdeXfQ5S988Q5TzjPpLQ4EEL+
	 nxKR3biEZKNDsegWHolcnUXnT0KGwU8jjPJFMFRGU3d8jqWUw46XWeVmpENIXD0OdGXGG
	 JgptBcntQDpSU9t5GxLzqxx3g/7eQU97iwXoYyXX73u4F9dHal5ip4vXIdwSJUNiQxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794101550;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZaPJ/QQGrlcBORHywt5/z/94wWCP27kjvOZeOT80sIg=;
	b=L9Oe+MFbivFhCXQX2lS9xj9RqU/V+SPddPiQGNOIgjqP3FVGsF8RVuYXBaWVQCbZhkDH
	 vylu2YkwnGmqIB3J0bi3KhbNu0OJhLS3frJxGV2hALHpVaxr6hlni8XVOrCUUq+qKNkYb
	 ZJuLbMMowbbz3LfeBazD2CjB6BLInWn4l/rjmme1CwXwmALEreVRYfolyZ64IH7QE0v+x
	 uVYBYZI3EzGpz9h8B+9xtYaTgfHvRuDlYpKlVHgnuzDD7oYcw4Lftj6RUAJ8J4s2JipOC
	 qi9Iek0cXmZj8P0ZEkUZjdtMMjE/ZpsUr2C7++C9fh/FaP5h1ROejInlMLgqv0uUCFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJtrwjnO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482E4606A326;
	Sun,  8 Nov 2026 01:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJtrwjnO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9571F0089F;
	Sun,  8 Nov 2026 01:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794101550;
	bh=ZaPJ/QQGrlcBORHywt5/z/94wWCP27kjvOZeOT80sIg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YJtrwjnOfZu4tjz2mSupEs5G6n2UBwUym7bFgUrQsS70mmZMor0hz0SNcTKT7LHLM
	 5Crpks0p/Zwrhs+bVrrapAD/WgDqLYihC1aV622SWA82dF5OshzyhZ+dA0MCyM3CEh
	 wVxiLNcALV2hfIeYCuhh3/8KUY0evkkJTMqzQ98gw+tukafdP2LxkHq+0aWjq70URJ
	 IgURoJ/gUJpJCffnzgjq6MT4Jq+U6u+ixuEFpWtDUFvJaD/M7ltb2zUB5DeSFz7Idi
	 wVTnOha6kjXFSMr3oS3nFujoggFyyGl2lquFNnMMEv3gjuh5vkFs9XyeiKvSPsyNw9
	 mUJ7vKEwHLZhg==
Date: Sun, 8 Nov 2026 01:32:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Rodolfo Giometti
 <giometti@enneenne.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Tobias Sperling <tobias.sperling@softing.com>,
 Eason Yang <j2anfernee@gmail.com>, Marilene Andrade Garcia
 <marilene.agarcia@gmail.com>, Cosmin Tanislav
 <cosmin-gabriel.tanislav.xa@renesas.com>, duje@dujemihanovic.xyz,
 herve.codina@bootlin.com, thomas.petazzoni@bootlin.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add driver for Texas Instruments
 TLA2528 adc
Message-ID: <20261108013218.0fe627e7@jic23-hlaptop>
In-Reply-To: <auyjgDddFs3OvnC3@monoceros>
References: <20261030164705.297354-1-maxime.chevallier@bootlin.com>
	<20261030164705.297354-3-maxime.chevallier@bootlin.com>
	<auyjgDddFs3OvnC3@monoceros>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Nov 2026 16:42:42 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> On Fri, Oct 30, 2026 at 05:47:04PM +0100, Maxime Chevallier wrote:
> > +#include <linux/i2c.h>
> > +#include <linux/mod_devicetable.h> =20
>=20
> Please don't include <linux/mod_devicetable.h>. <linux/i2c.h> already
> provides i2c_device_id and of_device_id. <linux/mod_devicetable.h>
> provides many more *_device_id and thus introduces a big list of
> unnecessary dependencies.
>=20
> I recommend to just drop <linux/mod_devicetable.h> here. If you insist
> on full iwyu, there is <linux/device-id/i2c.h> and
> <linux/device-id/of.h>.

IWYU is always a bit of a 'roughly' case in the kernel.
There are standards assumed sets of this header will always
include this other one. I've just started assuming that is
always the case for these ones.=20

Jonathan

>=20
> Best regards
> Uwe

