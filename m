Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4316C2F0C78
	for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769200735; cv=none; b=XSpXAwdRsxVwDTYr+tMA51gyCKbK4yzAx4VAfGyMfoVymasEVdfzwFyZJzDFhQOfcDl0FeHhJu/x2dHrGRNNGYE1q7Rc0XFa/4CeZQxY74PybN3TAXEMJXxUWzq7gsg077kh07aoUimeX+L3O08umHFZv+lQ4He+kDu97M2JVHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769200735; c=relaxed/simple;
	bh=0SRGld8wg9ob4xVn5NpAO3HJVSu6bKkd/d9jBcJCtAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WIkzTH3gLVaKxK439OfKETJnEGae5/h0WCDA+cNWBBwBhDBT079aPwd6KqkzPhCS3Sq9x8BGVq+H6qDXdjGdgzk/FnCOe1houHQLAxQXjfdWpo90fthh4SGvrSIUachR2jesbdcK0maFYfkDTXNJ76ckfjbeT9ynkFRRsA+UzUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xzIrvnF7; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xzIrvnF7"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-45c7d812567so900685b6e.3
        for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 12:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769200730; x=1769805530; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRCMa7QMJdZhKtVQUIWaGLlL9RgCPrH55zdDP01EigE=;
        b=xzIrvnF762GBAObHQ2rZhb5ZgMhMMLbsTSmgBZ4rSwfyBl5qKiAKcKIZAwG3rWLADE
         aX6QmrcJbAC139Wv6WmpPdtF2rbEJiocvy8xeWgcCVeaTRsRxfgTN9/0MwCKcH4cgkeT
         clco2n4E1skD+wzXHLf5PhUw4KPuNZKHZRT4ZHSm1DUSzB9exHmHtzEIC9JAjG0OiXWR
         76cTVFvFPM87wjRNamza3lW8VMzK938801OiCgoLjv97HNHiCUH7gNpNJ+NsJBhE+5Yr
         uMLseAFYb+gI9UqZv6OIaTRL41HXlrX0rZ4Co78nl7I0FpHqxpRw5jSv3WUrcSaTohcZ
         9Y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769200730; x=1769805530;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lRCMa7QMJdZhKtVQUIWaGLlL9RgCPrH55zdDP01EigE=;
        b=lF3WKhHkZ8fwfqK7DNZjpojFqEUx+Ua7xmrZmZeb5UiAQwggaAFUN1cLvRDaHJ27lh
         NzMVueMeV+6CrfFeGxC7KXLDLI9v5ZUfso+PhYVsaM/c/mlqs1NPi9DXw49S0Z6m3th8
         Oic5kj9+dBWopu+VUjlYXg/r5w6qukWInMKGcH+FpplTprjFci1QzepJsWZ0GJVfTb4a
         DTUTQbm1JmEA7vofzBZ7frYaOUklrwW5XpLmhh5MJDaIKaYdW7XiSRKLVGXwosMkUTuP
         PQOJv28oTSE5t1gMdMni/I4QO5hEySaKLWOXeTpyzCl1MVzPyLc45gMRkbl/tusyOHrE
         cI+g==
X-Forwarded-Encrypted: i=1; AJvYcCVwAQJxDRjmD3bI4s3NCqBZsidgzizbjAkm/QlxRIQII0mSBhIwDVLoGq9jetn/U1osNYc4OCqv8Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYzyrWgixjjbM5/Idune79AkTKrs4bxeOcCV2nA/lWQl8/nqKp
	p1DD/O4l10o9DqFm2WXWC8VtPp72vJUvfV1yYvBEdszME2qCU6WCw4rRjB0lDWBT1Ek=
X-Gm-Gg: AZuq6aLGc/ZSIaZoZmksE98i8CyYxls5iK7dWkpn5/DLMJy1M9S6y3kyQMJstiwMxNV
	llUSXRodfJF4v7zdaXx3OF7zxJ7wYXGAv8tQ8Y1uLQcKDEvmETS7E8QQ6ZlWcaXwWRz4OkVbtAO
	37cfnykYtmVM7hbX8FTljs2JRmIky3tvaw/QpOEkES6oqeGN7BkhY1i75bZf1MGNhQc/lk79nIb
	ZKyVjyLsuEfknG6DZO1IpSIukp0OpJuUKCMAmwUBL+ZqFdNs68f6bqD7I7MhSxcOOvIYg0xb2J2
	GQcQIOo9VzU0z8D524TOOapDHv1/oBJB13R1NEFR18zp6voipR1LUec8IXf4iWH861im6iApUsu
	zkLHiRPP1n1vyf1kDG5bKEZt5lwtQBvW1K1x6nGyUHjoqfjWvkBjOkwJibTQToG9zYiksM+3Dlc
	SDccmE7fYIJINA6sOpYOCDipeF
