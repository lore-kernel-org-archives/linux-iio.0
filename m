Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:34331 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754980AbdKBPEJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 2 Nov 2017 11:04:09 -0400
Date: Thu, 2 Nov 2017 16:04:07 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Marc CAPDEVILLE <m.capdeville@no-log.org>,
        Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v4] iio : Add cm3218 smbus ara and acpi support
Message-ID: <20171102150407.bparxxskfo5pzvvs@ninjato>
References: <20171027161426.m27e52jvnpgembsu@azrael>
 <20171102143550.00005a66@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cev3sz73hn4q3cvy"
In-Reply-To: <20171102143550.00005a66@huawei.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--cev3sz73hn4q3cvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2017 at 02:35:50PM +0000, Jonathan Cameron wrote:
> On Fri, 27 Oct 2017 18:27:02 +0200
> Marc CAPDEVILLE <m.capdeville@no-log.org> wrote:
>=20
> > On asus T100, Capella cm3218 chip is implemented as ambiant light
> > sensor. This chip expose an smbus ARA protocol device on standard
> > address 0x0c. The chip is not functional before all alerts are
> > acknowledged.
> > On asus T100, this device is enumerated on ACPI bus and the
> > description give tow I2C connection. The first is the connection to
> > the ARA device and the second gives the real address of the device.
> >=20
> > So, on device probe,If the i2c address is the ARA address and the
> > device is enumerated via acpi, we lookup for the real address in
> > the ACPI resource list and change it in the client structure.
> > if an interrupt resource is given, and only for cm3218 chip,
> > we declare an smbus_alert device.
> >=20
> > Signed-off-by: Marc CAPDEVILLE <m.capdeville@no-log.org>
>=20
> Wolfram - this needs input from you on how to neatly handle
> an ACPI registered ARA.

ACPI is really not my field. Try asking the I2C ACPI maintainers or
Benjamin Tissoires <benjamin.tissoires@redhat.com> who did work on SMBus
interrupts recently.


--cev3sz73hn4q3cvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln7M+MACgkQFA3kzBSg
KbZbDQ//QE1QuoCCb+3SBCa+7I4cO8un7u7yloHkGkYi7pWc57XLCbEX3pKYrcLK
eqV494XwAErDB7IGS8oA6zK40LiWGL2JHVYrWFYwvMiO5wV1mAN73MN0mMIdky2J
tCU9Km8N2r41xSO6D8zcpcgqyt9DH4qINaHWMq56jxNcVuSxe8HVLHntJDxLlvMn
Va3pxL4vXE5V/Uls77YVnPir99jQtQOf0TrLELFURCBiuvjCOm9XgPRC1ULXjbUl
pAPp2WkFeYY3lfe47ynW5ISQZQFjrg5G7/6mpWnDFXD2nFlc2uLPcQnNQQVmqkEN
Y4F5fcEdqaY3OPuQqgpkUs8UJChbq1dsgVYbLWpD4K1b5To/pxoWGC2RqT8Mo5Wp
YozZvC9rT7XroD0dAyCmEEdm/ACwJMktLHNRwpQI88vO1xR7GkrXC2wbswFP58NF
uKADPNDBcTCRHFFb6CUhQzxCnZsv8YCXQ3eoPODlGVPf+WZ/XGMbDx0s25Gtv39U
XCrtD40yLP4QpMRw39HDSxuWpsZVCJCBtSKTy5+VTPu76gB2Cv977ox5siq88EDc
BhzpVoDyFX3GUv5vb/a/T+mOFw2CryepeLHDnC+WIOTZ49OskoJYBNm62ON7R7YB
XhnVQZL5yuDiVOzQju7NcDKKsqCPpmDPid8ZBWnaxSVBsvKg358=
=EjH2
-----END PGP SIGNATURE-----

--cev3sz73hn4q3cvy--
