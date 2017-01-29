Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751865AbdA2QrZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Jan 2017 11:47:25 -0500
Date: Sun, 29 Jan 2017 17:47:19 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        linux@armlinux.org.uk, maxime.ripard@free-electrons.com,
        lee.jones@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz,
        bonbons@linux-vserver.org
Subject: Re: [PATCH v2 16/25] dt-bindings: power: supply: add AXP20X/AXP22X
 battery DT binding
Message-ID: <20170129164719.eulijkfarzrm2o6j@earth>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-17-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mukm6o4sdvqxauxt"
In-Reply-To: <20170127085458.18270-17-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--mukm6o4sdvqxauxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Jan 27, 2017 at 09:54:49AM +0100, Quentin Schulz wrote:
>  - added x-powers,constant-charge-current property to set the
>  maximal default constant current charge of the battery,

Since this is information about the battery and not the fuel-gauge,
it should use the WIP "framework" for information about batteries.

Have a look at the following patchset:

http://marc.info/?l=linux-pm&m=148411561025684&w=2

-- Sebastian

--mukm6o4sdvqxauxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliOHJUACgkQ2O7X88g7
+pqaFg/5AVesLB79ONhBfPfg6kUhv6wp4BXb1AVMLVFvL2Y6paxbG8XKHUvf6f1v
c5eE1o/bIi8ypjPEOZA7oA2DbcZDi5JlSU1E3ZHo0aC20SQ+olYqmHEvDPtP/s6n
mdCNiGGc3yUlzpISSglgdi1ApHYXMeGccBvbt7O8UcXK9ql6QcBLL8VQk0JOeUSr
3sfuy8pxOmheV+SaYImy1ZYxuMJlw5FQ1YxKqzk39pid2hwgpoZJVUStICBaVU4h
NdKCyM7b3qMye9L7Gj5nwnB9muZL2ptuyMa154dTZ+qfh3AmyYqbNacFUQqr4VsW
D5N+Jn7kIoaYYxBQYi/5St9Sv8/tdAf/gYdX60Dpbw0UzKXorF8W6mE3a0ugPPbb
VTN92DsIPZrkot6EI2wa8RdefGkl6nwCRG+928vot/Ubj9mr+jqJRQtHXdGb9gtc
LKSPrnj7jDd2MU4X6czgGP4ohdM/dY14GgK5D1ovAYF+r8S+GIu8gbkZiVYBFqUI
+AevtilowEctQ6igtHHdTOpkVM8VfX6QNXDz87mu1fs7gyj7Hx6hKvRqkVAXPM5A
1eS91GlXby6y4y+wg4NR1XO+6zTJzaw/T/+BtXrYQod1zXxaho6kCKONOaE8WDPN
gUpI0UVUQAaIrAftI854qcv8tSu6h+D5UW3ZMycMyA5oUme7Nl4=
=YaD6
-----END PGP SIGNATURE-----

--mukm6o4sdvqxauxt--
