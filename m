Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:48005 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367Ab1LLTPM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 12 Dec 2011 14:15:12 -0500
Date: Mon, 12 Dec 2011 22:15:13 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Stefan Hengelein
	<stefan.hengelein@informatik.stud.uni-erlangen.de>
Cc: devel@linuxdriverproject.org, linux-iio@vger.kernel.org,
	gregkh@suse.de, linux-kernel@i4.informatik.uni-erlangen.de
Subject: Re: [PATCH] Staging: iio/industrialio-core.c: Fixed call of obsolete
 function
Message-ID: <20111212191513.GE3503@mwanda>
References: <1323704459-32235-1-git-send-email-stefan.hengelein@informatik.stud.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kA1LkgxZ0NN7Mz3A"
In-Reply-To: <1323704459-32235-1-git-send-email-stefan.hengelein@informatik.stud.uni-erlangen.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 12, 2011 at 04:40:59PM +0100, Stefan Hengelein wrote:
> As scripts/checkpatch.pl suggested, there has been a call of the
> obsolete function strict_strtoul which should be replaced with a
> kstrtox-function.
>=20
> Signed-off-by: Stefan Hengelein <stefan.hengelein@informatik.stud.uni-erl=
angen.de>
> ---

This doesn't apply to linux-next any more.  Can you redo and resend?

regards,
dan carpenter


--kA1LkgxZ0NN7Mz3A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJO5lLAAAoJEOnZkXI/YHqRuAUP+wb0gzSCaTyOnMXADj8JPGfk
5eZPKFR3hCFq4G/x1auDnW5x2umVGiFS8hxVREEC6sau877M1HlqGbaNchFSHUCS
SnVjpIJerzsvtX6WpMChkxFSv4ZH8vgdGua06zW3mXWuKzvnGmlWhnxEa6AqTb86
stDr7KhKEjlKY7pqWcK6NS/kspbWD5rFDHDCWw0m4KG03QH8Cb0B1SuaVuhpY5Jt
9tqcZjzEFnBOb5gc5ghQBQBqEE54K8OXQ8bCHADSAlQA8fkNWopG3QUWySc3ETp7
EgZgEnlM2OE5etRrtYuZX4Bkn0+jAXGY1XcQTEYq1KT88x0DFhzFh98QfCS+x8Jd
s9a5emtv/TqR9cuHc620WlFY1NxaeiCQ0bfG8M7kYnf2d6yt/5RpkM7QHRLp8fHL
/gGJP+szezPREvQ1ueXhw6j8SR6jtEJLop0nJzZmr4MLEHCW3XvSU+WsMeK0VTeT
+qlHpqR1BrSqRRtE61ugNreMUKmPW7KpVCO8pJBj6hOaqIZzwfrbg69RGJDxy4Il
QxnndV/Wj0IAySvase+WXr2RlI/E7yEDwRyMeloSXoAS/qyDSwQWBT2R+ZAwcBBR
/QcP2Lx/5nWwaTt2QrGkrrmfzRtjCj0UdAqk3AVKTeD+5Bs9AunYhsjSwebRj0v0
xipk3Jx6VY+lD7BZps5h
=F8Ov
-----END PGP SIGNATURE-----

--kA1LkgxZ0NN7Mz3A--
