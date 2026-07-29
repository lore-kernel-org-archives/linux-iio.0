Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A634314B0
	for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2026 12:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785327822; cv=none; b=vEnYRArFf+4EHe0kSYmzHRAQYVux4qgt3IEYSy08VTs0uB/hhcFcn5YV6zlop2HanYoMtvebCgOpzy4Wgka2aZ7Fxkcjfo/AyB3bFt4UjoJZuq2ZfZKhBHNJgo79jjbqJFChwMevkJMmgHU6sMkzIyrT4Dq9TEUn33QcpfHq9hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785327822; c=relaxed/simple;
	bh=C9TEJDpYY6Qs9FGzGqgxmi5b/j0OLmiHaNMCg7TRK3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGdEnjn7cZaUTH/aTHPxQBij2GMl7uP3jKOX+MlIxT6Lo0noiWAYp6baglBN//pOvxI58zFVHqNOV37S6PD2mfvcAHlOSl5egi93hFtGyVg8lgCTjOFdu/Y/rLY5MaWkGGReitPW3ejNhvFjib4sAb32aHXlKpm5k2URA3v35Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=plEDZKfH; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="plEDZKfH"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso612114f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2026 05:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785327819; x=1785932619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C9TEJDpYY6Qs9FGzGqgxmi5b/j0OLmiHaNMCg7TRK3M=;
        b=plEDZKfHrqfj//fm5lTI3mKXDsTCoPvpaOgo94KLU/FyoP25hHOBDYU7+gZ7Ddnx//
         SCKKT89DcpOE8DDqrIBS0kREl5YBM8rN3HJ5lV2CkGh/XCjWIPg37E0uBa/1SvjwNev8
         G2Jr4cFY8YkCgZaOJjRkQpFTJ10rOVC+dbxYEe+mVUrXxQoCbjoM0SU50/+7NHhel9Vw
         YyGmoIUw8rwuoQR/BH1kfYGqWjvtaMPBY1Xt06C8xz4+unTfLu49Ld2Qe93WwBSGz1Yv
         6eNtRHUpbk75ipAMdMx2tL1HUj7CGX6lWVdUNBJ+VAMooTUH2mjo0Nm8CjQDtX44gqoY
         M15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785327819; x=1785932619;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9TEJDpYY6Qs9FGzGqgxmi5b/j0OLmiHaNMCg7TRK3M=;
        b=iGBQwgzufcEVpkRBkV86Hi3ELuC4Exu4fB6kTYyedolmAprJzDP+vtm8KE46zSL02i
         5flsGG6IcZz0Z7cAOk3T6PBMz00bKv7wbTaUoNOFEo3LpGOIvcVwcR6YFUTxNpgOMCYp
         4wgwzft5qfBQDNb77XxQDsrCGrgZIwb/woIcAu0YvMvtLbjX5/Ff0COUSknWqgK4T3op
         kNEYp6YQ7BfqpFAMs1IdfOXQ/ewXyEkWIguMFhf/FUZeaO1IrMZiS95oF75eV0V/5TMP
         5hk+eOD5QTC0IUGeBsYZPcNixQ3SWuMmxsyYkZXoJ4Az0KpQ//NrXrtD9tJnN+qZt6C4
         RmgA==
X-Forwarded-Encrypted: i=1; AHgh+RqlCeY27WzoVRp7Gkz2ILQZs1ngs6gMLphETsnIFhe8+5lsxjfoIyI1gDQsOUlWs+PkmdXnN4Ulxrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx46DedmFq+61pAS2NGf87jMo9fyD8YkIiT89FONbckkXQVLHS8
	7n1cJ4qZVkY/OlmweVh+Dsr5Ah9mPcwGxqzJNJtOX9vngqiCPMlyC7xTT4MmCtfs7CE=
