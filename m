Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E32396B9F
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111556; cv=none; b=IsK9RDTr/O9MkCmv+rwfiSYMse+lTriIgBIdOj3ACLdTxDrVhrN7ev1CdJ0D3QS6fx1FYH3/8xBrU23ywLJJJzkulVCzUN3MeSbQ2/APZM3rnYvuw3AOobEHA2yTLUNTROoXR7s3ltSOhqw/YjxJvvHfc6ziATmhnNfhEKiQBho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111556; c=relaxed/simple;
	bh=bBG7TvcJENnFYMvO8BCiBF9gagryLSagHnDtoBiXlq0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hHV5GsseqTi0UuyzZNvRbp5L8kIH+Tm/XYpYjTWy2L85Nh2BHQ4oLWRvaYEleZR5m8f2bQK8lJIDfPp2XrASt+asi6ULeFMdNUDazyHvRVoVNGarOu/z59Rbv23JQ2nLRVWWDaVC88jb+SIIzv3fz1j+7GC1JISJY2Q6JSo304Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OD9mrJY4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OD9mrJY4"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so43422605e9.3
        for <linux-iio@vger.kernel.org>; Tue, 03 Feb 2026 01:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770111553; x=1770716353; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bBG7TvcJENnFYMvO8BCiBF9gagryLSagHnDtoBiXlq0=;
        b=OD9mrJY46Lsw10a4CiMVG9aNmEJN+QdGlzXdExlf4aeMUyyEVeVF7jT+3Uv55KN1UG
         QIDE1Xx328cmEXXwpCeQvh7iyy8Odsu2PGVZBprOFqLzyNXFRJSaxNBE6/2QppKyWI56
         fUtp2B0a0jbrt9rpKN6S4qk6ddgljw24lEQkOq0sdMdK7Zr6OOkjvnJkC7ateWSlOx5f
         epEmA5WjoVM2YPS6PzbY2yGt5iroajpaxUI6Oe07Yjq0iLLGJL0QVWsHbm+Gu3NeYdUW
         dhcOZJS75jidppoF+Ji1N/uhjtYs4jrMtCK9Z+zbq+phq42/nJKRlSRbGdb4Mlmdwx2E
         fkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770111553; x=1770716353;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBG7TvcJENnFYMvO8BCiBF9gagryLSagHnDtoBiXlq0=;
        b=UYiMzqh323ehyYxyXmhLm+gIUMs0DHHr6ZgYAVNwPGwGGT2XDPADS09rA0Cg/n5VKU
         sf9wRn7x/vGMi22SQgfkOj5Q4Di0BlWzT2pZg95YWTqENlX6369E1XEjBMgbw1FXIxkd
         t9XzzkXPtxlYr3hyPZq8dQ7pypUBGtoFPPoq5OCK0nvY0szLTIN37GflUAK+rz6BPZ2p
         LRm7m+VOANxT5Lmw96dwN+zBtkbyY0kmutKHk12qB9Jfhz2VIuUvKb2ix4O0sm//WZW3
         B9oN2IY11xn918tKMkXo93cDkqU2znT0tCeGlJSIsdtEDe8bVPclJBT14HJAH2kbZU+T
         TctQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG0rmyq+M0RHuo8dMfAvIODkcbWDy4UzP9UiIA4vK93/tzHDlvcABweXt7/3LdpwP4b3hsWu8tie0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUYlrtRPeHK+vU0UZOMb4KA7kf44bi7JF5GDYujjwow0xQYK0g
	4gR8SsMPcaj8gsjRLeV0AvJE1CTntqc8eAw1SBJu7zM4tYqLeYXRqTQ9
X-Gm-Gg: AZuq6aLRctmquV0trjulurr2eMa4XXkYo+l/SLTdTeoLRfXvjKtCisUtXRFaU/jd8rS
	ISSTXEt3xmFU5n3XFmjrbvCPkidmpQ0vA26z/z6MCXWEvPvtqbLjIGHyVPIDGzC2ZrKzUK4fZmC
	nqIGlADDmDSiXybIDX2/xHk3IieLf6LEIg4bPZCt5V440pPyLOxlJag9efSVrhLTl5Yp7E8/wdf
	Sg5S8x9YfokhvoW7lofEvPS3chJcfysDn6LqaXaZQPvZ15dc50TVV5SEK+qjwVkU/dDZgIQYcFV
	+I+I7pvlo/Y2KC/+Imf7ejdSAjVd4n+dlxhsgHTqAG4hAh2JXugt0jMQkCp8ws33Ti6RGMBhNko
	UvLkOu4JJgK9oY/v9qwv2FbBectF8kOpp7ZJtQRyslknRhNyb8yWWwf1UfoDakA5T+brhQQx84e
	mbgctAhXUMXiaAbhDsRac=
X-Received: by 2002:a05:600c:3e1b:b0:477:a978:3a7b with SMTP id 5b1f17b1804b1-482db491ea2mr185259255e9.22.1770111552791;
        Tue, 03 Feb 2026 01:39:12 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830512e0edsm54373425e9.7.2026.02.03.01.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 01:39:12 -0800 (PST)
Message-ID: <0b16fc61249b507bb65f3f0f4a9c1e5eef4b41a4.camel@gmail.com>
Subject: Re: [PATCH] iio: gyro: mpu3050-i2c: use pm_runtime_resume_and_get()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Antoniu Miclaus
	 <antoniu.miclaus@analog.com>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, 	linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 03 Feb 2026 09:39:55 +0000
In-Reply-To: <20260131164135.35f07a27@jic23-huawei>
References: <20260130153227.213413-1-antoniu.miclaus@analog.com>
	 <20260131164135.35f07a27@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-01-31 at 16:41 +0000, Jonathan Cameron wrote:
> On Fri, 30 Jan 2026 17:32:26 +0200
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > Use pm_runtime_resume_and_get() in bypass_select() and return its
> > result directly. Unlike pm_runtime_get_sync(), it doesn't increment
> > the refcount on failure.
> >=20
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
>=20
> Please always put a cover letter on anything with more than one patch.
> Provides both a nice name for the series in patchwork etc and a=20
> single place to reply.
>=20
> Are these fixes?=C2=A0 What is side effect of the wrong ref count?

Yeps, at first glance I would count this as a fix...

- Nuno S=C3=A1
>=20
