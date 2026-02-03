Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363083A9DAD
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129615; cv=none; b=nbkP5ZA0+Jj322rJAK/cYJ/Ysf2BffpIgBY5ELoiPCllTZn9yLlk6A2gSWbGN3jqdJSTblNN0xjlOuY+tBHeSTpr1/7cfineY99H3MXrlhsm20/hurlN8mDP7u6j1i2aASlSelP9hqyG1jYnJTc80L7rJfqjTjA1J6xprhaSi/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129615; c=relaxed/simple;
	bh=m/ziyU4HLGC5IQ7uzs5nBrRKBSwg2S1LdvZuY/kbNk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5wRSUvQ/KqbbZzunBjheDc9QK/iXsy7x8CgCeWJFNVdGsFWVfNiO0LSG4EpERPsgYPwkNzB7Y0oQxp3NW4KZAq14/fvK2Y5SgCj6DNzDz5qfoww6/9MGsci9vQWmUKUYqIRuwvMb22dAGXjXmpZAU9VjzDSXQJJ7Bik2XYax8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6dH5K4M; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6dH5K4M"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-823075fed75so679176b3a.1
        for <linux-iio@vger.kernel.org>; Tue, 03 Feb 2026 06:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770129613; x=1770734413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXDwaifGC6j2k9hfNfLuDwLHZpRvyVgqB/72HtEhxLQ=;
        b=F6dH5K4MhImfzQ6+MU3AY4Lv3GcD+38wy6FokgXQYifU8f5lQRxOraF0BDAQ8S4kTL
         I9a1o5o71o7RJf7r9jHTCwaDL/AhnR7em4Et7YwmkGfoRJnYciMNqqmvrtv7CyFniDgO
         sHt72wN5h9g2yv1i1B/gosuB7aPbd+A8jq7SitAdUuU4apMCOeWCrZaJIHsVhIfLwGuV
         SNIhIHoqZbzwlu57GK4fpmDtz64XMoqPHguE6pE3MUEAIQFn49xyoRTZnoVkhoqWHN55
         NUuHJfEwcG/qHriBOviI2oPQ246CD9voQGY7iUIJWnVuEOXEhKtQbqz6RFjB+Od8Vemu
         Dp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770129613; x=1770734413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YXDwaifGC6j2k9hfNfLuDwLHZpRvyVgqB/72HtEhxLQ=;
        b=fCiTrP67a5/KmkBe15E62Z5+8wUkGTNCZI7QO6tLKJX1IIBJU20Ck9QE1TN2BERPD6
         qEFFgojUESzDSbiE0L4vuvwVKmfI++6DLCCGoqq9mpLw7n6cWKxTgi1P6gMKuCtCiQZx
         +MUB5uu7VJ7gvf3IGJ3qbixIeKKbcbIjfuqv9D3VhkEmfUfbE67egDtm+NiiGMCJt2gg
         1yc2dkQhsedFqSNv5sNfes1FrPCBBL52YuxyZj/g2DG/cQklxrIfALLd11R8MDAwmZwA
         /9ZUexUqmHTrSOxo8Y372/spc5JZB5LbblJiJURgwQCMHqfmd8pCh1TbMp785AAx7L9b
         EYaw==
X-Forwarded-Encrypted: i=1; AJvYcCXQXwzYlcd3RhMetvKhLeRFTAgzCzLoCvsSXhUWcyWH6NH0ppKrA0ZsKqfH7DmXKIbfIeuMqkfL1oI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFJTXF5kB69ApiHl1BfByvp1cAxVSogrNoofvuPDHlUsbX9VP7
	OC9CkKjj0kB2y2bj4iujbmkyZQUpqErfLLxqZIZ91vZO5+kqpQixE86y
X-Gm-Gg: AZuq6aJpksrzD979fP7dIiDjBcczHppP6/0hg4IaDC8BY4DP5O/ynzaWCWW+wh/L9Rx
	e6bSpWRUiiXCtTk5WBKtRPn5WidirFvjc6ywbHTDTjlSSAwj86XVXZdrqZ4MyPOG+m3BkJRaHxI
	2wlX3bNZWLhuCDikB/vljTqd+WrELll+dJ5aq0HYGb47DdUFN3atfAQdzyclJ85D8XhbRYLSikz
	NyypUGb8VI7lJlXhzgpy8qCMhWsdS6dlPG4AdljnaR0AiqjY8jd5zX6BO3amHTMeBK84ecaNG8b
	m60ai+UZHuu5MtULOGOOmOTbkNkJiIbtiZNo0KFV64JNoTfDYhyjlRsut/6coFGv1+o3NV0QiF/
	m24mDNs3vZvBfE3k3T4ERbz1FiNvRGV3unpgESIaM7ArWAQDg2gZLo3Igd8lKoY7eCVKGFjJb76
	TmscWx4/YW
X-Received: by 2002:a05:6a00:1307:b0:81e:af19:34ac with SMTP id d2e1a72fcca58-82404325ea7mr2773928b3a.29.1770129613506;
        Tue, 03 Feb 2026 06:40:13 -0800 (PST)
Received: from arch.localdomain ([2409:8a28:a52:d2b1::1004])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1ee89sm19810313b3a.14.2026.02.03.06.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 06:40:13 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: linusw@kernel.org,
	stephan@gerhold.net,
	hns@goldelico.com,
	jic23@kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH v3 3/3] dt-bindings: iio: gyroscope: bosch,bmg160: add bmx055 gyroscope binding
Date: Tue,  3 Feb 2026 22:39:43 +0800
Message-ID: <20260203143946.301233-4-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203143946.301233-1-jerrysteve1101@gmail.com>
References: <20260203143946.301233-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the device-tree binding for the bosch BMX055 IMU (gyroscope part),
which is compatible with bmg160.

Datasheet: https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_datasheet.pdf
Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 .../bindings/iio/gyroscope/bosch,bmg160.yaml         | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
index 3c6fe74af0b8..e19aa1797f14 100644
--- a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
+++ b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
@@ -11,10 +11,14 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - bosch,bmg160
-      - bosch,bmi055_gyro
-      - bosch,bmi088_gyro
+    oneOf:
+      - enum:
+          - bosch,bmg160
+          - bosch,bmi055_gyro
+          - bosch,bmi088_gyro
+      - items:
+          - const: bosch,bmx055_gyro
+          - const: bosch,bmg160
 
   reg:
     maxItems: 1
-- 
2.52.0

