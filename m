Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937674AbdAFCrg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 5 Jan 2017 21:47:36 -0500
Date: Fri, 6 Jan 2017 03:46:58 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, linux@armlinux.org.uk,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        bonbons@linux-vserver.org, icenowy@aosc.xyz,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 17/22] power: supply: add battery driver for AXP20X and
 AXP22X PMICs
Message-ID: <20170106024657.y72pxkh6xeexwpp4@earth>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-18-quentin.schulz@free-electrons.com>
 <CAAEAJfBeu7Z_JeM55Tyj4a2ZOxNWhq7qoPDwFyftoO8sCumVQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="khfwpblf4d6qwfaw"
In-Reply-To: <CAAEAJfBeu7Z_JeM55Tyj4a2ZOxNWhq7qoPDwFyftoO8sCumVQw@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--khfwpblf4d6qwfaw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 05, 2017 at 02:34:48PM -0300, Ezequiel Garcia wrote:
> > +static int axp20x_power_probe(struct platform_device *pdev)
> > +{
> > +       struct axp20x_dev *axp20x =3D dev_get_drvdata(pdev->dev.parent);
> > +       struct axp20x_batt_ps *axp20x_batt;
> > +       struct power_supply_config psy_cfg =3D {};
> > +
>=20
> To be consistent with the AC power supply and USB power supply,
> you might want to call of_device_is_available() here.
> Otherwise, the device probes even if "disabled" in the DTS.

I would expect that check in the mfd code. Probe should not be
called at all if the sub-device is disabled.

-- Sebastian

--khfwpblf4d6qwfaw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhvBR4ACgkQ2O7X88g7
+pp8QRAAk17mkOlg3XNw78yV3odE5Y7CZ96debdw6VTJudUxCVGpvG2TDcnUQfJ0
6YGPzqJuEROEx02kqnBxHKX0rorAW65Hay+rXk9MWguj7xTAzuYy4Ghb5H4Gnrbp
f7mXPVBKUFyP5fUWgFDlxzi5rdfcAfDGyBXS4emUDGbCLFMkMZ5/hivCe8V254ne
e1jOGUeyjIV8xO6FovjO+pHRx6HCS+9O2fGhznNd4JXAtKVNqEC0rBAdP3fqIM/0
gj3Xs6zTkonoFEnUmhufyNIYz4aQf2qH356PkYTrMCYBqeSZSTVC0biZEKCJ/sEt
FBmdR1SBP7Xm9H3ExF6UrJ7aZFF0PRK2Y42K60/hUoAwKUqjrK5WPx6GjuMBXky3
1ABHUU0PVZCCfO3KKF6YJNbtcd0164jb2ruqTokx45Vghg+V5l72i/Pd0/mD0eU5
Bnee9g+JearygAqES4xaMOrjOQT9//6OToP7jBPVKpoWcQAuY2TE14NAd63UzgOr
MXGeCDFOqyS8PGkkgRCwsUjJhKCQJrNb0yxKTnl9mHwX8/SF5Di3dYJh0cBpaVmz
8g0BIIXTkXaH8ki6zsiGb6L8tmBP674PLy+SpKMJtW6yvkRGS5GUvtH8CLgCER2w
RZHMCzlYMYBNN9TDoZQHzDh03SxxXRz8FxeaaaXsWlK1DwqyvGA=
=l1Nc
-----END PGP SIGNATURE-----

--khfwpblf4d6qwfaw--
