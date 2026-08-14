Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AD24137AB;
	Fri, 14 Aug 2026 07:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692619; cv=none; b=Hum81rvT3ZXWocQH8+Ah6iAUK/+e5mlSW5KEoT+Lr9Tzvab+JOWaEFll6l1mqnaWZYEs+K12kbBvYqmcoIMvja8O/aqS/3iRepl44E7iCnHKgP4YOGddf2dLYm8i2qc0FOXPotLEyo3bEuBiHnxHe9CTTCLiefeWwdAws/uL8C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692619; c=relaxed/simple;
	bh=iENJuKUMY8eOPlT9mzKwoNfco8HPAAjNVJikKWTSYyQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=XcE6o+lLIGsLJqewx+eETIMMHEApIE6vZwi6Fo//tkCbRgOOawuXeKzLVyAJmh7UyCCNRIhL929LCb7RjVyibvjjc8POY1XXWEOtTvyP67rvZ4TtuBoDK2QqOUp2yH6LILVM97o8CrJcp1z//Q6TGElcqjOp7u0m0BLAHiu+wP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovGyXzlR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovGyXzlR"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DB9741F000E9;
	Fri, 14 Aug 2026 07:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786692611;
	bh=fAcxQ0KOUcMWRzzlTnz64uZJ6JDOLh/7o7dkLSx2CnY=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=ovGyXzlRxmXaDYtef4aGoHw9YOqBv59qswLEUBFUr6bbFZySUTas9ByaDK3LrynfE
	 YqrzlMtkaSoxp6zIwZIlh9/isbICI4RwwGj+0OB4bmsMctsdksXyvLZxnUMVSYdEBs
	 SkRWEKfyxCRXCetlihJTFMd1ylLG2XFwaNhReVShHBEcUGpxb6bKPcnMHVJ5OKQgKd
	 0EPMDFBUvnJ2mgEy+FQq2UqmYrPtWDm/y3+bJdPWG1NfNZ7nHKvRW8KQ5XDUpfRYsz
	 /yHvJhMMMmZOmVj4GRLxAHEIMKmzSZ+rBRRdc/fh+R6DyqWAgytS5qYq3GvCErCHMF
	 0OEBZF78D42jQ==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=e50af02b9babad11da73eac21cd43fb816234b4908fcfdb70e72eaf484ca;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 14 Aug 2026 09:30:07 +0200
Message-Id: <DKOHO4TEW9SJ.1952Z1TEMQ75T@kernel.org>
Subject: Re: [PATCH v3 12/14] gpio: regmap: Add optional runtime PM support
Cc: <linux@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <jananisunil.dev@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Janani Sunil" <janani.sunil@analog.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Michael Hennerich" <Michael.Hennerich@analog.com>,
 "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, "Andy Shevchenko" <andy@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Olivier Moysan"
 <olivier.moysan@foss.st.com>, "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Linus Walleij" <linusw@kernel.org>, "Bartosz Golaszewski"
 <brgl@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan"
 <skhan@linuxfoundation.org>
X-Mailer: aerc 0.20.0
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
 <20260813-ad7768-driver-v3-12-cb554399ad26@analog.com>
In-Reply-To: <20260813-ad7768-driver-v3-12-cb554399ad26@analog.com>

--e50af02b9babad11da73eac21cd43fb816234b4908fcfdb70e72eaf484ca
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Aug 13, 2026 at 3:57 PM CEST, Janani Sunil wrote:
> Some gpio-regmap consumers share their regmap with a parent device that
> may be runtime suspended. GPIO register accesses must resume that device
> first.
>
> Add an optional pm_dev field and acquire it before register translation
> or access. Release it using runtime autosuspend after each operation.
> Keep the device active across the complete direction-output sequence and
> propagate failure when setting the initial output value.
>
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

With a nitpick below, that if there will be a new version could be
fixed:

Reviewed-by: Michael Walle <mwalle@kernel.org>


> diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
> index 06255756710d..aae32a569914 100644
> --- a/include/linux/gpio/regmap.h
> +++ b/include/linux/gpio/regmap.h
> @@ -29,6 +29,7 @@ struct regmap;
>   * @reg_clr_base:	(Optional) clear register base address
>   * @reg_dir_in_base:	(Optional) in setting register base address
>   * @reg_dir_out_base:	(Optional) out setting register base address
> + * @pm_dev:		(Optional) Device to use for runtime power management.
>   * @reg_stride:		(Optional) May be set if the registers (of the
>   *			same type, dat, set, etc) are not consecutive.
>   * @ngpio_per_reg:	(Optional) Number of GPIOs per register
> @@ -92,6 +93,7 @@ struct gpio_regmap_config {
>  	unsigned int reg_clr_base;
>  	unsigned int reg_dir_in_base;
>  	unsigned int reg_dir_out_base;
> +	struct device *pm_dev;

Why wasn't that added at the end of the config? It (logically)
doesn't make any sense to just put it in between. Just put it below
the irq_domain.

-michael

>  	int reg_stride;
>  	int ngpio_per_reg;
>  	struct irq_domain *irq_domain;


--e50af02b9babad11da73eac21cd43fb816234b4908fcfdb70e72eaf484ca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCan7EABIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gpkQGAuMtOcBpig/wiKXRZxo5dnZWZytuizi81
9gdKnnLs2SwWDhVWeMI3KqyskL9c8npyAYDxudngtFW003ppqWmitRqZajlOE5Yc
aqIa4ieGjeGa6vIw8n3kW7J3+ulzY76wN80=
=UzzR
-----END PGP SIGNATURE-----

--e50af02b9babad11da73eac21cd43fb816234b4908fcfdb70e72eaf484ca--
