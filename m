Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9B63A0EA2
	for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338104; cv=none; b=kSh3NhssnQi5UoDQVriAaGXYIYK7gfCKdK35Jbc6kPdY532zEd++IbFL3Tv6Wk7HLi/7wmZ1Z44G2UzbGLMIHs8gmVcFAvO9pPBVGFaTc3GLes4mTVFigDPdUShVaqCq9ig3SIZSK3oOgCFpJPHp5fEm5ElM4GT6KEqMD5cKbNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338104; c=relaxed/simple;
	bh=/Hnj0H/O1buiz856E9WnnfEKOTWPMlp9u8uY75SE1ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXfnzgCgnEok8RqV29ZTn7dcLb2cbnjUucvoms/lbDC4MOMQegFgMWdmjDJiBRJ3lOBqwiYyhQV52SrQjnvfYwRJTeD+0wBvta1bT3S513dbZiaVVZIP/6ukFxXMB8NvEYBeKtxhuWIi0WOh9MJvdonLHTdbbyKmlcqA1SfY25I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGdde5kx; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGdde5kx"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38ea6a5a0b3so11470361fa.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 04:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776338100; x=1776942900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REsA1kYbcVU9wVxwqH3VEQZRbwMApYiGqa5ppEy1C1k=;
        b=cGdde5kxFILV5x6RiUEPXzWOkDtIq1WOkF9aUwPTefLPTPHlmfBzofZkkOySFjzMIA
         wpLvmxruTkRO3oHjX8u/d1QJ/aU324SSVdoYVR/khpCENkywiQfEhdd8jChw2tal1lwK
         E9GigL6iLu+/kLfKodbYtLc2/uXR7PlLrs6ymROmuIlBgbc8gvmAzZnUj1Kn3F6L17S9
         mV2EW0lftj4q7hCgvEA8C5dd91eS8j/1IuIj/HBMkG+AnUBhNguLjEE26zCNh90aempJ
         moWZ0b0pJ0zdYqxa5nH20H4MkHIc/L0R9aUtu3S4K5yc1Gsh4Qti6SK5+G2LSlWrm57I
         kwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776338100; x=1776942900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=REsA1kYbcVU9wVxwqH3VEQZRbwMApYiGqa5ppEy1C1k=;
        b=QdDaeAsjtwC/HKUcM93NODMlR5LRSlhc+RpN4ep0mLjrGGXeMGcbfyaPgxbE19ZmpT
         Cg0/wkWHkw/PUGd499uRbBCQcEWrt30rLH/evtf2UZmKu30G3fTj1Hs8pdA5Dez3Wh2S
         g7natYvemmz1EEKg5tIoH9DVbnDzRshOmNHuzAEZNyBHnebdtjrqolwe80/62M6dzzRh
         HWh+kC6e/N1U2Ueend5J0aCJ124/SZwOQFWD8JRWnTZvhztno7TQYneBwX3A7jkbiUL6
         ihu738Grg39FK+pKLI7JJN6slj/Ft/oAU/nzLyzMEXx2HgHVknvsbTnU4QGNQ58XyTTo
         PO5w==
X-Gm-Message-State: AOJu0YyQY1TepbYjPam+YITFJdC5VcxAgdISWNJnj8Wrxjgnuur9s8HV
	CaVykLqyN9+3xUZsg9Lq/2RUHn/FEs7aNqUuzc13pA/5eLUUnNqgWxio
X-Gm-Gg: AeBDievlao+uPuP/7kxZPrJNSZLUnEMIz/92gOctr+uuOTuSsXSRKa7MRngaJDWYD6j
	H+T/Qihf1glEVftO58Ssiv1jLUSSC5202vAKpsDfU3nM8enAGjZajQ/DIwwJ+6qvoVWQSpm6eiV
	fvMQGmoI9WMnEckKnqasxWs0FMJRTEuxJxUykDoaQkI5zwQIFnkxTWrHgLwsjQnSaL/w0WOvjnN
	Yes6XkJ0PkYpF2YuWH7YM7D6bL4LvuXmdKpIWcLKDgm03IgrJFSaKtlgsiiSGzIS8n9XToWhqKo
	PFow4Wut52WlgOeN+A2pno2L9VtL9Vgp3W0txzvU5yIs8MXmAypJKIFvfkPIA1FmHdvemZvkuNH
	hAynUClcBZbf6MUFfIOOMedgF7dDFVcHZdW950Iiv6wX148CHUZS7pLDZma1CO2L/dN+k2Vpudd
	xBUxCGa9Q0qPsZjz+oVf5TUog=
X-Received: by 2002:a05:6512:114c:b0:5a1:3b7f:450e with SMTP id 2adb3069b0e04-5a3efb54747mr8905980e87.42.1776338099516;
        Thu, 16 Apr 2026 04:14:59 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e9ebe67edsm10734831fa.19.2026.04.16.04.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 04:14:59 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] iio: Fix iio_multiply_value use in iio_read_channel_processed_scale
Date: Thu, 16 Apr 2026 14:14:42 +0300
Message-ID: <20260416111442.61932-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260416111442.61932-1-clamor95@gmail.com>
References: <20260416111442.61932-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function iio_multiply_value returns IIO_VAL_INT (1) on success or a
negative error number on failure, while iio_read_channel_processed_scale
should return an error code or 0. This creates a situation where the
expected result is treated as an error. Fix this by checking the
iio_multiply_value result separately, instead of passing it as a return
value.

Fixes: 05f958d003c9 ("iio: Improve iio_read_channel_processed_scale() precision")
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/iio/inkern.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 0df0ab3de270..9ce20cb05a9b 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -738,7 +738,11 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
 		if (ret < 0)
 			return ret;
 
-		return iio_multiply_value(val, scale, ret, pval, pval2);
+		ret = iio_multiply_value(val, scale, ret, pval, pval2);
+		if (ret < 0)
+			return ret;
+
+		return 0;
 	} else {
 		ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
 		if (ret < 0)
-- 
2.51.0

