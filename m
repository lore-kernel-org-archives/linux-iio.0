Return-Path: <SRS0=6xFd=44=sirena.org.uk=broonie@kernel.org>
Date: Mon, 22 May 2017 11:06:48 +0100
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
Message-ID: <20170522100648.q65ubrw2aannwtjn@sirena.org.uk>
References: <1493119630.24567.192.camel@linux.intel.com>
 <20170425113513.GQ7152@lahna.fi.intel.com>
 <2a116105-0046-bcc1-b560-f6986220fb4b@siemens.com>
 <20170425123029.GS7152@lahna.fi.intel.com>
 <ca23678c-be8c-1e3f-4688-67b29770c99b@siemens.com>
 <32803199-239f-821c-7942-748436d53261@siemens.com>
 <20170426090158.GV7152@lahna.fi.intel.com>
 <9a210132-854b-cf3e-da33-fc3d073ad491@kernel.org>
 <20170519160133.ukkne2emubfbrrvg@sirena.org.uk>
 <e224532c-260c-a2df-23be-35e5b3243151@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="raaukt2yjibaci6f"
In-Reply-To: <e224532c-260c-a2df-23be-35e5b3243151@kernel.org>
Subject: Re: [PATCH] iio: adc: Add support for TI ADC1x8s102
List-ID: <linux-iio@vger.kernel.org>


--raaukt2yjibaci6f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 20, 2017 at 05:26:30PM +0100, Jonathan Cameron wrote:

> Just to clarify what do we do here, where a regulator is providing a
> reference voltage and there appears to be no information on it in ACPI?

> Right now we are just going with a fixed value that matches the board
> someone has, but that's hardly sustainable.

Yes, the ACPI people need to come up with some standard regulator
bindings for this sort of application.

--raaukt2yjibaci6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkiuDgACgkQJNaLcl1U
h9DxyQf5AZ1nyzrWNRPzTaMogDQ1tEhSs1HQAMkq6xD0siLsp3Q3ss2VZeXORn5D
uAjEXZKnV+XxlDwMalC8PAMCEIo66iZzvoq0agt0prrwKD/A4Zj/XOBkQTohKaO+
LxLxgtNUdWPZzgC22guz6Cf35D+d+LYci4YnkcfguNoeMJAjae82C9X1zbNGiLxz
7GCOQQJF6pXRzfzENfpk/1ZUT4vsoHFhOGaDGRXtAYaNFVKwvgAOzuppTPsiA0wj
c4MWuZ97BjrBcHU7AHZks6LjCp6w+mCqVbAgAl5hQPAN0SDFEqs/E37cNRzxU3mO
9DwF2mFSfqHTs5sDkAn2XvDH9BNfuA==
=/Pn4
-----END PGP SIGNATURE-----

--raaukt2yjibaci6f--
