Return-Path: <SRS0=dHSl=4Z=sirena.org.uk=broonie@kernel.org>
Date: Fri, 19 May 2017 17:01:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Sascha Weisenberger <sascha.weisenberger@siemens.com>
Message-ID: <20170519160133.ukkne2emubfbrrvg@sirena.org.uk>
References: <CAHp75Vf517+vfe7GiTH2Gb0WBDdqi4fcR5Z1O6ideJMpbDhysw@mail.gmail.com>
 <08d40bf0-4e68-d763-af99-be1f60e369fc@siemens.com>
 <1493119630.24567.192.camel@linux.intel.com>
 <20170425113513.GQ7152@lahna.fi.intel.com>
 <2a116105-0046-bcc1-b560-f6986220fb4b@siemens.com>
 <20170425123029.GS7152@lahna.fi.intel.com>
 <ca23678c-be8c-1e3f-4688-67b29770c99b@siemens.com>
 <32803199-239f-821c-7942-748436d53261@siemens.com>
 <20170426090158.GV7152@lahna.fi.intel.com>
 <9a210132-854b-cf3e-da33-fc3d073ad491@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="74r3a7rrizpn442x"
In-Reply-To: <9a210132-854b-cf3e-da33-fc3d073ad491@kernel.org>
Subject: Re: [PATCH] iio: adc: Add support for TI ADC1x8s102
List-ID: <linux-iio@vger.kernel.org>


--74r3a7rrizpn442x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 27, 2017 at 07:01:07AM +0100, Jonathan Cameron wrote:

> Somewhat of a pain to basically use a random value as the default going
> forward.  Presumably this isn't the first ever ACPI table to need to
> tell use about a reference voltage...

> Mark, seen anything similar?

> I see https://www.kernel.org/doc/Documentation/arm64/arm-acpi.txt suggests
> that mapping to regulators isn't expected to ever happen...

There's multiple different camps trying to use ACPI for very different
things.  There's the server people on both x86 and ARM who want to use
standard ACPI and nothing but with the power management all hidden in
the AML but there's also the embedded x86 people who have the same needs
as DT platforms but find themselves unable to use DT so have to map all
the DT support into ACPI.  This has been accepted in areas that clearly
don't overlap with areas where there are existing ACPI bindings for
things, power management is one area where there are clear bindings
though.

--74r3a7rrizpn442x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkfFtgACgkQJNaLcl1U
h9DaNgf+POVTKtea4fn1SaKG48ZQVgjmu8ymoeD8EqhREHQK7GTA6DaooF93oedW
vpWgY9GDh3uhztwWg3/9FrmKsT7fqmsT+fsjapx0/uG0WgqALf+lCzR1GfZ/ON9N
JY85/4G2bbtWMlxVcxGbEewhIK3KA5vhkfO1g/m7GtgGb3P1Md3q2Lz45A+dxP4D
qWAYG63mqmpuK/gKVBnw91KXoxNYb8xUGSld+om16M7e2/UBW4b670ers7/L/jU/
fTPnKawwlGjQnGH9xrDhvTax3BP0dv/68+CToyd+Io+1ncJHBPxiRgdonT6nsAcT
zsZj9+RqdBGwOv28hk3lltvoenImdA==
=tB2j
-----END PGP SIGNATURE-----

--74r3a7rrizpn442x--
