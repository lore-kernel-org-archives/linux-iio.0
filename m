Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA7C61FCE
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 19:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778441811; cv=none; b=aAntrZv6gka23+O+NxOuDxctJb02IKhBbEAyyP2Q3MQh3BQWGP2R4Ik/dr8wyTM5D4m9gSt3TD+FQ8Bj9aimBNeYGlfqZD90jO+8Imv9pQ5dvKLcSqu4NUog6asJHx04vmHwXWWMzSOlWcZheA6GYtUF7sHUG+l0acvJW9T0ikc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778441811; c=relaxed/simple;
	bh=InK1uMLMHIryIx2rfET3AXRnxRLRala+9aKoJnwTbAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZMRchlOl+a9aqw6V+KtPh4/ZaAXogBW1ptlwh6JGTHqroI9uwevndMWuf7QOXNVzmEZN7v+XqUoFPQYSpxppNTo78nnFRTiu600vtjEiMz6D9R0GYImENSEZC7REALOw+OFsdNlmY8Li8DsF7aovG0vtD1ggs1pyguESXQp5lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9xWspjO; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9xWspjO"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a86bfa2a4eso4266013e87.1
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 12:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778441808; x=1779046608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPr/xvPiVH/kfxzskdqjcF7SmnVg829pocol8hpc4ks=;
        b=V9xWspjOcY8p1LoJIs6Zd6KUDiM4tAYckzgCt04CrR5EXg88kxaorE+RmjS7pecS17
         jfmBMTfrzkmwCqo13vEcF20aMUaOovYigq/ElkMZ0RSalS9oLfzi0miqdIjgTgYHJG/S
         yPV6Qig/X7YymlIzjqKiUO2fIUwnRLnzjwuvTmVySBJtO0+AhRtUaC7H6ceSQOAP9hf8
         W6JtmrjwWhrnAEJoEPNayF1siSo7k74CA0pD7k9JV8v8467vms0HDY7kx4bb/6vg7Ana
         Egt/hWmHRLCiFzr8rqvRMJMrnyC2wMjsqcKpbLnNDGzzHJpH+hiK2s0h+1oiI/AIdfxU
         HVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778441808; x=1779046608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JPr/xvPiVH/kfxzskdqjcF7SmnVg829pocol8hpc4ks=;
        b=qgtAfUfGGtz9LiIIOiTCD6xE0H8Mw0cPrpDlmkg8IhjWL7ZpSi4oyrf+DCQU8dWpg5
         48SKFgGcJGRTW1CRSvoMwWC38+O+7vL49U6+1NybDC5AQjZTDZ+4UYmvC6uNs0kea2cj
         L/V97jIVuDwqkty6cgiHiOIcQa0Ir57b00ktRMPCZtbiZENizA2ZbEWtgWn8eXhhTMZ5
         U1HFysucsuje90PN7X9plxfyWuuLyuYu7Cn+T05DRx0aUFsx5XTOcKTuhWkKbsN0heK2
         V9Uk6tu1noVTe6I64Z+7Plq9LNOt+3mT6/2vaOFJbMSfKXLxznP0Twk72XU8BS0vXb5w
         D1TA==
X-Gm-Message-State: AOJu0YyNt1ZqD+xUFpoYYN2jiBrfujHqhEyLeNJJwrdaNBDYjzfpfMZK
	jGII4WcEkx1mEm7yUvzsS3UjGAsm6ulsfzZIttI3DXsMEmNvR8Xeuyo/SW05zS5d
X-Gm-Gg: Acq92OF1Y/u7FBxE1PvBb+lk5wMPautDpy54X2Q1Tx39BWpRIDlxiUHnVuouwKBzoUW
	4O69bamZrHLwqPjaLCeu/eGsuDZEv+/Vcotp36c7s5GrJxknYCKZ7pNNugrliOws6hzBwUrI8ux
	PVf7CZQLaw15NdjOo7VuMAhI1mvau1PlXSTOVLB1nVb0Z0cTNdwnYGC5ekLYeHhrGvqgpNwHcIS
	NXzYyFn3bv1lH7mIGkO+BhK54+E8SohPo9HBATj4q8EchNgrHPWy94JRfr+xMbWGNLGNq44Fq0c
	/vt9jP3OcuS2wGUsxU8J4IFTF+lRuprWDaOtkGT8FFjlt/+0gIXErHx1yraaR1l7tn3TU7WVnty
	Vc8r2tGj1D+cB+ZietTtAq2632xFLANJpQIfF/6APBCAAyzdahpH0HuYYRAKGiY+keh3gmqhuAb
	npad55LdBur4odVLGR08mJpg9ObhuTocB6MXWmlwAqYiABzKTm8C0yS6iMmmThoU2M
X-Received: by 2002:a05:6512:3c85:b0:5a8:6cbc:60f3 with SMTP id 2adb3069b0e04-5a887ced391mr6825864e87.34.1778441807693;
        Sun, 10 May 2026 12:36:47 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8cbfc4dcbsm309105e87.16.2026.05.10.12.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 12:36:47 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	andy.shevchenko@gmail.com,
	dlechner@baylibre.com,
	mike.looijmans@topic.nl
Subject: [PATCH v4] iio: adc: ti-ads1298: Fix incorrect timeout comment
Date: Sun, 10 May 2026 22:36:45 +0300
Message-ID: <20260510193645.4616-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260510123801.4066-1-shofiqtest@gmail.com>
References: <20260510123801.4066-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the lowest supported data rate of 250Hz, one conversion period is
4ms, not 40ms. The 50ms timeout is deliberately conservative to allow
for kernel scheduling latency, which can be significant under load or
on slow machines.

Fix the comment to state the correct conversion time, use "lowest sample
rate" for clarity, and explain that the extra margin exists to absorb
scheduling latency so that no one is tempted to shrink the timeout to
match the conversion period.

Also drop the redundant ret variable assignment by using the return value
of wait_for_completion_timeout() directly in the if() condition.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
Changes in v4:
 - Drop the ret assignment for wait_for_completion_timeout(); use the
   return value directly in the if() condition (Andy Shevchenko)

Changes in v3:
 - Fix multi-line comment style: move comment text to its own line
   after '/*' (Andy Shevchenko)

Changes in v2:
 - Correct conversion time to 4ms (was wrong 40ms), add scheduling
   latency explanation, clarify "lowest sample rate" (David Lechner,
   Andy Shevchenko)

 drivers/iio/adc/ti-ads1298.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index ae30b47e45..25261163d3 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -210,9 +210,11 @@ static int ads1298_read_one(struct ads1298_private *priv, int chan_index)
 		return ret;
 	}
 
-	/* Cannot take longer than 40ms (250Hz) */
-	ret = wait_for_completion_timeout(&priv->completion, msecs_to_jiffies(50));
-	if (!ret)
+	/*
+	 * One conversion takes at most 4ms at the lowest sample rate (250Hz).
+	 * Use 50ms to allow for kernel scheduling latency.
+	 */
+	if (!wait_for_completion_timeout(&priv->completion, msecs_to_jiffies(50)))
 		return -ETIMEDOUT;
 
 	return 0;
-- 
2.54.0.windows.1