X-Gm-Gg: AR+sD10KUSquVXYlFBp6mXyxRPpXUzR5EGOFT7024OAXXftGJ1gmcl6VZcXGuOT6tc+
	TvNUKEpotNZTDtV34t3Mp9lj7NhYl4O9oD3DYO/mcZ1vjkvu5YlAB1bxoOfWFkxGHAIYtqG+jjj
	wrDSd/rkElMDBAS4BP+Bpx2jZ2S8Jw1PJy5qvL1tP/8bqk+A3lRxWzDDS2MN42z7+IStguS5UXj
	WFdYYgEgXsLNaZIKSTnF9+kp/CMwuGWwIRa7966vdR6bKnMFU79bYzhDhSieU47EBaifRcpLpC1
	7B5f6WRnBJBVfhOnS/phSbwauvqP9Wqybk93XsHtIo0n7xA+ZPjEYrrYozdGYgF34l+Bhvy9juj
	Oo7eAZiPYS8o5nH4quzQ2zFks077b3Y+NBiKaErJvMTVRTEOON4LEmLbolHxobwwQ0oFRVwo92l
	Wr6JA5jhfJaaOK2olNjq9PKzc7BXRatwVDpvEyDCW7fvOfjZCqgIYFXZ+M2vCXoElVNB3Lt6ZNb
	zGgogPd6O3HkgmAjoJJAK1pdS2HN6pSih4d83HxmOtFH9pt/aTEIqjW1YGJ1w==
X-Received: by 2002:a05:6000:26c9:b0:47f:93fc:2d24 with SMTP id ffacd0b85a97d-47fb1ecdecfmr7698897f8f.32.1785327818663;
        Wed, 29 Jul 2026 05:23:38 -0700 (PDT)
Received: from localhost (p200300f65f47db0401da7fd03a16a046.dip0.t-ipconnect.de. [2003:f6:5f47:db04:1da:7fd0:3a16:a046])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47fbf0a4a00sm1380426f8f.34.2026.07.29.05.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:23:37 -0700 (PDT)
Date: Wed, 29 Jul 2026 14:23:36 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add support for PAC1711
Message-ID: <amnwpCYeuv99uQxx@monoceros>
References: <20260728-pac1711-v2-0-609bc026093c@microchip.com>
 <20260728-pac1711-v2-2-609bc026093c@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5uhykc3qqf5i5ckw"
Content-Disposition: inline
In-Reply-To: <20260728-pac1711-v2-2-609bc026093c@microchip.com>


--5uhykc3qqf5i5ckw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 2/2] iio: adc: add support for PAC1711
MIME-Version: 1.0

Hello,

On Tue, Jul 28, 2026 at 03:03:49PM +0300, Ariana Lazar wrote:
> +#include <linux/i2c.h>
> [...]
> +#include <linux/mod_devicetable.h>

<linux/i2c.h> already makes sure that of_device_id and i2c_device_id
are available and <linux/mod_devicetable.h> will go away soon.

So please drop the latter #include.

Best regards
Uwe

--5uhykc3qqf5i5ckw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpp8MUACgkQj4D7WH0S
/k6mJgf+KAbv5DnvJDiMrLYKle0wO1AjZvUzLqKWqEUVDbLO4F4TZgrud6YNe36a
IvDlJrQvkjoBSPlv02r5HmMhmm369PzNTh9czUg+8HLuW4JomalTM0VO14vw79Mz
gCX9MtlcE59mEttg4b1yHexQqZOz3wtsfScxaBC6nrF/4Qa0ZQzQN0VoM/GW3QTt
UMSnLLfuhfD78uM+yikKiU4JiVoLcmc3/PGQbIQaW4fURWftcmonTQnmnnnDXVit
XJ/KDMRnqN5MVtoXKI98albs6RBu60uXcHs8rw7ugFWmWsLgG/g3ugnf9oxV2UNL
6NMgObZQMp0ehA5lFeSjBaaJCdPBNQ==
=oLKn
-----END PGP SIGNATURE-----

--5uhykc3qqf5i5ckw--
