Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2161B389472
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772094351; cv=none; b=dnyBThnpt9T9wlqyibs/KiwpnCbIaxsEu0u4j/yYtfKfJK7rOQqBIhpEk3ahPg2tTQAs41S0ukQeSnVqcWS4il0NGzpQAP26PCJUpVK7YDUzU4HRjnnrf0RTWh2i3VaZs/CkbKFqIPJGXx6l2aMZ7u9rD1QfsUc9XKY8tfn99EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772094351; c=relaxed/simple;
	bh=TxG0f9exKqQbKSk0xa8lU/Cx6XtKZupuLU8VGhgW4v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qubMpv2wzJCMV5rYl5PUNn01ChNTT1f6lrEfbzuyvC9UcxfJKtwheiNWJ4AUXuytjpPbo6PhCLeyncXrFG6bjWmXk3DhOqf+Y6brpKReXAW2ckGky+BgHEXf8vR2RuVyKh6UcIwzBDVL7OVq4gV2EyXmsYCJZpsLOo/sUyEyHsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AliUklpu; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AliUklpu"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43989bd056bso458581f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 00:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772094348; x=1772699148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2DXQgUmURVJwaYW2hiIMRPzTKSONvVLRn6L1AJLhT4=;
        b=AliUklpuYsENPancw0nVy4vDWnYA+EnVyj6+yUzyrJBEtLp11Gi6tIxHgd+Oa2cNCK
         24gStdKA5aV7/FJG/syJeL4p5soOWehecdNtRGFzZ0vzkxgW33GHSNjhPKsOmW9IKZHg
         MRAffrkhEDaCApleGKQ7AiXhxFdKtNdm694N1k2ClHlGH81Q9z5Rjeg52MaIVaEMP3XR
         pBK8ISXusTxLFP+PtnGErrmQHL/Y7zAQankeiQV4auiDeTCZUFv9vptkhivarDljyWPq
         VCOoiU9XryeTFY9ck0Hz8fwf3DQ2ULlBowEtfRJXqKZ/uXjZ+qffK1t6XKuaJeIaTIoQ
         DWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772094348; x=1772699148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t2DXQgUmURVJwaYW2hiIMRPzTKSONvVLRn6L1AJLhT4=;
        b=pDot5eK7ADluyq0Azqu7NLNkejsQOh23UsITtP7dImMoumMDrTqDmf9N/GGcDOZE6b
         rffmk//4aIhT60Bf0p2hCbqwiS2pb6AbxwXxfJk2q1kGtzS58BVzTTeHjxMlVMzX6Mt/
         DuwayT6/5fUIX5IP9L+wADD9FJOp3BdyO0FHKvMxic+1JAutqS+ppV69fONSTYafO0y6
         13vcyMwgw2k/Rgii6ZlsHNYVgtiaqt6ksibALn27guBP7w+HfM/ItgHT8+DfX7Oyh5c/
         768bkY4ttTrC4+01uNRkvTJBxe7EBOPOp9dcVIKisIY0b3Z1TmZFjo8VRM6KqbD6YgVt
         aahA==
X-Forwarded-Encrypted: i=1; AJvYcCVZO3kT733OKokuPx5jfj+UkJ00rFtmL2l28Vosq5FkLa81EN9OKP0OG0TCzz4mzN0vbgbGeIQ7Rjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoXsRhpoe7ooT8uQ/jVUec0qp/Rw+jF8FtJVFI+O45QWOGXr5F
	QeThztY6R9ybx4PcKDnDzYzzYcnBKpBlHomb3mPbvBrjJ9tgGIp2vbBt
X-Gm-Gg: ATEYQzx/VWEMp23f97XytYRkGkBUH3FWx4n9tlQ7E8CjlAuvXVLhdgk+PijObMNWaFo
	rPqRUuAXR0MQKuLGp8ZvGWZVXNxkvG6CEZWfU54GR7qyajI8D9bIzjkwzcyKut5HboOe8mb0Vpc
	dj13kzE1ONEclLgsgkLP7YRHf61KfNJGck9cUA0O+EIVJ5l/BMS7FxBVu2vdke7YzmDM1efGLzW
	nqAvq0TlxRsydXLQYHXPjG3ozORBEYrRBxSynXz+8WFtDHbQqfrKvdXoZ7jpSUk+ZNiPC8pTs6F
	OWnNvGzoI7QhMGCC5ica3w1fc7+f+qvU5mLAu7m3RG2iyTpmUqsMmMqirH9PqKqp6Kwrp9mPJEp
	4LpA+P3doK/ePjflihCqXtQxW85Tw7t1+VOatE1fWtePYn3WsQrprFWiilwm/+TG6Zx2nRwabag
	==
X-Received: by 2002:a05:6000:609:b0:439:8c7f:712c with SMTP id ffacd0b85a97d-439971aead8mr3568173f8f.8.1772094348355;
        Thu, 26 Feb 2026 00:25:48 -0800 (PST)
Received: from kimsufi.. ([2001:41d0:303:6f54::1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c09897sm40683939f8f.17.2026.02.26.00.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 00:25:48 -0800 (PST)
From: Ruslan Valiyev <linuxoid@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ruslan Valiyev <linuxoid@gmail.com>
Subject: [PATCH v2] staging: iio: adc: ad7816: add timeout to busy-wait loop
Date: Thu, 26 Feb 2026 08:25:47 +0000
Message-ID: <20260226082547.69616-1-linuxoid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aZ_9x4q5BZRJi3ue@smile.fi.intel.com>
References: <aZ_9x4q5BZRJi3ue@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ad7816_spi_read() function polls the busy GPIO pin in a tight
loop without any timeout. If the hardware fails to deassert the
busy signal, the kernel hangs indefinitely in an unbounded
busy-wait.

Replace the open-coded while/cpu_relax() loop with
read_poll_timeout_atomic() which polls every 5 us and returns
-ETIMEDOUT after 1 ms. Per the AD7816 datasheet the maximum
conversion time is 27 us (temperature channel), so 1 ms provides
generous margin.

Use the atomic variant to preserve the existing busy-wait semantics
of the original loop.

Also handle the case where gpiod_get_value() returns a negative
error code, which the original loop would treat as busy and keep
spinning on indefinitely.

Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 172acf135..9b4ae3ee2 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/gpio/consumer.h>
 #include <linux/device.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
@@ -85,8 +86,14 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 	}
 
 	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
-		while (gpiod_get_value(chip->busy_pin))
-			cpu_relax();
+		int val;
+
+		ret = read_poll_timeout_atomic(gpiod_get_value, val, val <= 0,
+					5, 1000, false, chip->busy_pin);
+		if (val < 0)
+			return val;
+		if (ret)
+			return ret;
 	}
 
 	gpiod_set_value(chip->rdwr_pin, 0);
-- 
2.43.0

