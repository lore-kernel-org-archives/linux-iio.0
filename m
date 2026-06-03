Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBE83F7891
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512561; cv=none; b=Kvy4KXegZVz/REQ7pJ4sbCQPpH6Wjw0V+1Izm5w0EdTkCnYc3MAG4OCwHfd+Ph6T2cHKBfjcSWNLQpBMMQ5ObWNl6c0uV+0l5gK51HAQHwWS1pg1uoigJeWyvoMaEQ3AJ0HRSxWWRO45XwJVxcWF/L5Hk7jOH8QrF3J8Ts3+5Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512561; c=relaxed/simple;
	bh=EcLRSHqnqB5L5pYI7tjNeUMf/1YsZCqijICND5QflsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqjhsuQrTeu0gRpdbJoabqJkOvXhsfO/i64yNwnXniEeSTyaYje7RM6m9E2dkuj/bQjbDYepeRMeQgAgIApx0vqWr7pv7tMfoXaaUJTsGAdqai+T0hCA+G3SVmzuyRTib91twMSkfA8+ZaXRQ3x0VxZt7+HcJcl9eYBfYb5pPZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjYhcOtX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjYhcOtX"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bf36a6905cso34204315ad.3
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 11:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780512559; x=1781117359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JP2oeys3gnF+eZfS4uTCq9ZgL+QAQ6O5vvj9ayK0/ME=;
        b=MjYhcOtXYatsxzcap5Qthf0sq/rvQp7/QRtu94Xx6B4Ahyi1KV84W9Sx5h7UrbubcP
         DQG8P+a3/1ZmlKq2LGdjubCUcS3RJsdvdJKp7rRWxsv+6v3FOi7gCaSLtAlwLNs4eJG6
         /QD1+LkDsS9VKMp1Uw6+nPkcSkl5m1TccQNoLc7ckUdhpYuyKeNz9jxP8c+l3wN1DyVN
         eFjuoFu+BmAC0DO3ogvy5nuvw8cWV7H46A0oX0mwkXIuJ2Wb3NJhfc1MpyNuOMV/wxWH
         k6aUDt+gIbyqdFBiwArfzh9hMyz6EZls9FGzkFcRfNJk2RORblHv0g8uNYjWN7ZFqJx6
         hgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780512559; x=1781117359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JP2oeys3gnF+eZfS4uTCq9ZgL+QAQ6O5vvj9ayK0/ME=;
        b=jxaMm0ge9VsW81qaeOIprA2BU45WbYfotv4O90F5kFvQua/wDZFU5jCG6PGeJzbLZn
         Csiw4TRVqqSkFNLnQ8BSIzbLzNPZrtdO2ttYYPIdeH3vhaz5OMt1IhLLwwvyEMS3j63C
         A4oqNXcYvYGsC9JUh2nonywpMlNAg+5p9+OsXmrYLHBJH0j4U0XXT+O2I69ZdNvOM945
         qKadOkSzimIgNSp+Nip3RCmKxqZZxS8F5GyxOPKfJFr49lLk6iofiDA9sYQJpJIPU1Bs
         cLeR75oAVh0Hxh1sp8bthYcAhDUvyHj+0irI8q9FmF/uDSot+MLGhUC25FQvmqODbbCB
         OYBA==
X-Gm-Message-State: AOJu0Yy2lCzgiOrMcHU4lquziXBzspf+0vlCNSL3/GqOLBeDnARcanI8
	a5LTgmiXEIzQXjnNQgotSRQyhOZGYbfbq+mvfMUjv98/137vGIJ4KN0yLWD4xw==
X-Gm-Gg: Acq92OE14JGf1Z/q99mJi5a/KSPqqM5M+eOwrGw9/OPgPt+J+ybjFjeQ6kfYMqQGD/7
	PQIJno2K/o+dLcCsbGnYdGVtEedkUqSaatRWPsZBw54gwhUSiUcNZHqXIH/7Mk1h+9NpWqRxxT7
	nyYdLHyiPIFg/ppn9AAnSf5XTmG6FXXS3n3lNyvTOqNhV+4biNqI2g9VvqLIvWllx+Tl9X6ty5X
	5+muHGuIrDlGCKroOe6viw6pUmWhtnIwH//zDIeWfgIe+uIRpbIEMxyA/GOn5pIfVrUaxLpt6sQ
	TWMRMDpsbbxe9Dsys4t2xhBWOLf8q0c71T26CF5rrIGNjLpBc8ezmlsV+WHqWDzUqdrxpLdpm+Y
	x/ODBwxp3fepkxVFCjXj/rB+rxO2zhFYDeNATAlo+4ysFgkR9xV2OWTP54HdMp45+sZlWHGuFJo
	fu2aK2ekfdeKtka93+A9FIvHs13wJGCbylFwaR5IV5EuVebyjtXRhS2T+aUbew/jvNZR5phxzFs
	Dy0+Pfd9VxQ9mMIGtwvJXD1Nzi34ufC4nPbSvW0KEpKFqDuKm8ZhQ==
X-Received: by 2002:a17:902:e14c:b0:2b9:ec37:2977 with SMTP id d9443c01a7336-2c1644dbfd2mr28650865ad.38.1780512559486;
        Wed, 03 Jun 2026 11:49:19 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2409:40c1:4015:6e6f:ee79:7998:9a6f:65e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d59csm32139675ad.4.2026.06.03.11.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:49:19 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	ak@it-klinger.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Subject: [PATCH v11 02/11] dt-bindings: iio: adc: hx711: add VSUP and DVDD supply properties
Date: Thu,  4 Jun 2026 00:18:50 +0530
Message-ID: <20260603184859.89693-3-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603184859.89693-1-piyushpatle228@gmail.com>
References: <20260603184859.89693-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the optional VSUP supply used by the HX711 on-chip regulator.

Also document the DVDD digital supply. DVDD is a board-supplied digital
input rail (figure 1 of the datasheet shows it as a separate supply, not
merely a bypass capacitor point) that was missing from the original
binding.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/iio/adc/avia-hx711.yaml     | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
index 1ea60dff98d5..0baf620e9057 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
@@ -33,6 +33,19 @@ properties:
     description:
       Analog supply voltage (AVDD).
 
+  vsup-supply:
+    description:
+      Supply voltage for the on-chip regulator (VSUP).
+
+  dvdd-supply:
+    description:
+      Digital supply voltage (DVDD). On the HX711, DVDD is a
+      board-supplied digital rail; it was missing from the original
+      binding. On the HX710B, DVDD must be greater than or equal to
+      AVDD; when DVDD is a battery rail and AVDD is a regulated supply,
+      one channel monitors the DVDD-AVDD difference for battery level
+      detection.
+
   clock-frequency:
     description:
       Controls the SCK bit-bang timing. The value is used to derive the
-- 
2.43.0

