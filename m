Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B4A45D1A5
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823115; cv=none; b=ZYnnq1F+eOeCxLiwCXu5AivUH7LWABdq+dPTq5OlNm+DECJId7if1QH3Hen2IaKYp1vWWPD0qYFQyPytFvgeKy8QzP/3Yy/OjAPAThZA39ud7VEgxssnVr+x3wWQZJcfKJpMyH2GRGcFRCzhPra9XR5/dajMc0deKvYPRbvX9kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823115; c=relaxed/simple;
	bh=YvHRvVSLzzqqzkfqQCcnLbqcQacT4HKjmF9ufos0CJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kOeOZVEv8wyXB70OEJy/bM5raoXpSLjQ2qqbjic0aMXh0xO+VS/xYHCDQHwS4W4hYx+tMHJhG0aINszWhDFf23UJuTomm4mVPKPZiA/FSKocIjtinOhPgcHQbd1xYi4vl0uDm1hSm/q6HlDtsGRF2iwCP1W2eD8UqgpLWlpOzWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTeES6Tl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTeES6Tl"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cad8076b01so11082035ad.2
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 09:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784823112; x=1785427912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yZ9g9dFCni59wwbH19gzslxq3IGq2T1h0tJXe1RGXic=;
        b=QTeES6TlOz+8t3NYXSEb3XTOSTIrBBVNhNrDhLy9cH4WD8uwx7YfrlyRHA7o/3wRl0
         J17qeigWQ4YjdyXIQNyYNny99uWIpvrwKQMs8c3K0mH9UBUJ2+2GlTod6EvgtI0K0UaW
         mZz4qz+W09kYDJDxMAqrgBuBuAkkX6KBjGrx/EIUIW/UxqJ2fjDufxz4e0/qXRNeHYTj
         8slfwpAc/zYiX7BM3bryPRX883cJLLYUaE0vm++5PK6mPwUac7EW2Se9Oq0SRe7X8W0p
         XrAR59lXlBR176vYhwUl35fES667mQ8UkVAi/0Vsfcqk8o5yFVb/hkfjpClTbu0PwYGa
         uMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784823112; x=1785427912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yZ9g9dFCni59wwbH19gzslxq3IGq2T1h0tJXe1RGXic=;
        b=VcXSgw+N+JlHASSxT4LeGnKpMTrqiawbI92IrgyPHGKAHJY2cvTzU/1TuWHoJq9IWB
         J6lj5CDwQ9zZ41NOgyYj3uGh2tW8L+NeSsagPFQT0+11Ugls6enLacrzOBRoXDKU0Z5E
         orxt23KXlg0tc+aV5ILudHG4JIAcRsur1jTgGYL7Z/YUipDr2tM/eplZ5SsotFDEnTQo
         p/6hGEuiC+Zeqm0Tt67kkyx3TYLzHCon8tXrQIdX35oVyfGnaECReqn9tQRmntafvzQk
         kiGLDZ2F/B882JpfZgD+tJ8acwBBkVZRJ6HWmcZsk02/a15ixHI/Xz49lNJDzCV0IWL9
         jN9g==
X-Forwarded-Encrypted: i=1; AHgh+Rpa+8mDsdgcpYzKO/i/+JTUdLPgfreKsR47td8qsBggPgEwanoP+gb90pL/3SNauPkcNQWvqIEg/LA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb3AcbsiytS7+7nPtxJ7OqAnzuXT9NYam3cg1HVvCuaFLkeuE2
	LGKRMMBetZg7ViQhFn5l2fYyI1ApXyPprVWCQ2+splOglYQu3mXgXwOb
X-Gm-Gg: AR+sD10MlBKaIcFbGxSQY8BI6PdJw/AWW3kC3xfJRgetnrh5I4RQ3lWKag0SG16PWtJ
	XY+D0Yi3RgcGFnReXIOOp64YL5NbYjPCElX+4NgI4lq+eLva4tIk1uODxHukgj/MUuUgZXXezzK
	9EYG22sE+gW0XVGXpczjsv/di6th5QcpOsiZznmhBL8++t92A6xaTNjGn2bjRGub9WnAU9QN+D6
	bkCOwmRMfbCw7L6bRvhJ3Jxo90R/rJoOByAVJ4n5mi+sbT2OmLEwVnIHxGrE2kCV3OcHiecudfw
	muro+Lw0Nun3XYtQNNvylPJif2UN4rsfuV5cc47z5mZ1JpEOfVwSn4xWJY15GzpVd5axyKRhZZ0
	WE8H8zge+wqnzYD3h5PGvBCWDQHZFr4nnkZSc0GWohjnyrYOM/73WHUh6HC2wKYhKqwvG+9qO3N
	JwpIO4pgfIaiXshMlzqsCEMGHucyBwvSU0Svf69eVJlIdd92s+Zn6tjm5d0bYanZfX3dIyq4kLU
	XY=
X-Received: by 2002:a17:902:fd8d:b0:2c9:97a7:3289 with SMTP id d9443c01a7336-2cfa752eae6mr44864035ad.43.1784823112099;
        Thu, 23 Jul 2026 09:11:52 -0700 (PDT)
Received: from debian13.localdomain (bb219-75-96-14.singnet.com.sg. [219.75.96.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f362e00sm36303825ad.71.2026.07.23.09.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 09:11:51 -0700 (PDT)
From: Adi Nata <adinata.softwareengineer@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	mazziesaccount@gmail.com,
	adinata.softwareengineer@gmail.com,
	email@sirat.me,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] iio: chemical: cleanup codestyle warning
Date: Fri, 24 Jul 2026 00:10:38 +0800
Message-ID: <20260723161040.20318-1-adinata.softwareengineer@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported by checkpatch:
FILE: drivers/iio/chemical/ccs811.c

WARNING: Prefer __packed over __attribute__((__packed__))
+} __attribute__((__packed__));

Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
---
 drivers/iio/chemical/ccs811.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index ce7187ccd706..0e5c79b775a2 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -70,7 +70,7 @@ struct ccs811_reading {
 	u8 status;
 	u8 error;
 	__be16 raw_data;
-} __attribute__((__packed__));
+} __packed;
 
 struct ccs811_data {
 	struct i2c_client *client;
-- 
2.47.3

