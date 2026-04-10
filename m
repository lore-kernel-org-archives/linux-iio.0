Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823F736AB5E
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775849867; cv=none; b=D/sWr8bvU8WEsO43Ne5J48bdPcngtk9p37HaLRzeUsEng6ij3AP3FIc1YBZl5V78RSdibGdVy2PeVdI0UvEPLtwhw7czZe02oW+77ykGGs5FESd/uoTfg7/exMClYtAUNz8W7cfGkdRELtI7FpCPSbFSVBEDtyQ29058SKJEYxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775849867; c=relaxed/simple;
	bh=3EHYN5vEXp464OOy+UC1yNhA1XEN9AYMsTv7UjS5bNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQvmo3P1TkQUfY7jACCxKoYTinv/HsCxB1o7VkJz/f9yqORA7w+u5Y4MbaY1o+Z3H3TudyjnuZn7fskLdxEEdQUv0uqh3OwTO7G4oJX7cSgiPGS69JOzsFscJeq696CiRA1X/3UZNkRUEt7hrIqY3spOK1q+kD3z7vM+VopVb4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AACdi/xT; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AACdi/xT"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cf3ee0fc1so1505691f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 12:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775849865; x=1776454665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0upwr7QVyz3Qfcv33A2Rb83Y4U57V9lVUbvCh3flZs=;
        b=AACdi/xT8WMcGFJq2v7QFHSDZJyfRaIDDump7O7xnm5F+hD59tsNL3ji/PxeNDt4jV
         uh0kC5LVM2No7WcHeODWlgKz1/8ED0YHIyyLyZXMTn8E0z5+I1bl4Pphg3tWBU+7ojOS
         lbtv2tyCWyQJSCQiZ8jULGPB9/pQQVFX4O1EyN6+usd7BwiyvfDBg8Hp5gtGF1vwetSY
         Iw0bF2yqK/HaVYgwgjhNc0VVvvQiVAH5UG8ER4v/84oIc2JX9Y9CNzmnmTcgypwUX5EF
         yYObHFCCZc3TR10T33F14OO8sz3QnXxE3rp2AbRrPviSxVFiTybRBZcB3ah0+AV+Jptc
         3bpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775849865; x=1776454665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s0upwr7QVyz3Qfcv33A2Rb83Y4U57V9lVUbvCh3flZs=;
        b=V6nRvbbZ/LCSWkVTQBg1aU/ik2lGk9kCtqiEHCRFmlWfjeZZ2LEMNR9cadgzxWNFuV
         bD/IR2I7cT9psVCyQGuSK93qBgh25NN2/FVMY7DJYT7aH8gzxnd4z2xmiC3rUOfcbCgv
         vkS4sQEWm1rnzwN0tX77fyqmNlNM3lTHAiD/7uE4t7/j69XTdE3oDoIJAIU0WTHBJGUO
         ep95oAuoHavF5yrp8htBugybpw7hQ7H66yHiOjR2LZfpkGcZo6au+5AGpA1UOPVmsZlc
         4L8RX5WXb5vS2tsvVhwTI8KCm132Akx1tQV+acC/W4Llq+x7ev+UbDqu/ywAydz4rsTA
         oGOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvDB7Z4Y8Z1O9bHMWhCMRAwSDH4ZtNNwiWWLE3i34A6jzForuuHs4PcCQF95QK2mCOZ1jIBgZhw3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvdJZtYGEZlW02hcZKWEkR4NN9DnGtVo6bu1SvtKJNLU0DUSBA
	zJxsZiSFC1qt/rMyI7vIsGcLFpZR6YCl44uRGvDxfdD5RJBxJru8oe0+
X-Gm-Gg: AeBDieu9H/TqXxLuYPE70eB6FjugDVtRDm0BEsqPjsLRGnPdW6VO7LeYDPT547/dXaZ
	ukbQvQLwJxY5PjdR49crsOFkLSq21WjtXBWyN1c9St6tuumxHYngKxckRNwCDG4xCgIM1M7cDbJ
	JgENUtRjH7QzQvk03vpXB+BXXuUFryW0+V9nsvjNqV4itJQYiidRlK/eqxMGWN2lryI+7zYUxil
	fyXhVdbseaCT9xokvJz635aP3nSmPJbraUalWwGBoXI/Sd7YFQaBId2cJ2R8+MUDMUx0qcSy9Eo
	t8ZN0ThbayyMlUJl6J8HkxQ1qJ671G4gj0LYXP5V98xqBQbDEIZrhSIEDlLaOy/vZU8nZ+5F2I2
	t3kXMsWQIo8+k5j91Weg5Lw2b9v2ZFT75Tsu9cxdL1Iogi/UV/UMDo2uuDdtj2hXSUdj09UP/1p
	zqiFjbvuZTpLbk+Ht4eU3Y3XRa5aRiRnT3i1M36nrMqVMHcQX+ofw9q/fWO4jBNPrRewP1GouxF
	9apLhAfm78C
X-Received: by 2002:a05:6000:25ca:b0:43d:2d34:8963 with SMTP id ffacd0b85a97d-43d6497b775mr7087922f8f.17.1775849864834;
        Fri, 10 Apr 2026 12:37:44 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50044sm9690425f8f.25.2026.04.10.12.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 12:37:44 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH 2/7] iio: dac: ad7303: Use devm_mutex_init()
Date: Fri, 10 Apr 2026 20:37:32 +0100
Message-ID: <20260410193737.35905-3-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410193737.35905-1-devnexen@gmail.com>
References: <20260410193737.35905-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_mutex_init() which is helpful with CONFIG_DEBUG_MUTEXES.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/iio/dac/ad7303.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
index a88cc639047d..1c2960fa9743 100644
--- a/drivers/iio/dac/ad7303.c
+++ b/drivers/iio/dac/ad7303.c
@@ -218,7 +218,9 @@ static int ad7303_probe(struct spi_device *spi)
 
 	st->spi = spi;
 
-	mutex_init(&st->lock);
+	ret = devm_mutex_init(&spi->dev, &st->lock);
+	if (ret)
+		return ret;
 
 	st->vdd_reg = devm_regulator_get(&spi->dev, "Vdd");
 	if (IS_ERR(st->vdd_reg))
-- 
2.53.0

