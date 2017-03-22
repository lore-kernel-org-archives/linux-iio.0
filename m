Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:48810 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758522AbdCVHSF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Mar 2017 03:18:05 -0400
Date: Wed, 22 Mar 2017 08:16:57 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Icenowy Zheng <icenowy@aosc.xyz>
Subject: Re: [PATCH v3 02/11] ARM: sun8i: a33: add all operating points
Message-ID: <20170322071657.omlvxykz5ans357o@lukather>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
 <20170321153611.16228-3-quentin.schulz@free-electrons.com>
 <CAGb2v64MHK7A-FhZR5KBbDji4VvnhJukqDz0Ude-LjS2YgVVfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gqje5lszmbmjyqtz"
In-Reply-To: <CAGb2v64MHK7A-FhZR5KBbDji4VvnhJukqDz0Ude-LjS2YgVVfA@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--gqje5lszmbmjyqtz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 11:31:54AM +0800, Chen-Yu Tsai wrote:
> On Tue, Mar 21, 2017 at 11:36 PM, Quentin Schulz
> <quentin.schulz@free-electrons.com> wrote:
> > This adds almost all operating points allowed for the A33 as defined by
> > fex files available at:
> > https://github.com/linux-sunxi/sunxi-boards/tree/master/sys_config/a33
> >
> > There are more possible frequencies in this patch than there are in the
> > fex files because the fex files only give an interval of possible
> > frequencies for a given voltage. All supported frequencies are defined
> > in the original driver code in Allwinner vendor tree.
> >
> > There are two missing frequencies though: 1104MHz and 1200MHz which
> > require the CPU to have 1.32V supplied, which is higher than the default
> > voltage.
> >
> > Without all A33 boards defining the CPU regulator, we cannot have these
> > two frequencies as it would cause the CPU to try to run a higher
> > frequency without "overvolting" which is very likely to crash the CPU.
> >
> > Therefore, these two frequencies must be enabled on a per-board basis.
> >
> > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>=20
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--gqje5lszmbmjyqtz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY0iTpAAoJEBx+YmzsjxAgUvwQAJTSFq4/o3ch4Qze5LOjdXHh
V345lF+v7dj/ci69HE+Vt7rBzh8suhoWu3tN6a7345BTvE32Foym2deIjFidreFt
U7NaBDHCrvFyPm+8yFiK+q9uZWEITgq9zgTWH+i7bmA2ToHB0fdwhK9TjeKYWKQu
bMNvRENIwzioYUl6gbu89eIJa4P9G/FPU/Qcz9FTJdD4NSLBq8w4z47uX+PftAEt
iE5Lh9suE/TWIxhLVnzdXC05MgGtUFxrp0kOQkLePsAipFNV18AFE/PAhVR7zpdU
TMoCtpfqrHv5FP8wklZVqX9ep11zELUGfCbLRUHJmLiL3YCPS9oSyAtSScf3Vp7X
9BYyJ9l9VJ5dBzge9Q1FtTSJ+Sm/k8d0VEV1PfzYBszRyUABpEYM4GChe+Ckh26P
oqCcFGghFZd+QxpZy7E0hNJ0Qr4U0YnWtKpNXGXnQ1vzZ2FUxhSTRCnahgGoTvI6
ES5bC3YoJSonlK3OfsC7uE7Km+0rT8N/QvLnoxmKMFesxkdfdUN+H8d0BqF9oWgL
FAtbBDeoqvFF2PZqwsACfn8XGGVLiQHBZpbs+DHO2WDljb05hEhvkm8WH6TuLnUx
wt1s3woseDK4HKApKnwoWhADzC5rJ8sbHzawUWiKQl0wjWulIoi1JAyRrJ+horm1
3fNTtXtUeh5hGKwwflmd
=eX9v
-----END PGP SIGNATURE-----

--gqje5lszmbmjyqtz--
