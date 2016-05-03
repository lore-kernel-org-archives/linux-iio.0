Return-Path: <broonie@sirena.org.uk>
Date: Tue, 3 May 2016 12:32:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Ge Gao <GGao@invensense.com>, Peter Rosin <peda@axentia.se>
Message-ID: <20160503113200.GN6292@sirena.org.uk>
References: <cover.1461953982.git.leonard.crestez@intel.com>
 <f22534df-13b5-0889-66d7-e4fb7f480f00@kernel.org>
 <20160502152328.GG6292@sirena.org.uk>
 <572889C4.40806@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YuJye9aIuN0w6xGV"
In-Reply-To: <572889C4.40806@intel.com>
Subject: Re: [RFC 0/7] iio: inv_mpu6050: Support i2c master and external
 readings
List-ID: <linux-iio@vger.kernel.org>


--YuJye9aIuN0w6xGV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 03, 2016 at 02:21:40PM +0300, Crestez Dan Leonard wrote:

> I have a device which has several registers with bits that are a mix of
> "cacheable" and "volatile". For example for register SLV4_CTRL:

> - Bit 7 (I2C_SLV4_EN) triggers a transaction with slave 4 when a "1" is
> written. The bit is cleared when the transaction is done.
> - Bits 0-4 (I2C_MST_DLY) configures the reduced access rate of I2C
> slaves relative to the device sample rate. This applies to slaves 0-3 as
> well.

> If I2C_MST_DLY was a separate register it could be easily cached by
> regmap. Because it's part of a volatile register I have to add a
> private_data field caching the value and always write it when triggering
> a SLV4 transfer.

> Jonathan was wondering if regmap can still be used somehow instead of
> custom caching.

If you want to cache in regmap just write a 0 back to the enable bit
after you've set it.

--YuJye9aIuN0w6xGV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXKIwvAAoJECTWi3JdVIfQ4jYH+gPdHHhwr8Z9oMSAwvGg9u4B
2HkhyrcABJQxFwoowrHADUQC/NZ4WMOpO1hVAnz9XXA2+LU71WXk3n5s/aaRaIPl
EHa4C91kitZvHK4+++4l2n9rihFQ0jiND1/2Z7ufHnDXROHm7/wAGfXUbUWQJekZ
NtVwsjn99TruSGtIB7IH9bv1zmIJu2tCCN1Zb9Z6SHbSsLlT7DojK5vnBnvCEyaj
DaCH9qyj0eDcq58CR9WVQJ9synFKm1/dHJvboWtIrjCF/nLYk/2GHEDimjZJRCJU
xAR6jBfFTTw+IhC9SJ9Aee29WpeJRiHY6gcPU8wn4cHeyteSJ6h+AeHpCFwdc9w=
=/q4l
-----END PGP SIGNATURE-----

--YuJye9aIuN0w6xGV--
