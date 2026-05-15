Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5F93E5565
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778851919; cv=none; b=HOzXa0altuWvLxVf9rQULCVjyk8ZkUyHHCaQMsqmVT+H7uNuKM2DzQKmyJCelh1Wl76KG+POREyViRJbm5R6D1eC6Czfaw28Mmn3TToNUxNeeexnlm/SaV8qF0f6iJrJEGtoPEQLCBwnkY6V3Zm1LzxqPPn1ci4VgVa5QNyN4Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778851919; c=relaxed/simple;
	bh=4UwNBQ954tlo1heBryq47THbfT0ZWBaGgve8Deniots=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EehSOv0kyvbKGgiLTnFN23ReKDM/W8+1wgcaeVnRy8QBA9cNCaIaUYjS4j2HyyWq/MgsnMMqPL+4JcT5cxDZGhekdJWWkWLFu3FRRCLYzmja3b7FTeJyJUZTp1nPZcU7PIiIALW8M76o7msLEZVKNRaB/eo+d/DNhtwspPPWZ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q7Edpqh0; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7Edpqh0"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4493cf2f982so655552f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 06:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778851917; x=1779456717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t/hO8MbvR1GGKUUZivADCNX4JORCJl2XljSKSn+y1jU=;
        b=q7Edpqh0baEQ4ZXF0X0iExVR7VPjVC8dHrWt8QHttwX3KQQzRHoflBXxkgHsiYUbTp
         GTc1bB+4YyEUOi41URH5m4b9AnRcx2QRipleitHe0w+BLFy2zG9+pdDazFtoPH9C6X72
         bXbIDwH8fDjfpukwzCH2kxOky+pPfiZxteUL91+ryW9qMZe4zjK1vYMGSJaXlwd+OjTP
         HnyhBfWkDO7sKTIE4n00zrcYPD3ci/Z5l79EET67aIKK0xR0DCU9Xn+FPDSATgu7FBM/
         /qNwvpFDQZ2IUbA9SuHOStz3AREvbX0+4UylOM3zmNBu8mbxNJI516UTelj2IdItAfmd
         edqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778851917; x=1779456717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/hO8MbvR1GGKUUZivADCNX4JORCJl2XljSKSn+y1jU=;
        b=FnLF+XWrJck9KVYu5eMisNkK/WI6VA+IRiNSgQzopmTWqHZH8tTXc90M7itsi5hqEB
         g7Yy4FgT0pKnAK3MRw7A4SE/7Y1x/vcN1cLUAGrzilDCvoYpg8m34aBTcXiviKym03VJ
         d4fYer/6OhRokor2Ls+/x2pATrjFjq6QpauNmacVhJnX890SvaRkVHZuArB1zbfdKWif
         PvhWy8D4223Dwk4mBX3+uDXin+vZ/Axh9MBGJayuFdSBu21398m6N83tAeIfHXHigKtR
         jGhOA+mcovsgaXWZU9meZNOd87WCpXH0/hK3v361QmNX/QcE058i+aJnPCxne6VyW1Ro
         B5iA==
X-Forwarded-Encrypted: i=1; AFNElJ9uoBKmruFnBgMmS2eyOiLAfKeiEchkXRhC2wiCSsZjuWJzp4MBNolJpWCjn2u7UxwbBqFshPq3OH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeGc66523pftz2aoVu8fYmLEQ7hHbx/yrDWqaAFJvTOt48B9oA
	i3fi+04uUgHkQPhztpxsstfBzE6NIJfCMkE4kAHVZHLb/9ssknOXe53i
X-Gm-Gg: Acq92OE2/WsTSh3s7QuTvTKumcfonPLP6HKSIhoulsv1ieOUySkKBceYP56WHkcjXZA
	ND49Zo6GwZaljMQTmjaZ431Xb3c+nsPf9tjFpLm9BHgwuRE7x6ZibpmiZ9SoyzVHV8TCY4XEXU8
	LW8Fr4YwMhyPRNS/39DowfiAB0inIVKtRcmk4cz2UQ+XQd4O11lC86DaYdWW3JgtXBMvuH6+c5u
	qqcJmlZ1o0kwyA2K5cgllCO2L/47Qw2ixTqe+BpsEnh7bupTNAOWaIxeEydMcdi8dEqlHsEjFFR
	i8Y/4lk6kXQ9NDxiQYdY/QBVRwRCKFgEq3aLSEFY6fIpGuOsp8SqeNTlL04a4D6V0CkDwfTxF6e
	R6OOKM/Q122bo/Ip+dM7+Rj3orvdWUE0zBWGeGxXIkHvh34/BB67taw31napNUqzEZ7J93M+wfp
	ZqaxZKMGUJoxv5PIeEDrrjMof7XQyRZ+SdHk3w1hfXNQmV
X-Received: by 2002:a05:6000:4683:b0:45c:e615:56cc with SMTP id ffacd0b85a97d-45e5c5edef7mr1708341f8f.7.1778851916671;
        Fri, 15 May 2026 06:31:56 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe248dsm14266021f8f.30.2026.05.15.06.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:31:56 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] iio: resolver: ad2s1210: notify trigger and clear state on fault read error
Date: Fri, 15 May 2026 18:31:38 +0500
Message-Id: <20260515133138.32319-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ad2s1210_trigger_handler() walks several scan-mask branches and uses
"goto error_ret" to land on the iio_trigger_notify_done() teardown at
the bottom of the function for every I/O error -- except the
MOD_CONFIG fault-register read, which uses a bare "return ret":

	if (st->fixed_mode == MOD_CONFIG) {
		unsigned int reg_val;

		ret = regmap_read(st->regmap, AD2S1210_REG_FAULT, &reg_val);
		if (ret < 0)
			return ret;
		...
	}

Two problems on that path:

  - the handler returns a negative errno where the prototype expects
    an irqreturn_t (IRQ_HANDLED / IRQ_NONE), so the caller in the
    IIO core sees a value outside the enum;
  - iio_trigger_notify_done() is skipped, leaving the trigger
    busy-flag set. A single transient SPI/regmap error on the fault
    read then wedges the trigger so subsequent samples are dropped
    until the consumer is detached.

Convert the error path to "goto error_ret" so the failure path goes
through the same notify_done() teardown as every other error in the
handler.

Fixes: f9b9ff95be8c ("iio: resolver: ad2s1210: add support for adi,fixed-mode")
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/resolver/ad2s1210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
index 774728c80..1be19fe8a 100644
--- a/drivers/iio/resolver/ad2s1210.c
+++ b/drivers/iio/resolver/ad2s1210.c
@@ -1334,7 +1334,7 @@ static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
 
 		ret = regmap_read(st->regmap, AD2S1210_REG_FAULT, &reg_val);
 		if (ret < 0)
-			return ret;
+			goto error_ret;
 
 		st->sample.fault = reg_val;
 	}
-- 
2.43.0

