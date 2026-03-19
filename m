Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CF6396D22
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 22:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773961076; cv=none; b=S/644r6zBRm3ctyk32r8GGYRtN/p5u1xb7Jvn9GLFd+tziCFArgjc1d9GLEM96OC9/7gGLv5i76Vnhsy3ocWJ4SviZsVCxIYKYzySykhsMcaYEfI46muW0TDW7dYI3BTk0Jt1rSPhMULG4zEl3Zko1B/lgMs5lOLGjZo5keBP2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773961076; c=relaxed/simple;
	bh=mi+nahRV3AML+TCczemZtpgfTgH6f2JB8wwFP4hJLiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bjMacqVbd1JijtcQMt5/UU9xg1jxZQbR36RuTceR/pGwquAuaobh6fjntH6bc1rMNXu2G3CSfdNoNZxHN8yFUP3RLEukVe3zzksib515fIrbGW8NMrqs0AZFzPBXYZMZqqIubhrITlrIHuE664xko88dNX5NRAqcAxNLqFX2fSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2Bi3MOp; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2Bi3MOp"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5ffc8987050so942643137.0
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 15:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773961074; x=1774565874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdTIk59iuLLyzn1FDvdiGEAXrgiOQ7EQ8x5uGts5rG0=;
        b=h2Bi3MOpizScc4xMNn64wi8V/Bj8CZUiTuXuyAqC6LCTKcrGmDlwQkGMWUPUufHV6G
         5wlIDRC5LoFCdb6rRau6M3L+nZm3lXZuKq+ODWSVqpx98WK1Hn5LwTrnw5nCxgcv8quE
         fkCmxed+WBFnFspQpyQPnPltTB8nPezMFw33jVf9tdze+58OBU5szo7TxRSGh9m5+Kxs
         JDuzmEVvD4CvwGR6Icyu7UJVBcoGEp08Tvwtgt7Jk3ASbh49KU70ZCjwNfSp4mCH7wHS
         j3xuGveKeHfEaKpiwho7JqhfqPfYa8F3lvHkdQgAPLGAczDilmO4HP1q8q19hdFPHBrv
         cJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773961074; x=1774565874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qdTIk59iuLLyzn1FDvdiGEAXrgiOQ7EQ8x5uGts5rG0=;
        b=kqCNs022VIi9+AtAG9qu/KoKC/Bs/CEFbM4MTFVtPRuvgDr4MXtkHCOLBFVPeZIJeB
         AiQ6T+n5EzF6DDhj2VPhrYiv6yov3h6/ghV+1pUlEx+TgLxzpj3zFEwCzH5pgW7mFWZg
         9tmcuCVRRhIErxCBHPiPh8Kc0hhO++rOUQlMEtzwvOZDQfmVaIFCSfauDq3IGEMd9mQq
         tGmswURrFR4t2F+01WCBAb1M8kUGU7v8P+UDa/XzlovNi4C4y3Zb0r7k4NdmkpenGhw7
         d0rcNgSo4D1Ppl/3vDQ4QOgoGE0bkkj+FHv1ypkp/oXfA/G/cIWmY8xUO/ObmzjtSnbt
         x95w==
X-Forwarded-Encrypted: i=1; AJvYcCUG+nSmRg9FcXpW2y4nfNzPfZ03uPEbRh60lWB1x56dPxPn4kRmQugR9HzvPkLY158qSoNiSUWrftI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZzhwzJK6PD2OX/MAMjKcoXKEde/Evyp83UwxbLaQse6EieJRr
	eUKyksQG3e6eTHfeMSQl5FRp08f0MIeT4eZDduAao6tcvO/TYUzM6wsp
X-Gm-Gg: ATEYQzyTS0yZJZw6fOlrVzOldC4QgDVAWOpMJ1fZzcJthUczrmNLzcNCarkX7qTlErM
	5tqNNvC/vJTJPCItYtAXowFrUmyQemC3qbJ9c3QJuHA2AZfzZ1XGMSWgwMJ5JuKYo1pNLqhN7Bf
	dPXsKyKWezfa0kfm3X48Eh4YRASQ7hv8Ha0YGLyr/1lAhHvIGg9f3sowOCZOoGstXfwEMlxbi1g
	DbVxc+ppIDgGsCIWL3ZtqZwgFjXcTEGNmFJ7fRz9EIjPG1bkqjPEYMK4bY9akIIrGH+VmLQYESz
	fP8ar4O432iRb1l2j+Ve3BCKxylC7gfr4AxZ8PrJUN7Z0AkqfmKMz5ND3vt2eoLyXdAWwv6JWIU
	lNy4WL0OIbKDUBjlw4kp7fksjpHcamzRSWsSNY3GfWEL8QIaYCeljv69ZwCwPOl0YbrfDnH/dn2
	EgtBRGKvq3FKU9tjDsRaFs05fiwTWEyBciKw==
X-Received: by 2002:a05:6102:5989:b0:5ff:ba2d:17ab with SMTP id ada2fe7eead31-602aead0215mr682760137.8.1773961074503;
        Thu, 19 Mar 2026 15:57:54 -0700 (PDT)
Received: from localhost.localdomain ([149.102.251.107])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95136bd79c0sm204828241.6.2026.03.19.15.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 15:57:54 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: iio: ad9834: use sysfs_emit() in show functions
Date: Thu, 19 Mar 2026 22:57:19 +0000
Message-Id: <20260319225719.73587-4-grondon@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260319225719.73587-1-grondon@gmail.com>
References: <20260319225719.73587-1-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace sprintf() with sysfs_emit() in sysfs attribute show functions.
sysfs_emit() is the preferred API for sysfs callbacks as it is aware
of the PAGE_SIZE buffer limit. No functional change.

Signed-off-by: Gabriel Rondon <grondon@gmail.com>
---
 drivers/staging/iio/frequency/ad9834.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index d339d5e8e..844e92adc 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -290,7 +290,7 @@ ssize_t ad9834_show_out0_wavetype_available(struct device *dev,
 	else
 		str = "sine triangle";
 
-	return sprintf(buf, "%s\n", str);
+	return sysfs_emit(buf, "%s\n", str);
 }
 
 static IIO_DEVICE_ATTR(out_altvoltage0_out0_wavetype_available, 0444,
@@ -310,7 +310,7 @@ ssize_t ad9834_show_out1_wavetype_available(struct device *dev,
 	else
 		str = "square";
 
-	return sprintf(buf, "%s\n", str);
+	return sysfs_emit(buf, "%s\n", str);
 }
 
 static IIO_DEVICE_ATTR(out_altvoltage0_out1_wavetype_available, 0444,
-- 
2.33.0

