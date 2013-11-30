Return-Path: <maxime.ripard@free-electrons.com>
Date: Sat, 30 Nov 2013 14:42:47 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, Denis Ciocca <denis.ciocca@st.com>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Brian Lilly <brian@crystalfontz.com>,
	Brent-Crosby <brent@crystalfontz.com>, Jim Wall <jimwall@q.com>
Subject: Re: [RFC PATCH 1/3] iio: accel: Add device tree probing for STMicro
 accelerometers
Message-ID: <20131130134247.GB3002@lukather>
References: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com>
 <1384876234-1211-2-git-send-email-maxime.ripard@free-electrons.com>
 <5299D444.30801@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
In-Reply-To: <5299D444.30801@kernel.org>
List-ID: <linux-iio@vger.kernel.org>


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2013 at 12:04:20PM +0000, Jonathan Cameron wrote:
> On 11/19/13 15:50, Maxime Ripard wrote:
> > Add the compatibles supported by the st_sensors library. This uses kind
> > of a hack, since the st_sensors core will actively check at probe time
> > that the device name matches the one reported when using old style i2c
> > probing, and that this name will be different with device tree.
> >=20
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> Note that this is unnecessary give core i2c matching, until we have some
> more elements in the binding.  I'd certainly expect the interrupts
> on the relevant devices to be in the binding...

This interrupt DT thing has been stalled for monthes, I don't have any
hardware to test the interrupts, maybe we can just move forward and
wait for someone that have the need for the interrupts to do the work?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSmetXAAoJEBx+YmzsjxAguS0P/R1imFtsPle7mRTcLBEhxK00
VpZO39WjU8NQ7u+YRB+RixXjRTahtPUt+Dm/ZRLdd8ji9LrWu6o8t26VeyCyN7ac
Yx6DI/2v6dIY7yOTMRMgkuKhMtCfx4fpCDZA7iHI25f5gNSUCBsNEOniFpeASBg5
57clstO73hgND2E4ih5PGTXcMvaqk/VuJnE32i/CzcuCCjG33GCtESZRQbsJyON+
qN77SgItz5nGoqDlG4Osne08qhhSJlMo2ds6o44s8nhwjdYnvMwdPpsax8OCGpii
+PsZP2bnuflb70U8dVH8WLdgwn89CF/W5C4x4Mcc/0OnycYaNhXVS25iyLC2M8Qd
HCvg87CIrNeNnTOAj1Ijkmyf9JugNcqV1c8NWCbp5K1lM7sUPRQmVsKABYRcGldc
mp1vMzOxFJ4/yuQH4/Txk8OTq3GlzdLntTdQ+liLuQxrwiL4h/9XQtqHoD/wUdD2
bC4ePAN6VEQtOIqdTCTd3Gp3wRD74Ql6PgpAheeykeCp7nUHzJZDcqxHGiCfAnuZ
YzA/vWumzrl3sgEJ+Qihrc50Lctm+ZmO2K6DcB53TLA8eeH9m9E72i9DvRThV7rJ
WOj3wFnD2yi34K5tWgiGgb2LPewUXvxmyhMunrRM+rN6ZM1oUioOCC6MWYsnn8VK
3gmwkT0cJ+QVU/gwTLDw
=AyUV
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
