Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-253.synserver.de ([212.40.185.253]:1264 "EHLO
	smtp-out-155.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S934658AbcALKPn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 12 Jan 2016 05:15:43 -0500
Subject: Re: [PATCH v7] iio: add ad5761 DAC driver
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <1452540774-26410-1-git-send-email-ricardo.ribalda@gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56941920.8020406@metafoo.de>
Date: Mon, 11 Jan 2016 22:05:36 +0100
MIME-Version: 1.0
In-Reply-To: <1452540774-26410-1-git-send-email-ricardo.ribalda@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="x3BWM0TCBHCxc6J26l3uGNup1bT4lom9A"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x3BWM0TCBHCxc6J26l3uGNup1bT4lom9A
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 01/11/2016 08:32 PM, Ricardo Ribalda Delgado wrote:
> ad5761 is a 1-channel DAC with configurable output range.
> The driver uses the regulator interface for its voltage ref.
>=20
> It shares its register layout with ad5761r, ad5721 and ad5721r.
>=20
> Differences:
> ad5761* are 16 bit, ad5721* are 12 bits.
> ad57*1r have an internal reference.
>=20
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Looks very clean now, thanks. I have just one comment I overlooked during=

the first review. When that's addresses feel free to add

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

And one wish for the future, please give people a chance a review and don=
't
resend a new version of the patch every couple of hours. This will make t=
he
reviewers life a bit easier.

> diff --git a/include/linux/iio/dac/ad5761.h b/include/linux/iio/dac/ad5=
761.h
> new file mode 100644
> index 000000000000..2f3702309d61
> --- /dev/null
> +++ b/include/linux/iio/dac/ad5761.h

This should go into include/linux/platform_data. That's where all new
platform data include files should go.


--x3BWM0TCBHCxc6J26l3uGNup1bT4lom9A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWlBknAAoJEOj3aLScRbOZMTMP/1OJ7Y4F/dVhc7kwtZkPlgk9
ao+GA0qNVcp5AebciIOsaTmJZXsMSn2dvBhePEDV49v6IaMOSvAgyaw1cirV+Tpv
h+2eN3ma8aXZ23jVcssyqvCafKTPZsTGt0f6qVALJZ/bSWQ6ux9UEHi91n3VhV68
cSLyWw2DOJTlV/hHQ11Wz3o4OhUP4Y40b9bgiQbizUnnBZZL8cmNk+OA/pvtaMod
7Fa7lzMO01yBmPOJ7DYprDxKm1bZYk9SFsLEyQjuKEcgukG8GCQv/XJ1LhSbjuNO
blxZusIT0V/CXB2ulN8LMOI1Qm+ykR21Z6AMpBdlQc9swFV2QF0HF09OhYprqi70
fv+OcN7UYGDb5x6iA6ff0bm3aY9ts5AGb9MkhyI0AySq9XAvA6MtXv+XDvj0OQa/
u5BJpHugcGkJMici4F/mE8MyYydj/dLwwfGcfstsQtoCpxB1FXe4jURWPCtfFcpX
hqzfi3d81FTru7+b1rOi3b+ijGIAcpfZ74F81pO7qGmcz9XmIdd7QSNZIWfQh6F+
dPdtEoHfXj73p4FAHdXzk4YyGV3GO6eJM7wMptHnceuoJmjTYj5IK3xh98l0Segd
NEmKAt/L7B0B4CCwFj0erFZAoRoDYTFtR2iDmcxk0D1Y/JueOBn3S/txe+kPhs2X
XvsXDz01Zf/aW39bMRhz
=D5ya
-----END PGP SIGNATURE-----

--x3BWM0TCBHCxc6J26l3uGNup1bT4lom9A--
