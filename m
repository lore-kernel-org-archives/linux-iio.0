Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C34A348C63
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781803552; cv=none; b=sdLOj/pe2RFz1EjeRH7GrHdu7Ko3H9kD9EIJy29P1uka63UMmmzD5BNI5541V0n09UP9BhArPfWNMcK1N/tGQ3iMo6J2BcB00h94DZMfpGUcm/BhkIgxxdzs6A21a50sOLQiGKKylx5f1QIqGEpyHjXtQJEWOgP20SywxsTZIhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781803552; c=relaxed/simple;
	bh=24kM4g3+wISlX1NWkhO/TxdeXtJj2lsQ+29OTn6CdrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2C/V5AScyl7/+2XDBRXWk8xMSRwmVPOUEsUaVBISzLoa6E2pPclWuhnprFFL/L97mYZsndPBquUkpbApzKL+tokB18NiGFofuJrLHWuABqD0IFqMD4a2cgIgpZnFS8p1RCg5i7uLPvM0Ir/1eKX0gDSgtVDRSdfFcwxGI1S//A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=nXc7jAnr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="nXc7jAnr"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so8756595e9.1
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 10:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781803547; x=1782408347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pUs1pCYfgyslcqbM0nVDJGJ1LjB7KId+9/g65IhvUEc=;
        b=nXc7jAnr/vNQgi4/QSm9DQDXbNNZ2zEFnh9uqAj0jZlRtayFwH81ilQw7tYercoSj5
         lbaH6AHXZedZ5mGnoqWbDArmrHU1ZjcrhbmSPsg78o52dCzEeDOu6nOPud+JnfUCG/FF
         5THhww5p5vVc+sf2fiTFo9yD0x/X46s1I38i63XAxtQh4eUvEJuC0DOQlFCn52/TX7is
         cIaRSIrLZ1xeqzDsYpiIsf4ugsmrFTDb1WO9SjbSQxwxEjJCSifb3rZ8X4kcMBEkfkDC
         mc4DY8urIsIE8WtlQguVywni3ToAfm4JE3O2Gf+cIAUhGQwAKsh6d1k1MWomsfUy64Re
         zVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781803547; x=1782408347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUs1pCYfgyslcqbM0nVDJGJ1LjB7KId+9/g65IhvUEc=;
        b=gHJf/sBjmIOIzk1nbWCjBsQolTMdJWL1/Bm3E1VAPcYJLDSoizpCa+/s0sbF4333TS
         bUG+zECkgmZuvH6lOrwoj2nRWPL3+Nu7XEKleZ4Va5O3mqhdyT5sg+OSyJKG8ExAtKjy
         T+66DlmMAY+dtmRdd6h+wJ0WnPW7HS99/6GCqD7NRAraut344QLJcl8VyLDRGLZOiANP
         2KRm09Xv8UjaLVDzQvDcQV7KIsgKWOexh/A64euUV4YwUIl8hzfnKgxz5RfIzDgQ8UHr
         EfgdTtp0Nump1R0kGb0KFkzIizf7PsXg4LNdjmkyYvdBFOr1EDmvkTRilDWBOxex3fIC
         2bgw==
X-Gm-Message-State: AOJu0YwVqL1O0vq/VFnYqPqa7WlivzR07MUicJh1HJQj0WPKh1jZ7Dey
	9zKjHcCYrAv9B0Y5HH9ec64aoz5Chyrxbrcgckr6Jnu4R/DgfkY3e6ozxRZ/fLpBiM0=
