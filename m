Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88E428750B
	for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771694491; cv=none; b=UY91T9LFyXunBODO2RhxAgv4tHwO4S6s7HiXCT+K3zYBlYOGl70x8D73S85NMCKSC73p8RU6nXj0frdnX7rWyzhFOXP9IQG4VUTGlsjORLOKPXjFlvbuFtmUC2HfN9H/vX3pJsu6q9PizPUYl7pjrCzFHqD//pL4gWD+nFZuBPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771694491; c=relaxed/simple;
	bh=MWGoq0D+Wj3dmGxH/U1RNB0L9/ZrR5Fqx8GX3kwl/zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xh+p+kmRqBLRd6Q9OuQ9joGxUCVOHqVq3KBL00+A0YZHDzxW1P0O4gpbmhuAgRXhU6MCRPF7uClMfy7X+XpAembKrpPUqkcbiTe4Nj4nK0H3zInyfvpoPR/6T8ORRDxyP+9Kr4OdDpGNgKLveTNxpZKgIOL8hDLC6GAtHMm1c+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEQoevrl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEQoevrl"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-483770e0b25so29953665e9.0
        for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 09:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771694487; x=1772299287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWGoq0D+Wj3dmGxH/U1RNB0L9/ZrR5Fqx8GX3kwl/zk=;
        b=HEQoevrlnhmFbf1iLFViks1znYvYZDtIrHHIVauKY83iAmaAPpH/zTz8JDNLkopKiJ
         1XRxxQ1u1U4iNam316T0xZNQp+7MT4RTnth46vQNkK4+Oum9bsFbYvTXDGNLXIZW26UZ
         W302X3dOLeS2/WTIf+MuNVMzS5UJZuDLU82Q9onRpynfuCnd9btfDeT0/m7y554PWHlN
         DnUWmlIkxgqJfR6Sr7DpD+1ZJDdhkOlNq+Xu/KrHxFaZZnSDTn9Kk9V3Z5KpDGa7MTRY
         Wns5WCDOsLHhaLPfX8QSnd2k7RNOV8UGc0m9bTFlbh/7yjnb3R2ZzaXbdAHdpt/FMBUu
         Gbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771694487; x=1772299287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MWGoq0D+Wj3dmGxH/U1RNB0L9/ZrR5Fqx8GX3kwl/zk=;
        b=o/1ntgYuwYigZWCXPKebwIsXOYiNAuO0DInlwj8upX/Vy4tTWVWSLxANrh5Lmrnczy
         NdD7UySk9xr/ye+m1F2K7DHoyX2LmKITqJD6c8OFuZ0B4Piqdcpg0GCuoMwa/WgdZVOl
         RE6LyWf/GhQ/bJCCcgfhfZJAh5xuuwbFjpORdEPUXDsgx4dTFWYPf8qRxM4HzmwOuTus
         nZi+tqPuTIwt/g7F4APHJSCKHmdLa54A5sWlmjt/UURyJ5fQcD3J5c9i7LQMTjBr1PVO
         WNlouHRxyayYZhHbLwDV/8fhDplYtTobuvot2C+Eh3tyj4so3OGAKn0HkmMTJtDx2g7l
         GKEg==
X-Forwarded-Encrypted: i=1; AJvYcCWY1qQ79ovu60vFts3o1PIvVD2xxQunu3ihtUH2hQ7AvZsW5Og3aiYDSLmC2hhQTLCHltJ9G4yFdX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe9YngGEWzOR57GU8vSBrV7oDfxu+15825z9Km89LQsNTkJlYL
	0tz0GcITsBkBOUwV8F8eC9+8F2218sSNdhjElxoxTKoOSvren75A9pxy
X-Gm-Gg: AZuq6aITVvAlo/9qjbLlJekzCQcLQWnOyRBf4dFyAiLp7bjuY/Y3DFJy4kAYb8ROQFY
	Hhe2LhvyVV8Py2fCz1e9TGhILrkW57CAxZwpVUcWD7G8on7m6JJsubhTPLtkBxvlzyv/Svz3pV7
	vIGFUblMDm14pKodE4/amZZ5tEnc2nVzBFoSfT5cxcAeqQ3vDcncFvIcAkgXyPqZRvyyYxnVr8K
	gaqZxzcVmsEnuYX3ROi234tGEdk6++MgQiu8+Sh4ust0r0UubhorOEoivP3UovnNvVMtZIz3uBM
	I2l0f1ORrMs17KbNBFoOiRuucV8L3MXwtKmzSj2c0rdXFjK48FlYD7n77Sxn1G2znMk/sgcmzm2
	Ji2onYX+jpiRuuWHg79JxKEPcUYUjmv2N4LVhkRNao4N8+yyFiBTcXUKOD7dr5w0hGllY8zkXlB
	j91rsujGysbrHPaolMdy2Kxq32csZfycRhc3V5qdFS83cjCjiw/fW4HWE3v/HD3w==
X-Received: by 2002:a05:600c:6217:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-483a95eb550mr51020795e9.3.1771694486784;
        Sat, 21 Feb 2026 09:21:26 -0800 (PST)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9cb3f31sm63610955e9.13.2026.02.21.09.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 09:21:26 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: dlechner@baylibre.com
Cc: 0rayn.dev@gmail.com,
	Michael.Hennerich@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-doc@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel-mentees-archive@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v4 3/4] iio: accel: adxl345: Implement event scaling for ABI compliance
Date: Sat, 21 Feb 2026 17:21:23 +0000
Message-ID: <20260221172123.57134-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <e2c74e7f-d851-457f-88f8-d80a8d17c51f@baylibre.com>
References: <e2c74e7f-d851-457f-88f8-d80a8d17c51f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I did go over the datasheet and found the hardware uses a single
register for both tap thresholds, so I assume the VALUE was intentionally
omitted from DOUBLETAP to avoid duplicate sysfs attributes.

I mechanically added the scale attribute without realizing this. I will
drop BIT(IIO_EV_INFO_SCALE) for double tap and update the docs in v5.

I'll wait a couple of days for any other feedback before sending the
next version.
