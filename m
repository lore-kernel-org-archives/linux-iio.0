Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:33016 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751119AbdEVGht (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 22 May 2017 02:37:49 -0400
Date: Mon, 22 May 2017 08:37:46 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] hwmon: move include files out of include/linux/i2c
Message-ID: <20170522063746.GA1454@katana>
References: <20170521203443.6387-1-wsa@the-dreams.de>
 <b876bed9-38dc-233f-053a-4b0d4ad990b2@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
In-Reply-To: <b876bed9-38dc-233f-053a-4b0d4ad990b2@roeck-us.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

> > Note that some files don't seem to have upstream
> > users in board code, so they maybe could even be removed? I didn't chec=
k for
>=20
> While I understand where you are coming from, I am not typically that agg=
ressive.
> Such removals force vendors who are not really forthcoming with upstreami=
ng to
> deviate even further from upstream. It makes them even less likely to sub=
mit their
> code upstream, and it may result in enforcing their belief that upstream =
doesn't
> really care about vendors struggling to release boards and systems to the=
ir
> customers.

I clearly see your point. I meant more the case where platform_data
became cruft because platforms moved to DT. I agree this is not so much
the case for HWMON but it was true for the I2C master driver where I
could remove the platform data and could save the include file and some
code. That was just a nice cleanup.

> >I prefer the series to go upstream via the subsystem tree; if you prefer=
 that I
> >take it via I2C, just let me know.
> >
> Series applied to hwmon-next.

Super, thanks!

Regards,

   Wolfram


--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkihzUACgkQFA3kzBSg
Kbbssw/+JuPK0Vq4fgoKu9Br2Gb7W2JiG94K9sK8r17E7w7/B2clgdg3pR+sLt4H
1N6wBWYqW4ESH4Wh9vzCYJ3PB8UvDVupft0wgTqHXgvHwQg9ktm4xXU4NG7TmpWq
sLPw879p7oq97vFaI4vXUrJSgwyKFph/ry4Cawga6Ze3jLZQGtcG2MsyCl325ZB4
nG3FEo/kvrzSjKZZX/LcMZwrux5VJO2jhVESGPRVgaksjPTazVB/qQib3kkLs2AW
XXv097JS+qDkVpKFKRCbarbYQjevy1YrRZkaYid27eUzRpiJho6kUswI9X16Hr8x
QE6Hmw3N6x1Im85rXvI8pJT6VkPEJMQ1AJLTgYiYK4PvRkH/PZMYiQPPIxhYFFQ9
a3j6aDRV8VKtP2kkdC/4l1hlB9mkX4HQzPPQb6ikCbiAApp2XaLOyFqvRLWibh/V
yPR3DSJqnZEb4Sj6bPWKFIl3bSYect0tJPbj6O3W4UGGNCCnLuAQ69rgBFxddu+0
HUh2grKkiytRXAC6hc7julq/Awx8INyVpH9GzUgGykU84Ysb1+Au+HpJ7nHzX64D
JGYQ0ryhlhF2NYpjy8n9KvQ/Z0JWzItbGE6NpuR2M982sQRxKpNYxtV1ZdXhpdMm
Nxci52OaqbgGiu391KLBpCta4yszf17oLrRLgKeZNHnBhitSf2I=
=ObKu
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
