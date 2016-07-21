Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:58002 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752077AbcGUUIQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jul 2016 16:08:16 -0400
Date: Thu, 21 Jul 2016 22:08:02 +0200
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
Message-ID: <20160721200802.GL5993@lukather>
References: <1468576754-3273-1-git-send-email-quentin.schulz@free-electrons.com>
 <1468576754-3273-4-git-send-email-quentin.schulz@free-electrons.com>
 <de8ebab2-cde9-d209-3c9a-e1868fafb84b@kernel.org>
 <20160719073109.GD17074@dell>
 <d64cf632-41a4-3e23-6239-7f854cbb0293@kernel.org>
 <20160721121253.GE14925@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YIleam+9adpUeYf+"
In-Reply-To: <20160721121253.GE14925@dell>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--YIleam+9adpUeYf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

1;4205;0c
On Thu, Jul 21, 2016 at 01:12:53PM +0100, Lee Jones wrote:
> On Wed, 20 Jul 2016, Jonathan Cameron wrote:
>=20
> > On 19/07/16 08:31, Lee Jones wrote:
> > > On Mon, 18 Jul 2016, Jonathan Cameron wrote:
> > >=20
> > >> On 15/07/16 10:59, Quentin Schulz wrote:
> > >>> The Allwinner SoCs all have an ADC that can also act as a touchscre=
en
> > >>> controller and a thermal sensor. For now, only the ADC and the ther=
mal
> > >>> sensor drivers are probed by the MFD, the touchscreen controller su=
pport
> > >>> will be added later.
> > >>>
> > >>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> > >> Hmm. Previous patch includes the header this one creates.  Ordering =
issue?
> > >> The depends kind of prevents build failures by ensuring that can't b=
e built
> > >> until this one is in place, but it is certainly an ugly way to do it.
> > >>
> > >> Few little bits innline.
> > >>> ---
> > >>>
> > >>> v2:
> > >>>  - add license headers,
> > >>>  - reorder alphabetically includes,
> > >>>  - add SUNXI_GPADC_ prefixes for defines,
> > >>>
> > >>>  drivers/mfd/Kconfig                 |  14 +++
> > >>>  drivers/mfd/Makefile                |   2 +
> > >>>  drivers/mfd/sunxi-gpadc-mfd.c       | 197 ++++++++++++++++++++++++=
++++++++++++
> > >>>  include/linux/mfd/sunxi-gpadc-mfd.h |  23 +++++
> > >>>  4 files changed, 236 insertions(+)
> > >>>  create mode 100644 drivers/mfd/sunxi-gpadc-mfd.c
> > >>>  create mode 100644 include/linux/mfd/sunxi-gpadc-mfd.h
> > >=20
> > > [...]
> > >=20
> > >>> +static struct mfd_cell sun6i_gpadc_mfd_cells[] =3D {
> > >>> +	{
> > >>> +		.name	=3D "sun6i-a31-gpadc-iio",
> > >>> +		.resources =3D adc_resources,
> > >>> +		.num_resources =3D ARRAY_SIZE(adc_resources),
> > >>> +	}, {
> > >>> +		.name =3D "iio_hwmon",
> > >> I still really dislike using this to force the probe of that driver =
but
> > >> kind of up to the hwmon / mfd guys on this.
> > >=20
> > > Can you at least say *why* you don't like it?
> > It just feels odd to have an mfd child that isn't really dependent
> > on the mfd hardware itself.
> >=20
> > Still if you are happy, mfd is your domain and my objections were
> > as you probably noticed not that strong - or well described!)
> >=20
> > So I'm fine with this.
>=20
> I see.  So it's not actually part of the same IP/chip?

The chip has a temperature sensor, and we want to expose that
temperature through IIO.

But we don't really have the choice on how we probe iio-hwmon
here. The binding was already there, and we have to keep it.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--YIleam+9adpUeYf+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXkSuiAAoJEBx+YmzsjxAgfK4QAJcH643zEYRF6DxX0PSoz+eM
7ST2T8CAUMHvOr5FdEiHBrtFU61FOcVlyJZrnt4is2p/xzHn+S5u/RGSwFJiNj5b
87CGXBRkdfYUDoqR4ZYaokcEhcLEzccUXPrC8l6PJBZb7WyQ6App2EDU/rNcMwrA
V/SSHoqqH3Mme2scgppYosmWpXyxQZxqgJh13/bWyuh2zoUHGlw0GFnd7n3XXLIQ
NuiA/xIj4FS5W4iUQpsaOMEI73+j0UvEswmWTayi8C5N5cbAvrrZTdObEko8erEm
LNgp2/6xGZ4OoPsrNZN314OMETk28348q4ZFmBRP98weKMgOILwIkJzVM3yRIecX
I8Rn6jtsrVLbA1WFCTKgmNkF+ccrGW/jc3ufr55YzEFbEmgoMlbBuPwZDFmsQKWt
ruZwr2e4yBX40RspH9GOEvpoV2TG7l3xsL8/VP0YMnQ1UypkhSY5Ms8vlIavi4TK
+20JUb4WPyzBGIXUsSx107tB0GV4xRw5oO83Z62962/aMgMIRx4uTHnre3knApJo
P28TVdoAe2iSV8851q78yOchidpSW/d2pQj50fhb5KhJSq82KxUetUdtyQOKTg2T
eAAQEgOGkfpGE5ziWr8fenqN2jz9A1p4lqvyuaipvdtWzb9t0E0+wzgTHrSkL+vN
R8uPK5s3mGAkvZmvrIiH
=qfw6
-----END PGP SIGNATURE-----

--YIleam+9adpUeYf+--
