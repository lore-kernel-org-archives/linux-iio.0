Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5A62BD036
	for <linux-iio@vger.kernel.org>; Thu, 12 Feb 2026 06:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770877883; cv=none; b=JUNnMxUEq7e3h+XESIblj4ShzT87b/mPh3oBytghGcq4/zWXTbzVV9xw7GOHw2KKO+gcgRoQH1Syv6p4O5tF6EOl30VcFAGHyNDtv1/hGlo15Av1y8mpiQ3bsjwKVAYhjUlAanjDS4LYB1zVZqpmPJvfJ0jc7gpc/H+E4if6tqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770877883; c=relaxed/simple;
	bh=sDskIjgemhXe1gLZvONHkbd0VO07jwLoHOGyyeLZ4tg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fra2NpQul4AAwBWa3KzyWo+ahKDYNW5HYg0J6dMRl2/S6qZ7yfzT3VDg7wcgdevoNQYwCw0SZATlHpkXnmPtpRN2ciHJ0ctKOPIgM9wt6Bva9Lpbk5tiPdYK4f3NzN7Hx5qoK0/PtxolYGFkds+sVtm5qMy25mIbz3sI8X61oWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUQQd6F6; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUQQd6F6"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2baa1ed79b0so41109eec.3
        for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 22:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770877882; x=1771482682; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VS/5lyCSMomFl4sGXRo0flBVBz2382VDyGRJidcfeh4=;
        b=gUQQd6F6JCwGG32ZHmsj/LYBeqSH+A7x+HtAHNAofuc1sy30viME1fEkpoRdG/GJtP
         CAf/VymK1h3RurfIC9Wlx9Gh1XllhmppRgeXA1l0zQD3TnnfRE+rhnPlhyV4r1dRmfMw
         0rdkqv6hr3Vz2EoG2Lf7xUY3MTf8Ctbn9/qDadxqY7nnpriIyKGgz98MUXTDZXvzIphU
         dIoRxVRKxqtNjj3PETrrSY3QXnflA4mAw8fgOspGppEEkOm5uSpWrryLIp3ql5GxYdVb
         GdBEl82d/D8I5I5Cr7tJQTFw2ikoR+f5EpA8fFfq6eWG0KvxO+yloRLLcDz8e7srfZ4I
         vw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770877882; x=1771482682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VS/5lyCSMomFl4sGXRo0flBVBz2382VDyGRJidcfeh4=;
        b=KluAhaa/44cfeYsxpOEH3snvCi0i2kMHorAmonzXgaWKX0CaEpH6jDIscsc630OK/+
         aTWL4VgoqgYkYqW+IaAuCnS0LMZTs16Jg94YWZd0s87sISsa9EbW6JjM627H5PQu6GBr
         z1OGJN6Pvp1jfHlTZNzfhaQc2ee+IiVkO1RAFpgPnGkJRxpx9bm6xP4OIMRQ4nYCMbpn
         kcNNai+SXflocv1dhdxEkGmHW37ppKxmH/ATuMEwKvk2WRZz16kyxLp3DxtnI/O2E9OT
         55EpnErWatSX2d15tDnU/tt2oiF5yJ04ok9sin9iMi8sVQLT+sfnQlfF2bRbhG1m+xI9
         8KKw==
X-Gm-Message-State: AOJu0YwrS6hXU/CqmbadgRWpSGGgLxDgNv31K1cYXA7uoUV9QQthMIbY
	DuY41XnoWYBfJr3nm6fAsLxwGfW6OkeF9Bp+njjqzSeXt8p3zLzkO1QD
X-Gm-Gg: AZuq6aJhvLnfI0V/t5XGUnYTQm6l9SP4ws85pwh+VvTWdWgZUdCvOoSUMc6mr/zD8JI
	cGjzEGIdl74n1UWhDdYNPxK2P7PMSdwsp/Kqbxs9Ysd6ddSIvJsQJrKJ89Sd1ko3lj1mqubwjaR
	U5YBdjRO+To4gWwltDDdpzqwRtRTPBm6BDsegW9UUrH4ic228u7BOY2zG8+Y0KHtNvz3z0CjMgX
	crOhPGMLnPxOfDDlKBNKgvwDQToGMJRHyarssKNKRLX+Xlw8r5wwWNZigGuGVwPcv3VrF3eFeut
	1h4q44xsg0MP/x1RKJgsIoEjfCU7NXsdqBQmto1s6u6/Aq2YlkGw3g1/fCOYeX5OPIh2tNVyJHM
	JmZHpJx9YegZk95lE5VVIHUY3xsR1WmRr5Baz0zMRnc9uF3BFn4Y/5TNq81nKpnpiG7f0Pf3aSL
	Jqp1eMOuPBKnoxiotvSPAOkbkMqcuPFB0syto/c3Ox6MvHw49wIzexWK4=
X-Received: by 2002:a05:7022:6ba0:b0:123:308f:667b with SMTP id a92af1059eb24-1272f73bb50mr354141c88.2.1770877881762;
        Wed, 11 Feb 2026 22:31:21 -0800 (PST)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a6f29dasm4313870c88.12.2026.02.11.22.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 22:31:21 -0800 (PST)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Thu, 12 Feb 2026 14:26:54 +0800
Subject: [PATCH v2 3/4] dt-bindings: iio: proximity: hx9023s: support
 firmware-name property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-upstream-20260219-v2-3-2b28fce5d09e@gmail.com>
References: <20260212-upstream-20260219-v2-0-2b28fce5d09e@gmail.com>
In-Reply-To: <20260212-upstream-20260219-v2-0-2b28fce5d09e@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=977; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=sDskIjgemhXe1gLZvONHkbd0VO07jwLoHOGyyeLZ4tg=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDJm9xUtf7FU1f3PD0ezY9po1GpknxC6tZeL4/kpOPcLx2
 XGlphy7jlIWBkEOBlkxRZYzr9+w5qs+3BP82zUDZg4rE8gQBi5OAZjI3SxGhu1X+3WvXemcHHdE
 5sr3SW7P3omUK0/9oW90Y+6uVNZJ1saMDCdfehz+vaSuOpv9U4rOV1cexWtqucVy6Xx/Ha4zSZ9
 eux4A
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

Allow specifying the firmware file name via device tree.

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
index 64ce8bc8bd36..cc5b5284c267 100644
--- a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
@@ -28,6 +28,9 @@ properties:
 
   vdd-supply: true
 
+  firmware-name:
+    maxItems: 1
+
   "#address-cells":
     const: 1
 
@@ -65,6 +68,7 @@ examples:
         interrupt-parent = <&pio>;
         interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
         vdd-supply = <&pp1800_prox>;
+        firmware-name = "hx9023s.bin";
 
         #address-cells = <1>;
         #size-cells = <0>;

-- 
2.43.0

