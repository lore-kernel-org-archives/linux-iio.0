Received: from mail-oo2-f3.google.com (mail-oo2-f3.google.com [74.125.231.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2805D175A5
	for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 06:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538561; cv=none; b=e8XSb9hcdGrG8gLfBO2MY1/wtV0V6W2+nsDaxoONFG6RUDDLoNycJd7OIZ6Ft9KmneyBRDDwfup8mbh2L8HZ/LvtCy1PNR3K9KwpDnaAB4JVXM1dRzVUMWuEHgOZAWzS97Zsa9oHnfQVgNm0oiBm9pEIFTWsmCe2E9Mv/bGFuSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538561; c=relaxed/simple;
	bh=VVdY4uLEM+PSjSa4BxpP6hRuJzxXf0AWV+5KTiKJqRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNdBwCH5sIcYMmGRXfsyBV2mOFwK2cskdHZ7NJ6/pflLi2UELlVqj566pAJJ+fb8WAx07otSv6esuK5g2A5Tk6woiXPzDqo7EEPls0SDFvpj8zZT6MsGGCAxRaKT44Z+4iT0lHqFFGRViof7ltJX3oFuKusdUPbla7zf8cbz9UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cq0h1Flo; arc=none smtp.client-ip=74.125.231.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cq0h1Flo"
Received: by mail-oo2-f3.google.com with SMTP id 46e09a7af769-8046c3d6e35so1225723a34.1
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 23:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789538559; x=1790143359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3+XuV3zRF3c0btBQBa2v8yLmcPdVUtoareQ/mmTC3Tw=;
        b=Cq0h1FloAFvJ4uelxsLaJIRU6juiFBup8+KIR06P1B11xRQ8Zn6dtgWJqq94lj+f+H
         +48TFAqLec2OdvoZkm3gSwhQgEWk6HZG8gBtdPF3QGSpc1LZzXjY5b2nKty6s6dFZRR8
         g3MMNrc65Aj/2UMEGi9xCX1MUuUSQCm72WcSK5rKVV78BFWewvrXzo9svr44ZBfxjFGH
         wBri9xv/Yf5Uy2LPh9uLPnpyBArawR3P2xbu7dd8SWmMozbFIkYvdDK7Ce830E7EJSl1
         b3oAhWZbHfjjHDnhLm9SXDCBWU8r+NEVRkYLvsJFbUzcirmplcZJxknO/rC9W/8hNOz5
         kMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789538559; x=1790143359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3+XuV3zRF3c0btBQBa2v8yLmcPdVUtoareQ/mmTC3Tw=;
        b=GCBsKhBLqb+KDtNjOY8z7KLVMQbvMLx4Zra69io8JIgjn398Fc2o25Hafz+loSxU1K
         wcNIjUOAqaYXvSOQwfeMZ9+wLgLRlz79PVU01rOwO5JIj2hd3Wns6Et9joiBlGNiECh+
         tvOjxL7pxLk4eGfQdlWJHfP7hMh5STGHZ1zuu+cZAHEt2U6xYpPJ2ridOScJcOUU2UiG
         sKDNs5wRshd/locke3/lYSJCciq3ikd6ahHk/tdH61BhskSxjmZDbS6WrFyQ9PIHgdKO
         e12AcmUg6qiOcTpKZXMOBT4OAa2YOfAC4/AUfdfau9MHPnWX+HAg9dgUiEy2HsF79jRP
         1b/w==
X-Gm-Message-State: AFuF++mM0JV9rpkT4Kn5rwENrdJEaqcDtDL1O1uCVaTDnsDxE0eH5IMB
	et6n3MX48ErGecmp6eQ4UI/HhdTAtKNJgmP3Cm6EdNi58nMc/u45sb5VWm8OpLhGCAA=
X-Gm-Gg: AYBFou1hV6z/uuqrhY02KvgLeuP+VYVXgz6GXzEw3xdx9r6fNfVX6dtyNk9xWjnxemW
	h3+yZGdoBvQk6okOAMC7rbTKXdXDp4+zoKpM67lEvrl3OnoqnLAi/0TxAO55WLVu5yxnLWe4bCC
	OazEu6jdslAY5T5FMBVT1aQuMjPwJQHwnd4lB9g90R20FCh1mdYrmJmXx+LOED+Bt4d1OmarRdK
	U3oRwBMpgnqMtAW1JiMLbwj+kyczZTMG5VIo/wMXf65ql4rYc8j/CJBfbIqxgGV9ebm0BhJR+A3
	r5jo323P6hr5djg5EvSJ4kkP48DmG/PnPumkBuAc5uTxj4x3FOmpAjfPkjY3NFB4Ye94ZVChdC4
	dM9+xJptj3d+z5g1ZkW0an4YA+2LLvNSvvVy3RzM+BVUTW2JgSJeF+rRlV4P7GPZMKMl9fxUWQU
	Laqg9RiDbjV6ZOEs8H9bEBWmGm5FDJ3ib4V9mL06vA+5sD/mJsXBc5ACjdXP9y2x2iH3hDp782h
	6NIxMRAXTIxn9uC8S0=
X-Received: by 2002:a05:6820:6ad0:b0:6b7:83d6:2924 with SMTP id 006d021491bc7-6c7d350308emr1367952eaf.39.1789538559010;
        Tue, 15 Sep 2026 23:02:39 -0700 (PDT)
Received: from DESKTOP-M0MLFVC.localdomain ([165.99.41.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5aa1194sm5150929eec.14.2026.09.15.23.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:02:38 -0700 (PDT)
From: Shehryar Ahmad <shehryar.amd@gmail.com>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux@analog.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shehryar Ahmad <shehryar.amd@gmail.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v3 7/7] dt-bindings: iio: accel: adi,adis16201: add adis16203 compatible
Date: Wed, 16 Sep 2026 10:55:37 +0500
Message-ID: <20260916055547.15206-8-shehryar.amd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916055547.15206-1-shehryar.amd@gmail.com>
References: <20260916055547.15206-1-shehryar.amd@gmail.com>
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

