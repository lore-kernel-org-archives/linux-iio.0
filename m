Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751258AbdA2QYT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Jan 2017 11:24:19 -0500
Date: Sun, 29 Jan 2017 17:22:55 +0100
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
Subject: Re: [PATCH v2 08/25] dt-bindings: power: supply: add AXP20X/AXP22X
 AC power supply
Message-ID: <20170129162255.if2o2ta4wt2vetad@earth>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-9-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="glly4zgcqyavd4xc"
In-Reply-To: <20170127085458.18270-9-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--glly4zgcqyavd4xc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 27, 2017 at 09:54:41AM +0100, Quentin Schulz wrote:
> The X-Powers AXP20X and AXP22X PMICs have an AC entry to supply power to
> the board. They have a few registers dedicated to the status of the AC
> power supply.
>=20
> This adds the DT binding documentation for the AC power supply for
> AXP20X and AXP22X PMICs.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Thanks, I queued this into power-supply's for-next branch.

-- Sebastian

--glly4zgcqyavd4xc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliOFt8ACgkQ2O7X88g7
+poOxA//csQTqNEfRMTnV6ZIYYcCy6RntNXATJ2wJ5wbH+X98r7MsrrUYdBP1B30
Y6/TI64oE3VLdAcG+8XLEWM0YAXeCH3MGRR3YJzP7QsPxWps0SXUHTgimmXNMki5
9BKvqi5LRwzBYLBRn4uvpJF1P0lDQT1n7lWLSBB6vRETrD9Ztg1bNVYRR7NSmf/P
3HLOsSGon9ayxl9DfxObcwWW6a4NsvKLlRwYxUmhqmzRkLAjpXnTGrLnI6RZLL5+
/SItb4k41RQblHOzO1HhfgfmTusKmosuOIt6bnci0VxA8Hip4ZBMwmDZGSP0nLse
VcWQ8v83zyJx5Z6m1aksNp1XoVbo9lwbSuSRsn2OL4jeuxmD9Fyt91ZT+PySVlvo
vJD/Feleuu8IhHnGMjSUq/vlqC4rgzU+X6cxmWEiJnP3OxvyYcsw9WLg73b2qWnk
LQkFypqjsBqDxwghucyubQGsfzHyUf08RymcfFHXE0cRfxa94aOxoCjc1TJR1BGX
Vm58ZEY29WcVn/DNj9HHdOhJHnWHna/UOnRpBYYfaYche+B/qe3QqWrBuaNM6teA
EFxX10pPYlIFaKUjAiVT52Mtwc1UefAb/Tgf6zDNPplzk1cKBTz+ZsMTZVvOP7MW
za9X7zdzdT/qha4e+8RJtjPtGFUJxGj2OFD7seyExa5ihTIvFy8=
=xeUO
-----END PGP SIGNATURE-----

--glly4zgcqyavd4xc--
