Return-Path: <SRS0=Otvk=B5=the-dreams.de=wsa@kernel.org>
Date: Mon, 30 Oct 2017 14:25:27 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Marc CAPDEVILLE <m.capdeville@no-log.org>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio : Add cm3218 smbus ara and acpi support
Message-ID: <20171030132527.tly4gbpm5wlqio2o@ninjato>
References: <20171027132051.sw5m5iboowlsrxxb@azrael>
 <6ac0c8cf-3ee8-ccc0-75c6-ec87f127857a@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2mywfakmfmugtnow"
In-Reply-To: <6ac0c8cf-3ee8-ccc0-75c6-ec87f127857a@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>


--2mywfakmfmugtnow
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Is there a document somewhere describing what this ARA stuff is and how it
> works? Is this "Project ARA"?

Check the SMBus specs for "Alert Response Address".

Note: This is general info, I haven't checked this driver at all.


--2mywfakmfmugtnow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln3KEYACgkQFA3kzBSg
KbYU/w//SdXtZEHvA4tvSiSPGibsY7zCFH774CwcSxJ3Uv86dln4cXL4wd1/phP5
ShqqXLs0sAOtrnFBNf56qjYXx0/ejF1anlOQ45ULFEN0/KBQlSgTepVKDwwmOvvz
Jd7V5VMAMmyEt5GMwL9CttEA4VQxwTD6rOmjb8g348XCQxBgYGTqmqYpRFhbi9C5
y1R1JM02b16hQX26/14ihX/7xVdj9bmUO4xT6bdMmvF4QuYbT0/zrDK+NqFOoyFS
qmRqcq0T8Rgvjj6d7AnHMjfO4xj44M6L6pNA7me/9bECKh8SzzVIo+0KqnLfL13T
zN8r9Gg7MmT5fxIxfpeWvWgexqc/tw/5iiT81luDJP2nuD2A/OPTZ5r6y5BYsGd9
fbh4OTPb63dGKeexh6szWhxoAz3mPPXE4jm4H/O/edcwLfjQAXer1bJEe5nxno0N
EbJLwbO26xQW0dNuOnihMnURdvqCHsMY8QAaP4IvurRy0LLFlH3WW9l06/BqsyZu
XXnQST+MGbWx+0+1geR4G+D6OSeK4I95R38D9idHnnXUKcRFUaIIe9gzc5LACeaK
mTEnyONbQmIj/K8i858qQkzX1FxyBMlpMzqcwMgLqYFtnYio4JZ8b+vn3EDkWK0H
6ImcazNl6hV2O9vHrNRDAl531FseSStwS5jgvcBb1R/bzfiBaMw=
=8phP
-----END PGP SIGNATURE-----

--2mywfakmfmugtnow--
