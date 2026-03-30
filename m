Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23563377038
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774894665; cv=none; b=fAC/IAPfUEdi/ul+XcCxHonhxeeMt83sDhEF2oWnpqjyeJCD8LwlpOAqr5cxaCAZ8NaYe4XoS5pbt596XWgBlIdvImKSm7G++hG5yjVDrRmGm57A98pWE+5XIbtByYxjssfDvJHvKiP7YVvRYGGpsaFTXM05vGmCvBhHgd0CcOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774894665; c=relaxed/simple;
	bh=v5TwC4wVPLBMn+PJai0mOiveMJJJtBoH0VbaQ85em6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c2ajfpMW/MtSOzfNbIEiKldmHewWhS0RcDQZLmE/GIzLGQb9BaHZmYUC0JkjrmvC483v52825CHL7XhTaxi5mQx0xzRW6J3iVuDXHTnEdrolrs06M00vyTE3nNHCWgHuhczih1MshEczlvGPZeBBWrIVGsasWBk1Bz/Q6bFQZHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LI+brK/2; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LI+brK/2"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-82a67ce6969so3488845b3a.1
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 11:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774894662; x=1775499462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gtow8N65d/BtaUdMdcH6YJ/Rpa4A5Q8aZEpXNaY0IMQ=;
        b=LI+brK/2ZriXePWg1wJgR9BgbK0Fp8YOt16iInAWYS1Wll5i6AEisuO37qHF5E2v0W
         jR0jDI01hJNbd5A6TTFAXZmhJLfLkgCh/Jccx7G9GKlnTLe6p1P8oRtUIgO6E0legCQL
         fR0iHMON9btuCEnu08aAwo4kLpcE64ng3cOfuurD3s9Db78dLAFIlTOPoQNfUXBv0xP6
         MRaGqRgwAtdf/FPk2Q4VQDJeKHk+ZUxK6v2UJfFXGByNhVzeY+Vw/szWfbUHdzfu4v5T
         Tntbp96Ljip0178ggBJwRR3qR06nJkhhBUO+FSvUCU/MGEoh6MHmJEiESynr6lWg6tLT
         BVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774894662; x=1775499462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gtow8N65d/BtaUdMdcH6YJ/Rpa4A5Q8aZEpXNaY0IMQ=;
        b=FvQty1b5uTX2/PHGmQNFKgzu08ShCyiQsN3PICrut9RCyCIxZPYB1C6XeVu2XEmy1Y
         xJcU1bLdflvEtBMP3mBCf8jSXVQoFuC+UDCEWm+VOYWZCkSdvaUCv6ntEswmqDjs4o62
         UYPD5eFEB8xrcJinWQWFixWIyleNwCRx+CJojCNFamumbh/Wxjjeh433fU4OEaMbPnrh
         i6RmsvBaSsl717ecw3IwFntECAriYSig53F7NDfw/436wbraDVIZobxVNIdYB8BMZdte
         hnmKFYFZAtN9XfPrNuC29l7F911Y0Sb30aMPERKnU4N/6OhX44el3hxe3dkztT9381L5
         VB5w==
X-Forwarded-Encrypted: i=1; AJvYcCVrb1jZijiju823ZIG3nEHKIgBG2I4rnKM8Hqedg4DGXE8S4opM24M66zGdKauAdRgq5jlKSCyBPko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5GD+gd6gExJCTx6L5/P75pvoae6MtlFtbyJBefy3Y/5IHfj8D
	N5i6/zaKaYi1yVkUsaZBVaBE7b3s6TmF/bJLGoXgJjsC+mLcN6GXgj4e
X-Gm-Gg: ATEYQzwLFadphOI4aXGZQaScAwxBu/XIYqLlIJYSU94AazICf1O4/A6ISkDvWfqjKtO
	Z+uPPMuAj2AxRp2AQUYwAN2X87t8ZjCokvQmVdiMHKXMVh7A1c/6WDh1LduJj+cvDp1uOWxl0G8
	wLbwtyGNcp27F0/JDmr74LEEen0GnwSvR2afhbDU0/1nYoQwlqpu4PwVdwdS4JfQMkkQGzjnkev
	JaFAiDWCbGOrY5AK2InK53ljmSEzsJ25M2G8b1wg72/l233GgH5THzPAheukq1uDKgXixGUBy3a
	RWfsfA+Xq6bwQLLmkIe+HOkHl+M9MK75PAjC7UkQGJA2W3h1lx9IGjluLJwjxmigEMkOn8wUB6L
	DOrUEUHHaGW/fg5iy2sAx/10UIQ5TLNET1XrgvMZNpFKSkrVEwstbaA7q65BM7Sgal12BtlQ66x
	bnS6L5cIgE/7IqImxczGVyM5DCyUDZa42dezhq7SVb
X-Received: by 2002:a05:6a00:1488:b0:82a:805a:7e2 with SMTP id d2e1a72fcca58-82c959d534cmr12982518b3a.9.1774894662502;
        Mon, 30 Mar 2026 11:17:42 -0700 (PDT)
Received: from Mahmudul.. ([2400:c600:545e:6508:42eb:3d78:89be:591b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85d4d90sm10099966b3a.36.2026.03.30.11.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 11:17:42 -0700 (PDT)
From: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Subject: [PATCH v3 1/4] staging: iio: adc: ad7816: redefine mode constants to start from 0
Date: Tue, 31 Mar 2026 00:17:07 +0600
Message-Id: <20260330181710.23258-2-mdmahmudulhasan1511@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330181710.23258-1-mdmahmudulhasan1511@gmail.com>
References: <20260330181710.23258-1-mdmahmudulhasan1511@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Redefine AD7816_FULL and AD7816_PD constants to start from 0 instead
of 1. This change is necessary to use these constants as direct
indices for the mode string array and to align with standard
indexing in modern sysfs helpers.

Signed-off-by: Md. Mahmudul Hasan Mabud <mdmahmudulhasan1511@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 172acf135..5acfceb90 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -22,8 +22,8 @@
 /*
  * AD7816 config masks
  */
-#define AD7816_FULL			0x1
-#define AD7816_PD			0x2
+#define AD7816_FULL			0
+#define AD7816_PD			1
 #define AD7816_CS_MASK			0x7
 #define AD7816_CS_MAX			0x4
 
-- 
2.34.1

