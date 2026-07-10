Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B473C7E0E
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783669319; cv=none; b=QmZfmZo4IFebVvj+cQw46qMhL1Rf9RV/9lXeN5yuaiRKJfNfOmMyl1VYvLcfWAVlRCZjjP0/i71EFLWv6zQXs66ifxw4AMQfXHfrf72c6LxVSsPmaAeT7mCg3gVn/S0r9hSqThYCZ/+jz6t7+Pv3rErdy5+/hUFwTBgQu2v6ArY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783669319; c=relaxed/simple;
	bh=T93RY8BFfs4W3gNLpnk8Dup8vZOb+pZgaXNLQW9klgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJWOpJHmKIXs447jhLExDbTUI0TjkJGskX8WwHylVDzoO32NmIgHHcr1kTfwj03MHXZukpozR0NWA8b49/wFhVkGGt+6q5BqpbBDCURzDwJYq4eru4ZnHimIZnaNlROYncMCL+CHj0MDW4FNQAVdF5p/f6YQ+MWsPyPgocbCBQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=dG3mIzjx; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="dG3mIzjx"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493bfe9f886so2837285e9.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 00:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783669317; x=1784274117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T93RY8BFfs4W3gNLpnk8Dup8vZOb+pZgaXNLQW9klgg=;
        b=dG3mIzjxQ19XSx7Xh0httDnnSYTYForJ6fciHVx8gUQFJd9U+6XIK1gkvmyHMJ7JDC
         yQoDniERqe4+o5EwKDPugkFXDjxK/XmYJxEsz0GNRXVtm6Tq2/nTLdH1PkQswkt+XjqY
         f9xdAJQqju6rVrPhyNN5YrfhocB91M57MIPDu4jRBYXJYDthnLE1cTYZFNGyw0vP1zwF
         7ojJQKg5MOGGDq+DxSmE00EgzmqbSKiQDyMprTs4aBSRAKIenM9GbhrBKZtVNa4JKD1v
         i85iA51xutw7njlCUdpgve3v1YSoiRjCKzxyRB63kxtD0cZHPRTC5g1N7t76BoqGsd+O
         13Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783669317; x=1784274117;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T93RY8BFfs4W3gNLpnk8Dup8vZOb+pZgaXNLQW9klgg=;
        b=ghSkEwdxW1wrJ+lCwjZbsngHNVn9H27dE2l3yRN/nAPEbs9ZSdpYDAPw6vY86RLYBt
         VxR+gnfPh9mxrnfyIQv2EtdhXogv/03NQB9TnzfTjKe7F/TI1p57k4E/R3lK6i3nE6jh
         5OoOknCyXVTGCeTc1zm0A1FNem+Lg0GMjiBSChgVxKjEAHyao2xaji5x42/o89nWbjp8
         rkgXuhxkHiVkrrJcWarp1xBF3ZNUq9LvbDgE4e5/oIpWuDyWyJD1yfrFwXWcotJCY+Hi
         f7ffHQQqUALSWWP/GNdIdYdDCvF9LmbcUlBmXgoXyoI8HlbaKI+0hMawtwT/Pa+yCS0P
         2BqA==
X-Forwarded-Encrypted: i=1; AHgh+RpKKSJo7IZsI5+0tLQYaBOowKSCuwpD7z9hbzEIJzWjmu9P6/B4KLbH2MM9uaIX+sDVmvHLtc0T350=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNIPQORWBFnSr1azC0ZmuTu1S6HyPhCFc+w7v3xMuEedM5YjxQ
	1RGNHFAN5bxD45qhfaZq7npn4JZOVBYi+KbLGwZLcNZTac/2KxFeLuW5vw1Y2z/UFEY=
X-Gm-Gg: AfdE7cmuNQYOAuq3HJZKNU/oDSe7nUKlwEdyCkQJsR53wf+y+h+qJf2MetVLUofAQXp
	sjTS16o2m9mNOScdFNX8rh+G7OPKvwIqgEim/Be1E1Nq79Bon6k83K+EhY3Hk36bufNmp2I89Wu
	g6MlXEf652luVpJs7Sv0wjNlZ3W1o1PJzmKIruO6zYuhhy3LFgMUNoCAAUpo7dKPwajl9Fub5Xx
	3KZAE1G3Ag11kSXb0zC+TRhtJdtGy0BKYBRikpraF0iJSR+/YojkPI0kvV8W+4uF5xezc22VBjd
	ukL7WbNSdmtlno5/GvQ1dUkk6Pt8I1T8ekfxqNfzWPBjGfdpO68PlEZHO09C1xcjVi+V3QaVGdK
	6cg6X6JYFDN2D5LD8QujjNHYAefwFi3Zi9E7YOC9zivnkMWmw6HrWPl7HaYcIhOS5N+s3bwq/Vu
	tdQCpHrODQqIo1BeZlIh+IEmllftnrfQAKet7SuUj5vr9UVohjJXhc5J51T4esPFKefQAz0eIqZ
	6Xu
X-Received: by 2002:a05:600c:3b26:b0:493:e3e9:85fb with SMTP id 5b1f17b1804b1-493e685f1f6mr105605275e9.20.1783669316966;
        Fri, 10 Jul 2026 00:41:56 -0700 (PDT)
Received: from localhost (p200300f65f47db04fbea22a44ee9ba38.dip0.t-ipconnect.de. [2003:f6:5f47:db04:fbea:22a4:4ee9:ba38])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493eb6e8844sm130641505e9.10.2026.07.10.00.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 00:41:56 -0700 (PDT)
Date: Fri, 10 Jul 2026 09:41:55 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, linux@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, jananisunil.dev@gmail.com
Subject: Re: [PATCH 4/6] iio: adc: Add AD7768 IIO Driver support
Message-ID: <alCiMwDDBUy4hbt9@monoceros>
References: <20260709-ad7768-driver-v1-0-44e1194fd96a@analog.com>
 <20260709-ad7768-driver-v1-4-44e1194fd96a@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2mdkilrp6cmozhgk"
Content-Disposition: inline
In-Reply-To: <20260709-ad7768-driver-v1-4-44e1194fd96a@analog.com>


--2mdkilrp6cmozhgk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 4/6] iio: adc: Add AD7768 IIO Driver support
MIME-Version: 1.0

On Thu, Jul 09, 2026 at 10:50:15AM +0200, Janani Sunil wrote:
> +#include <linux/mod_devicetable.h>

Please don't add new users for this header file. Only use those
<linux/device-id/*.h> that you actually need (if any).

Thanks
Uwe

--2mdkilrp6cmozhgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpQokEACgkQj4D7WH0S
/k5zhgf/cBqR/U9qN6HSwvEBvsH2YOyi2p7lqn4lGxGpKm0foNPRhW7lOziW1Wqz
oQESCV+7YKOqDOOgBTi5kCK0GDOR/68hQ9jF+IC8vGa4HSRURd5Kgo63T8mOCWSA
AE63f+yQYUH25nYtGDkF2a8Tl1l4A6oCe0IuiDZLx2lLbGWsKHVVdz0shdU+8tAG
9QXbQxmNNlHX9vIlIS4TtbhHo4Bb38pVVGyAyodZyNwEJLvoq7P0ariGNRHIGZLT
rdVbBkVgfUjKWHLpMDTFv9nDJghfDAVMXN5zfeLANW5EeDJvPBPwWFJ7zVdBEDX3
lVGl+K5A3uVTjmu1RkAZq/5JjP+pcQ==
=P41k
-----END PGP SIGNATURE-----

--2mdkilrp6cmozhgk--
