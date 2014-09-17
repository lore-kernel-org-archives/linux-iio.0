Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:48783 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756223AbaIQTxf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Sep 2014 15:53:35 -0400
Date: Wed, 17 Sep 2014 12:53:28 -0700
From: Mark Brown <broonie@kernel.org>
To: John Syn <john3909@gmail.com>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <20140917195328.GW7960@sirena.org.uk>
References: <CF17C5B7.1940A%john3909@gmail.com>
 <52F35C5B.7080409@metafoo.de>
 <CF19225A.196C9%john3909@gmail.com>
 <52F3FB6E.3070201@metafoo.de>
 <D036210C.44F7D%john3909@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CN3FGaqzfdtlPLTf"
In-Reply-To: <D036210C.44F7D%john3909@gmail.com>
Subject: Re: DMA sampling and IIO
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--CN3FGaqzfdtlPLTf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2014 at 03:43:50PM -0700, John Syn wrote:
> I=B9m following Mark=B9s suggestion and using the audio API to stream the
> samples from the ADE7878. I created a small circuit that translates the

Please don't top post; quote relevant context when replying so people
can follow the discussion.

> codec and then modified davinci-evm.c link in the ade78xx codec.
> Everything seems to load OK and I see a /dev/snd/pcmC0D0c device. Now when
> I try to use arecord, it simply hangs and I think the problem occurs
> because the ade7854-i2c driver is in the IIO folder and my ade78xx driver
> is in the audio folder and currently there is no coordination to start and
> stop streaming, which probably causes under runs, over run errors. In a
> traditional Codec, the I2C and I2S functionality is in the same driver so
> it is easy to coordinate start streaming and stop streaming.

The location of the files is not going to have any impact at all, the
callbacks aren't based on link order at all.  If data isn't being
transferred the most likely reason is that the clocks aren't being
started which will be a driver issue.

--CN3FGaqzfdtlPLTf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUGea3AAoJECTWi3JdVIfQjnAH/2di1Y7LjR7yXm22e/PsxOHO
28ZuYDa2jYzdKFMcwkKQI+/PpneYcgWNa0ButMd5qS7EjtuO1t9RIRKt3YCH+246
yfnArvfFDmxonGxXSBWFowpG5jskuLMPiApL+wvcX/wdHxYDPsyeaoJJX+iJIaKZ
M5RlzYO8DFSZhbVuke0DqO1H8a9lgfTDqQVRCe7yOI2JX0hUcqWx68ZVhTSkC4YM
MAoGJNVjpIYUu+dAW9Fm07EfSSP1Nm/UGxAeHywMNZJm7yjZj6Xq4HyRnYezLybT
WIo6g1N4I6CDNMf/3hoLTODcAV9TfNyfuJMThhe4SNBzWNndsI9Xs94Sro8s3Sg=
=plAS
-----END PGP SIGNATURE-----

--CN3FGaqzfdtlPLTf--
