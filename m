Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2C543CEF3
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 12:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031538; cv=none; b=jkCqbUVZSAZCSp2Toy5FOAcXGC0U8jAzIKdDgkgqgHtHtCen9H7ZLaIRvntfvxq2YF9IOlJTEErxEM+XI2haWLJCAeDKcYRTDXgnC9T+iVBi2n4FCsLQmkzHmGqYBr1OB6jNP6QPDTyaxp5Y7QBs9KSJ59VYbiYiT4i2p5gDJ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031538; c=relaxed/simple;
	bh=jhe/rRXPzCANNrMsHe72zPW/Vi3q/jmNvhnQfOlHuhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tN3xQwhYz+f0G3fb1RjtDEUORPRnOfr3hcnzxd/MgrJ4A6pfiJx2HUohQGTd7mwsP3pDpK5qDeB5vqNOFfgwzXRTDWYn5vc051hQrdrpef8E94JgDtMcJ8dNWokSZkD7Kyh4klbGZ14GIqNP0Ip3h3WTMtqbxx9xQBnCIHnSXDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=CEm4PXtS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="CEm4PXtS"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so36353195e9.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 05:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784031535; x=1784636335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1NJQhaiRxRZvI5codpeHWU5ZWtOmLBBBHRcCW2P8aLE=;
        b=CEm4PXtSOywhGpENGcQFRnZ8pq615YQO98zm+ptaCpXOg9iVjKDl+EFaAtjyDzjRSg
         S3LcQ59mBdbCamMgHyzi9rfK9tTCAQbLNX1R4xjLzEZmWOXQKQBRaHZBR3oW/N4hqppi
         eXXVwz8ZjUTKqbkxha1qHmHQR2aNuM2KWII7ujv959lT0Jr0X2QuhjrKEpdDYwgDzQDd
         FVFYAniBFWlwCwmqN0HKeR5kretiOqHff/6+Y9cDTPufdEqOwuSJO14HmA9+AgBVVOBw
         X6MnrPihtlZmAUF5J4ToGZb4VgNDbiIi9Df48Qkf7n5Gh7FF0U2+g2fMM3CGT73kmtAl
         NI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784031535; x=1784636335;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1NJQhaiRxRZvI5codpeHWU5ZWtOmLBBBHRcCW2P8aLE=;
        b=iuJND8tMnBwuHcWS+w9bzujmgrpTfc2ULQbsZzWw2NZCN/O1T7/MbLUnjHUgZL50Hg
         a3QVWfSzazBQVIQq8tcjxhFD/ilkFn8+a9+hdIuI5tLJweL6tdG3t4t2BSUuvLdXFwkK
         Ky3/vXdnrieANhlqKhLZ/L3xYHTWGjF9aghNweO6TCO7EQDHT9GxjVU1hK0vHK6a8Uqo
         eGtQZYEtThglLxx06Tl2/GT5xpJlBGgI5kH3xZkkhvD4tzq2Bh2sLRo0kUqiq78mH0Oa
         +kP8OwsaMYigjYf1lT0Axg4gT4nGmor7j3W3J7dgHvTz9PO+fNc+9UhyEm+GgaapRph3
         vp2Q==
X-Gm-Message-State: AOJu0Yzqnaay4WFmogFkidiu+MKk6j+yAYy85AKjdwMiBPZQ1VAk5yA7
	DM2sre8uVhhB/FAAWCkXWDjAI07wdHo29OW+7Ni/sf7dKZnKJM4lK9A0LiRu244cDw0=
