Return-Path: <dan.carpenter@oracle.com>
Date: Wed, 14 Dec 2011 19:42:20 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg KH <greg@kroah.com>, devel@driverdev.osuosl.org,
        linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] staging:iio: Add wrapper functions around buffer access
 ops
Message-ID: <20111214164220.GM3503@mwanda>
References: <1323684526-11134-1-git-send-email-lars@metafoo.de>
 <20111213004506.GA11553@kroah.com>
 <4EE7145F.9040003@metafoo.de>
 <20111213235926.GA23916@kroah.com>
 <4EE87755.3000000@metafoo.de>
 <20111214143144.GL3503@mwanda>
 <4EE8BB28.3060807@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5V5c01chtBAiSHoy"
In-Reply-To: <4EE8BB28.3060807@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>


--5V5c01chtBAiSHoy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2011 at 04:05:12PM +0100, Lars-Peter Clausen wrote:
> On 12/14/2011 03:31 PM, Dan Carpenter wrote:
> > On Wed, Dec 14, 2011 at 11:15:49AM +0100, Lars-Peter Clausen wrote:
> >> Marking the function as __must_check doesn't make much sense here. Sin=
ce it
> >> will either return an error or the buffer length. So you'll always use=
 the
> >> returned result one way or the other.
> >=20
> > Isn't that the point of a __must_check?
>=20
> My understanding is that you should use __must_check if it is potentially
> dangerous to ignore the return value. Which is not the case here, if you
> don't look at the return value it's kind of pointless to call the function
> in the first, but it is not dangerous.
>=20

I only responded to the previous email because you described exactly
the situation that __must_check is designed for, as a reason to not
use it.  It struck me as humourous.

ERR_PTR() is likewise not dangerous.  It's just a cast, but it
doesn't make sense to not check it, so that's why it has a
__must_check tag.  If a function is part of the infrastructure and
gets called a lot then a __must_check is appropriate.

regards,
dan carpenter

--5V5c01chtBAiSHoy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJO6NHrAAoJEOnZkXI/YHqR0C8QAIuLnefjh6Tz6LklA0nkd3Pi
Q4zLYrkRb/zrWTP6xgx1S8e+KTVF7puEgwbbGEOYVocp+m36//b311SIPVmBRwP4
eORpvwowuFdFqb6jxxXV8lGDvTDTz1EBqoSrn/SaQOdz3tRzTRVGQrQwtnvHrvFy
caGRU+GkeZXgIkOlCI7XlLEVt2lBDtWo0rAVYryZhFDGql4zcFgvK6A2bF6Ud1f/
w9C30uMAN7XDGa+EVZvLU/visfZt3UoLhuS0v6kERw/qt96djupcxtUVKKvLrX1X
H6gTD2TXi04tlNYAfH6urPZBm3u326RZGAmQpwDt+u7t5SegRaUZQUqZBD8GQZGT
9LTOEZTFmWqOMTnbKe/4+cX7Yq4ONQPjjfeYBQK6ewFRj62oxBj2vpwAARIXjZqh
RjX3RMSznawuK3O7KtgQfXMqWfVer1SsnnZN41QpkvZKsNkq4x2dEBvTCck2LWZm
lGsk9djzD6cLLSUqr0SEteFwnA620wbEcUn3cjqZGqjh+uLW31L1zj7aU25nAYKq
gWWHXiE85zJoi76csr8Ou6yOh+bb/8P7xa8o28hgxPZ10whlsPowZ+kQIX31RgST
QX9blmjnmyhBih5qVgfa0hP/dq3K5YyIvSvdn54APOOsGgsY1Lz1YTAPOkgzGDDm
M4yZbZNLLppRuAky8nGL
=zBuf
-----END PGP SIGNATURE-----

--5V5c01chtBAiSHoy--
