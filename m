Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4787145A1F
	for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788020779; cv=none; b=uLhBs4A9aslTu3qdIzCixp9QdzhIvNAOwBnC3zH2nR7+fWkumnPD11EfZSAE6/n/ERYUfjrgp0i3ciCYnU11364IXTj0c5hITPBQdMmKoGWjzemY9o+L3weCY7640gCYWChV+FNlur2ja+qFhMKnMn1G7YcZGouSQanBtTnyb+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788020779; c=relaxed/simple;
	bh=S0psc0GokPMG3r5dgQR0E3KceBkww71p70Ddzytet2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DyKitZb8HPYS7vzhDIU/0k2Jd1XXHgeQm2vQIFH7WdTD9bxIB3XqZXuoNbpjwbivr1oF/RHfye3jxXhcwmz4N5NIu3j6aksfFcTJCAqn1Fusl0I0l3ESU1MIDe3pPrFqKHOwCS/Qa54RiUm79LQru2tEdDcrGOZRd/Ltslu6ctE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPP6qe1O; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPP6qe1O"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso18077385e9.1
        for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 09:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788020770; x=1788625570; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BZLzJmQwMgWXL3sbjVA8gM6zLJbXj/mUC/hE8T4vkRg=;
        b=RPP6qe1OAYKTpcZB5weZFbheSLvek7xhDnM8N41s9xLKgdZo18CUUXxiIoLHVAbi+8
         5xlT6C/zz5suI8xwcOjZ0uRHf8oCRfvLUzq4t1tIRh9y/7cIAGBEDXnZJft15zom10VP
         wwCxjYQOCwnPe/MoTID4hzdvF26Pzl5XZbKpsSU6XxLi/GXGUiDxggbE9IMBs5V+Khw1
         /HiQggtIZNr54H9xZT5BEhsLzpwVLM09ewVmYQcSakk6SmDzfKLYg+64Eb9B8XmLyNVW
         skFY1zktYtrxpROgbrcllXRm5+4x2rv0yJa+/BbwtyASpKLuG2lyqbxWsOWgnuPTPH3E
         Vz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788020770; x=1788625570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BZLzJmQwMgWXL3sbjVA8gM6zLJbXj/mUC/hE8T4vkRg=;
        b=hpAcxkw+IF/mo3ygNJOf1oNvWHt6rED4jD+D4Uw9VGB4a3L4YLC6cvgx0aekbmZrvc
         w1HjBO/TB/mYP1PY/1fciskjpw668TRYxopB+KBAi7zQ3BXEviBnJEfztu6Kh9PxMxhp
         eOIMg3uTzBXasWK+enKKebsxXCPZkLG/Qj8IDQUUrI51k42PcE+X+9upmW9R4PodrUH/
         Ukl3ErC+D2CfNwdsf4073a4igjfdymOBIMIfW7fLAArJ/08cGuWnFxhmev2IO2rArh7K
         1QXQCANWaOulJQzbvab+v3twI3fWzZlEZnNZBmvb08bByEwuOfAZiRePKuiZfSX3iZSa
         /Pmw==
X-Gm-Message-State: AFuF++mJ29vKlPCFZoB3WLoevZhSloWbm71b7+KgZbQ9ZX5Y/ITwOCTp
	gGpcjx8UzFsrON9uXLq7wG9He/BQmTZSRvBbbJbCgZ0r/jqf5hXmeUF3
X-Gm-Gg: AR+sD12sTF0cyLy7zehCJIkzMya3uT5G3H11XpN0DNkYz+2idgF0Sfcz+3JIS9KrFyR
	WSdYvKe6ww6w5RSwn6Rfg2bPCvrahSDEvuPY+etowz3gLteRRjaJB6BEYdYZwsidLBeF8F9Lpmm
	3Sg3zr7c1vCCAcsHBq/VA0aP7cKR4YWYMmLscPMyZPmIdRF2pCJFNwjWlpE9is8OP7J/HRY74rm
	cCYT9R7eZ4x8XP30JUF3RO0kD6fJ04+4GWEaHNV+xmqpS7sZaU0NrPT+c0/7Sl1MBjmlpqdaTsM
	qV/4o6R4ePKEb1CGu1ooKaHmCkOi1miszPfyEfdmEpZsTTdtBQuzAQJlTFpJO+1QLHNmTEZOwws
	HXZtBoVVO7smNDwrBkF230ZQ5aPyqZEzxxnS4HEiDirLr865YbZ2ZBJPBAqY1E4N7wA0VdGFx28
	tkkJXlWq6SbAFc7Mv0J6HNTP2iJlN4/5lyfxRf6/TbcoAObxJ788BLVGjlIrn2EeHAqMqm/OXXb
	lLv7pGXb17SzBvqZG0vjqi+3GJR8h4x1zdals1DT6F2dmXyrGBmd8YhAzoGJ4TqjrF9LBl9ank/
	20zsuSR3q6yMf2MIt6VXAOex2HdQmNSPoUk+2dWJQcbyGjI/MxTEPACam0vuazJOuKPlkif5JL7
	jEmXk9JzaqpJzOaYVL9rQbMhp
X-Received: by 2002:a05:600c:5490:b0:49c:cf18:494e with SMTP id 5b1f17b1804b1-49ccf18498emr47674955e9.12.1788020769528;
        Sat, 29 Aug 2026 09:26:09 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b92679be5sm137861705e9.3.2026.08.29.09.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 09:26:09 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 29 Aug 2026 18:26:03 +0200
Subject: [PATCH v2 06/11] iio: temperature: tmp117: sort headers
 alphabetically
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-kernel-header-removal-v2-6-c67739d5dedf@gmail.com>
References: <20260829-kernel-header-removal-v2-0-c67739d5dedf@gmail.com>
In-Reply-To: <20260829-kernel-header-removal-v2-0-c67739d5dedf@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788020764; l=928;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=S0psc0GokPMG3r5dgQR0E3KceBkww71p70Ddzytet2M=;
 b=ZYFfLtT6Syy/NUpaPutKPHlmtUMOJHqwuvm8i76shdwXaebkICsXD8FyumA0Dkr9zgJ1tIBbw
 WXNjhMkosLdDxUHs7kJDav7cvHJaVwy8XKujToCQr8Ud0sWnaQqnf0f
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Sort the headers alphabetically to improve readability.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/temperature/tmp117.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
index 74cb8d62bef3..fed8af2d81eb 100644
--- a/drivers/iio/temperature/tmp117.c
+++ b/drivers/iio/temperature/tmp117.c
@@ -10,16 +10,16 @@
  */
 
 #include <linux/array_size.h>
+#include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
-#include <linux/module.h>
-#include <linux/bitops.h>
-#include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/limits.h>
+#include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 

-- 
2.55.0

