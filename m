Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795001431;
	b=M9ywMygersEZQB+QNwxyBIhDE3XsLw1/qo1N8j4XS+B+gXPqhyyCXLmhDS5+A576CgTs
	 MTuE/HD76kEbGKNLp+TA5gt37ys+HHaTfC6iR2Om/G5MwhstN3PhSFhYG9GH47XN3VTzb
	 E07MzbywzJLfv/9lBHrMW1DGVShxypRdSQWjH899tJVEIecbBpIdB3ycmgB/zR9tnNN9h
	 uTvsDwzO0PE8GS+A4rzzfP5rt1aRg+W7jFgCWxm/MIkerHyVJ/abNGUeXjBpZrxwxC7Gr
	 Wxy4vgCPM4M4HW4ZRG/Wr+0iSx+t9/LaAUiiwDWp2rKv21tGabaSGoKdK7Q8v6JsKEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795001431;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=Z75hr6SmLYWvtnOelqxQFVBcQ5cH6DsL8tdhf209THk=;
	b=ypysiUyj8ZYgQrvqehCIdwLQ7FB9/dUgPUKEY0n55KIgiQmsQRVT2QyhMZzscdRHPhS0
	 VL7oC6K+vkjn+l8isfpcAfM3C00jRds+4j7EY24DwRgLYEeoe4mlyZwG3X9ZodN0wkNv4
	 tevCjhWGLo8BqeUiRdKnYIk/bEIzi0aOlEUINCz3sJFh0biGSahZOapB49BNQMX8eQchP
	 AWJ2em/eW3HhEF+jGeVPe8GOEOPQD9pxljOAey0UjgdhuGWYoRmdvrlJWpFjGe4vVqC3n
	 uSf8RA7Dg5hdYBDFe5TNLGYcPsqCv7SJW7XZ7He/4pj5CZAZVcTrYH9hftriPc+Xm3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpPYl0jx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97713606A320;
	Wed, 18 Nov 2026 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpPYl0jx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9401F000C4;
	Wed, 18 Nov 2026 11:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795001431;
	bh=Z75hr6SmLYWvtnOelqxQFVBcQ5cH6DsL8tdhf209THk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PpPYl0jxRytdIpYJVgujuokjsH3uezcSkC88kmkC7/h62CXproAcU9M2GdiJDawQv
	 5+ogBfvjaLfbKfhhqODJjrPQADU7rRPy6qRIq1gTO198xRiY/Q1SQnBrZfcT6RzJR8
	 XSvDBN/KRhnw2VhnPEf1zLhxtqI8RH1ArL5N2aALvbHg/cebnXYy///VPjFSGRjJpu
	 hxgg555qXVsFzNKKspl6nKnQBuTzlB006mFminqcgU+v33/AyFdn/MhhV6n26MM4XG
	 29rKoAYP0mxd9rLAoQvoGP/owvb21FAfSgpHlaRBsz2hCcojKLvjmYGNVSRSN5jDIe
	 QOB/+T0INllAQ==
Date: Wed, 18 Nov 2026 11:30:26 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: raffaele.tranfaglia@gmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH RFC] regmap: kunit: add tests for values wider than
 val_bits
Message-ID: <a93f6d11-22a2-42db-81d8-297240c9bd2d@sirena.org.uk>
References: <20261117-regmap-kunit-val-bits-v1-1-a1cd02063217@gmail.com>
 <av1qOFxolvDhQTKs@ashevche-desk.local>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IwlD1OsplhXpBGsL"
Content-Disposition: inline
In-Reply-To: <av1qOFxolvDhQTKs@ashevche-desk.local>
X-Cookie: When in doubt, follow your heart.


--IwlD1OsplhXpBGsL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 18, 2026 at 11:04:56AM +0200, Andy Shevchenko wrote:
> On Tue, Nov 17, 2026 at 07:55:14AM +0000, Raffaele Tranfaglia via B4 Relay wrote:

> > +static void raw_write_wider_than_val_bits(struct kunit *test)
> > +{
> > +	struct regmap *map;
> > +	struct regmap_config config;
> > +	struct regmap_ram_data *data;
> > +	u16 *hw_buf;
> > +	unsigned int rval;

> Reversed xmas tree order?

I simply do not care about this.

> > +
> > +	/* The "hardware" should only have seen the low val_bits bits */
> > +	if (config.val_format_endian == REGMAP_ENDIAN_BIG)
> > +		KUNIT_EXPECT_EQ(test, 0xff0f,
> > +				be16_to_cpu((__force __be16)hw_buf[0]));

> Do we really need those explicit castings? I think they are already inside
> the byteorder macros. Also we have be16_to_cpup() and le16_to_cpup() which
> might help.

If we do need the casts that probably indicates a problem.

--IwlD1OsplhXpBGsL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr9jFEACgkQJNaLcl1U
h9CndQf/SewsAZTR6YVIafssLoLMkykhXhPc0/UkWKTWCpQU9/KU8piCxKw5PN/i
XKSPGLjx2qu1axH+SXGdmQLRxSiWJHSUT3BJpZbtDvpfoiEV1QmBYScztNhLBS2a
BbnJC0G6+Q67Lzphi7bx+DjRTnlhiMyXAEFbUTHwFnb+4PQFhpn7ycuf1LqQe/Ub
IR3sz7V+74rEKeyC5H525UXdd0uLx0r4wKwTmuloMBkoxThJKcSIeSxipg7djNVh
9uMC2HYaJyMyNt2m83PQWoZkJU7H1K6SN5PJFeCdixEF79pQCuYJSdFDSWmZO6Kx
HCR/LY6sXtvwwelZCsQfPXjyxyyhig==
=FLe7
-----END PGP SIGNATURE-----

--IwlD1OsplhXpBGsL--