X-Gm-Gg: AfdE7ckR0B/HnV+76OaAjXSLzkPGoft9S3bPrwDZIO9evsm+18t+HBtc7gUl9SurPJ9
	na07J9fetI0KYWNKSBaHhg/uLzOhYalQ+HT7ywTJWjJ5CJisnI5Xj6RDb8wmI/T/ybkSIR2ZH1P
	Miy8mhf1vqlJR/h43QCOM9spn5XiR7s4h/UI1K3MuYEEO0G7Pu1lZhNOnFpqUJce0wOikmF6Xh8
	BsgQXKg3c/ODnondLvuqgCA+/Ws7caOsJNnEwsEw8cHeZXDIilUz1j69Y5dsUAl7VqG3m5oLgo4
	nwG5SRDOBZzbePe8lI9vz0lu7zzvRzgCTNetKMFVvYn72DjwfhTeoXPtWS90n4yevckdovm4XEd
	c5x22mXA8+PFOyqvDXFVjQmxMXAgPdeY35/dmJGG92AYMWKTy84ts+vrAnfU275wx5ACwwFI6c/
	LnkWc2+4buenaGA6WABOtEbDMAzA9Xs+v913lP+5BLo9K0X5p4Pbo4im/zVzd6+VfONQBcxX/xT
	EsCwSKIKdc+C+Y=
X-Received: by 2002:a05:600c:1d9a:b0:493:c8f7:3631 with SMTP id 5b1f17b1804b1-495389bcc3fmr24238165e9.22.1784031534838;
        Tue, 14 Jul 2026 05:18:54 -0700 (PDT)
Received: from localhost (p200300f65f47db04b44a80421173aa03.dip0.t-ipconnect.de. [2003:f6:5f47:db04:b44a:8042:1173:aa03])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4950a322dc6sm75437145e9.10.2026.07.14.05.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:18:53 -0700 (PDT)
Date: Tue, 14 Jul 2026 14:18:53 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com, 
	dlechner@baylibre.com, jic23@kernel.org, jean-baptiste.maneyrol@tdk.com, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org, 
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com, 
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH v16 04/10] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
Message-ID: <alYoUSf_jGegFP9E@monoceros>
References: <20260713215842.69097-1-macroalpha82@gmail.com>
 <20260713215842.69097-5-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hsdmlg2odk4qgvo2"
Content-Disposition: inline
In-Reply-To: <20260713215842.69097-5-macroalpha82@gmail.com>


--hsdmlg2odk4qgvo2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v16 04/10] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
MIME-Version: 1.0

Hello,

On Mon, Jul 13, 2026 at 04:58:34PM -0500, Chris Morgan wrote:
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>

Please don't use <linux/mod_devicetable.h>, to get i2c_device_id and
of_device_id it's enough to have <linux/i2c.h>.

> +static const struct i2c_device_id inv_icm42607_id[] = {
> +	{
> +		.name = "icm42607",
> +		.driver_data = (kernel_ulong_t)&inv_icm42607_hw_data,
> +	}, {
> +		.name = "icm42607p",
> +		.driver_data = (kernel_ulong_t)&inv_icm42607p_hw_data,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, inv_icm42607_id);
> +
> +static const struct of_device_id inv_icm42607_of_matches[] = {
> +	{
> +		.compatible = "invensense,icm42607",
> +		.data = &inv_icm42607_hw_data,
> +	}, {
> +		.compatible = "invensense,icm42607p",
> +		.data = &inv_icm42607p_hw_data,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, inv_icm42607_of_matches);

It would be enough to provide the driver_data pointers in the
i2c_device_id array only.

Best regards
Uwe

--hsdmlg2odk4qgvo2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpWKSoACgkQj4D7WH0S
/k4vjAf9EhLLO6r3K/guJlw31Vj9bk1/VbXkK1ojy2ZTV1OfNoaUZWMmjlDIeiJN
jAPXLjn483i08lLHZTuzuQRVUe6nJ+S+bjtVUOOaPS0d0cgpehOVTCQzZGGYFTrc
j7Oy7IDiQv3oAPPJLc0FD+SPQPLgLvyr7ejigSbTIWMWi61GOj0jIPEOfiF+JDxl
CXZPuX6mCIr7kOETT9GvUsQOZX3T+dOQ0HBvc1an9QbtrqUG0+VFex0Ic3HAzrhI
0Yat0mQBsjw4p96cvfD8Jx4F/9QoadJYRhf+Yk+pWEDbCLksKdClqojVbLVVVNmq
4lva2HNPJjfdFrDJ8RIyfJVwW5ZGhw==
=ej9W
-----END PGP SIGNATURE-----

--hsdmlg2odk4qgvo2--
