Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6FC345753
	for <linux-iio@vger.kernel.org>; Tue,  7 Jul 2026 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414030; cv=none; b=Z6kvdWq8onCRwp0zCGZXQMldKF0ETLYO19Tv6/e9ZstLgOBKVeB8n02BhUbQ99Of3eov77fq9KPqrpbg3u8+4Iz11ASeRocNM01O6BRC5akff+orJrWcFGQJkhUBc1d1xO+wje0hpzDtPv37P+lXG+0aDOCAYyb97Pn9zVkD/R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414030; c=relaxed/simple;
	bh=fKKXULirbAGvNP45qqj38/NkZKNHfc9wpoo35PVZMRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxVhbBgs88Iq0FkicOP1rt54dSJaQ6MzEO854gTgsfxTX6WSmXmdq+Da4LQtNumZF737+8SAa4sDT1F5zuzRDpN0E8+czOX/BBAfwBaiAInwig/af/BXDebdrzZE0lpx1T09IjgROOOJ8IpA77k87b6jKUAvDEzqMkoU3Pf6MgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=KOlAa2jy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="KOlAa2jy"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so2385473f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 07 Jul 2026 01:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783414027; x=1784018827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fKKXULirbAGvNP45qqj38/NkZKNHfc9wpoo35PVZMRg=;
        b=KOlAa2jyR3iYayMm1cYiX0sprV2rCThZeiWJ5XD9kAe+NX4BlMBY3B47y4YGTslDxK
         elb3BBfWYzZf75FeNvqrYqoDhkPNNXxPV0nYzYEEKVkc3AWDeVVX/KJg1QsUqA66WMtm
         4VQtVb9QsKbwzG371CyfZRVQAVdcTQiOjE0ESZIFyjBTxt4gwahnS6WT3lw1xOUcUyuG
         STQJ/W8pNb+svTZHAfoqin2ENfWoeI19FsXe4Ds2BuL4thaUet5NBBA/h4VQP4Tp+kPm
         +Sq1WbY+I00fYYHD3R+27taHn4xwWzM2BsOe7KMK8ysVJ4TUVPkpjxlxzyd9vnUkdkT+
         LMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783414027; x=1784018827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKKXULirbAGvNP45qqj38/NkZKNHfc9wpoo35PVZMRg=;
        b=Mc8I19u9i3KyTz9q/90g6P4r22DwAX9sFbz0NvzBbOPFKO7VJxhnqKm9mxhQojFVUB
         y104z80Q6SR7EDj+SpcXjezz5nl0yI13J3qUUNmiBq1jTokxsLLG1GAG7gfO+3l4AFJ/
         MiNNmI1vl3zVogIybcKqEFvssPwWarDKy3q3H57YV2oz1xy8khLcTiEqISLOk+q/1mGe
         UBgQZMVQnaF0o/zW7PxHSkcUzgLoKuJEdcglE1cDJM9T8rDTHnP9HoGn/3IcjCujTx5Z
         uZ75Mv4FlgdODMTLwvc/8sbyMRhxriqcUVGP/jbhrN9d8UaOsA5VkzXmAjKZN8y1g4cC
         yAEw==
X-Forwarded-Encrypted: i=1; AHgh+Rrv/IE9gMIRzFTxB+4HaVLVJOZMWBubLrFxS+oyXwJvVYedDdDCIHGRjo0Cs2ta6fTfMW/ayxdE+eY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVYqhGk3e750kUkSrFOLQ5DL5R4ewlBUj986f7IYdI8f0h1roP
	fH1fMYdIROW2TLvsdZ1ectF96K8y6VqGJlVxukl5XZ6QBU5CIfFtzRm4SBPV5QXXPPE=
X-Gm-Gg: AfdE7ckxoC2e/O7HdmGaQr5Vdfx18erI1inY4xC6o+vmL7gCi7jZnVkgZ+wfYuBsrFP
	vE1orrBKr07S6Tt9v4ZZzg9dv3Obg6zVVxgFRuAhWZNxRtJe960OLMXLtrPziUFW9mLfbAwO/RR
	6FxWY6MmklFr/9XWV55ZYJHKy5pcolThMq8E/dlJH/vOTzIxk49kJxL1C6TBUH6WztM1js84JKX
	AjHZjswE5dWEOYZ3AmejqLfffkRctOD7B/DM3evIbwfSaVy+wyq3R1DCJ0cSGmVv6Fqjb+xqfsE
	YN8jwQUb3Dy7mUz3sDWkP6SnPS/QlaFb+aK+hguoVv9Wv/3tJVfsqakAMxN88cxIj76YAGM0JB5
	GKdSyV9lRB8hG6J12OLKKPTLgQYP5/nDTcrv7nWeG6bDJ1HjMTvC2Az5UsqorCZ3HXSQPPLekYM
	A+56dWqkmpTv0GBKZrzcU7LLKuOD8ZTMDqiuCaMTb+jm3JOvbFb2A1bgOg/LuhmMqfadlXm8clI
	+5c
X-Received: by 2002:a05:6000:c4a:b0:47d:e549:38d3 with SMTP id ffacd0b85a97d-47de669bb8amr3387505f8f.8.1783414027417;
        Tue, 07 Jul 2026 01:47:07 -0700 (PDT)
Received: from localhost (p200300f65f47db0437b4d928ee3eb6f8.dip0.t-ipconnect.de. [2003:f6:5f47:db04:37b4:d928:ee3e:b6f8])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47a9de1d91bsm36478392f8f.4.2026.07.07.01.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 01:47:06 -0700 (PDT)
Date: Tue, 7 Jul 2026 10:47:05 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/5] iio: osf: add UART IIO driver
Message-ID: <aky8sauMNjNI6XQH@monoceros>
References: <20260707014525.1015-1-kimjinseob88@gmail.com>
 <20260707014525.1015-6-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vz7siebehkiwd6xd"
Content-Disposition: inline
In-Reply-To: <20260707014525.1015-6-kimjinseob88@gmail.com>


--vz7siebehkiwd6xd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v7 5/5] iio: osf: add UART IIO driver
MIME-Version: 1.0

Hello,

On Tue, Jul 07, 2026 at 10:45:25AM +0900, Jinseob Kim wrote:
> +#include <linux/mod_devicetable.h>

Please don't add new users for this header file. Only use those
<linux/device-id/*.h> that you actually need (if any).

Thanks
Uwe

--vz7siebehkiwd6xd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpMvQUACgkQj4D7WH0S
/k7rqAf+LbPo8+ykNY9xw0Yo7uX5zvw8zIpQRAOsaVut0iF6O3dTqNr8kHXqRPwD
fIuXr4ITi19Y815vB5p8z+VBIu3NCRfYdka1CZfe5SQvYX6P8pPcC+11zzFbjQCm
7DagYx73yH1ipHcH8J+sltqsIndT49ZTfr69BLh7XAEVgyWuMWP5hh3sthtDAeLh
9NQ2wAYVLOwTQ5rkC4mLjXkvhsOQ0C9ajZbmlN/541D4atNkkCY3pWnrRE6+Mwg2
YhK/i3ECVtC5qGJ1ABcznW3g8zGBtRbZDVJxOrc5W6Xcig35ffBPz2Ljdo2gyE6K
hTIO+Cq4Hrbsi/zMMKf3NwxHCnuK2w==
=V1H8
-----END PGP SIGNATURE-----

--vz7siebehkiwd6xd--
