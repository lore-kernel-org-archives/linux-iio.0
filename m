Return-Path: <dan.carpenter@oracle.com>
Date: Thu, 2 Feb 2012 09:20:53 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 5/6] staging:iio:events: Use non-atomic bitops
Message-ID: <20120202062053.GC24652@mwanda>
References: <1328121956-29596-1-git-send-email-lars@metafoo.de>
 <1328121956-29596-6-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
In-Reply-To: <1328121956-29596-6-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 01, 2012 at 07:45:55PM +0100, Lars-Peter Clausen wrote:
> We always hold the waitqueue lock when modifying the flags field. So it i=
s safe
> to use the non-atomic bitops here instead of the atomic versions.
>=20
> The lock has to be held, because we need to clear the busy flag and flush=
 the
> event fifo in one atomic operation when closing the event file descriptor.
>=20

Is the performance improvement worth it?

regards,
dan carpenter

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPKitEAAoJEOnZkXI/YHqRFQAP/3AiM5glySPAkhp4RUf01Y/I
fFHLqn6pIYdUeLmtCGboicSezuh8zRVbR3qwKBUpzYxbg0I1DGSOIa2ArCtq9R0X
2IWzoQzu9/aDmhKKINofBCZTsau+t1c4IE6HG+3RS+3NfciPMonHFa+GM9PsE0kW
oD+NpwUCttMun/DFbB5gAIVJ/OGo3ih4Ogz6S7PAx+BsRnI9aLFzAsxx+7e0SAPZ
1/PVrLJD57YKI9Ia9jCGMwoIK8VqE6JSIjNKqcOpt6iHyq87sK4D/k7oUJX4NNgR
eOlxEr4O3CzSgabvBh2N5Jlf5EHR1eCFRgEJV1CLZfTPquiB1NY3GEpR43L59OjG
t6H8NhHSIYR22y1rkbncM66/rnsYltrC84Lg5B38H/tV6mSjG1ct04pGRILNqAIG
B4df4W/BFcRzrNQVNYwu48C/CJBXHEIYHIljlkMCk/z0tqaPV6ZRx3Wf4TF4HMAU
A6L/ZckblL2Z1fGuf5CqK3wpriMRqmv9vQ8mMkIv7HY0P7y0H8qGAHlAJiT1LUGT
h7kHYLmnohhxyodD9qDa5N6IKlbTeGAZ8A+PiOcPMz1Bt+AKfFbWBr0xVfRipl1+
ZOQ+G+u++cusaF3lGNBjlsH8xDjD7aWTYPgtmBX7yOZU6P29T1HNkcASBMl4LV7m
kFYcDf/4Lo0TmYRqhUuh
=faV/
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--
