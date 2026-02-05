Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB2B4218B2
	for <linux-iio@vger.kernel.org>; Thu,  5 Feb 2026 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770304080; cv=none; b=eW4cdC9/0r1uStYjZ9bmE1AdP2aJMoykA2dgZ0KVCu1XQkMbpeBhFF7GFsBtNp/SmbXyaCtlhLK+XEoqv1BKBFgT7SyQ4YRZ+Us1EJENJ1+iGO0qemxNI4/tYAMx/RlctOmZxc4eLehudQwRNQIa158p1h7LX1ZFk1FWyBx+sKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770304080; c=relaxed/simple;
	bh=KNP9MKmZ7v5HGtrcDpSoxqegxyUQTo2VMxBFwhjMi6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HN/+2aIEBNLrHwSNwEieLi8SA1y20/QtFKWAO+1OxGZQSyVeMWgBOWV53tEkqil38txwrwUKIcMUQXLAeMgNTfqt1+FsrYwxWvr9BJaZzht/vyNPt7zNVlCDO78UGerzHUQVS4wcSeG8hUie3i/RzDPKs9pp8RtVliF+Oq3AAng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/OkTY0x; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/OkTY0x"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-126ea4e9694so203991c88.1
        for <linux-iio@vger.kernel.org>; Thu, 05 Feb 2026 07:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770304079; x=1770908879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/T7xe657/lQnGEkXy0hvPJYmvXm+qY+vU+kSTvh3POA=;
        b=J/OkTY0xIrEOEYHbmUpuEN4Myd1NsiLAGCgXP1AeNNdgMhPjohsyEG876382QrSLQt
         hWjH0KEniY8O2s3IsrT2H3KDMR8dejFmHgSu5XIOciHiC+RvpsYzAolgogA2uVXhVUPp
         URg+RbcW2mMStr6lmuc8b00fwZNwVNEdWTPKIGUI3URRWhfCfWgaQF1gu4Yv0NF/dQhe
         pZS8Uu81hxq5M7/D+OVBvhnchIL9nF0aAfJ4CpD5TasbUyauRmO7EEqOHTaIMtN5T7Iy
         +CWaCetmAguzNbpCZTmjA6KZBUmi87xvlBYnFhWYUTMZcsQTtq4/mugpgXCxm905lmX3
         qcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770304079; x=1770908879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/T7xe657/lQnGEkXy0hvPJYmvXm+qY+vU+kSTvh3POA=;
        b=wCeVYCBWDq5wV9KZ7uyT1gttFunVsfJq+2ZWgPmqx2107KaK43aOuJKlcbxVK7arDt
         /kjm8u8A75OQDDKSmhtqvf68/0Ukl1J57NKwBc884GoN67sWZks2Rb9VbIn2PjBJTblC
         utllGv0klm4f44JpPwfndwAYLHwaUrgItaj2XBlDO4wtmZ85U4+0Q7pXYtRc8eDB3T9K
         g1YFk8UKm42gIhRAlQfHaWhav/SkPvZqLIepsNlxieEfB+SjECBm1yaw2WyXrPqzOw6+
         pRIjnh27Xm8UUEKwt4Q6WHZnsbiO40o3JtiWwTzzt6UkpJTraHIKaXDC/tkZxEjyvXPf
         wlhw==
X-Forwarded-Encrypted: i=1; AJvYcCV+YawN/P0nriEEwyWYMyJaMxKPLQj3yHUSCLqd1vWgfoVb7RpD6J4eobFzK03ZAMD9/actOOMm1a8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAwonWRiuTkdWz365a2+mth67n24/2DOAnOlSIQCOCTT69vU5s
	nwSjt8Ve//QB5KMXEYk++BuqPvhL5kZFX1AKFJr9Hj/qZ772Jy6N9EF6
X-Gm-Gg: AZuq6aIbB3VmA3gglj81k2pdsHMhaJCG8hK/cBQKywILFuuHOBZ4f9ABZ0fjEc4Y1+l
	8EK8xO8z4F7koJ0oIlyw8Xoe+7QsI1+xRIznKFotQ50Ait7Vx/5BqMLrN2TZhxPV/GXMOmjAbTl
	D7LVdbol/BjQrZYemNHAkyoLJZa0CmD5LW73KPJVWdk24ebL5B3QayqtpE3UR9NvjkqLKVn4G3U
	vesYZoiA50/H5VfalxehSaikCv60FVVjPPP4712ojCkkA4iO4fif2+o7teA2QbIzQ/ULEG2ixSB
	NtPvKwA0FCtHd6gCvjO6+JLwT7P3JNo0FfLN1Mm1pqpoH+bxcTaaMsqD4gy6dBZhR+VVdFz5jt9
	o+NgfS3+ii79FKXWai+BL2N2U6mG3sJzfk9STTbqSmlADinf9klBu+JyWEQ9mujzFVHS0bCSzth
	EMt8I01ZKd
X-Received: by 2002:a05:7022:2506:b0:119:e56b:9590 with SMTP id a92af1059eb24-126f478d974mr3839400c88.21.1770304078556;
        Thu, 05 Feb 2026 07:07:58 -0800 (PST)
Received: from arch.localdomain ([2409:8a28:a52:d2b1::1004])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f4e04467sm3909693c88.2.2026.02.05.07.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 07:07:58 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: linusw@kernel.org,
	stephan@gerhold.net,
	hns@goldelico.com,
	jic23@kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH v4 3/3] dt-bindings: iio: gyroscope: bosch,bmg160: add bmx055 gyroscope binding
Date: Thu,  5 Feb 2026 23:07:30 +0800
Message-ID: <20260205150734.525947-4-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205150734.525947-1-jerrysteve1101@gmail.com>
References: <20260205150734.525947-1-jerrysteve1101@gmail.com>
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
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 .../bindings/iio/gyroscope/bosch,bmg160.yaml         | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
index 3c6fe74af0b8..fcbd4b430e48 100644
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
+          - const: bosch,bmx055-gyro
+          - const: bosch,bmg160
 
   reg:
     maxItems: 1
-- 
2.52.0

