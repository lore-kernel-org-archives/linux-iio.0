Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:37343 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752209AbcGRKCe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2016 06:02:34 -0400
Date: Mon, 18 Jul 2016 12:02:32 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
	jdelvare@suse.com, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org,
	lee.jones@linaro.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
Subject: Re: [v2,1/4] hwmon: iio_hwmon: defer probe when no channel is found
Message-ID: <20160718100232.GE4199@lukather>
References: <1468576754-3273-2-git-send-email-quentin.schulz@free-electrons.com>
 <20160716170013.GA27490@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2hMgfIw2X+zgXrFs"
In-Reply-To: <20160716170013.GA27490@roeck-us.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--2hMgfIw2X+zgXrFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Sat, Jul 16, 2016 at 10:00:13AM -0700, Guenter Roeck wrote:
> On Fri, Jul 15, 2016 at 11:59:11AM +0200, Quentin Schulz wrote:
> > iio_channel_get_all returns -ENODEV when it cannot find either phandles=
 and
> > properties in the Device Tree or channels whose consumer_dev_name match=
es
> > iio_hwmon in iio_map_list. The iio_map_list is filled in by iio drivers
> > which might be probed after iio_hwmon.
> >=20
> > It is better to defer the probe of iio_hwmon if such error is returned =
by
> > iio_channel_get_all in order to let a chance to iio drivers to expose
> > channels in iio_map_list.
> >=20
> > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> > ---
> >=20
> > No modifications for this patch since we did not settled for a solution.
> > What should we do?
> >=20
> AFAICS the only thing we can do is to replace module_platform_driver() wi=
th
> its explicitly coded variant, and to use use late_initcall() instead of
> module_init().

I thought this kind of changes to the driver init time were
discouraged these days?

> Anything else would result in endless probe deferrals if there are
> no channels.

Well, technically, not endless. AFAIK, the kernel only retries when a
new driver is probed, which should hopefully settle down rather
quickly.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--2hMgfIw2X+zgXrFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXjKk4AAoJEBx+YmzsjxAgf8wP+gICG/dhPEoqbs2mlIeQNnNY
5EnySr0wli+gxNV3Ud3lCYUIGz9PmD3rWVDecrJInVCGw2VuQ5cFkEzfHWuuTMkS
1+Hsi4UAsAiXhjAINgmzgZTEOrps0Jrs+C1/HQUT+bgMLAXA9J1IdYDSITGeH7Sc
8T2R4BXjkhTPdsq8uwvTjdWDUTf+6BG0NQ5n+QAKpfUlug07W0xQ8TavWTvK3FQB
mEP1u6xnGaw+w8WbprhQx9Pg0WfIXH+xf3H0iO5ZaJRpLXPRBL/RdF6Qbk7pdg31
B9VXvG19bEJBxCgdzehn5diw0cVoeCpeO9TKZcoAJj+RVCh9VMcDt30WFLYr9mIO
yK5ry25jZF/0yf3/cCfxRP6TKh/87EJ27D1n9Dj9Y4ISe1pIXWUFAlMY9VVBE+Ra
iTW3urXzIjhIqNuDto835GDVcnFgCKDnsmZZrJG9LImz4/WhXEVKDQ7loawNN1WF
45g01AC6k2FfmKmb5OQSuWlH4yj9OHBHJ2PqF5JzuOVQnNz/9jUmU+imEIcVJf19
a3vmUGm200PSmthUhYDgdBcRH5UnCvlCaTRTzg2Xpl/arv4UfB8kOhNPsSBU7zib
VccVQ3wXWKa5t/88AYoeZasR+dGQlNM3MXu+QrSrknRrGuhR8oE/bWIFx7zh++n2
i+ej3tLaqRg+qrnPtGvm
=+DCB
-----END PGP SIGNATURE-----

--2hMgfIw2X+zgXrFs--
