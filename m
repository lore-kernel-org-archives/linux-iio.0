Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BD43BED66
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 17:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779038321; cv=none; b=mD3/mRuOHPpRdt+sym2D9T1RONyyohUZ31NDJRT2zkqIcbwaCkmTge49uJvkI5H+Or+7duqtF3ymhb/0VxB0zEFQzktmQ1HoTpo0bDxs8zxFQpa8Ay0EjRfFiUHnRaWWV6fZ2N6xiLT9hJZqQgdCtSDwoBXY3QCcQH+OlPA9HIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779038321; c=relaxed/simple;
	bh=sC7gGKV7ozm/WzcKRL8dyf5wyvuKoJ9tCvD0h0m34KA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iWMszXM7IL96tglA1DHpPSjeVEFbnVHrEM50NFKQPuN3/d+3IBzecYuzefRVM3430BwTgRyobos7/3cH9lmcH2zlReDkwAfyEPoRwLJChH6A82kknA2ux6rkUsUoF1o6x8L8wN3zcawVI5OOLl2gQ12vShbD6gQEIeGMAWcePsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZT8YHCl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZT8YHCl"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48d10c981e4so2486565e9.0
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 10:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779038317; x=1779643117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sC7gGKV7ozm/WzcKRL8dyf5wyvuKoJ9tCvD0h0m34KA=;
        b=eZT8YHCl9SLDA7CfoQ6j3M+c1Iaflh/BAv+/Wc/EriQzKp0bUCe5CfdCgitKl7GXxa
         t1+UrR/KdIX0YNfijHS+RMhpVMolS1AUmCFUn4EnkBvDqUVvTP0k+lAI9u4z6OKRZ2bM
         gL/A//PLT2/M/x6iFszzmehWSpGrmmk/2fT8nWIVR2ncwwabFF2sUfHhyYUIqnLwHLTR
         REaKLSfVn4GM5/z6F+m0VJRV8Ds6+E4hGQOoKtwxL4yCWWLMfWw7SzgGK6cIb/0EI0Ao
         dkp6TLBmMm3OOgW2Tyk+obOGXdlOhSsmBM7tPKrlEO4uDLnoPETFieqOHPTauMbtefWF
         VlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779038317; x=1779643117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sC7gGKV7ozm/WzcKRL8dyf5wyvuKoJ9tCvD0h0m34KA=;
        b=UQpAuvb3PLg26ZIiIPwjDjlKJJPevSxj69dSBjxxpi23hxZZFDZGKbE0i0mTqXJORG
         WvYqzB5QODEsXtiW/g/yRytWcfPeFOctyROakpfLYsr+kDBcz3o6qBCx/eiw+PejRwS/
         ZR3ELrtXkVUPqcl5tg1ccp8PJNKhWY4cPb8Taux5PsDrxdIIEzhPCr3rIHm+Dc20bbS9
         UHFRmMCr3xvFUi/MoGy39IzD+M6ImLaiPpZCHOeZR9V2hA2M9bramRoawJVPeF7kOFqc
         VwKvcBKIZJ6zwNElcZzPM4D37G+ks/LahFdKRbN2T+m881jDXeKFGDmOI2c2vAckM0pa
         3nqQ==
X-Forwarded-Encrypted: i=1; AFNElJ/BWV524n/OZpMm4BlM2aRZVXkHaziOfkKjvbX3Wmuv739kYyMA5c4YzuulNbNrTczDeESONOoZp0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv/npmOph/jTl1qrnBNztiX+4k8g2mNsRe+IUT1YXWxdfuYSOG
	WL1IwbVf4Sgf4xfQNGPTO8aSpeocK8UHEESEYAKul5hB3AABNtbsT3Yf
X-Gm-Gg: Acq92OG/l5FV8IomUi2FkGCJX/Ma3Qxe8yRo36AcUG8CJiJ6S32T1gd2P4F1IEn80WT
	KU2tfgb1uF36cVm9s0dfdM06JEFLO0UAmzUVXN+kvdaT9MUuo7OZ4RyP2ismHQEPoAAyqP1q53m
	Q20GrM9ajgmhdgDXEMf/Gb5WW9mJRZCYjHP0nIYsCyX+ezZ5ma/woFBZsJ19nQAUFkVZaxlshFB
	k/OTwmxdryQYwXNbXr1KBAmfAkmXbl4wvGYexrGJZnNDwdhuQxFpM9DuWuNdw7SgDQdXfw/Ym/P
	WcBn0/PZMx5g6bUrmV2XUYYIoOyiRzLHEMZZXDvcLWY7SX6zIPllO3FHjcyVhehohAGEvhERAeY
	2U2atfw8cHKwDGzxwBO7sRzwMHgeMyyqaKjkOUzZatpskBLtfELDlw5euR7lS3ETB/6wj+B0AFo
	W/qmG5bO3MQuVkpcZ7lJQ/yrCFv/rlqODKdLuRrQrMUiVh
X-Received: by 2002:a05:600c:3b07:b0:48e:6db5:76e6 with SMTP id 5b1f17b1804b1-48fe63099c6mr95495075e9.2.1779038317040;
        Sun, 17 May 2026 10:18:37 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3acf7sm30645659f8f.12.2026.05.17.10.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 10:18:36 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: dlechner@baylibre.com
Cc: mazziesaccount@gmail.com,
	jic23@kernel.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: Re: [PATCH] iio: pressure: rohm-bm1390: notify trigger on all error paths
Date: Sun, 17 May 2026 22:18:24 +0500
Message-Id: <20260517171824.1845-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <54ee1fba-3209-4192-82c3-674a1ae3ca8f@baylibre.com>
References: <54ee1fba-3209-4192-82c3-674a1ae3ca8f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, May 17, 2026, David Lechner wrote:
> IRQ_NONE means that the interrupt wasn't handled, so it won't be cleared
> and the handler will likely just run again immediately. So it probably
> isn't the right thing to be returning in the first place.

Right -- though here it is called via handle_nested_irq() from the
threaded pollfunc, so the return value does not feed the IRQ
controller and the immediate re-fire concern is moot in practice.
But the IRQ_NONE choice is still odd.

Matti, do you want a v2 that always returns IRQ_HANDLED on the
error paths instead, or keep the current shape and just fix the
missing notify_done()?

Stepan
