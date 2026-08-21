Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D41481FC1
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312551; cv=none; b=T+6eNnPTgzo0FLEneeoyPwsxigM6+F2/fPSAsQBYeovahaCaMjv4eKtdHm4V1s8iX1/bYLMCx7b9f/tkKwSkCor+wCCEJwd3Piq7tqBM5ObyJdN0r8H72g/qv2ooktgVklHxTeOwH2RCLRY8C2VbIpgsZENszpd4/9kEo0GXHgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312551; c=relaxed/simple;
	bh=OYToqEEQxAUkOIMyrrG5Rv8GjKS9HPYnHJZx4cXkuRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nqo7+UqaJ2br2Vqf4y2PEQ/h6zzbAVsUi+kD/uyr9MyFAMZnXYTGVvKHRyTcyRX2B7Q0COsMWFA8fFfOg1Bpvo7sddnle4MEuTAusKP62XQzvLUygfsmVgTjWurXgO3wkMN1pvrVlCTJGbf5nV63Yh9DmsIf9cc5pZq8fs5FDp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqW5eyaV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqW5eyaV"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so8606625e9.2
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 04:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787312548; x=1787917348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OYToqEEQxAUkOIMyrrG5Rv8GjKS9HPYnHJZx4cXkuRM=;
        b=lqW5eyaVUT7To/SZogYLHfwvXAhHc1+YSvOuhiCGdq8OrnE72/5Z47KoCxVAoxo4Xx
         z2RXOb84Q9pJss8UECXoR5c3U7eutPZrZPZ7PQNFLP6ULuQbWhN8iUMj32Qw6nrMytux
         fghpxX9nfGu9VypZhTo7hYpUAE1HAOdNtwt682CAzQOck9XgjfS4L6Z6nyEcJgyZR5CL
         CjlOjf5wM+QvpDru614r3XvYrSyvFlKLxxlGakP63YNlTOVkvRMabf5d9Ghn8/zCl3TU
         55RWoX0JhxAONeRNpRRMF53Q0J8JVMPZAI/dr41xJXGKGf6+OoWl9HhNcNbzTForNMq8
         AWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787312548; x=1787917348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OYToqEEQxAUkOIMyrrG5Rv8GjKS9HPYnHJZx4cXkuRM=;
        b=DnhrIwpKdJrcrPbtUWdWxwJ4hTHQTEisyzIuaGMoO2e9F54FAYcya8nQYdp+U/TkK1
         xdtZcImXCBLah1lP5O7fOeOmeXydhtY5IORIgBnJMkP7WwVpJQTCq/uSnSMH025bfCr6
         8X3+ko7Yf/2URU0fq5BUi+LztyLV5WdWMjYwm3oP3RiHQOCnk9nNGEIjU9WHRpa3JG2j
         z9l6kHn7qYywiC6Ntx3UA17P3DjhhL4uQo75evpLxD+5NTqa4lB2ai0LS/kyO+uSXTC5
         0nxcIFLTUC5tcGhZm0d6XV8TW/n3kFLng4+K1dWG26Y8/s0fAutpNkohkdAaLWTTHKgB
         1E1g==
X-Forwarded-Encrypted: i=1; AHgh+Rrvo2G4BY+hQ2gzL44JnJF0HZ+USuZ1kLOaqrWpKVV4PNS+L0cRRUjqzo4+alMZ8PUd+o19KJXP9+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyFYjD5vwjgMxgpZx88O1+iqsPGAzjlbkb9APO3Mj8u8ZHMJL3
	wjBni5oiVH1Mcti7tIQfCFOaJnI8OcR5P7djvWPG2TcecH46z99H1oEY
X-Gm-Gg: AR+sD12T589E2a7Xs2csWLNeKUtOjaHWelcTyfiH1oh3H8+vFfyh9hIFOnSRUvh3WEH
	tPWyxEJ+ytS523NcAV39aKGuafCP6vGFAKetEnGSpHsDRyEHMbD85/5NiMs0T/FnyHrkaT1jkvP
	XcKuwYWeFOqLomnLm9s1IHJyzakbFj6ICXLwIMKUwFNf+Wjfd6xTiS+bpMgnEay7PN8PV+r7ntx
	X7x2lMXyUsbIQzfK3ivJ4Y4Mz5MGyjW0+19ArViklThnXbVIq6zEhTL4MCs9UaODMyZuQXLEznw
	ZS14XOXa3Sv4OjXYS4IwtThvSiHoNc9xDup7p0Kxs2BzJHIM+m0SgsJSvzklcACgliTQ6/HmW8z
	yDeUNZ0T9QpjEzHjV7mC2IBk9GmRRGpgoafuJn+yt/ZiD0ZS/sLBJw/F6R7Io1Y4FmJZFH3HclP
	12sPpvAU9PWZn2glhp1M7Zefs6QCOjpVqr9VaMps4qOB1/i1E4XGytkj7+yMGwOLHu6N7MnucWm
	oJDJoNukx5BRAllpLMI/Ozk
X-Received: by 2002:a05:600c:8b16:b0:495:52a5:8829 with SMTP id 5b1f17b1804b1-499b8343dd3mr71965735e9.11.1787312547553;
        Fri, 21 Aug 2026 04:42:27 -0700 (PDT)
Received: from fedora ([105.74.130.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b9111a5fsm24333905e9.12.2026.08.21.04.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 04:42:27 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: joshua.crofts1@gmail.com
Cc: 0rayn.dev@gmail.com,
	Michael.Hennerich@analog.com,
	andy@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	krzk+dt@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@analog.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v5 3/6] iio: dac: ad5504: strictly separate ACPI and DT probe paths
Date: Fri, 21 Aug 2026 07:41:53 -0400
Message-ID: <20260821114153.58607-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821132021.00000d2c@gmail.com>
References: <20260821132021.00000d2c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> ret / (MICRO / MILLI)

This exact line was discussed with Andy on v4. Patch 6 in this series
replaces this whole branch with the output-range-microvolt property
parsing, which does use (MICRO / MILLI) correctly. We agreed it wasn't
worth changing here to avoid an unnecessary intermediate diff. Let me
know if it would be better to fix it at this patch regardless.

Best Regards,
Taha Ed-Dafili
