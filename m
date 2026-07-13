Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72468383338
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 22:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783980069; cv=none; b=gxwyCFEPd2rXPxo3pZmkxbbT4SurzZu14GEQPJX4eUxKpKiJgfVyIr4rrVQ38ZO3MyA9AwsKZewMYAf/a+nwEBjmz2Aly8rgrudl6y0DwNHBbmRRDEqTaFqoPs8QLP0oOMdpUyCcWGLKnJygqGEbRXSMFOx5MGNuqhS9IsS4byE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783980069; c=relaxed/simple;
	bh=A88hQpU4gvevyn/wMC8LlE1D/v2qPQHhtPxMc3pde1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWb0uggfvaQ82Zwn/raxN0MzIpbxTWQRrklK+u6ZQkgX00ADiGR6Gtvb6O1Lw1wMka5ZJ40Ojm0VNxoMjyJXrLk9vj+iYC/+YOlVZ5fH4kUGRFCRu1QL977dXfpSaL9nOdUoJdFT47Ff+u7a/g5BzKFTFZ0LQE+xbsKGZKL9cts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrwoFjLA; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrwoFjLA"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e9ef94c0e2so172076a34.3
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 15:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783980067; x=1784584867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U3MCSu0Vj44YX15WVLsrx07UD0x7rviAz6FLqVYGZxQ=;
        b=JrwoFjLAZYbIxGGuNqw2DaYhQpkH720ITFTfJOR1vnHDz77HdCh5CJ6fecbd7T8Ke2
         +X7ER9hc2kpTzU9FP4FGQgN+q9a6MlSNpbcB0thIYFCbHANtzz0/sM+WMNOX5bwr45Tb
         1BhEpp8zAYiHI2i6wPQhQG/WkjgM/fil6AOx3d/Ju0tJPV4IqmcOoMWzCRxZop+W7d0K
         QT9soB0us4K8xEU351NRbZSM1QF51aCpZnPTw87tO3Mp3Y2W9N7NCtSoy3eN+bDp3Ibd
         U7NZsHaMw/hWp+44ilV4wuQOeIirrluIViZlMf0N4DcJhHRFGLoa2hkmAl4XkWWsO4yf
         wZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783980067; x=1784584867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U3MCSu0Vj44YX15WVLsrx07UD0x7rviAz6FLqVYGZxQ=;
        b=Tbkiz0m7VeAUHeaW9nO3Apw+HZFykthlFRhZ59DbtPHZzJE+OdsvNu/SBNo4CKEpaP
         3UI5V4PvRjJoBV+QKFwj1U5IvyY6NQqM2N+2J/VbB7O2WRk4qWMYty1Oa3kqA7vxIGeT
         3EgmF5NrLf7f6x9l3xEZHHa29Y3HgUd4vRcZ7+qZ2mjWymx3glVogG4gO5cqc3hNKq4U
         PijwUHLSQ0J+00/ZLcFFdcNGrm51lO4QpnNxIJB3XvRKGCpx+e5CCQLhOES7MaCKnZHU
         TuDdWxa+8EPxA94XirMTYJV7Zk0mdPkUHt8uESy9sIAfpDvaPCKFLwLDrmRIilCG9ihP
         5x6A==
X-Gm-Message-State: AOJu0Yy/JV0rDKY+bG67+7hoTB7RjZxnpiJ4t2UaDZlfCgr+1W3aZFiw
	9zTFQGPR+sjJJpqGNg7arWjNJFbtO0C4sppqf3z7AsaCjTASvM3yIClfrPbuuQ==
X-Gm-Gg: AfdE7cncuMj6L7oVwNN03ctoIYXlBV/t1+JH+YrnYDJZlQwpXT5mr+/GAOnN8H4vY0R
	zx5yBJ1q2+7NhG6euaSFblSci2L375FT34wJLLNcAaMEtKZFXKntK+9GY+EwFo90ESCurWFANGq
	SvHeUDSgBpkt6227UZr27P9M6Rsx0DVNg2QR52YgPPS1LoXO0ppKezPYEJBhtmpIwWaw2tGAAR/
	jXQO16Pq6exmpG+GKFXINlpBv+VOD5Yy2V7uG4QaZd9gnI3O11CFfCHB2PE324sKQyF4vMlIPNC
	EQCYy7i6wa3Ld5O08ityK2+WmfNxQOC4We+xh4203SwGTExCNhPQjW+VpS6xPC87Ug4mUjSYL9c
	I26jJwOQkROg6CI68D1mqY7CJC51SF37UUnamzZmPIynUZrXsoTZL4SAMbZo2bF1S9kgNchk0s+
	Fj+C6nxh3vlVZuHVXB1HAANg==
X-Received: by 2002:a05:6808:2507:b0:496:dfe1:e8ce with SMTP id 5614622812f47-4a42af91aeemr7105476b6e.22.1783980066993;
        Mon, 13 Jul 2026 15:01:06 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1acc82f3csm12939785b6e.3.2026.07.13.15.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:01:06 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v16 02/10] dt-bindings: iio: imu: icm42600: Remove interrupts from required
Date: Mon, 13 Jul 2026 16:58:32 -0500
Message-ID: <20260713215842.69097-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713215842.69097-1-macroalpha82@gmail.com>
References: <20260713215842.69097-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Interrupts are almost never required for IIO devices per upstream
maintainers. Remove interrupt as a required parameter for the
devicetree binding.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml         | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 9b2af104f186..f6f97ea03038 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -67,7 +67,6 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
-- 
2.43.0

