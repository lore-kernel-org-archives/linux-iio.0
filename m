Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9C739A4A4
	for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789289657; cv=none; b=YXdPnVhX1iibF3y4YSD3VTTetCBYAEWR70DnPNOI18SQlbuyNrrSZExMmjb5tQtiJEa7zr6mkYp3/h76NjKCwWYTSl9FZSTTkarDQ5rpVWi67fwUlNu3uPg1e10sXod3CbjobwCAOfgj1kjI5bwXzPNSqsIEloUdz4tyKpUURWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789289657; c=relaxed/simple;
	bh=VVdY4uLEM+PSjSa4BxpP6hRuJzxXf0AWV+5KTiKJqRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkoQdBZzPZhq+WhV68VbJLsYg8ivu8hprb30CJCBwSF4v6ePf4SVG2VvTSZNfMUV1MgubtClX17WkJL+DUqAPUa5GVvRegbth8+qBDs5Gs6OJv0LnvHPh4MNMWRi4hSDLf8WtEWB1FFQdvbCQ7n4+jSWzy9npFv0XdkBBObdONQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0OESqIx; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0OESqIx"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b92ccb8e0so5885435e9.1
        for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 01:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789289653; x=1789894453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3+XuV3zRF3c0btBQBa2v8yLmcPdVUtoareQ/mmTC3Tw=;
        b=m0OESqIxqhbdNZgVZKunL/mesyu7on+gsT6fvBHAttwWN59T+NhkY6tYUqMcC1+i7l
         Zfbr8l7oOrSrX5/M5YdGrdmEeoOSO7bI43JhWhgmCRRMMLpBdLsSJihZ2MwX3bOquUxN
         PAJ+hvJcyIUhCnmlGLayFuGo4EjD4XxJhjujy2vovwXCXy+U314qZhIoFu5Mcqk3rSjZ
         qUs+hOVkt1pO9XeHFblzrBER/ijgMSGFlSvIB5FzALeti/+uKTpzVU/OsYWvMSzY4Ksx
         VZXpK7Wng97FzDFfC9KlQKofvHeSzynUpDjo7mef20ObseAAtgJu2s4ifEePBq3z6HmL
         6GLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789289653; x=1789894453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3+XuV3zRF3c0btBQBa2v8yLmcPdVUtoareQ/mmTC3Tw=;
        b=Pzn3nlWtgV1g+GrAaCYHqvabShD14i6qGbJh9XHcg8Pb9nzWLi9tO80f5KrLWYa9OW
         mbmh6/bvENVdcO8KNk3w785kUbO0dfLLQKTxMgqOwvXmdGkjz7eMnX7bCDSm1S+NyfkZ
         M7Lfh69uiciKhkrKq4bzxUDBkqGRHEenW7a2P+5X3Rj9gKDWgtw31QYwuGu1DWV8XBxW
         4cEV5c/6z3d/wcl3dP0HuGyivXedwkbATfekCugYbGlYh7bgCVPsrI/YlT9gbix/XN6n
         Sh0uAeQFCi7n4R7MXIOklAX8qaSdCxYec1lk9l8uqHB/gxs5rfS1TfZdbMz9kKaUvxIH
         zk5Q==
X-Forwarded-Encrypted: i=1; AKwUvBxWLsPfQYqy8Gl8HCEJ015tkm+BNw1fiRdzLadkKFtMPo+zPgCvgQ2kiIipLsYTK5oVFMwrWrIT+1o=@vger.kernel.org
X-Gm-Message-State: AFuF++l1KGVIjrrXmyx6qDZZ+vnPdDauA0tNE+u0i9sBtWA1LuD+Xif1
	HSIxVv+tnjEZCYAgcGWq2ChCykPEz180dfvp9n7iDUc3S5AXP54DuRcz
X-Gm-Gg: AYBFou0JYqLIBp+sxd8lXPKAUKEtIuyHsRU5gpRCtiE+OmtiQ87OeQEndcgOoq3YgxG
	RXiQbx0rv8FKv01NkUZ4nfOt1y3pP6wL+9iMlppHlfTq9xdfwa95l8TslgYVgltaYOWwDl3ZVCj
	34zqX3ToyKHEjkvYx/Cv9rBZE9sMUbg1xuDZIQgubuHuORmmigpsmKE0kxp6ykcV3Nu8+jwaANf
	XDrrjGQ2N9/J/coxfWC265rzamnI+GiWs0P7S15InHyx9XHxi2ULjzYvDTj0DMhKrY+rrqmYmSH
	OQgif1jx0ZnIblZ+SZMZX0Hwq3t2cjtDuKAcXWggaFXMQpnFN4ydbBzUZU3R149dekXTupqzD5M
	1/EXSTZzLkqWnLi+X4efQhb4PxMUob+fgKP1oVv1J5RvmkS1rFyCeJtyqkX69N6GCpgv6gV4B+u
	HacVPrBJI661XNyPdi/oj2Kr/aOwMsUKXga28Qa0Br/EJhaES4eiGcbBlsKIXbjJ3+DoxndZlOo
	O85xn/+DnTIhZdGyRM=
X-Received: by 2002:a05:600c:1385:b0:49c:fc6e:a3d5 with SMTP id 5b1f17b1804b1-49e619bfebcmr113344775e9.20.1789289652755;
        Sun, 13 Sep 2026 01:54:12 -0700 (PDT)
Received: from DESKTOP-M0MLFVC.localdomain ([165.99.41.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e7f5sm18228489f8f.9.2026.09.13.01.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 01:54:12 -0700 (PDT)
From: Shehryar Ahmad <shehryar.amd@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	gregkh@linuxfoundation.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	devicetree@vger.kernel.org,
	Shehryar Ahmad <shehryar.amd@gmail.com>
Subject: [PATCH v2 6/6] dt-bindings: iio: accel: adi,adis16201: add adis16203 compatible
Date: Sun, 13 Sep 2026 13:53:07 +0500
Message-ID: <20260913085307.13846-7-shehryar.amd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913085307.13846-1-shehryar.amd@gmail.com>
References: <20260913085307.13846-1-shehryar.amd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADIS16203 has the same external interface as the already documented
ADIS16201/ADIS16209, for the properties covered by this binding
(compatible/reg, the DIO-based interrupt pin, and VDD supply), verified
by datasheets Table 5, Pin Function Descriptions, in the respective
Analog Devices datasheets. Some Auxiliary pins differ (e.g. adis16209
marks a few pins DNC where adis16201/adis16203 use them as AUX COM), but
these are not represented in this binding.  Add adis16203 to the
existing enum rather than creating a separate file.

Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/iio/accel/adi,adis16201.yaml        | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
index b6ba7ad1a..3ce5fb1be 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
@@ -4,21 +4,23 @@
 $id: http://devicetree.org/schemas/iio/accel/adi,adis16201.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: ADIS16201 Dual Axis Inclinometer and similar
+title: ADIS16201 Inclinometer and similar
 
 maintainers:
   - Jonathan Cameron <Jonathan.Cameron@huawei.com>
 
 description: |
-  Two similar parts from external interface point of view.
+  Three similar parts from external interface point of view.
   SPI interface.
     https://www.analog.com/en/products/adis16201.html
+    https://www.analog.com/en/products/adis16203.html
     https://www.analog.com/en/products/adis16209.html
 
 properties:
   compatible:
     enum:
       - adi,adis16201
+      - adi,adis16203
       - adi,adis16209
 
   reg:
-- 
2.43.0

