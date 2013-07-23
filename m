Return-Path: <thierry.reding@gmail.com>
Date: Tue, 23 Jul 2013 08:33:29 -0700
From: Thierry Reding <thierry.reding@gmail.com>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-iio@vger.kernel.org, jic23@cam.ac.uk, jic23@kernel.org
Subject: Re: [PATCH 10/11] iio: adc: ti-adc081c: Use devm_* APIs
Message-ID: <20130723153328.GB2066@dhcp-172-17-186-34.nvidia.com>
References: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org>
 <1374569897-3858-11-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
In-Reply-To: <1374569897-3858-11-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2013 at 02:28:16PM +0530, Sachin Kamat wrote:
> devm_* APIs are device managed and make code simpler.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/iio/adc/ti-adc081c.c |   18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)

Looks good to me:

Reviewed-by: Thierry Reding <thierry.reding@gmail.com>

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJR7qJIAAoJEN0jrNd/PrOhZf4P/0M9vVDa7WkrSJzlrOqMaI7K
55baWFq5l4+2YElYrltQx23obHTbf9qhlmzSUewjjhflP20Tr9Y7ENkojxBWC4lp
CN64rJCCVVJqp6fflLB7MaypRGOYpZ30SfZoCBBTW2zRvpyX5J5p5L5ikGrJNDKC
e+rCyRWe6HrALGxDb7wWVSzOwQCgH3VOW5TFakP7IbKO0a/26pTCMIVdjwdzEh7n
ODQsE6svHrHQoOtiOk3JtrgWktZTmEMWdSWSCjj2rH9G4yVYlbfQal/WFV6PxJfb
pgMpTtfjJdZ+cguW7D3d+P9sk+EbZPkF2kjYx1z4x63bylFMTjuRM3eryfCsXPrO
OuG8jPBzks3wSP8iCMrIJeuYeeND3nSFOnCd/rWsatCgOpynbN9unHoquRJ7SPva
EwUIjCd0Eo5odnKWYuGQdX9aTAimNU2cp7eZmihy4hfc0E7euypSk3nZZdg0g01U
S0lRXJo8JqFRDhSvyZJdc2qQf013tHdirnYjkYup5/x/DDolzokNhYkG9EM5VT9E
H2Y2yn5lu9iVzNlflSstTdMCJ/67M6gCadm0qgqU/zAxPQqe3kRpLokKQEptB7we
h1zZLPqzejMQdcOoqgeiumUPr2U6rh+5PGjYrlwJG/Uv7AHRSxsuiEh/7oxGGMZu
uhd6ySgl7Rl1+EHjr2be
=GSZL
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