X-Received: by 2002:a05:6808:1306:b0:44d:baaa:c537 with SMTP id 5614622812f47-45eb1ac4ff3mr2135834b6e.11.1769200730536;
        Fri, 23 Jan 2026 12:38:50 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:198f:2b50:c48:1875])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-408af888da1sm2167805fac.6.2026.01.23.12.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 12:38:50 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 23 Jan 2026 14:37:31 -0600
Subject: [PATCH v6 8/9] dt-bindings: iio: adc: adi,ad7380: add
 spi-rx-bus-width property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-spi-add-multi-bus-support-v6-8-12af183c06eb@baylibre.com>
References: <20260123-spi-add-multi-bus-support-v6-0-12af183c06eb@baylibre.com>
In-Reply-To: <20260123-spi-add-multi-bus-support-v6-0-12af183c06eb@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2086; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=0SRGld8wg9ob4xVn5NpAO3HJVSu6bKkd/d9jBcJCtAo=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpc9w9z/Zrr1ZFq1ZeucdXrgMdnDu88JnIRiD1n
 rYl/9vfUCSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaXPcPQAKCRDCzCAB/wGP
 wACVB/94YY1h4opJbziyMfR8A33W8WxV7v7l0Isb56J4ij4epEbYwIO45nuXIaUJfWqyNxDJY9y
 YFnG5YsmtuiBrrxaW/U4JTM5bKHF76nbLCESS+L3A+6HaWJiJynP5CzbZn/D48gS4Lz09gsznd7
 PcHIHkdgAVKrj/9MaZAXFFZhs90hnhrZMHMB0xXb6yQpeQEgmwbV6Hg8g/PD2nBfRmXqSsC96cm
 HvzVhg5OmCJ9rPlpSJhk4g8a2PL8LdRtuPkYHxsu6Jm8DCyGqqf5rfTnmcjph5FnsCxjyHlnFLd
 w4MZPIGgU3ayqA6cd2zc9vFDKhWmDeSLKa5IRhDyQ//Wq33K
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add spi-rx-bus-width property to describe how many SDO lines are wired
up on the ADC. These chips are simultaneous sampling ADCs and have one
SDO line per channel, either 2 or 4 total depending on the part number.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v6 changes: none

v5 changes: none

v4 changes:
* Change to use spi-rx-bus-width property instead of spi-lanes.

v3 changes:
* Renamed "buses" to "lanes" to reflect devicetree property name change.
---
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
index b91bfb16ed6b..396e1a1aa805 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -62,6 +62,11 @@ properties:
   spi-cpol: true
   spi-cpha: true
 
+  spi-rx-bus-width:
+    maxItems: 4
+    items:
+      maximum: 1
+
   vcc-supply:
     description: A 3V to 3.6V supply that powers the chip.
 
@@ -160,6 +165,23 @@ patternProperties:
 unevaluatedProperties: false
 
 allOf:
+  # 2-channel chips only have two SDO lines
+  - if:
+      properties:
+        compatible:
+          enum:
+            - adi,ad7380
+            - adi,ad7381
+            - adi,ad7383
+            - adi,ad7384
+            - adi,ad7386
+            - adi,ad7387
+            - adi,ad7388
+    then:
+      properties:
+        spi-rx-bus-width:
+          maxItems: 2
+
   # pseudo-differential chips require common mode voltage supplies,
   # true differential chips don't use them
   - if:
@@ -284,6 +306,7 @@ examples:
             spi-cpol;
             spi-cpha;
             spi-max-frequency = <80000000>;
+            spi-rx-bus-width = <1>, <1>, <1>, <1>;
 
             interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
             interrupt-parent = <&gpio0>;

-- 
2.43.0

