Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCFF38D6B8
	for <linux-iio@vger.kernel.org>; Thu,  2 Jul 2026 19:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783019883; cv=none; b=ab8F6ZdHTFX+C+n68NKkBvW85qUlGVW8AZ2zt2P957VaSU4S49bJRQj2sXsMfjyBDiuelXkai9XfOkOlXE7LkGDZ3KRP16602rUOJq2sroUWWwB6jvLKX0nw8ba41fqTEnHDfsmReyEKuBfKHI4qbPWWxQgTZbpmKiZDgjQ2DyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783019883; c=relaxed/simple;
	bh=7Jhp+zM1tfpkkN+RoLtUSVk6nZ1f2/5eMW//z+sr/K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uf+igkEigu1jHhTSVudt1mmB41MWM0tEULz3TwBTgHsFlJBLmUB9Yp9rBuLXbqjjjfw2q/eedzIUdkXVytv0ZplBAB/KQHmTH9LcoDjYkqOBnnN7RSOsVF8OEBkuQOmpgkhK+b6iggTLbMNo5wTWSfPKIR3yKaqObb+IVygK8vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQ7r1Bgs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQ7r1Bgs"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493ae59eca6so15323365e9.1
        for <linux-iio@vger.kernel.org>; Thu, 02 Jul 2026 12:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783019879; x=1783624679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+D5vTuc3ry7GSi1xLxssIPLXndzO6UHth0lr4ZSJjLc=;
        b=mQ7r1Bgsa5vC4VCzEkZciFij/548g79qdayqonw19z4GWW2x2pCjymIkYBRSiqM0fi
         j3p1TG8XKY3pZseRS11SClUhBuL03sJfuwMP3toMdnOlD/V+I3JjqgJ59Q2bRBw5Jn3D
         0RuTG+kRXpfCzpzlrb7vVHffDPwg2kvzanQ0qzt41y2gSK79bExdmMrRWJj10+nf8Z7G
         ZY3m0zQRomhy7hMyKEHQH1jyA49GWu49LdFAWeL5vZON8sfr6dNY6GaTI8E9ALwq6iLr
         2QT/w9rSetkME4HmS/JHneDqjcBig32BgTmDdaAh+0UVZDSE+G5d92A2w16hgkFH9WPW
         5XcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783019879; x=1783624679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+D5vTuc3ry7GSi1xLxssIPLXndzO6UHth0lr4ZSJjLc=;
        b=k/RnFGkMGk3U+dseHpGatgGh0XTYTtL3Sot9eNj9HX/hXxd3kdNx5VwYm/61NGkWWW
         IcVCbyhUXtQeSrDzhgeh9cTJwWR0h2SjxhVcBBa/wdiI3j1roHJcdqfpjg6ABhZtnKoI
         xRAqpTsvHRcbGPclwCOrn8ae4g/dFjoBP62vtNLSOEqllcZQHYuol66QV7xqE4NXx6LV
         pvzJZoufQByDBsIg7mucYxTwSvI2kNOokovd/u84mUcplhdLDxdTy3YColCHywmtBF2C
         jF2TSLmST4H6XpYgbEPJbEbhUQ7BlKwDJki99CHexchuJBMnj6xQFGXXvLk/VxcrUAL+
         unfQ==
X-Gm-Message-State: AOJu0YxQLkZgtp3f2TEA26WZEbOlzBIGVNTPXKFiKiYqsNIn5LrKu9m1
	HclBr2VCLhi7YRbGXYLHDqlUu3rMLyV+hNE6UxK6fxewl5mk9QcbTSSV
X-Gm-Gg: AfdE7cl9pfmpGxx1Pp8Z5cBsB3zEtZWfTpB0SOO+zjwpDapefybEh2n7baUJbDxZOi0
	lkJZydv9xEHpU1r4h9AjI3VcsP6kvxMQ1IdeqwyTX57xpqjORZa+atczgfRI1i3yeIinsENub8Y
	aysHZ078t+phPR3dctjYW4uKtQVjFWEdYIBK6WezEMlIR0Abmh2cBNrfsoh9vRRmhnLnPLzzfCd
	++HYaK+9w42UeI0kSNs0I2cQC9afYXczVC7f5qCqIQ/NTjylHelN1aYz6q9HGt0l03b3fthhcAW
	IXGGLuU7/2tqma6exllsmmr8uwhkWQuPoUcxrTf1Igo3FDTg1FPlzyzuoihNfAvikkeMON/x1XZ
	s0RYu7p64isaBsJvPSj9rBLvmJd4HTmhUUaUQLKT1KRVZiEUZFRymqV06m6nPPoacfKgES6i4xi
	rvTblPDxMi6ulMEvXrWp3rFKO6M8atoBuwowysaF4xpHsW8woNtFq5ozXDzF6ASODYArUou+lAj
	+DSjg==
X-Received: by 2002:a05:600c:524a:b0:493:af0d:484c with SMTP id 5b1f17b1804b1-493c3df2fb5mr94081325e9.34.1783019878564;
        Thu, 02 Jul 2026 12:17:58 -0700 (PDT)
Received: from arch.lan ([91.230.98.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c6368f89sm64678805e9.8.2026.07.02.12.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 12:17:53 -0700 (PDT)
From: Tomasz Duszynski <tduszyns@gmail.com>
To: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	m32285159@gmail.com,
	nuno.sa@analog.com,
	tduszyns@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] dt-bindings: iio: scd30: update maintainers field
Date: Thu,  2 Jul 2026 21:17:44 +0200
Message-ID: <20260702191744.118898-5-tduszyns@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702191744.118898-1-tduszyns@gmail.com>
References: <20260702191744.118898-1-tduszyns@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I was dropped as maintainer because emails to my previous address
were bouncing. I have not stepped down from maintainership, so
re-add me with my current email address.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 .../devicetree/bindings/iio/chemical/sensirion,scd30.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
index a5b0debe85b1..25291bda1a8b 100644
--- a/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
+++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
@@ -8,6 +8,7 @@ title: Sensirion SCD30 carbon dioxide sensor
 
 maintainers:
   - Maxwell Doose <m32285159@gmail.com>
+  - Tomasz Duszynski <tduszyns@gmail.com>
 
 description: |
   Air quality sensor capable of measuring co2 concentration, temperature
-- 
2.55.0

