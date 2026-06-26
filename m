Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C5A3EBF01
	for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782477529; cv=none; b=edYaJhzc40t/pJtB6oaiN8F0hgv8Kppl8vFakPiCv6rpYN0nr0l7EBTqtNtB/ay7IKPZs8PjbisB0cA1yZmNy/6NVDFHWOrPM+/744nbAieyVrxP+/oKypfZKmuIUUepOC4K88Fz2FdsN8/5NdxYgDptPA98AyKKwsywHfX8+/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782477529; c=relaxed/simple;
	bh=hu0SCgwCfY0yz/mE0xVirYl/PDMPSCl8AX9qMRbT5xk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3aPV+yb66ZqRPmK6kn1yRtlHumOtfGASnJcYEdIH8h/heIQwlGZmdS3WR/9ZtIp1/q9v5B2VoOI8XH6A/VrEKgyxvqGPdC4r0vlhc4AzHV+o/w9njhO6qNI00w96a1EghTp4ayG2geTV9XJD7gXSxc3pZLrVGJ8cuYwoB9BuEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qMIPx6Ob; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMIPx6Ob"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4923fb1f095so8893065e9.1
        for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 05:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782477526; x=1783082326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13+1JyTSj7Gptc3kEkYewUZqpLdvoXqNZ1OaTPya0TQ=;
        b=qMIPx6Obioy63qItChFG9qVpTwzCG1oQ7PF6MXXOTru886Izacrn4J1Sbx4potx8OS
         KTE2Uc2d0GaszI6yvzDnwlU9G8qQYMMHECBKzVt3cbdrZ6k0CEJGwYgeqqF6xvQuk04Y
         mZBdMNkzOjjDw2e/dyKtBI4imaupZm9CQSVZCRUfsXfcs/gObo8D9OriwEoAFeysNsWR
         0tNL0aSyT1LrL+IyLq2kqSsenkBuB7N82RYqwnKFcoJJ9uCcxf5pZIQ1B1ZVWb+9YQCO
         SEdwtfgziP1dStNoFlsLCyncqXpDyhb9J7UI3Pt+tcQW9DuG9i9NhZvWJzea3QGoLqho
         GG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782477526; x=1783082326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=13+1JyTSj7Gptc3kEkYewUZqpLdvoXqNZ1OaTPya0TQ=;
        b=SO6rdLXLc07j/AP9VxsvH8lClf2YnVusRhHBr496IMaBR5/v6YxK8kW1VKDb/uBobb
         vXCGNAxvEkt6pqJLzTGk47JyxjTmX5LX9Ce57trqqPd3ibvoJnm6EDORz8X6SM7fbK9Y
         DA8qRBlx78VQ6RVo6li6yKe67CS6KDN9wxxYE9JYwfaLlsXi6J18JZw4VFpd7EVUTlGo
         5aPbgprbGCO0atiJ7wlKZef37HnHFiXmJcij+ah8GhmjMLlQli3bKgzqc8mUZu5CbgjF
         E99WubKuyBRSjIfiErZbZcOxTsUNZ/rNMkp1+khUzEM3hcQmNHIrW/isku7PPcOspTE7
         nBww==
X-Forwarded-Encrypted: i=1; AFNElJ/9+/+3sG9iLB3TAT0qbvAMMCfNMBfvV+g1MPjyBe3nuFJFabtMDSJ27hTtMIE1bIixjQnDLmul2yM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpaNUTS2DXFdDUs2ASBnnpqifltKnOTzAhnEsrOxY0e/a+PNIZ
	AMqfFJ34ZLqPfswfX2x/OSF/oY0cs9T/akI7tNC+X6YZQs45zDqH/h6L
X-Gm-Gg: AfdE7cmKzWi9iDMJ71Bto2QB90n8i+Wec5b9d1w8g76emZf0BCcqEGsGiaY9uEh5xoL
	l+ww0+g8qHNLx32vf/dDT5k4Y/ftzicJTQWMfyc7c6WP3V0Znm8zelkQVexUwo7AxZfInnnkvRz
	U4Vj5KWaU7IhUMKN1xpnu5Hk1qxQjGmWU089ii8XFjl/nrpPHuYCEVWpMNiwHFEHxX06L3/y4rt
	Fi0uQibE0+2qpSsmffYTDns2z2RhMhvkeOTCGnGWDQmAEJZyCWW/P+BeqT3ollbCJxRQG6pG7Hf
	tu2LoYiAMhFJyWvRy/pIIFIAUlEr0UMCTlYsjdNx6XcrF5AEES3VTX0r/7dcG478SETO9SPrhk3
	xN1ObNNro+7HYrYhDr8pukRqc+EUCXAUb3mkn2/B/o5Ctd7TkCO9GsBuUFrtIh2ShqSlr0vwEPh
	S47fEA+wm3d3idzzfb9YgokKPbYuMZZVLGzFFIonH2wuskc1MYjlhWkAZ+C9HIzyYWDY2+1O5bN
	bjHbsTQPO1W7t1OhNaehTUc8VEFSY3SuCvxReGVooxFthHaw8wKy90mfqxkElqpmeZLM5W/JUV3
	B7m9oSdZItJG+hHW9LgXpjst9aD+pBPoQSDKMrudrdTaKU3SOWIanUM=
X-Received: by 2002:a05:600c:3b1e:b0:490:e190:3b50 with SMTP id 5b1f17b1804b1-4926686b374mr107679545e9.9.1782477525380;
        Fri, 26 Jun 2026 05:38:45 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49269020266sm73586345e9.15.2026.06.26.05.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 05:38:45 -0700 (PDT)
Date: Fri, 26 Jun 2026 14:38:43 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: light: al3xxx: add missing REGMAP_I2C to
 Kconfig entries
Message-ID: <20260626143843.00006fd7@gmail.com>
In-Reply-To: <aj5v3rDRlY7H39Tq@ashevche-desk.local>
References: <20260625-fix-al3xxx-kconfig-v2-0-796cf8d7cc49@gmail.com>
	<aj5v3rDRlY7H39Tq@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jun 2026 15:26:06 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > drivers/iio/light/al3010.c: At top level:
> > drivers/iio/light/al3010.c:48:35: error: storage size of =E2=80=98al301=
0_regmap_config=E2=80=99 isn=E2=80=99t known
> >    48 | static const struct regmap_config al3010_regmap_config =3D {
> >       |                                   ^~~~~~~~~~~~~~~~~~~~ =20
>=20
> Now all is better. The only thing is missing is Cc: stable@ line.

I knew I was missing something - must be the heat!

Hopefully Jonathan can mark it for stable while applying.

--=20
Kind regards

CJD
