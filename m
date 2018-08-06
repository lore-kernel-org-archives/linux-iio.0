Return-Path: <SRS0=M1Cr=KV=sirena.org.uk=broonie@kernel.org>
Date: Mon, 6 Aug 2018 15:39:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	knaack.h@gmx.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
	davem@davemloft.net, mchehab+samsung@kernel.org,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	robh+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: Re: [PATCH v4 3/6] regmap: Add regmap_noinc_read API
Message-ID: <20180806143901.GP2414@sirena.org.uk>
References: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
 <1533557087-10401-4-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p/1JFEOz/hVXxMAZ"
In-Reply-To: <1533557087-10401-4-git-send-email-stefan.popa@analog.com>
List-ID: <linux-iio@vger.kernel.org>


--p/1JFEOz/hVXxMAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 06, 2018 at 03:04:44PM +0300, Stefan Popa wrote:

> +	if (!regmap_volatile(map, reg) || !regmap_readable(map, reg)) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}

I suggested having an explicit operation to check if a register supports
this mode of operation when I reviewed an earlier version, I didn't
notice a reply on that?

--p/1JFEOz/hVXxMAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltoXYEACgkQJNaLcl1U
h9AJdAf+MuzrfAjV3XR/vvxIWIN5fNHaN8p8i6B479nzAsnIRY/IirqmWxYZ3+X0
7IJOxtvbmZR6EW6VVT5ccTAlAnbrduCT11AbwOpLDYf8Zkjldv3AfepOURH9lUI0
2/Ve5mb3F36MLGvOBqqdVKkAezpPb+MrWc44HuSofWo85mGGTeBWlMV7UGr26/HZ
uMYXA55IRthFAAHjrkVDRt/Y4kYmzRtBJNt1ihytVH1T3OMjyqdWeE3WGA50uv0r
GIZ3RIB8t9iiEFWFVxxR678VNa6bSBy1CjHyGN9TKVNPpwBEqUL11ToBFiobr9Jp
ef5nNuAxn/I22hkhVMmCRQCU01V5DQ==
=Prc5
-----END PGP SIGNATURE-----

--p/1JFEOz/hVXxMAZ--
