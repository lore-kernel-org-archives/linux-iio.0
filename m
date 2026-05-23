Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FBD39A04D
	for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779543959; cv=none; b=GbR755SF6fu9kdemZeVHbFOOctTlNMQeMdee9ZmAmQS/WanPFbyEgPQ/64xSCoY8dJCi+o8kG18z0GfLhVpr8fP0zE0EhhREeASHw3KZAIEbRqjTFLx7WJT/J3Eo9UN7j0G964t3aElHQirhBYwkOJDSYxg5TWfmx2CQS+WmRrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779543959; c=relaxed/simple;
	bh=etupZFY96r1dtlFQQSxz6ZsKD4arOhkSz20hQ8jJhWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZGmzUoYyYkJAmfNWT5lBNdVrDjpqM8eIsRaZI5lks13wC0lG//+qYkq1cwJ2xL++Ev9EOd/X+nl7zu+p/eWgKs8bzXUTW22baDD60Wsg1tl14FVPVuG37rWMfRTK1OKkl6mC+Pw0tHm6/coeu84esY5FIeZPO8ZBnEzT2JOANpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UG3+/lTX; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG3+/lTX"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38e8232b28dso8190461fa.3
        for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 06:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779543955; x=1780148755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etupZFY96r1dtlFQQSxz6ZsKD4arOhkSz20hQ8jJhWg=;
        b=UG3+/lTXETW3Cz/ZigpKdS1MYhn/HsSovqeKK6iq4nmeasliunfrQtx0hIDclJYEHO
         ZaE8DGxx+WdSgBsgEDUz12LRuFJjGg7VkI2wUKzRtKF23Z61lXOX0Bfewd9JNUb1S2sz
         7IY4HUZnKiJk0f6rXMAHBSgojkrCDC4HSpYHD4WnYPUJBfmiLTSZ9NNA2FlvtTCLIop9
         3yS2n4JuOOzAgsEUomhDK/F+A3IVgJhbbIUyOpFpdQR/+XtqrNljfQBrmulqBydsgdN6
         TIvykyHVIxiVLYjo7VLN3wzxK+qb+8XNNRVB2FiL6yxMihyo80YUAS9B27HYzez9INs7
         0oFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779543955; x=1780148755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=etupZFY96r1dtlFQQSxz6ZsKD4arOhkSz20hQ8jJhWg=;
        b=RpBBJwLa7/uyxuqe3FmphdNKgFhlwE7hgsYBr7JD1682houTTCpnqxPGCk/Y5k1047
         va/93u+v9ieRWxzbEcX26FofpHQmYpo8ZZtcSsMB5Jg+pUGUukCKUeEL+B9nTYZGpfgt
         3nqIhIednsqluSPjs7yoDMwt47vB9Som7qhWBiRf0I0Xpn2UE2n2IsoKK3ksqzfXGhVE
         m9THSUxzA5gId0QXLyvLXCFhD7X6Ordo64AzX4OaSGf8lQjex+O7sz+Q2TdHAm8Y2FTr
         1IUC7QZr56xTsCJCBcbpsUofQ/9kf8m6YS2+uwxHbhgGUM3h/ZsLks4OM6TdzOMiet0a
         Mp7w==
X-Forwarded-Encrypted: i=1; AFNElJ8X/d8nNndAqUo+QHmmDXtqiin++OtBe7caI8Jz2PuoD3bYgQntRuuJpQX4BPlWvf8QZ4CwOMNLCaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFo+OS9ogndFFywb6/o9ZEfNrlVGDypw5c0NnKwGjJX7aaFYnj
	og1gZDq5wNaNCK8R3HL8mFKU5rzqH0DJ8eDFF7OU27kQauBe4WmdkZxM
X-Gm-Gg: Acq92OH4RjjRUAJVv+8wApg2g+VwrUuntOXe59tCGC1UGaCsnbk6Zal67WeoajVti2g
	moZmu8M4yVlPRzE3JTraXEYj5SCKKldXBX1Lm/Z9MUPh8fzHWLsCG+7zVcVPutly8KfrGT9gutI
	VERXms8lr86WjE91CyvFvZMuFTPBLxcfV7mNLzXjR8N+SCZ5yX2lkNaumxZgVnLMjrHe4OByx0G
	7GsaLCSzu/Hlu5i5mnLnF/Wv3gChj55HsBmNrkeZd5W+GXLNfrE52XxoKnQj+f/2T8SmidFLL98
	SwQ3zN7c2qXqSN4MCQbEagsjs9TIoi7gxWQu2ykVqOP8zOmOuTMw3wLSFBSFUYemN533EZykM5w
	yb2rdM64LN8CBR8DBBauZhInJo2G4J3FVl6xED7GyAt1T2JFW2//Vvzfgmq1cGVX+uflBe13qY1
	EKtpCE4ZZtfhT9r4QYW7ovDwJzaFml0SDWsEM2k+MF0N0dV+k/5KnO+lYQQQ==
X-Received: by 2002:a2e:a593:0:b0:38e:2183:2287 with SMTP id 38308e7fff4ca-395d8d28ba9mr12231531fa.6.1779543954292;
        Sat, 23 May 2026 06:45:54 -0700 (PDT)
Received: from localhost.localdomain ([213.230.112.147])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395dcc0a4cdsm9985841fa.19.2026.05.23.06.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 06:45:53 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: salah.triki@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: Re: [PATCH] iio: potentiostat: lmp91000: fix NULL deref in probe by reordering setup
Date: Sat, 23 May 2026 18:45:46 +0500
Message-Id: <20260523134546.4910-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260520185142.34015-1-sozdayvek@gmail.com>
References: <20260520185142.34015-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry for the duplication -- I'll drop this one. Looking forward to
Salah's version.

Stepan
