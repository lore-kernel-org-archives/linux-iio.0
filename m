Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9C23BED3F
	for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941925; cv=none; b=uYcKb42Emsej7/V8t5wwlFx48RXacNRhfIIjlJ0lZm4zBS9QjNHCOPNvAXnJJlPgj6FIVm5l7+5FfcKf9Xy+IZBddNur7tSSv0UM6AUHTxYuovX0ZLnxfGaePi7LiPoqkDKSoYxHXeOLSyv0sQDmuMtFg3DQ2NEchNuGQk0jWME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941925; c=relaxed/simple;
	bh=7eZ/V2eaMySxWxCo4cGkZvPIdKQnHRuBxfyly5k7J8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Suo4q1m8iWSmj1w13LgrEHI7JU57x/olgUaZteM5G3aX4HnSUcSTL0Mf1Ok8BsT14qJRXAgmxiyf4lnDzYWDNO0UfeZ5+J2LTwT0F9hCYYzMssPLUr0LL+L57o9rn+NboSfhBW+elZpt4s0sCAm/nJOp4EbsRGOAEW5qExoJCcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHZa81Tw; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHZa81Tw"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so52336895ad.2
        for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 00:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774941923; x=1775546723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsyQeIKYq/U0F7fCPtRCvH+bKBGjWc1PKEHcjMfaaik=;
        b=mHZa81Tw94RIgZyjZmnVwfaEGbXyzjQXnUbLQPRkmwI0NGpHbNtC05+h7PVKZ200MU
         KG7UN/Hu2wDO+xFCb2FUt7Edzh9xZGwDnVXpKwfUcGyXNhKDgBZDjLSx1fdinY7A5ngb
         PF4WvjbjoWrdgU7NkpkT7wVmY9mrfNmZ79TOQcDMc1LKyVIWBgCIMYw9oZQmjVWRoN36
         e3HH5UiXEpXrNdqCvmjzqVL2fcMDIN0MoFhe+eXwSeAUInXlJOogZp7IUAcLcP2EfQcY
         8jj3foW1a5r6GinpuHsZXUFqN6QKm5ARLEQkXU7CRZstRMsQ6ZeFIeWamOXLSXySBLXj
         xhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774941923; x=1775546723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fsyQeIKYq/U0F7fCPtRCvH+bKBGjWc1PKEHcjMfaaik=;
        b=fsH2QKS6sv/FdKZfC7q678zUJ559U9zpO/A5hGggoyRhj2y/+drK1KTezyaDMYWv1v
         68kBIG9DSXauQjU+p6pbepreaEPjAg0no5I1VIXgfR1Lq9pw6KUKtpTm/x5Scb7geu9Z
         c+68axpIu2zVL3ISuW8x4UmGQvLuCRrybG9pAD9cUzs9So1RqaAWQzOEnnXo2GciyBTd
         b4l+ovLZVbaH01CYbcrI/DNXAbEE/NxysUo+6hhpu3IaF/F80vXT608xF2ylyJTwSCzy
         cMuUrhy7L6gzYYpSJnc8QyMnCsAHxAhqxs5FFXhPyWDXEZR4c8Ey/pMZXopIO3cFZtw6
         eBZg==
X-Forwarded-Encrypted: i=1; AJvYcCWH5cif0Pzq7vafR72UfCn3Duw5RFsk33li0QEB3FF90RXyDVrTxJiROt5dVFOB8+Srqgh3VuScD4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRkb+CMQjAPIiqbTwkkJpaJOoFYjI1uDdq6U7Llpn9DI27KHX9
	EyIdaSYReqPcPRNlzj6/3o+vNiZ3C9Y0luEvkPifzY2hQ8BEGVRj/9o6
X-Gm-Gg: ATEYQzyvfBnPa3+oydZF/rif498dLReIFiDjN54rUBS0qlqkukTJBeSsecTxuiSJWCo
	kedr63vzGeO96x0dO+HKQM15NkNCoKiwcEzSphl2AVj3Otcu8JYmW3spGWBuULdcNnhvfMYOTl9
	JWnDye6Oq7bMzhrcbKTJa7zYQ8RcEWLmdxm3hHy9Hd+ZGbYMgN0fMAmtlUTfh99KTtUZna86KX4
	bed0FdKkJ58fCLgxQ+ep47Eh71hRwWfwDClKFlAWe7iWwUfO0I4lFDrzohix3n9xbiBautGGDZ7
	RBnPwazxglVfVpjG41nkj3w6OsSGJNPDEmYrKBrgBTw8vXi6/MVXbGuj069UvuhwMUT50S6zhTl
	4UuEGJOIRYgXcKpBz0t2IEw1AkeSATiBSHURm/pbtKM91Je1YJp0K0cJyRRlHRMzEgaXHe8tjtS
	ZId8TEZZsonYbozR2vKYmlNwWSwH+rE5doOZPPHFs=
X-Received: by 2002:a17:902:ea0f:b0:2ae:55eb:f82d with SMTP id d9443c01a7336-2b0cdc1fa6cmr162368355ad.1.1774941923274;
        Tue, 31 Mar 2026 00:25:23 -0700 (PDT)
Received: from Mahmudul.. ([2400:c600:5412:6527:d590:8704:ff8:2ffd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242642956sm109272495ad.6.2026.03.31.00.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 00:25:22 -0700 (PDT)
From: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Subject: [PATCH v4 1/4] staging: iio: adc: ad7816: redefine mode constants to start from 0
Date: Tue, 31 Mar 2026 13:24:50 +0600
Message-Id: <20260331072453.6530-2-mdmahmudulhasan1511@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331072453.6530-1-mdmahmudulhasan1511@gmail.com>
References: <20260331072453.6530-1-mdmahmudulhasan1511@gmail.com>
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
 drivers/staging/iio/adc/ad7816.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 172acf135..9a2f60b97 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -22,8 +22,9 @@
 /*
  * AD7816 config masks
  */
-#define AD7816_FULL			0x1
-#define AD7816_PD			0x2
+#define AD7816_FULL			0
+#define AD7816_PD			1
+
 #define AD7816_CS_MASK			0x7
 #define AD7816_CS_MAX			0x4
 
-- 
2.34.1

