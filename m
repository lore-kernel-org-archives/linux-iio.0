Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01763EF0BB
	for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772048482; cv=none; b=t2zKCU/p4VRV81tSBg+0S/+sntoFuW5A7kTUHWhvZwsD5McBprhDUG0r0/CjuEMdL1+s1kDaLU6eZ7vwYa1k6Y+NeAfea/aiquXkOuRFlW2RhweVKB7JI9GXE7wmZMwGOJs6qaPCufaU4j8c59R/drQk4kn0b2f7FqeuXtSZqc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772048482; c=relaxed/simple;
	bh=RLS6Ctde66yo3DY+1QhNw/+1vdcqCGEHPFV20dCNLa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIYqzD3vVg8Xdz3B/9i3pSUq+TFMAghfyCwZsixvcdGWNIux/FX/p49j2qy3k8bIazcUsA1iPRkZaVcR1BKAiU+v8i62Ds5UZcFmOJXMmdjI2iaUTP9rWy2yL7Gg7kkw+prLvAj19zWyVQEcRPXex09YLE+/fJInSgkxT2NoI3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/8VrBIj; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/8VrBIj"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82728e5680cso68843b3a.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 11:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772048480; x=1772653280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aFSIPVo/IqqhPOfk+I5yatUbOpxU+FK6tAxs+CicbU=;
        b=T/8VrBIjjd9+LryiM4sG8HKzX/9iuq/NF5tK6QZe+cw0+KLD9Ut1AQ2SLzxctfRDVN
         pTMkfnsGOYeTARDj0/Vmylvbi6oJIUUMIaMvhmE1LpmwuwQxUcBLryOF3YWssfdMJJxJ
         GTNFberH6oweN2c6I6+SAii3ElFXYdItu6eX1kqStVEHavC6KoS4sq6xh7Txn3wl22MG
         EY6PC3zO8yabAiKq51JC0ZAPxFc7NNXNr/QTZodZl5bFOBYHdh5O2i3Rb4cdMk7j7Mb3
         wGtvwz9/Hf8hBblxD6NloW/cXHHcYgbZsvbDazSEC9geg6QYKkLy9ckAU6njshq61Hnc
         CmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772048480; x=1772653280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0aFSIPVo/IqqhPOfk+I5yatUbOpxU+FK6tAxs+CicbU=;
        b=UicSa2FLKgem6LIJ4WX/byVxVIuEnC9klBrni9M11v4PGnZy4t1W+GPTJGb3J8O/PH
         9/Usz5bZK+D9hjes3DHND5NHLOpYxQkf5kYnbyiPMtU5MBjDoGkatrNfQYfQgtKVGZCq
         LiuyhyytWWUGJWM4NnAnI6LDG5UbhHJKhRVpNSCrAs4gnt+EgMzeoDU14y88c3wMsZ6w
         noUIgQfaN4e+nmqkjZdUou0MFcGbt7dsr8d1EsubvpWL1tcToicKpU6zxeQhgqzeyiHq
         aW+NGBNbQPLcT+TUqUng26lJIOiRpTVlTObTjAJTr5Gpux++RB4F00sgSFchAkShcxCX
         LDnw==
X-Forwarded-Encrypted: i=1; AJvYcCVRcvkNBcSBQNmDLesUypE8dr9cfAC25x3pzlaP5rJk3yL0jlXgspU7sDp3BjMBCxKbW06pBDaZ/PI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr/z+WvjSqC+/ZnLctdhaaATjfOL0csyUwuMgkok8/OVTVcTQp
	fyye4eogdIBMv8aDiJJkQD/ObZmdHWb1szpLIZKZrYXqJMIF04eQ1kUB
X-Gm-Gg: ATEYQzzH1FeuRhXiRlbKMaML3dshI/aXrvlQpxAemw5oZAm//caUARKYQG55ZVjFTY+
	HBLWIfvY4/2JwJrvuvWcBxbZHG/R16UZV+Am9/IH6Xncch7/eBCMV7Q6wojXdl1+w2vlX34QHiD
	k3lhWZuGnqDiokhhBvraL64JM614sQbOO5wZqoNkVUaMuX3vFtn+iQ3eDSejdoFIct/bym9eCNg
	fpUjq+Wrw2Uh7zwXq5dsoqmRNH+qEMJYYLQcJaUPoWPP2iueZFmCln7DMZ9No6mNNdaRFLIOXWo
	jd5lAom3JzUAR4Hh6P040uS9NV+bgtrNLkqfc4QZ1RNkGPNYjoRVjAs1GawY3QeHybeY82Tu3ea
	Q7eID0B3hucAMK/odAjV9FHPvu4BKcEgyvCDV8l7Zs5BN5fACVrBapxIYPAMiozZzpFrDjFpfIP
	AhH5U/Y2P+Uxi8i8RIDk0ADXdD
X-Received: by 2002:a17:903:f87:b0:2aa:cfee:a476 with SMTP id d9443c01a7336-2ad74567025mr154314105ad.48.1772048479963;
        Wed, 25 Feb 2026 11:41:19 -0800 (PST)
Received: from arch ([2409:40c2:505a:f4f0:ebc3:455d:5e47:8a2d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5dbaafsm302215ad.36.2026.02.25.11.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 11:41:19 -0800 (PST)
From: Bhargav Joshi <rougueprince47@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rougueprince47@gmail.com,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v5 1/3] iio: frequency: ad9523: fix implicit variable
Date: Thu, 26 Feb 2026 01:10:49 +0530
Message-ID: <20260225194051.8614-2-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225194051.8614-1-rougueprince47@gmail.com>
References: <20260225194051.8614-1-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Macros AD9523_CLK_DIST_DIV_PHASE_REV(x) and AD9523_CLK_DIST_DIV_REV(x)
implicitly relied on variable named 'ret' instead of using passed
argument '(x)'. Update the macros to explicitly use the argument '(x)'
for their operations.

This also resolves the following checkpatch.pl warning: Argument '(x)'
is not used in function-like macro

Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
Changes in v5:
- Reflowed all commit messages to properly wrap near 72 characters as
  requested.
- Collected Reviewed-by tag.

Changes in v4:
- Used full name for SoB 

Changes in v3:
- Updated macros to use '(x)' instead of 'x'.

 drivers/iio/frequency/ad9523.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 63c485e9e44c..5725ab62e0fd 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -167,9 +167,9 @@
 
 /* AD9523_CHANNEL_CLOCK_DIST */
 #define AD9523_CLK_DIST_DIV_PHASE(x)		(((x) & 0x3F) << 18)
-#define AD9523_CLK_DIST_DIV_PHASE_REV(x)	((ret >> 18) & 0x3F)
+#define AD9523_CLK_DIST_DIV_PHASE_REV(x)	(((x) >> 18) & 0x3F)
 #define AD9523_CLK_DIST_DIV(x)			((((x) - 1) & 0x3FF) << 8)
-#define AD9523_CLK_DIST_DIV_REV(x)		(((ret >> 8) & 0x3FF) + 1)
+#define AD9523_CLK_DIST_DIV_REV(x)		((((x) >> 8) & 0x3FF) + 1)
 #define AD9523_CLK_DIST_INV_DIV_OUTPUT_EN	(1 << 7)
 #define AD9523_CLK_DIST_IGNORE_SYNC_EN		(1 << 6)
 #define AD9523_CLK_DIST_PWR_DOWN_EN		(1 << 5)
-- 
2.53.0

