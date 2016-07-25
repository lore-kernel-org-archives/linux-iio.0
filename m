Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:57199 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752321AbcGYJze (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2016 05:55:34 -0400
Date: Mon, 25 Jul 2016 11:55:32 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Quentin Schulz <quentin.schulz@free-electrons.com>,
	jdelvare@suse.com, linux@roeck-us.net, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
Subject: Re: [PATCH v2 3/4] mfd: add support for Allwinner SoCs ADC
Message-ID: <20160725095532.GK7419@lukather>
References: <1468576754-3273-1-git-send-email-quentin.schulz@free-electrons.com>
 <1468576754-3273-4-git-send-email-quentin.schulz@free-electrons.com>
 <de8ebab2-cde9-d209-3c9a-e1868fafb84b@kernel.org>
 <20160719073109.GD17074@dell>
 <d64cf632-41a4-3e23-6239-7f854cbb0293@kernel.org>
 <20160721121253.GE14925@dell>
 <20160721200802.GL5993@lukather>
 <20160722135556.GG14925@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="enGqbSaueFq5omEL"
In-Reply-To: <20160722135556.GG14925@dell>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--enGqbSaueFq5omEL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 22, 2016 at 02:55:56PM +0100, Lee Jones wrote:
> On Thu, 21 Jul 2016, Maxime Ripard wrote:
>=20
> > 1;4205;0c
> > On Thu, Jul 21, 2016 at 01:12:53PM +0100, Lee Jones wrote:
> > > On Wed, 20 Jul 2016, Jonathan Cameron wrote:
> > >=20
> > > > On 19/07/16 08:31, Lee Jones wrote:
> > > > > On Mon, 18 Jul 2016, Jonathan Cameron wrote:
> > > > >=20
> > > > >> On 15/07/16 10:59, Quentin Schulz wrote:
> > > > >>> The Allwinner SoCs all have an ADC that can also act as a touch=
screen
> > > > >>> controller and a thermal sensor. For now, only the ADC and the =
thermal
> > > > >>> sensor drivers are probed by the MFD, the touchscreen controlle=
r support
> > > > >>> will be added later.
> > > > >>>
> > > > >>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.co=
m>
> > > > >> Hmm. Previous patch includes the header this one creates.  Order=
ing issue?
> > > > >> The depends kind of prevents build failures by ensuring that can=
't be built
> > > > >> until this one is in place, but it is certainly an ugly way to d=
o it.
> > > > >>
> > > > >> Few little bits innline.
> > > > >>> ---
> > > > >>>
> > > > >>> v2:
> > > > >>>  - add license headers,
> > > > >>>  - reorder alphabetically includes,
> > > > >>>  - add SUNXI_GPADC_ prefixes for defines,
> > > > >>>
> > > > >>>  drivers/mfd/Kconfig                 |  14 +++
> > > > >>>  drivers/mfd/Makefile                |   2 +
> > > > >>>  drivers/mfd/sunxi-gpadc-mfd.c       | 197 ++++++++++++++++++++=
++++++++++++++++
> > > > >>>  include/linux/mfd/sunxi-gpadc-mfd.h |  23 +++++
> > > > >>>  4 files changed, 236 insertions(+)
> > > > >>>  create mode 100644 drivers/mfd/sunxi-gpadc-mfd.c
> > > > >>>  create mode 100644 include/linux/mfd/sunxi-gpadc-mfd.h
> > > > >=20
> > > > > [...]
> > > > >=20
> > > > >>> +static struct mfd_cell sun6i_gpadc_mfd_cells[] =3D {
> > > > >>> +	{
> > > > >>> +		.name	=3D "sun6i-a31-gpadc-iio",
> > > > >>> +		.resources =3D adc_resources,
> > > > >>> +		.num_resources =3D ARRAY_SIZE(adc_resources),
> > > > >>> +	}, {
> > > > >>> +		.name =3D "iio_hwmon",
> > > > >> I still really dislike using this to force the probe of that dri=
ver but
> > > > >> kind of up to the hwmon / mfd guys on this.
> > > > >=20
> > > > > Can you at least say *why* you don't like it?
> > > > It just feels odd to have an mfd child that isn't really dependent
> > > > on the mfd hardware itself.
> > > >=20
> > > > Still if you are happy, mfd is your domain and my objections were
> > > > as you probably noticed not that strong - or well described!)
> > > >=20
> > > > So I'm fine with this.
> > >=20
> > > I see.  So it's not actually part of the same IP/chip?
> >=20
> > The chip has a temperature sensor, and we want to expose that
> > temperature through IIO.
> >=20
> > But we don't really have the choice on how we probe iio-hwmon
> > here. The binding was already there, and we have to keep it.
>=20
> What binding?

The binding introduced for the original driver this serie aims to
replace:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Docume=
ntation/devicetree/bindings/input/touchscreen/sun4i.txt

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--enGqbSaueFq5omEL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXleIUAAoJEBx+YmzsjxAgaaQP+wWpVxlyufGC1gnkx621V2ta
tX0vfzz2NRU1ovRvj7G56mm8QHXT3T9iyt6CMh53Q9sGyErdyAPTtf4/+xGbaMFe
K1GA7xAgFZo6XjQj88y8ZQuNoPUXQiwmJAgv9joZuL6GKa42mppeRjng9md0pboJ
saQchCxjB6F3Oo4jsaaKOQyVHsNwYK0SFdKZrKYFbB/d5M1NKqtC6Rxm9aV3SQeO
nEnKRk/VVFwWYJ+XZunDNRvQ9Eznga1rdijCNyPO6VTeO1GgQy69Skjz7HAUEYQe
UeiQjp5mHyk/YIOyz6IXhwKc9aTw+gFfQQZvv5QW3GndU2Zv391f5xWq2nfQesuD
fW2wPmtDTMSqS9NJi0H5Co/jtO00eIXvf/g54OXdW0ANjKTP3wEJPgVes8fa9E7o
MD+yvKVvpRHNgCRsMz4RjjvTlZF0cTxEcF+uk6PZ1jRNAY5rVjt5L+4Fju93utTU
iuCTc1DxBj0ByqD9aXnnU/8fE9Bnonc7kAAVCtN5761mczD1nC7OurkNf52z0G57
FqGfXR1CUveljAoGJNqMDBrCrPg9tQyrNqYMKJRjcxNbjcWssgYvZEkA/2bOR0Le
Y2gk/DQ2VoTEQap513YzEsZR8f+phnXmAx48CEHrUPSbW8/lqj/nvkD3uhTKi3rZ
A2O4meYRsk06HBSrk1zg
=t7qi
-----END PGP SIGNATURE-----

--enGqbSaueFq5omEL--
