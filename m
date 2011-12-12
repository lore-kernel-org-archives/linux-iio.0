Return-Path: <dan.carpenter@oracle.com>
Date: Mon, 12 Dec 2011 21:55:13 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Johannes Tenschert <Johannes.Tenschert@informatik.stud.uni-erlangen.de>
Cc: devel@linuxdriverproject.org, gregkh@suse.de,
        Jon Brenner <jbrenner@taosinc.com>, Jonathan Cameron <jic23@cam.ac.uk>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: iio: light: tsl2583.c: obsolete use of
 strict_strtoul
Message-ID: <20111212185513.GD3503@mwanda>
References: <1323700503-30053-1-git-send-email-Johannes.Tenschert@informatik.stud.uni-erlangen.de>
 <1323700503-30053-2-git-send-email-Johannes.Tenschert@informatik.stud.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
In-Reply-To: <1323700503-30053-2-git-send-email-Johannes.Tenschert@informatik.stud.uni-erlangen.de>
List-ID: <linux-iio@vger.kernel.org>


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

These patches need to be CC'd to the iio mailing list, and Jonathan
Cameron as well.  Use the ./scripts/get_maintainer.pl script for
hints who should be CC'd.

On Mon, Dec 12, 2011 at 03:35:03PM +0100, Johannes Tenschert wrote:
> @@ -621,7 +621,7 @@ static ssize_t taos_als_trim_store(struct device *dev,
>  	struct tsl2583_chip *chip =3D iio_priv(indio_dev);
>  	unsigned long value;
> =20
> -	if (strict_strtoul(buf, 0, &value))
> +	if (kstrtoul(buf, 0, &value))
>  		return -EINVAL;
> =20
>  	if (value)

We save value to
	chip->taos_settings.als_gain_trim =3D value;
als_gain_trim is an int, so on a 64bit system this would truncate
the high bits away and we could get a zero where we don't expect
one.

I don't think it's a problem, but looking at how als_gain_trim is
used, I noticed this potential bug:

   362          lux_val =3D taos_get_lux(indio_dev);
                ^^^^^^^
lux_val can be zero under certain circumstances.

   363          if (lux_val < 0) {
   364                  dev_err(&chip->client->dev, "taos_als_calibrate fai=
led to get lux\n");
   365                  return lux_val;
   366          }
   367          gain_trim_val =3D (unsigned int) (((chip->taos_settings.als=
_cal_target)
   368                          * chip->taos_settings.als_gain_trim) / lux_=
val);
                                                                     ^^^^^^=
^^^
leading to a divide by zero bug.

   369 =20
   370          if ((gain_trim_val < 250) || (gain_trim_val > 4000)) {
   371                  dev_err(&chip->client->dev,
   372                          "taos_als_calibrate failed: trim_val of %d =
is out of range\n",
   373                          gain_trim_val);
   374                  return -ENODATA;
   375          }
   376          chip->taos_settings.als_gain_trim =3D (int) gain_trim_val;


Also I don't understand why als_gain_trim isn't unsigned.  So
basically I think we should make it unsigned and I think we should
use kstrtouint() here.  Also instead of returning -EINVAL, we
should preserve the return code from kstrtoul() and return that.
But I don't know the code that well so I may have missed something.

The other divide by zero bug should be fixed in a different patch.

regards,
dan carpenter

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJO5k4RAAoJEOnZkXI/YHqRa5oP/2ORyJihX0Cy1+FfGjXN1fl0
tx2jEymGWFmDC1JHNw4y6DrFq0ffJ6YxZigC6a8LzM3DrNDAWrOkNQ0kng/Ntd3/
kExF6NzgEvLwo5uLm8ZzZ3odzXiLX+HSdfT7dVQCwjrI00C9XfhORFIRnxwBk6ZZ
EkHvs7ELqUraR8T/t16u24vYwKzzsLWdRcvjDTw2aZlHAVofRW4TeElHob9R0EUQ
6jSLxiylwCtv7/bl2fQF29qMSba5SoGL65eSl/bBFzVCgnH9yB5RREuOqBQr82L1
lvWoDaGlaoYeLlP4p726B+v+9rvDioQP/9+q3ndTQ4lFasNLCsbIGvgDcGTs5x17
VKYT1KQydYRCGcYVgcSLavCGJOYFW5F3g6KonPT9KreJaOct9DSdRa9g1i9LOxyF
zU6kRjWWsWQuUJdRQDXiLzXURjY2wGP+2VwaMjGYChr0+1j8gCvaBZ/L21TNxFyt
w3ynZZ6LFGOyYTfzwS7U+lnqauffr2hxSeskgOmmOnbYEcsZCJpPwj/zvd1TBuOJ
dR2kJoxEBNKsrzRrpyD9NU8slTRS6qgGpbuphg6BRjniwEMqcWRjckDAhyKobaE0
3XrzqsLPBKBLRirKr3z8JepR7kyqp2VI+3LzLhvvDUziGcCinwFHe9oPrjGadOwx
B/Hbrs+xhwvQpBySElv+
=duSn
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--
