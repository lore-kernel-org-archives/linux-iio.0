Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAC461FCE
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 19:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778441681; cv=none; b=vEx/quAIsdr/gPinv8ufCgqgTDPz4aAaHehaWfG6M62yq6TBUyQ3cKZJFkanoTm5CNDTvQegMY97PtCiBzY3xnpNOFZ3mGbsxGjdKqaPGB5BO2Gfp9AOXsWKbm/XNsL6SKFI2+tNJ70t8HaBcpWrvA2nB0ZkgwDBm8BPOSFZMCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778441681; c=relaxed/simple;
	bh=InK1uMLMHIryIx2rfET3AXRnxRLRala+9aKoJnwTbAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTnV6/EDrc7cJnSNEMXeBhD8Tk5EvZJtryxPJhGXMxOMCCQUZPoiM3tQQ3nde+nYUyVlQqiI7WXPN+r7EXgumkIEjViBywRE0B7TV/WwUfnFBu9/+ID2IxQDDhlDR661RzFlzrDIHoV83Ws4Y2pFvR/B6v5MjJn6S3ePwmkatn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ugc4Y9JP; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ugc4Y9JP"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a85b30dd54so3666918e87.2
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 12:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778441678; x=1779046478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPr/xvPiVH/kfxzskdqjcF7SmnVg829pocol8hpc4ks=;
        b=Ugc4Y9JPbxux3IOq5PWine8rw90MQqcGETd6EE9OmgzxNqmyJ5/iPa8UUrXSfn+wT3
         AF4HXqr0rGhyEfVVQNXg0tPwOkSN05TGFV2vr+5eMmausM7f7omq4UcDto2W9CeAIWT4
         3HeeC8KLtlsFbFBvvwMk/WkkfoyyN3etassfXtA86V0XOYMh8vQ6YzomDpunvyvuwfYc
         Ya43CVH9Olr5II8z+QBRLyuW/OGVjnrEahh2BsOCJMb/DfMGV87tl+3Xg41UetyATk6m
         RxE/fWyDJWF2zWLmkuE19Xyf2g0dGFztqsvkllrbisgpmZNZmbIUwU/nXofJy9O5RJnG
         paWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778441678; x=1779046478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JPr/xvPiVH/kfxzskdqjcF7SmnVg829pocol8hpc4ks=;
        b=MajY2th93lLnLq6bgpf9LqSETtpiWZuWgCuec7ly7yX3GKcEwajBcMjgGQ5SV4JAx1
         mUQZdFUFzD0cLQlo85pvOuVQUxwhqz3KJ1I8Mr5Bj+LU8pD2WLEl6dSmN62penjvdfel
         v23bTKOx9waqxLmiboYWA+JKZdSwyIxx4oOF+Bxo7MGss8xzKHXqv6bD5xiXSO/H3MlL
         0XV4iW2nkbvKzogBFhzAdF9pdCEwp2aDVrSbdAFy5UA/ee/TpOawY9RHNldIYoWF/h0L
         VQRbifi5QRfJChrkKIxYnRwClku7TUSE4D7B3BVmof1gSu0Ggp2zdjhFc/SIyKaeo/1x
         Noog==
X-Gm-Message-State: AOJu0Yx2zHxgrYY5JGVLUlNWWFSB1fHicC+Y9+3ZN18tI23bZlDZ9xNo
	BJubvuFFEm0I2WOd1jfh5W1L5AYCCMkexW90FSwP9ePa+0R73wvb/ki68zocuqEI
X-Gm-Gg: Acq92OGqHqM51xHREKJM0TwB/qev/243D2cAji7iNSuy0QkdCOOBBZwu3cbw6c+ckA1
	uq5UOOMw1/lNGrEmGCLSc5+PCT2nXMvts2d2KFM98+eOsfsv7/tuZIZ0WGjN2Xt6+HSvsHhQR2U
	O4+i1xdoCvfHthiU4uyDV7e3FWiFSa+6DX7HnCdgh2cH5nj/U0alebUpVVV6zQvdJouoGZANtQS
	PnXufHuVIkuW6cMNYBWM5mgsdNUXxa42QFUq/FGyeUMWhLw2MsJRh/jCAIN1mK5ddmq0G/2/1nF
	9ddx3dc5chyLWZl5GiEL+8DiZnWx0CqIuZmRTOA2J2PSOq/Ma/sknlCJkjfxfZqN+FdNfJkznNS
	imTreVx/KVW6bfIbtW5yyq7h0T6D48aaBDoqaKYSNn8sNiVczZQBi/amr7eM8hi5BGwaygU957m
	5TY3U+e+alGOabtCYJN8QTwxwZWIjWnrGqAV2KZ446+pnYd5zE4cMzANm1iJvKLQONRQYp3HC4P
	8c=
X-Received: by 2002:a05:6512:31d2:b0:5a8:64c4:38bf with SMTP id 2adb3069b0e04-5a887add241mr7145517e87.5.1778441677716;
        Sun, 10 May 2026 12:34:37 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8b3e75c31sm1616787e87.18.2026.05.10.12.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 12:34:37 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	andy.shevchenko@gmail.com,
	david.lechner@sifive.com,
	mike@mikelooijmans.nl
Subject: [PATCH v4] iio: adc: ti-ads1298: Fix incorrect timeout comment
Date: Sun, 10 May 2026 22:34:35 +0300
Message-ID: <20260510193435.4602-1-shofiqtest@gmail.com>
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