X-Gm-Gg: AfdE7cluAHsJwc8UCRbfqzn8kuBTyjwvzygn+0eTYdCZl7ATTEI8zW4eJvghsgX19XJ
	HqvikuxnyYFypvQo87hevO5PKqJdM+p1V5aOEWCCbOoX8D9wIP9YwWuY7FrIK9R+0oj+m/T8urN
	MsdsENlrMBGy+gkUOYWSZ7SlGsyiW+kQg+E/EWs0cfXee3G8o4xsfsWc22kbSzOwBFVq1f9zhIq
	9j4IsXKvB9Mhe5R3q95oCF40OO055WH8PMMaJjNmOjly/nYMMU+5Ss6PYXhuizi3S6P6JxhKR7/
	52nlJ1FyElgaJxFSaZORb/xvfPe+jF39YmPahyllIKth09k5TCLtgpLxTQo9YwQHpEIWvgdQU4k
	9b7PapjWTTL3fr247Y91wMJe6AEOBDiF+IKRDs7AJ5IuBWw6Blk76GQOio88SftTN3c89HqQC6h
	/xzpgEqUSeZuAMJji5K2bOypzvXXU+Yc7ymA53bV/UmBcfWfsSwPu/jECQGhDCsUpL08YQFygXw
	dBZ
X-Received: by 2002:a05:600c:3e86:b0:490:e18f:d112 with SMTP id 5b1f17b1804b1-4923f56c1b2mr8389095e9.21.1781803547407;
        Thu, 18 Jun 2026 10:25:47 -0700 (PDT)
Received: from localhost (p200300f65f47db04cea0a59ab11cac9f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:cea0:a59a:b11c:ac9f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4923fd33dafsm4270305e9.8.2026.06.18.10.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 10:25:46 -0700 (PDT)
Date: Thu, 18 Jun 2026 19:25:44 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: magnetometer: add support for Melexis
 MLX90393
Message-ID: <ajQpq1yzA-ig2c7s@monoceros>
References: <20260618160141.11409-1-nikhilgtr@gmail.com>
 <20260618160141.11409-3-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kc2atgzcidxkklwd"
Content-Disposition: inline
In-Reply-To: <20260618160141.11409-3-nikhilgtr@gmail.com>


--kc2atgzcidxkklwd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 2/2] iio: magnetometer: add support for Melexis
 MLX90393
MIME-Version: 1.0

Hello,

On Thu, Jun 18, 2026 at 09:31:41PM +0530, Nikhil Gautam wrote:
> +static const struct i2c_device_id mlx90393_id[] = {
> +	{ "mlx90393" },
> +	{ }

Please make that:

	{ .name = "mlx90393" },


> +};
> +MODULE_DEVICE_TABLE(i2c, mlx90393_id);
> +
> +static const struct of_device_id mlx90393_of_match[] = {
> +	{ .compatible = "melexis,mlx90393" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mlx90393_of_match);
> +
> +static struct i2c_driver mlx90393_i2c_driver = {
> +	.driver = {
> +		.name = "mlx90393",
> +		.of_match_table = mlx90393_of_match,
> +	},
> +	.probe = mlx90393_i2c_probe,

I guess you want

	.id_table = mlx90393_id,

here.

Best regards
Uwe

--kc2atgzcidxkklwd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmo0KhUACgkQj4D7WH0S
/k7GrwgAu1DSqOXoWtneHXUsxpm3BPvSSx7V4coHsGQIVhGMIzOuHlj1DdyrM3yA
NuShM18WdXvHIZetC+I9MmN4vpQhgGcJKIe9uVh432ZK3s8JWcoOIOGufiLYTp8M
Yynw6i077ytTSA6K0EYger1u/6sYlNh2rBAqe3JqLQ3AOceOVzrtXF3XaVvsRxcI
WkaJBl9JnZwqidb063RRszj/iqWvAnMHz0VJocZIpXiIpsuhl+8WIzyITLEqGD8B
j/FG79DvaiU5XsFollRc2y6zgN9Gr1sIzeiugDciAJgy36JGKnKq6PhkzEA2jbQP
eF4QAbGXwI/F6wUFbhl2+Mw3U1DOKQ==
=EHbj
-----END PGP SIGNATURE-----

--kc2atgzcidxkklwd--
