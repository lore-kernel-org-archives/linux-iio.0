Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56308 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948984AbdD3Tkl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Apr 2017 15:40:41 -0400
Date: Sun, 30 Apr 2017 21:40:35 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Brian Masney <masneyb@onstation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: isl29028: add isl29030 support
Message-ID: <20170430194035.ype3jwx6bwslkkfv@earth>
References: <20170428155558.17723-1-sebastian.reichel@collabora.co.uk>
 <20170428161716.GA3075@607924cbbc93>
 <d76123a7-36aa-df14-5a2f-12ab17224c57@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fjyts2bjugtat5pk"
In-Reply-To: <d76123a7-36aa-df14-5a2f-12ab17224c57@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--fjyts2bjugtat5pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 30, 2017 at 05:27:07PM +0100, Jonathan Cameron wrote:
> On 28/04/17 17:17, Brian Masney wrote:
> > On Fri, Apr 28, 2017 at 05:55:58PM +0200, Sebastian Reichel wrote:
> >> isl29030 is basically the same chip. The only difference
> >> is the chip's first pin. For isl29028 its named ADDR0 and
> >> can be used to change the chip's i2c address. For isl29030
> >> on the other hand that pin is named Ials and is an analog
> >> current output proportional to ALS/IR. This change is
> >> irrelevant for the Linux driver.
> >>
> >> This has been tested on Motorola Droid 4.
> >>
> >> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> >> ---
> >>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
> >>  drivers/staging/iio/light/isl29028.c                      | 6 ++++++
> >>  2 files changed, 7 insertions(+)
> >=20
> > Hi Sebastian,
> >=20
> > I moved this driver out of the staging directory earlier this week.
> > You'll need to base your patch off of IIO testing:
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=3D=
testing
> >=20
> > Your patch should apply cleanly once you update the file path.
> I did it rather than having this bounce around for a trivial rebase.
>=20
> Applied to the togreg branch of iio.git and pushed out as testing of
> the autobuilders to play with it.

Thanks.

-- Sebastian

--fjyts2bjugtat5pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkGPbAACgkQ2O7X88g7
+prypRAAjq2SF3kMD030EYPB4OlA0E5OGbn7aZLQS36UPv7mCazjUegxEgy6iR+R
ZiPgGtnMEp6r/FTxvCBDlUEBEXuX9frXnRkUW5NQEqlvXz52cu6phk2YhFTFy/gl
Ro94GZUp7QtWef8kScE4W8BEJ5DrGD/VBFw1ZkIO6hgHDZDXgoAljOqiBPSETsNL
Jir2LRL1EDmYniiHE7dWwdEykBP/qQbT8wv5/I9sSuYGQKYYhCikCFeR6T3rHN3y
3dhU0fR0ZXi9EUsLPPN9o8uc9J0i2O1LU5BvpNlfNXghBXLDe1gZkHME+LSiNJB7
07JN4TQuF6lJg6iRV9RUlbyQxaOQVKYAka1L9pYzg4QDXiUmI/pzwjPqRcTYYU1s
4QoARjRqLdLv8EP+rRyrcHUl27cF96eSnQ8T47btVxMshUE2TLEx0AHnweKllR5p
gwla6PTYeMSRNtjRFy3RlYZfOSzFZZhY2bSkwm69xTJ8wPoJALGpEcerEpmEvcHo
8xR6+MkKtQPeuPbpe3Y2QDVmrlsrTic4PwOmWRy7subRdxtklfznC+hNIGV4DkI/
1Ztv2q1LdXXZa23DiAZmtlEr6bTi1XUaleZloXS18olU+FjWFAALY1LwWDK5WTGa
JybFhJy6PoK1DHDKRanxZu4gDpIUxomgURq4EeSAvfWD72QObUQ=
=pUMr
-----END PGP SIGNATURE-----

--fjyts2bjugtat5pk--
