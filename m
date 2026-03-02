Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80CC383C78
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 05:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772430698; cv=none; b=FR4f1rMckSmlbfe7hggn1gUKVEoRqN3y004/I0P1dVgooh6Gut9r6PNIvB5g9FpPqdLguFQP8ioCxF1ayAgS6oqm1GhvC1X+f4sVEEcWW9PiHyJ+BW5/+zp04uDF2AmrOjlQBgNWXUZWN2rKFOE3ux02vKDC9nNpO1ayZbW9LSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772430698; c=relaxed/simple;
	bh=NfdMZtRmDWG84xsB1oCF301jY03yoPtQEd/Cb0Lk/RI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hFpKRT6xZbdpDQ8RfHeAlld6NeUHbQ8QfJe4xWv56EykB0DxikF43BKGzoIZvOm4XobZ7OImuU368NtsJuc+l8z9R8tU/79KQ9XPGuiv9Lh8wE6HBje4fcHR/3rOEDu+sE4UG0usgpBuZbIu0li4kMfRptfQ0XhEiNCSFMRfdSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdQm5s1C; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdQm5s1C"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806b88d8c9so5170655e9.2
        for <linux-iio@vger.kernel.org>; Sun, 01 Mar 2026 21:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772430682; x=1773035482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/j8A5zdvwObBnxNewRQ297ifIM+qPSnr+wEJhcglHSM=;
        b=AdQm5s1CzLdnu7pLsugUrtNYWz6dj6NTZ9NUGbbseGtk47ia1sOX3Lkht1WChN/kCz
         47lJE7Jmg1Ja9GW0d/IDd1yR+Wnt1ogQC77skV4HNBK94068c2xKOcjie6CZAZrMhsEG
         raf8tqvsLKZalDkG7gHYv4X9qxWjq/BaEhEBQTeu/IjeJwn8oub6MIF+PqMC2gohrPZX
         5UQSjl1IgFjelm1MTSx/6oDZNuNtxfBEPyS+IpZn8iMzLzU7AP15+gCmSxXYYOfxXqYz
         HQ/d4wMeIGOgfcNlV1TUiGdNFcAwLtUzKf8StUGrBhhr0xczSYvKlGEUAN5yzubTQUt8
         yanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772430682; x=1773035482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/j8A5zdvwObBnxNewRQ297ifIM+qPSnr+wEJhcglHSM=;
        b=CYOb4XGKXFGeDPC7NWAb2UcXfF1QgQoCr+AJw6XmkZGiW3x+XQL6U46atQF5znO4CR
         9G9CyL06XUS22CzRRkGIpKd4CfWqL042krTmHg/fOY+dTSanq6dmQZ+1QhFWmPyh6SI/
         4mXfkG9gd1NAZlgBBkbkYXlc6tLS/5acEGJeEAJ9OSsrZuymfMOZ69vAJoIc0l/PfuGr
         T4C4JDRDyIIDT8qoM9WsFb8QHBKcF+JWHkXLufboZuAcddppq04ETj8neobh7O3fnrMB
         cMLZiQEYD9Icua42D0+ugHXP0+Q65nX7OMwTWV1qkD72xQNr/PdEJaRyEt4DvEG9PWtH
         io7g==
X-Forwarded-Encrypted: i=1; AJvYcCVSqM1zlZLo66OrUpc5d/L+nIv+wmIeN9BTR/lfOR0OfKLPzPiBEP3yTNVIvxLcACrbY8LPOuhoG2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YylPmV5CqrtgYzaGViu0X6hMd/3J2iNoEYqYaZswgpU0kzwkM6X
	7lgjcKkrJqSgj3X4l+Th7AB9kbD+fInJhRSz6DU2opdy0WB6DDqEcBgM
X-Gm-Gg: ATEYQzxO0lTlqtffE3lkfZ9mBGKJlyZnKNpIX0/aoY1skOmRQJDmDCI07XKw7jQZtFI
	B13MzRzgT87Rp7srFgearpASWWWBcSx4UhKhuOVMs/sH0rgnCeNNb2Op+0+lgn573fOB+/aJMmV
	cksyNs61i0Ox3tV6AarWUPDvjBbBZxEKpHzDxyHiKiO9SG3zm3JQsSb8QRxgEn6fMkdB/x6Ad3s
	6r1h0G1mzKh+PUmnJbyiu7UrqDDns0Fr480lJoatZ4W1bKWeMUvBHgmPt6Y90EGUR77JGa1fE0v
	rSz+eYe1NbiO6Md1oMl+kT0QT7szBw1K4QYPx9IFvGPAqjNOUvAkRB02PaEmpxtDAF0cvhmAo9n
	bStwVIEc/bHhQIPsBoBdHlGvPxa82fL/9vtw/SLBF8hLA/mdnUH/JUZhOnVgdKY2M4YmuTkwh59
	h0gsVwGlwu1nGHLLRRq3/ubWiz3s3BDm+TQwveL+K/Sh077l077TJQdNoLgWlxzHy5MyUFkkMF8
	qSVdfJ7iqVIwg3YhklFCjy4ANR2C+opyObEFI+yPhAVcwmuB/xa
X-Received: by 2002:a05:600c:5249:b0:477:a478:3f94 with SMTP id 5b1f17b1804b1-483c9c29b66mr115775765e9.5.1772430681870;
        Sun, 01 Mar 2026 21:51:21 -0800 (PST)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfabb84esm375746375e9.0.2026.03.01.21.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 21:51:20 -0800 (PST)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH v2] iio: adc: ade9000: remove unused ADE9000_ST_ERROR macro
Date: Mon,  2 Mar 2026 09:50:36 +0400
Message-ID: <20260302055035.36363-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADE9000_ST_ERROR macro references ADE9000_ST1_ERROR0
through ADE9000_ST1_ERROR3, but the actual defined symbols
use the BIT suffix. Since this macro is currently unused
in the driver, remove it entirely rather than fixing the names.
It can be reintroduced in a future patch when it is actually needed.

The individual error bit definitions (bits 28-31 of the STATUS1
register at 0x403) are retained as they follow the convention of
defining all register fields.

Reference: ADE9000 datasheet (Rev. B, Page 61), STATUS1 register
(0x403), bits 28-31 define ERROR0 through ERROR3 status flags.

Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
v2:
 - Drop the unused macro entirely instead of fixing the references,
   as suggested by Andy Shevchenko and Jonathan Cameron.
 - Add datasheet reference to commit message.

 drivers/iio/adc/ade9000.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index 5dcc26a08970..7b0b1cbc880c 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -218,9 +218,6 @@
 #define ADE9000_ST1_ERROR1_BIT		BIT(29)
 #define ADE9000_ST1_ERROR2_BIT		BIT(30)
 #define ADE9000_ST1_ERROR3_BIT		BIT(31)
-#define ADE9000_ST_ERROR \
-	(ADE9000_ST1_ERROR0 | ADE9000_ST1_ERROR1 | \
-	 ADE9000_ST1_ERROR2 | ADE9000_ST1_ERROR3)
 #define ADE9000_ST1_CROSSING_FIRST	6
 #define ADE9000_ST1_CROSSING_DEPTH	25
 
-- 
2.52.0

