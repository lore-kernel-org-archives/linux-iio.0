Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:52696 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752805AbcHXGmX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Aug 2016 02:42:23 -0400
Date: Wed, 24 Aug 2016 08:41:53 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com,
        antoine.tenart@free-electrons.com
Subject: Re: [PATCH v3 4/4] iio: adc: add support for Allwinner SoCs ADC
Message-ID: <20160824064153.GC8103@lukather>
References: <1469519027-11387-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469519027-11387-5-git-send-email-quentin.schulz@free-electrons.com>
 <20160729071230.GB6215@lukather>
 <bccb6739-4804-8c71-a120-2cb8672fb57e@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
In-Reply-To: <bccb6739-4804-8c71-a120-2cb8672fb57e@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--rQ2U398070+RC21q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 04, 2016 at 10:41:00AM +0200, Quentin Schulz wrote:
> > However, I'm not sure this is even possible. Isn't the point of the
> > runtime_pm precisely to not be called while you're using the device?
>=20
> I agree on the principle but I am using runtime_pm functions (I am
> mainly talking about the pm_runtime_put function) when probing or
> removing the driver. Let's say we remove the mutex locks in runtime_pm
> functions, what will happen if we are reading raw values from the ADC
> when removing the ADC driver for example?

Most likely, the first thing you will be doing in your remove is to
unregister from the framework, so you won't be able to start any new
conversion. So that case shouldn't happen.

> >> +	/* Disable all hardware interrupts */
> >> +	regmap_write(info->regmap, SUNXI_GPADC_TP_INT_FIFOC, 0);
> >=20
> > This looks like the wrong place to do that. You'll disable the
> > interrupts of all the devices of the MFD, which is probbaly not what
> > you want to do (and if you do, you want to do it in the MFD driver).
>=20
> Yes but all subdrivers of the MFD are using IIO channels from the ADC
> driver so anyway they would not work at all.

I'm not sure what you mean by that.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXvUGxAAoJEBx+YmzsjxAgbUoQAL9ztN/frHXQdu1soQJd7bqB
TPNJEZRqEfwSgvuDAStUbw08SHRr0FFulUqh/IfL3YVfrNgbfyvkCdqoIeVybh1d
IAYavznXCbKbUHz6pRVLtWw944qBi8ZJHrXN3c4YKCJlqvOQDSE1H8woB0Ps5eU5
s7twQ8fkd8+Hu9GHL8Ysc3WnLxRIpNj7SfihZA07K9Fg94hy9jjweZFKOSBCXqTQ
YqwT9V2njt4QjyyLqhPZGlssASX43wmIvhD1JNHFKDFRtBJ6u+6a54xuJx3XbJ2g
jk0Wl6+1n9HU03IF3x3/OHPzD41owhI9wYDw1vZLDsQYP1RFL9y/H/P3F+yzy0u6
8mQW+utOmIUzR3YfsgTWXTiaaXl71/m+OCOJJzaKFfWabnH2kpPSGEkt/jXIHidH
rGZ3/l6Ver0sVTq/aW5mvCZasfU5vWgVTrf+/R2Pm07tgchj8lA62jCEAMW0sNCO
ZEozn/v5fB4tp358luaXee5f3/xiLSx37NMLwYZ3m+msZevMZKJoP2KT1wR7Ow3+
wjAyUIlJbrDTaqZy2FU1I9IHwHj4Hbh68tK7Dk9vy+2qusUmF6/IJG6E59ujhyuq
2SVw0az7MS+VHKql6lX2n+0veiF/MjNdKm6su2SQhJk9l/B2qDxTWWcOpF5n1u0w
3hqgZCGDaj1KqF6eiGUy
=vBPm
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
