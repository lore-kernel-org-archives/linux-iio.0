Return-Path: <dan.carpenter@oracle.com>
Date: Tue, 13 Dec 2011 09:33:50 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Johannes Tenschert <Johannes.Tenschert@informatik.stud.uni-erlangen.de>
Cc: devel@linuxdriverproject.org, linux-iio@vger.kernel.org, gregkh@suse.de,
        jic23@cam.ac.uk, jbrenner@taosinc.com
Subject: Re: staging: iio: light: obsolete use of strict_strtoul v2
Message-ID: <20111213063350.GF3503@mwanda>
References: <1323733102-7868-1-git-send-email-Johannes.Tenschert@informatik.stud.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nYySOmuH/HDX6pKp"
In-Reply-To: <1323733102-7868-1-git-send-email-Johannes.Tenschert@informatik.stud.uni-erlangen.de>
List-ID: <linux-iio@vger.kernel.org>


--nYySOmuH/HDX6pKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2011 at 12:38:20AM +0100, Johannes Tenschert wrote:
> Hi,
>=20
> I changed the patch to use the right kstrto* as Dan Carpenter suggested, =
but
> I'm not familiar enough with the code to fix the divide by zero bug in a =
good
> way.
>=20
> I also didn't change taos_settings because I don't know it well enough an=
d don't
> want to introduce new bugs. So kstrtoint was used provisional to set it.

Yah, yah.  Neither of us know the code, so hopefully the iio people
can comment.

regards,
dan carpenter


--nYySOmuH/HDX6pKp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJO5vHNAAoJEOnZkXI/YHqRn5UQAKZYJJBgVoXkD8rV3Oq3XVdx
vl2rmTlrgILPGFNXXRNWNUL7N8oshoAFpY4ojaADiGBXLLBBF+IBt+QpVI5z9ulk
YQm79Qo9BGiEYQ2nB8HDpWxG9RpFQKOCygB3uonbK3sIMdtEcCutG+wWi9wU8+qf
SR0BRHbVMZWllPmPsNKvcxlglpks9H0KTFa4agf7N0bv8ELZC/gUfdKmH7jxiz9w
2z8Qoyc1GCUAzH3wEn2TNxriCAnjKNMf1JoktogFQ1xGoocBy1zvm2TjhC+RlUyv
PcgHN5sNsdWzkkAJyKFEwEhoj5bMfxgmpx0IAQT7LquMYyJnABeKeV5pFnwI81o2
ZYqUIJqJGKVdDIWbM3QAdGdHMhsLIdGwgEusCJEVHiFUolt3ow3O8Q+H8/E8sM2o
zwz1swzyMbXbD3HQ2qLri9MigtBHHmAtpV3UeFkXEyyl/9fQ3M1MRxtjI60Wi2rz
g1FQ4IOvwBqXDIPjBQYlfiBqvZVodpyIFeUqV14q4d+Eci3dimaQUmf7tICzYc10
sxWwiNRUakVW7O+tjIgEUsyDDrYD0rSzXTy7PQJ6uiolf1f+yYLw7dThfBsVRjwi
12OiPS1ztawuo527GTqnuPPICoL8JQE5Z4vzdyfDopQcoV44ohZWd3LOUJyvsyzH
IxtOUi3XfuFMlNA6KPbO
=aDlb
-----END PGP SIGNATURE-----

--nYySOmuH/HDX6pKp--
