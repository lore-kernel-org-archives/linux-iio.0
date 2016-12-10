Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:36033 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752641AbcLJJoc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Dec 2016 04:44:32 -0500
Date: Sat, 10 Dec 2016 10:44:29 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: linux@armlinux.org.uk, wens@csie.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        antoine.tenart@free-electrons.com,
        thomas.petazzoni@free-electrons.com
Subject: Re: [PATCH v8 3/3] iio: adc: add support for Allwinner SoCs ADC
Message-ID: <20161210094429.yp26sfoz54oqy3dz@lukather>
References: <20161209102236.17655-1-quentin.schulz@free-electrons.com>
 <20161209102236.17655-4-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jelaxmmeem3a7pss"
In-Reply-To: <20161209102236.17655-4-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--jelaxmmeem3a7pss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Just some minor comments.

On Fri, Dec 09, 2016 at 11:22:36AM +0100, Quentin Schulz wrote:
> +	/*
> +	 * Since the thermal sensor needs the IP to be in touchscreen mode and
> +	 * there is no register to know if the IP has finished its transition
> +	 * between the two modes, a delay is required when switching modes. This
> +	 * slows down ADC readings while the latter are critical data to the

The latter between what and what?

> +	 * user. Disabling CONFIG_THERMAL_OF in kernel configuration allows the
> +	 * user to avoid registering the thermal sensor (thus unavailable) and

Isn't it obvious that it's not going to be available if you do not
register it?

> +	 * does not switch between modes thus "quicken" the ADC readings.
> +	 * The thermal sensor should be enabled by default since the SoC
> +	 * temperature is usually more critical than ADC readings.

This last sentence should be in the Kconfig help. You cannot expect
that all your users will read all the source code they want to compile
:)

Overall, I think this comment is kind of missing the point, maybe
something like:

/*
 * Since the controller needs to be in touchscreen mode for its
 * thermal sensor to operate properly, and that switching between the
 * two modes needs a delay, always registering in the thermal
 * framework will significantly slow down the conversion rate of the
 * ADCs.
 *
 * Therefore, instead of depending on THERMAL_OF in Kconfig, we only
 * register the sensor if that option is enabled, eventually leaving
 * that choice to the user.
 */

Would be much clearer.

> +	 */
> +
> +	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
> +	/*
> +	 * This driver is a child of an MFD which has a node in the DT but not
> +	 * its children. Therefore, the resulting devices of this driver do not

Wrong indentation for the comment, and saying why the MFD children
don't have a node in the DT (backward compatibility) would be nice.

> +	 * have an of_node variable.
> +	 * However, its parent (the MFD driver) has an of_node variable and
> +	 * since devm_thermal_zone_of_sensor_register uses its first argument to
> +	 * match the phandle defined in the node of the thermal driver with the
> +	 * of_node of the device passed as first argument and the third argument
> +	 * to call ops from thermal_zone_of_device_ops, the solution is to use
> +	 * the parent device as first argument to match the phandle with its
> +	 * of_node, and the device from this driver as third argument to return
> +	 * the temperature.
> +	 */
> +		tzd =3D devm_thermal_zone_of_sensor_register(pdev->dev.parent, 0,
> +							   info,
> +							   &sun4i_ts_tz_ops);

I don't think tzd is used anywhere else in your function, it can be
made local to this block.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--jelaxmmeem3a7pss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYS855AAoJEBx+YmzsjxAgvnsP/1PaZYrgRvWPxHZj/p72iE10
A4mB32vGMC+brAtMhBgFCUHFeWPlJSZYcpfoxC9PMiINBSCKT5nlQhttJr8tjTNZ
Qj7YNB+V4cNXujBFnNyqcU2YrrBJduaafasg7TwaUppbtkGe3XOHho5Z0yUAsPgO
m4DLVIvcLgFSHVjCMrdEG9vtIDtzrQ5xZblwLM40FsCCXzhSDQ0FCdt4bRRNy2ug
5jeOi7gaoV5Wpo8Kw0grwrSaTfSpXt4Y5Jpj/c+h27ty2UMZzIqn0FYW6OrhQ/Xk
xEJreH6jl9yOjyQIOCOIkB1XuSqzpHgZEmjo1KsBqD57P/7RuE0Ks2ZfUfcFpKHd
oq2RociROAX2Yy4twFCFHXYqcnCVswBN/zAV9eHhjbuBD4yQl9gfyID8xbOuixLk
dyo7X6Lmosmoponw1piUnW3EVokVddW3CRrkMhbbl0LLqGNAEaAq2AqM9AE8SAmy
hb/shp2x2/+p6nWwPyNcUjJzK+jPPsoMZpsh/bE/USGYoH8StENDiiw3Lmw1gjok
5Gft5AldyPqnEyNqthdijDkGviT0mkIcZDO9CRoMqAz0gepCLRRld7o+FFLAxfjj
s0SR83eYzECz3RRqSvr26dG0fq4pxu33RRrPzoEdKLoCTYrrmJ9S8sxieSQKUyj/
HJe2xfN9kZEGhiG3epzx
=We61
-----END PGP SIGNATURE-----

--jelaxmmeem3a7pss--
