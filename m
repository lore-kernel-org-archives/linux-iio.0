Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795818740;
	b=l8iRe6JxlvuYoWDLzSdo77q0MNadPpxtV1LfPKOdO5myAxf9IHUfMOjs4XndAqkBl0hF
	 8ylCpJD8eR0G8MBERNnclR9uZfsj12/CLeIWp+dYD8b6byXuNlDd1VHbWn7Tyvgl1HEnL
	 5Dm9FmBZW8UTGeL6zb8G27sMaogcilNMeUr8fgm3ZHt9t8HZoX3PdAp9Plh5AGgbHCOJr
	 P5Al3APMUmnYyPx/BtQEoTyjsZAckogv4MdFYHbe+D+X7GWv/ctEYPDhs4DfbRGNO5XYU
	 gqC85KdgcbwTvz19I+UNYX9wQPfh90l6wzh0Kr013eqNkBtFjiYDxQOYX56uR8yjUUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795818740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0i1G/+YpV4sZoXtvA5HG/1gUD16tCeL0tcOTZF5OSg4=;
	b=mRfliF/ykpttp5b7+JpbQfKEvb2eogb/oDW4zvLwOJpr8mPsLN6I2dNP8VIO7VU8K8Lv
	 ThG+GGSJUq+kpP2TIJE+RjHPHDlmC1uYk8yKPx+QtWKKGlM+rYs08ep3gJcmt9Ym21QXG
	 GQ2w84vdnDDyuhPWD1DhLoT8ML05GEnHLV5dqfhSz9/YlhIKLVpj+O+fjNHyLBDYNteun
	 ns5b1IHiR9v1BrDu1zEcUsGLEMGZ8ZwMWEKOLH+EFcS55bypaq2DZRsV6kGHvVMsy8PPq
	 6UKmG2kdWkpZWOdxnmDTyyfnOK1qjPk2mwBXazwxjlF2HND/pgbWzwEEFIajdWGzTBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AH0UC1Ja;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48D4606A339
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 22:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C48D4606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AH0UC1Ja
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e46e449e8so5639458f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 14:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795818738; x=1796423538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0i1G/+YpV4sZoXtvA5HG/1gUD16tCeL0tcOTZF5OSg4=;
        b=AH0UC1JaXTdM1K4oaYPHTi9yx537Mf0QnZ6//35H1UjhlmcoPR+ROTsEPP7PYipi5f
         aEiLTiSntKha77pfMTEnwB5lu8RM5pW56Qg8SmxAluxiW3RVNLBCW1ltI4GYMY/MT+fQ
         vHhOfr26GTL7STS3wJ7FmAKeMelcRh9JWSAZXg3vfBM+shGpPwxxCFGYOvsBQDGF9A5b
         5iOC/RQ3Axju/x4Uh95KF3FIsPX0qwgq6r4Mc8oEWvL0gSDiuvvRzzE20/uzR253uSI/
         SEbSgfNAhmNZPfHEtIjd3Fpd4pxCtGz293JYyVbHhbzcIO03neFYkZCQUm7v6iGUMGdL
         5wXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795818738; x=1796423538;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0i1G/+YpV4sZoXtvA5HG/1gUD16tCeL0tcOTZF5OSg4=;
        b=V4W93IOKQ8fxBAclqQwcxVx//EA0PEc/7PqrlhTs3QbFSU7/Fz9BBSAmFvt2jJctVp
         qMCI1BolF4/ByvxKjjiUTs7Qvb+APN2QvCbNciSAfM7sZiVnxVusojGPnTN9tbC0I4AN
         Rva0mRH8LZ+YFrqf9X1wVSmowkITkZ9iWpDqfdqezEeT8fH7bT+V5x9efT8wsz8SMhX+
         Gzg12Ke1SLk3clxWW8bY4FKckSVS64nJwpjnVTvrdW8IykhfpSS+tV3IUxwgm5b0RgTx
         xM+KJKfhKpXQz/Boezk3tUc8YqxHOKcQIXt7SwKn0ZWD5TRFEKCF7D94ZHqXlgomZufH
         ukYw==
