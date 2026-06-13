Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F06E3242CA
	for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 08:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781337974; cv=none; b=ZnwWntrwulTp7ZT35NI+ctE0zSSNr2GInJlcrsSTr4ISlDWUo++wneeW7Z/CogjEDOzimjTcVXqoWGerHz28E75YTE6phvJR1ZIcfBC1JusZ6JQaiUhSBFx81sIdpr1W0eNTBMiuMelGkN+nLgMKVtVTD0fnTmAhIhYOknzaJgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781337974; c=relaxed/simple;
	bh=DeVg0bi2qnwtneVj2BkteKgMLEFX64W6RwZtPGHh8tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQToslXGa3/vEilHsDBbx5F5SdJmuA1XK3p40PyoCJUZj8V9CI16+sR5SZ/zgdUyRh8rdrH6FsgCrBbKipPnwxN6bZTJ54E7s3quoA2qkw9vO/UctCVx/gxVHiGxRp2N6cNnql9FwxKJRR0iiVYYpqakpwt7+XSbUt40PbqPy58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Re8R4t1Q; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Re8R4t1Q"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4908b92904fso19102455e9.0
        for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 01:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781337972; x=1781942772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeVg0bi2qnwtneVj2BkteKgMLEFX64W6RwZtPGHh8tg=;
        b=Re8R4t1QUHquewlX/3eEs2fcHgn3liT9pKxIhr0fGiY0hvffFxOYf6xBeASSbYH4HP
         gpu0168YHHE2Y99c6mxXmKXGltF+Kt6AWC+Mw7C/M8QXTBFeZAR4hzKs9LmMI/XZvV+Q
         PVAjxuejgS6Mte1FLEKSKuuqW2qBtDyxZhSMSQmFk+HK/GN19llpkDkDCXlMSXxLvRSo
         y549bLfvVwykXgcqMMXuMRK5moqXbuP1xqSPrpXlDI1mhWbbBQoAOcy72s4GxGEq/cPv
         4QAybecDgg5yaFJ/3ij4MUD73kd+gNhk5wwLC85NCJQm/uPCtlGY3aLbQvJOQbfggMeb
         XpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781337972; x=1781942772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DeVg0bi2qnwtneVj2BkteKgMLEFX64W6RwZtPGHh8tg=;
        b=C7ZRTTYvmdsNxn8fg0CRhbhebXA6yx8DMW5ZyVckyKkjJOmc9BikxOnmreiiGSh5Wz
         vNogWGh7BsvW3ZnQWk14GR7MJvWkhLzRE5CtQgy4AObmI8hwndmysYmYzINTHI8B/e51
         2e0O7Tq2zAJWcUBqBeC6xK3fBV1gT1VqLi039SKLwaQLFaPs/p5zY/R/cKgsMuy63GlT
         nO5nuYvpt7da2mT+YlSbvXeXq6JI/Lz0T/SVQ5clUBMx++q3ZSgSfWgCZJ/PznffF3TF
         gJOWE0C1dtVUCR13Eqf4mqdhsgBjBV4d8ZwQKXlaWOEfN1kotw+AxCcjVtq7Wp37yDbW
         ZaqQ==
X-Gm-Message-State: AOJu0YzKfIsw1Nu1ka+EK/3yvht2vorcjVcoGmFVUovWJrzFj56/muAc
	IvOVsABBLm0t7v6Ev26GCry6ZVHGZYvO5k8GuV0NmlGot2l6AQmm6+BFPJf91A==
X-Gm-Gg: Acq92OGKDxQuH8vVDfpaCOESmMW9XA7fj8Zw0VbezW3OW9ipoD44Im1XOy891CGSU1U
	ecvn/SKAZn6E7GGKU3nG/b8RF5ortQ9M0KyrMj57Iit6ygXYnVuTOsxdSJnioYFlcdyctcEIGCh
	vAc3X7/CLCw0jUuwrqfCQg1Oi/WyOJ27GXEsqIizdkm1SiNh4RfFO/BQY+cddxhw/XSDN/OEuHF
	sP4KyKSu2lVFvdJzGU6AHShkMwr5Yqb/rvItYSmUBa40KFfWwDrVo+bt+u4PFhVw+DanuABFAFS
	UzwuVrH/UJfAyR2p86k4BmHATzU51AHV9XCl1pR9k8gzEsW/iROrorx6GnHQiYZl1IKj2ANVXRA
	PFaVPKjplHMdjACGKLs4klave1jJaca3+jEO4/ciHMNwfA4nzPAuObP1NTmD2D89dZZk0rqOkKn
	LFXsZmIw5Q6atO+4IF8yyUSgFrdmDqmN498YXLwGNi+JI5
X-Received: by 2002:a05:600c:a310:b0:490:b58b:a8cb with SMTP id 5b1f17b1804b1-490ec50b860mr58693755e9.26.1781337971635;
        Sat, 13 Jun 2026 01:06:11 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49220304180sm53456435e9.4.2026.06.13.01.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 01:06:11 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-iio@vger.kernel.org,
 =?UTF-8?B?Vm9qdMSbY2ggS3LDoXRrw70=?= <vo.kratky@seznam.cz>
Cc: =?UTF-8?B?Vm9qdMSbY2ggS3LDoXRrw70=?= <vo.kratky@seznam.cz>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Linus Walleij <linusw@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 02/11] iio: adc: change from %ld to %pe for PTR_ERR() printing
Date: Sat, 13 Jun 2026 10:06:09 +0200
Message-ID: <rfot56KMT1aR8vVOIe5xxg@gmail.com>
In-Reply-To: <20260604120201.116925-3-vo.kratky@seznam.cz>
References:
 <20260604120201.116925-1-vo.kratky@seznam.cz>
 <20260604120201.116925-3-vo.kratky@seznam.cz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne =C4=8Detrtek, 4. junij 2026 ob 13:59:22 Srednjeevropski poletni =C4=8Da=
s je Vojt=C4=9Bch Kr=C3=A1tk=C3=BD napisal(a):
> Replace numeric PTR_ERR() logging with the %pe format specifier
> so that error values are printed in a more readable form.
>=20
> This change was identified using a Coccinelle semantic patch.
>=20
> No functional change intended.
>=20
> Signed-off-by: Vojt=C4=9Bch Kr=C3=A1tk=C3=BD <vo.kratky@seznam.cz>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


