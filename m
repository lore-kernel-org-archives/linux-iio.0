Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF23338907
	for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 23:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770766798; cv=none; b=K/F89cmlBixlgL06JRhOkSfLeXbB3OSiB2OIjgm4Gi1eATmBGEoQKd8lElVriTrx8t9azRThaYy+1BPxkJAdGDelmucRJ5AJr3RvPGnJiWG/fyajJNJyHWjGLfmyxMQ82Ju9ifowGPbLnRXKKlwSuZd1pd0zAbJiBk2nq2gYNug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770766798; c=relaxed/simple;
	bh=EF3KYgzjAoJP2SBc171ARj8KPZC16BDbu4mINKLJzKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayD3OOdFesGYbrCDtg8CohmIFoIrVCF0gA0BkJWGRulfuaws2l3s7OpRaMYGlZnxSyXiEIDirv/B5LATcr5owBgfMS831wSJIgJ5+gha6YyQO8Im1ZXjrqk8Gjldwilp15WL0ccC9u8DGVj+bpjmIvwVDC5DYMgH0NuJu2Ya3b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0t+mCXK; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0t+mCXK"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5014b7de222so61879521cf.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 15:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770766795; x=1771371595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdHIFvs605gqtkx0443IpAji7w6Jn7pNamC9BD3YnF8=;
        b=W0t+mCXKbOIQrMVeq1qxKc0T+WN9UNAS5yCv+gdLa38TQQhKyKEZw1MO3oeavYgvMj
         uIqoBws64yq4PnuBULwXMVnofwouG+hgi54iN+6KTJFcPyMxRqcNx7mNDC91jGJ5ZuhC
         vdVbcLjFzqEBhYN+MG5y8HNcBunoVVzXyWweHU+mjhrxoI5zmStcMK0uhCkms1FBLm1Q
         s77SK/pp1AnaFyOqI82GwF/X3hrCTlg0H0ggkTxP9/WlzaCi/ULsHBAxirHQUdB2ey6h
         JLn5csAyD3zW+gjH4GuHwrW3XfNS8RQnGOz7cn6kRiprHrXOFdCoEC3L7bH1CiS78RVu
         1cnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770766795; x=1771371595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qdHIFvs605gqtkx0443IpAji7w6Jn7pNamC9BD3YnF8=;
        b=jzyqM4Z+7tMBVtXYiEnkyK+ql4r+AOk0xmlgNvVsUJqSa4z18JyTCZNfg/fnrL1ZA7
         W2/hy/Gybq7qU2apw36VV212Js6Apr83uuuZMYAPXDzUVUCwUKfmD1nOnIH5naIEN/Uk
         Bo9cNATbI1vr96V4B0JkTwX1Y1DzTnEz63hkBiIkIQ5M1X4FRbcCRj4tptfZSAgdeord
         BBWW1M87Bxik4J1xbF9nogx5SbnMzigJezeKr7g4ZOXRtCFqihMmuBNGXlbykLG3NHjj
         aDsWXaNunxzIgzN3VDmnMw+iZ6a3usWZCzqTBT7C7niLL1Ec+hdiRBOVeMdd6VP+dLRb
         9hhA==
X-Forwarded-Encrypted: i=1; AJvYcCWkd80E5hM10e7w6pYSpA6uxDIAHkfs+KFJQvRwOXZjtFyU4CtHukXmdwPyYsz5Qi6GTr78dJjcrN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/hC8U9F/GepuVpyI1G+rzWsEGiEPljuUl95VQA5t0jsRkUcuq
	L/+0NCJBPauyEl4JBc+cEiHj3RWhl4039gEr99035Bqc+h1Fx3iXo/NL
X-Gm-Gg: AZuq6aKNsbyl9pqTury4Cn4VJOppI9tXehDkLbvSPrxnV++794ytWb7XT86SadyzssF
	lkk03dP7MzwifNv0WPdiWa4tlToalHGix7gFalzcecs4eHcJAmbpU3UIMKqksto3H8+qZgSznA7
	nI2BLth0fPlTRHYkz2USbH7pbPIkP15bR7ZRm+l7uUwRghWx9wVASpOqwjJ4DLVDWFWVUzwtNEH
	8WZxohOzoL9P4bVBTx0Rp7U3kNbIYzY7jn82sq3NoEfOSE32EH2jaG+xu5jAj7d2SL2L2Q7xMVb
	7ZnUVfypHPkUaoAnR1AJwQWiwJgNUM54FeRb95oxsQreWWCm0giD1DBPjnq5RjRQx7cuktxXMeH
	ieAMbkfGS+wCas2wL8UwJWCQPAoDLeWgxPR7nLomtqGF6p2kl/HPE8vuJ2nTDdk0Kp9sSqzzvy/
	cAO++C1dGfMr/JXEOYZpO8FjWGquQxS6+mEgUc7d0WdQ==
X-Received: by 2002:a05:622a:653:b0:4ee:1f22:3613 with SMTP id d75a77b69052e-50673db66c1mr53256101cf.62.1770766794786;
        Tue, 10 Feb 2026 15:39:54 -0800 (PST)
Received: from localhost.localdomain ([50.21.71.60])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50682f13f20sm1850561cf.14.2026.02.10.15.39.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Feb 2026 15:39:54 -0800 (PST)
From: Neel Bullywon <neelb2403@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neel Bullywon <neelb2403@gmail.com>
Subject: [PATCH v6 2/3] iio: magnetometer: bmc150_magn: replace msleep with fsleep
Date: Tue, 10 Feb 2026 18:39:44 -0500
Message-ID: <20260210233945.40975-3-neelb2403@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260210233945.40975-1-neelb2403@gmail.com>
References: <20260210233945.40975-1-neelb2403@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace msleep(5) with fsleep(5 * USEC_PER_MSEC) to allow the kernel
to select the most appropriate delay mechanism based on duration.
Using USEC_PER_MSEC makes the unit conversion explicit.

Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
---
 drivers/iio/magnetometer/bmc150_magn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 5eb710eb020d..f254774d28e5 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -681,7 +681,7 @@ static int bmc150_magn_init(struct bmc150_magn_data *data)
 	 * 3ms power-on time according to datasheet, let's better
 	 * be safe than sorry and set this delay to 5ms.
 	 */
-	msleep(5);
+	fsleep(5 * USEC_PER_MSEC);
 
 	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND,
 					 false);
-- 
2.44.0