X-Forwarded-Encrypted: i=1; AL+hErGzDnT2sFxxaoX2JjMNdlH6P4oDJQYPJEIUYfddU7kej/GF2NkC9uVJnKkQY9U4CVvaLGvasidwzR4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Fv2SE/aY12Qnpke3ik/YImxcHVRxC0PkOmeTUBUqUjLLar+1T
	psdzm42VECX5km5POO3bxEQlE9XhNSdxpSWDHqshSggGMaEgAdy6CkML
X-Gm-Gg: AZFdTZecMvtIqnqwjSp63A8LUuLci2Dkfm8TvlVupV7lFyTPvQ/wZnx8WDNPnf+Ltmc
	0qmcaGJ4nhj5Dseki4577VDA6wOYbD4vf8CUImX6OBPbFYZNdpisnPpV+AHTkrXxeV2Us6KR7Xm
	ecND6otnglXTeKEbvnLfT7aatzma8pCUqmA2++lKga6hOnlCBNWnpNOTJ9zKpcZTldOEEMEIIsr
	uCGGQ0i0R8cE9Zytz7BL/dkO184nhsmmzM8TyiZ6cPijJD3ts9ef50ph3phenLYQ5H9Zr4Uz6P6
	2zIMGBpg5n86/AEPOoIf68aB1e/7HSroCywOrsync88y4oKGFP/uF4UOlVPSK5r9YjaOassa/AV
	v2IwIXntm2w3C9+EI3iYpUX1zxj5trRksGNoOqlr/2LcYJg6jLATcE9Ybv03slovPXApUjCTmJ2
	u37vwqbXDOlqwN+V/fxklGAT4LoBIFfB/z61AIqPwSW7DNliPgpSdhemi8GUpqCQh3PDdLFobR7
	AIPODW3v7k9Ae6kBwwZ2/VLk8VKh2idbSfEn9YW67KsTNsG2x3xirJwLt89MUsR9jjMqvWL56FT
	Nr8UueaDkK+XGjIx4hJQ20zY6sFsjZJnOvL0VgcfPZu2ayA=
X-Received: by 2002:a05:6000:288d:b0:490:a3e7:8af3 with SMTP id ffacd0b85a97d-4abb73b516amr57641981f8f.35.1795818737759;
        Fri, 27 Nov 2026 14:32:17 -0800 (PST)
Received: from localhost.localdomain ([130.61.107.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb989b3sm49465507f8f.51.2026.11.27.14.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 14:32:17 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Sam Protsenko <joe.skb7@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Exynos850 ADC support and soc thermistor
Date: Sat, 28 Nov 2026 01:32:14 +0300
Message-ID: <20261127223213.2481987-2-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <DN5A4ZMSEDUO.FUSGQTLBRYFN@linaro.org>
References: <20261125-exynos850_adc-v2-0-26de1c6f1717@linaro.org> <DN5A4ZMSEDUO.FUSGQTLBRYFN@linaro.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Nov 26, 2026 at 04:23:15PM +0000, Alexey Klimov wrote:
> Regarding number of channels. The Exynos850 spec says that ADC has 10
> channels and, looking at the registers, the ADC_CON2 register (offset 0x4)
> lists 10 channels as acceptable ones.
> ACH_SEL bits [3:0] field in this register wants to see numbers from 0b0000
> to 0b1001 (from 0 to 9) and lists numbers 1010 to 1111 as "Reserved".
>
> So, I tend to say it is fine to have it set to 10 if it doesn't trigger
> any hw issues.

Thanks for checking the spec. Then 10 is right, and channels 8 and 9 are
probably just not connected on the XCover5. Reading them caused no
problems here, so no objection from me.

Adil
