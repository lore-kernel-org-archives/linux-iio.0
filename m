Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60996 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028AbcGTX40 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 20 Jul 2016 19:56:26 -0400
Date: Thu, 21 Jul 2016 01:56:20 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Samu Onkalo <samu.onkalo@intel.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2 v3] iio: magn: add a driver for AK8974
Message-ID: <20160720235620.GA2561@earth>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> This adds a driver for the Asahi Kasei AK8975 and its sibling
> AMI305 magnetometers. It was deployed on scale in 2009 on a
> multitude of devices. It is distincly different from AK8973
> and AK8975 and needs its own driver.
>
> This patch is based on the long lost work of Samu Onkalo at Nokia,
> who made a misc character device driver for the Maemo/MeeGo Nokia
> devices, before the time of the IIO subsystem. It was mounted in e.g.
> the Nokia N950, N8, N86, N97 etc. It is also mounted on the
> ST-Ericsson HREF reference designs.

[On N950]
Tested-By: Sebastian Reichel <sre@kernel.org>

Do you have plans to take over the axis rotation support
=66rom Samu Onkalo's driver? The Nokia vendor kernel had Y
and Z axis inverted. Below is what N950 readings look
like:

n950# cat in_magn_[xyz]_raw
154
-9
-65

P.S.: Sorry for missing Reply-To. I was not subscribed to
linux-iio until now.

-- Sebastian

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXkA+hAAoJENju1/PIO/qaDXUP/ReOubpN64EfAGxtOzDCQoj8
UCkNLFtncg4DCcYNrbWcs7eEfRGfmBLQ6TZoDE+WJtiTt8JDABc0tBlI7jtqrPc+
nb2YUc48xibCG2bt+CzjVR0DSaQP1lVDZRYFJoFXuhY/4b0dzTYdGVoNgS3v/8Cy
702pnyVD4+17voSszwLzeTu933hePf3FbUNcjsKkIkbHjlAK4Hyfw2NqT9UVNG58
PlGodzXplf8bRH7yXCRam9BPJWX+Z1h1a4mHz/YC3xTrXV4qCSDssEB/lylYkiGx
YdR13HtavxPciZ1OOr67wN7itEEvYzPB77iD8YPAEE5xJdeEWCpSDUIJ4YXcoSYn
4AHpRLDlo/7WK0QhiF9LTVbRgmzS6tVnU+oQBcwQWpyfOpv+WD6qpFAZdu2eBMxw
Y+SCmdQxNusNFCQZz1+0MsFB1gMhua/cIUbGKLZQ9poaLsK25riqDlDO9LF8GBtj
fLIH7UxZs3qrm/BcgU1ntR4zKSY1P0msrHcPfA5NTSkUEBsCAhpq06OyzgdK2H4G
LXQV0apBK80nCn9yJYzwqVEBl5D/m09kpXH3kzZ40fIhnFMhOKAfr3AVEr4Phh6x
aTIkjSXKPkpOmfUqsVLuayFn9iHeoR9xasV260OSAQQPe/uE7GdS/jXDf/EqrULv
QiKJraefE1/9Q7m5d4Bh
=Oeoe
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
