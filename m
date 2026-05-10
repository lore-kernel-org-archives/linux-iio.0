Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBB931A575
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 07:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778399998; cv=none; b=Wq3CRWh8a8x2rC1QWhVBcGgg/pXDlCV+txuZlTBEn2WvyZugHjn7RzsZY2Je4J7190fpDhuFZ5fFjb4pMI2AKf9OBzIQKiGk7yMOiQ1RYDMbymfVWY8DEQkcTLDCMXjb4uyBG5ahv7oUKyvDBWghHsrjKKB8o5jppGN4OWBz+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778399998; c=relaxed/simple;
	bh=KKWcOyPg/nqiP3RNFcs+IuvZfMa1B2fj/LqbMVrAFu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oqb6ulo+oAhpeVLuhJ9d26NFgD7g9X8DyltaxNik95gZyJHlYCCsyxbqj4n0uIsAWwdJCX/p4esk/nLP+WisjegSv0VQdVnuOz74MRg7AFmmCiummZcZMBolR0gmkyBS4JELSyCLDut/TcfeIjBUX12ARdENmTpFQXgd21+5ytU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhJ2/MA4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhJ2/MA4"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891cd5927dso3078865e9.0
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 00:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778399995; x=1779004795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKWcOyPg/nqiP3RNFcs+IuvZfMa1B2fj/LqbMVrAFu8=;
        b=IhJ2/MA4Up6dcb2HtWVO+A74FE3QuOqLochZVzfAP5ZsyApTMkGR0hd8UaIzkBLI8K
         Q6MWnxNcKcqMEKaYRe/yos7c/YjrybLVkrwPT+Y8LdqM2Zyl4PCj9aSvG3XwZVe6K6qx
         ruaquIqaOoDmm9uONyibNHR4Lj3NKNYWfB0vVdtdab0CHiiE0kq3GT05tEuTxrOrB4bF
         640EVkC1aYQdIvg+Sm8BVmQ2NHHOtvV6mIe/2WUVd0QKUEqgB9L0+WjcNwYjSUuIuF7Y
         BGd5Knq2wHXZJfUgGr8JteO3jzE8qtGl7yWVUYjFyYoUXtal4tvqfjInPWfeY6ewMiHa
         fLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778399995; x=1779004795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KKWcOyPg/nqiP3RNFcs+IuvZfMa1B2fj/LqbMVrAFu8=;
        b=qPtyHVGiGe1hBynrrUt3t/xqA8QpAk2WrqcaesLdCgXkAJvw+s4IeBoddE9792S9by
         BvVk9IEytT8t4WmdREDA2Kvxd/J4HVpRWXn20ibcwkrgNZv5HNTFEkp0lyRmG8EPuLD/
         4jc+gPzcfuc9GJ5G1KdLPIiFocp65NqfvHhjqhdyDxijO4GZosG9VoTYlMKX0uqrmmZ2
         GaNBufQmLqrjf49DSXUviL5SRRXKWAz0uVyPeitupZUuxhCSnog0YEuTltOVIqdPi4Hi
         rFTycP1XAkfusOyFWDwmQW84Z8UUED5VznUaNMCb6PRJf2cwkOqjzqqDPV1z1pj0iDCK
         Pa4A==
X-Forwarded-Encrypted: i=1; AFNElJ+kBoouAfL3XqFHf6T1X5k1DH6m8zo2wcIkZ3TydrzDbUvxVtnY0F1tR3ZmOJ3LcFJalNPLVs+WTlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwftchhMXcPCIOP2FwwoSeUffZDfDPCiwgB0VUalmZdLLGvK2Zb
	Gz+dArUDH/5DNQOFPC6xY9zZNlMkcT5Kw13xNNWZHhXuWty0Oc/bdeer
X-Gm-Gg: Acq92OEMzbpNDvbXCvCDq+tNKnTAXgEPUFCQhSjoHNTVAJlqm4CaXS6q7KxN5UX2M/z
	Ja30DoeD6kselb2BM8bn/F44aE8jnh9wmfbki3LkGlLp9M9J3RX78SRfIewwVgcbU5Xt4fX5nxP
	tj6k5lxlJbq1BRasr7DlddWbjhiaCp5IjNJzqTuVOWh6zfdw7+Ig5norSQ21k8pd2S60+3Lw9Ea
	Wr2G5Erzs6IgKV6qfy7AZ7qOj5YjTESzs63OXnFpYPk10g+6M/St4pf88HzM+VEYcy0Fbqh490X
	HcDE8SnhhQXzQPb84RWE5hlsEt0wWsIGkOxkPNt+ANTeX8PYW7P8aWiuNAz1QZE+NDqa55VR/ug
	RK/PIkPkfGcnhUP0uNKgeqhSc8M7GXG9VHZE2DPUoedapOXjZnDfK6zLeRLLrprqB4F/ygrtsSs
	wo7zNAdy7bNQ7h+0aZLGxEnxdMQvkoaal6WgTfZeyR980=
X-Received: by 2002:a05:600c:46d2:b0:488:7e7b:dbc2 with SMTP id 5b1f17b1804b1-48e51f4539cmr146668785e9.3.1778399995064;
        Sun, 10 May 2026 00:59:55 -0700 (PDT)
Received: from localhost.localdomain ([94.158.58.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702f4042sm107048185e9.14.2026.05.10.00.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 00:59:54 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: m32285159@gmail.com
Cc: andy@kernel.org,
	giorgitchankvetadze1997@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: Re: [PATCH 3/3] iio: chemical: scd30: make command lookup table const
Date: Sun, 10 May 2026 05:42:44 +0500
Message-Id: <20260510004244.37342-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260510003136.35026-1-sozdayvek@gmail.com>
References: <20260510003136.35026-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 10 May 2026, Maxwell Doose wrote:
> I'm curious, are you having AI do your reviews?

English is not my native language, so I use AI to help with phrasing
and to learn kernel review style. The technical analysis I do myself
-- for this patch I checked via grep that scd30_i2c_cmd_lookup_tbl[]
is only read (one read site in scd30_i2c_command() via
put_unaligned_be16, no writes), which is what supports the const
change being correct.

Happy to follow whatever disclosure norm the iio community prefers.

Stepan
