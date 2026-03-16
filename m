Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020DC382395
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651714; cv=none; b=olg2365L0Zu5/aE/TlUTM29E/Fur7zEJBsj1RCoyKVOM6wF9NQmZH7hT0s2bigYLC3BepDhPJyYgU/Q1Zn0j//cyGZToiYqVPf05KuLiSC/yZN1CIfIDib3noTBKJRpRocJ9DdK71yvoPBK6AayczMpxSOfJ+adCWQQkKavZIpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651714; c=relaxed/simple;
	bh=Fe6+iphA9F6ev0JQO0Pk84PfZ7jfQsHoip4Cne45V8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NuoHv86wa/934v0y+EIrNP2KseClrZGUtdeTP4upfpBxeKpuZLjoTEHghqsgzutovNWPpsCKJskEK8GlNmEAJBzrolrKxWJjITfIs+w9qxpmvsNshnbHIsXeMbV+pSrzUjW4cs+KcllDvVl/xlBrbwFBkozJjFMJ7yf6vlKO4R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBxMJU/f; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBxMJU/f"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ab46931cf1so38553585ad.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 02:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773651712; x=1774256512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NnGrKZfCQ5OdVoltW6rYje+I1caYgLD5Ja8epWAZIs=;
        b=SBxMJU/fkwtC/24Y7v5Z0rpxy3crm6a9LZ1EEllg2YAfBzaSShzuwEBmeJDyKbrVty
         9N1CY6Cxd/Ohy267Hf/D7e/99AC2E2QXHW/QbvvhZDve6s+0dpy5b7XAIs5FMwK5WBJc
         t1ttmQs6HcIb7Sz6BY5uW/b2S1iE0wlFyiUX27ExDqpApsrD25iUn0gVgb6gwHug2MVr
         pCiuSviVdJ4eaOsA//soxYI5020MgbAK+vi0s1HnpF7uXLwwr9urkqSeZ5tVNXPO/nM8
         q9qvyVipUcNE8wd/6HhrwprvMANSf8q7xkcWDeSZE2oO/3zJQrxMA4t26BE5uU4A3Ouu
         ykVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773651712; x=1774256512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7NnGrKZfCQ5OdVoltW6rYje+I1caYgLD5Ja8epWAZIs=;
        b=nkWOtRmi5bXqpbK2QBxo2mcrGDeUgtD7AIWa/2ioUr6oWFR+wjE/wEy6mlYHl32XrD
         moput0kcTCRiwXqx/HM/pKLFHOtMiFbbwos9splDLbo4Bmy4Cf3GiWIEN9axZSYPSEOk
         yd+LxJs0itZddpiuUQfXd/jvgJcgFJW8q/N3HuX51i/YBbzuFawyYF09L5QH+2DfuVnr
         0UUBmuRe5TnE8gWQVN/A3PG2QTtwJekq2aqOowz5sleD+IrvMngBup8sVRPnSN1wgDiq
         J0Yy9F6GVitlOuX/gQPNfV871Ym2OBVTxdCY8WU3+VVLUuN60hv0S+ulwmOQJitT1o8Z
         YYvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt34PBsFKTZRHyC+C0Kd2xRg9u3PXuqJ//wFFgb3Rzyr81b6YRSbgAxBvJMHvThSZ7iV2i1vYVni4=@vger.kernel.org
X-Gm-Message-State: AOJu0YydVLfnZre8l6f+6CyxA4/SjyofZywbvBlgZmmhT1bjrFx79R9m
	Vs+YcJpZUe3MdqTa/D64F1KWcRFbFBTHAkq9W40O9XtmUrGFWcZAARHe
X-Gm-Gg: ATEYQzyD8VMtTJ3kZmE1F3VSbRdF8t7cBG9uzc114WwzrNiIY2AUPlc2H7kr3LYK/dN
	XG8/SuOThuYQa47s3nDvw5IdWKzSBBnUos6vOTNwl4YRWEYg8zQqd3DoQLAcHx/lJjqoFYUgI0g
	wOetub5yjlWH/pAlC3SbzrNwPw/6iD0/mcc6XfS4Lw1ghI1a+XkcMpYHsssWhmnXrsUV9eq5lbB
	RexD6aL6nLHCXIeRteDUCkwn91239W72+7Htm6Zswfexugb6MaT51g1xS+ze3Bul2U4mcx5llpB
	osbnAHpJPttXnwafuUD0MpXDcJ2wrG7IWzYLqyuAjUWITg20ejR/z5QsoFVoVB7UWVL+TjEtHvB
	XwnrEKzKY3rBN4KAq6YfKdHL5Io86vYXmNWs3UOLQvOS7v9bYFgJiZ6MS1prmMCPTLPyWZd9kxr
	NOocBGj2Ci+KLnsO8XQXpLGXVJ
X-Received: by 2002:a17:902:f708:b0:2ae:cd8c:bd04 with SMTP id d9443c01a7336-2aecd8cc00emr95744645ad.10.1773651712295;
        Mon, 16 Mar 2026 02:01:52 -0700 (PDT)
Received: from fedora ([2401:4900:1f33:4eeb:289f:fcde:6da5:35e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece868172sm98105835ad.89.2026.03.16.02.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:01:51 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	i.shihao.999@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com
Subject: [PATCH v5 13/14] iio: cdc: fix spelling mistakes in comments
Date: Mon, 16 Mar 2026 14:30:21 +0530
Message-ID: <20260316090023.14691-14-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316090023.14691-1-i.shihao.999@gmail.com>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistakes in comments.

- becaue -> because
- reenable -> re-enable
- irq's -> IRQs

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/cdc/ad7150.c | 2 +-
 drivers/iio/cdc/ad7746.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/cdc/ad7150.c b/drivers/iio/cdc/ad7150.c
index 427d32e398b3..8106a6a83561 100644
--- a/drivers/iio/cdc/ad7150.c
+++ b/drivers/iio/cdc/ad7150.c
@@ -306,7 +306,7 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
						dir);
		if (ret)
			goto error_ret;
-		/* reenable any irq's we disabled whilst changing mode */
+		/* re-enable any IRQs we disabled whilst changing mode */
		enable_irq(chip->interrupts[0]);
		enable_irq(chip->interrupts[1]);
	}
diff --git a/drivers/iio/cdc/ad7746.c b/drivers/iio/cdc/ad7746.c
index 8a306d55c72a..cb97e3c978d8 100644
--- a/drivers/iio/cdc/ad7746.c
+++ b/drivers/iio/cdc/ad7746.c
@@ -606,7 +606,7 @@ static int ad7746_read_channel(struct iio_dev *indio_dev,
		return ret;

	/*
-	 * Offset applied internally becaue the _offset userspace interface is
+	 * Offset applied internally because the _offset userspace interface is
	 * needed for the CAP DACs which apply a controllable offset.
	 */
	*val = get_unaligned_be24(data) - 0x800000;
--
2.53.0
