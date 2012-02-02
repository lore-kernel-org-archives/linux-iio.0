Return-Path: <dan.carpenter@oracle.com>
Date: Thu, 2 Feb 2012 14:49:22 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 5/6] staging:iio:events: Use non-atomic bitops
Message-ID: <20120202114922.GE24652@mwanda>
References: <1328121956-29596-1-git-send-email-lars@metafoo.de>
 <1328121956-29596-6-git-send-email-lars@metafoo.de>
 <20120202062053.GC24652@mwanda>
 <4F2A53F1.3020304@metafoo.de>
 <20120202111916.GT3356@mwanda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ryJZkp9/svQ58syV"
In-Reply-To: <20120202111916.GT3356@mwanda>
List-ID: <linux-iio@vger.kernel.org>


--ryJZkp9/svQ58syV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 02, 2012 at 02:19:16PM +0300, Dan Carpenter wrote:
> On Thu, Feb 02, 2012 at 10:14:25AM +0100, Lars-Peter Clausen wrote:
> > I don't think there is any real performance improvement to be expected =
of
> > this patch. If you have good a reason why non-atomic bitops should not =
be
> > used I guess this patch could be dropped.
>=20

Actually perhaps it's better to apply this because the code is
already tricky and the double underscores serve as a reminder.
I'm fine with this change.

Acked-by: Dan Carpenter <dan.carpenter@oracle.com>

You could also remove the "/* Does anyone care? */ from
iio_push_event() because we do care.

regards,
dan carpenter


--ryJZkp9/svQ58syV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPKnhBAAoJEOnZkXI/YHqRgisQAIrpVCsX6Nlh0sHMXtcmMpxk
Vth0VVP5yWIaf815Yvg0GYRjFa37o97hzhllTEU406jxMnrGOXyvxindux6Jg+oy
Thl+TELKv0KS6p3ABirwc38LUnb+VZ1uM0d2d8+p0WR06X0GECa4pqunU+M5YiFq
RS2IzZABNIr+w4sqJVvo1f7cXU82fjFGzBuBsCtObTGRnPHpxkpGdH8Xds8afbaQ
f+LZ/X8+T+QzL81qZ9syBzBRod1tUuIgnyXFXVtVOzmzqK/QWuZNvgxt/8IeYIB6
2nnfCC1BIos6Asvw8PbSirt+aASrCTaN8/O46q1Y/bNrc9qtx/PlkxSrj0fgGWJU
X47CFXY7z/h3g2YnZqDZW2VOd/3FEB1JBTBEOzuGTh8CjMVLJ78A12OsAfHJeD1a
Uawy1tX/qJh0A7tZp5mZbd+d8+A+Xdw6M6lqQpQ9oFliVU05NMF+Q0FSSYdDf1qX
yIueT0ZwA6Zq/qdTCNH+3CD6jWp+/gf4tfhgu4p0zjd3Aq1yniQDPRkvIrRe7wKo
Dt2ZOnoIjUS76p6+ZagZBCfx0z/f/XEj5/jr7wjdslGpJ3hA2YWFehGlRhguF807
Jfq0zW+8lPvoxBCfID/d1mAaH1KxdY84HVh+VrGiBf56AhQLldrbok8CwRraIoDg
hEIsJzbHXra/VmwuSQBa
=I00E
-----END PGP SIGNATURE-----

--ryJZkp9/svQ58syV--
