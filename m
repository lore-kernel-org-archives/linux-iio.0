Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB14743800D
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 19:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389713; cv=none; b=bK1IwhMt1aRRxdzxURwUhNXDxSlPCaluFt7qhg7u3KSPTrHt1UUjxypmHB7GzmYruG5mKJKSdGy9iuyvkMykIOB/UVqlIsViNJSjrNmP+j5sVizE1+B5lM5QQqUtEjrc7S8yn1PEroPh8Ui0GurbUzJOiRdCst+y71xWdPXhTtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389713; c=relaxed/simple;
	bh=uexxpyY32n0KDJ6TFBGqjZAlB3EeE5v+ilAqXIhOHwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JmS/BrCl7eI19guqGokduR23oKdnIOmgVP7N0ombrx1hmhwGThr4CGTHaBnEHCzr+SOW2n9t5aJmVsJYbC8Y9tkhg7j9wVTOWhRmlNeWD0gavFK1e7pnjqlL8mBzB6Gz+slRSVqCN2KcfRaD63FIvrWKuhVjWtDZq/fDp2xe2Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ctvgjmmc; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ctvgjmmc"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-664b05d408bso1899431d50.1
        for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 12:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786389711; x=1786994511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2N7xrd0aGyVwzggneWt5AqqDVcxSb93c/y3jTFurvbk=;
        b=Ctvgjmmcv3dNHutGk/juVowBBl5OdkRatntveyqEDpuZPML+u5XU3FWJKPQtMeGEF6
         llmZV8/pQ8tpDUH37hR3p3VFXrKGP6x358zSGaQTlG5WMpDl9DW1dLJeBMTn7rPGSK2T
         ZNgZ610elEpXG3xHR0QwOOFs5NRv3ftU8ZGK4SjPc84U0MJcLMNWcsrYe4pP0AlCtexp
         p0pFX5EhQqh0eluarWxRIjzrDtiBJiNeAkuN8331yOsEEV2TYbAmg460X8noaWEok+9Z
         1QqNXb9XFkYxOjKXbOvbZMUwCDL67GrtJPp8DE8ABO2FO8hbgRaNHLROQLqslwwsH05Y
         MQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786389711; x=1786994511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2N7xrd0aGyVwzggneWt5AqqDVcxSb93c/y3jTFurvbk=;
        b=gi5tte46hlsKImM6NrvPBIPrbdwIMo4yiZlg1mNuWYtIOLMQ7ty78sVGZw1HTgy4ea
         vZOOdISB5h7YYMnYO9tRjeYR8j0p4wyJQTnKrH3MJaGm28y3/8+sHLGBTcGhO570Ije8
         ZFXl8xlx1M1zFMc9q4Y7WCTtpYTm0D0Cn3WzeZCHg+LfxeQ5r/oMfJ6xc5kC5seJQzMc
         WrpinVavjuSpWUYclXhsDgSRgRgVVANKPiXfgVcTiMuM0xRLrkKLrbovxKrRNGiQbXcF
         X/CKDLo1JXZHrKQeT+bqtyq4Rt1wEO61McLWvRD20DS6vxAPkbpDolxWnUqEWc5Xyl1h
         ETrQ==
X-Forwarded-Encrypted: i=1; AHgh+RqwOvNRHGjPIhsyJ9NbifZn7oRElJMKIi40ng303jDgDN0gdkYlsbWfGlzKtK+COz7ZOKJ5PxvRQOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV1leqZFTn7Yq4RpvEeN6Vqf5erzGoRMXP08x+kKnewiITjEgU
	8OehGFcbmxEO8vmlsC3IiQw4TuV7+r+dyqM6L9g4plSDA1SumZQMoqYx
X-Gm-Gg: AR+sD12/QyI4UdhDSdMxERoUoPTUFB2CTMw9mfB/nLbLZ3P6QZ+YRv9MD1vMafDiNtM
	liKaxRIGtAYOdox8/kky57DjcjS3KgbhrF98SGvUIyx98vn1hzuBRCN1gRJoouWlpY97bjzhb9A
	zrgznpQ1aetmUozAJ4G0+GdyavbUmZW6bCOD4JBBSZUWjpbN4j2w7/7MiUGHZs64H2x8Kq8hAdX
	NzQ0dSYGGgx3BoTJdCTZWKfzrdpi02W48V1LMgJ1ooIizvWWlD2893TFuV/aLqT2Gl8RMvJBBP8
	hC9AGQF7Jzm04uMTMNus0dOrm05G02+Hk6m7nMmFp7dzn0RgBVZ2N10g5SqSOS3QIDYChzJgn7f
	pE/gtWrQyoz6ZmabNrbZPE2c7L033yFlvqiQBplalgLLQ4OUW2VNvhiZ1f/bRS20C5yB/z/uBLp
	OE+Zd80OV/iQpBlX7ChYs3TUNsIMgg1VdcgaalcuaqIJwoVWDe1zgWI85dn0EHjAeGMRJBcEI/s
	MDP7meJea4dKePFhqMu8Id/Hy8QUPkelS2OVgrX4Rc=
X-Received: by 2002:a05:690e:441b:b0:668:8b3c:77e6 with SMTP id 956f58d0204a3-66acd2f1fcemr10753609d50.26.1786389710698;
        Mon, 10 Aug 2026 12:21:50 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:82a2:5c54:b9f5:beef:8bf4])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acafa90basm6928863d50.16.2026.08.10.12.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:21:49 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mranostay@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-kernel-mentees@lists.linux.dev,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] dt-bindings: iio: proximity: document LIDAR-Lite v3 fallback compatible
Date: Mon, 10 Aug 2026 16:18:41 -0300
Message-ID: <20260810192131.153495-3-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260810192131.153495-1-rodrigo.gobbi.7@gmail.com>
References: <20260810192131.153495-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PulsedLight was acquired by Garmin, who now sells the LIDAR-Lite v3.
It is pin-compatible with the v2, and the driver already matches it
directly: commit b257c1a45e99 ("iio: pulsedlight-lidar-lite-v2: add
lidar-lite-v3 property") added a "grmn,lidar-lite-v3" of_device_id
entry, so no driver changes are needed here.

Document it with "pulsedlight,lidar-lite-v2" as a fallback compatible.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
 .../proximity/pulsedlight,lidar-lite-v2.yaml   | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml b/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
index e19c8d166b81..baae9bf20a30 100644
--- a/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
@@ -4,14 +4,14 @@
 $id: http://devicetree.org/schemas/iio/proximity/pulsedlight,lidar-lite-v2.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Pulsedlight LIDAR-Lite v2 range-finding sensor
+title: Pulsedlight/Garmin LIDAR-Lite range-finding sensors
 
 maintainers:
   - Matt Ranostay <mranostay@gmail.com>
 
 description: |
-  This binding covers the I2C interface of the Pulsedlight LIDAR-Lite v2
-  laser rangefinder.
+  This binding covers the I2C interface of the Pulsedlight/Garmin
+  LIDAR-Lite v2 and v3 laser rangefinders.
 
   Besides I2C, the mode control pin can also trigger acquisitions and
   report the measured distance through a PWM signal, without using I2C
@@ -20,12 +20,18 @@ description: |
   remains the active interface, as a plain status output signalling
   when an acquisition has completed.
 
-  Datasheet:
+  Datasheets:
+    https://static.garmin.com/pumac/LIDAR_Lite_v3_Operation_Manual_and_Technical_Specifications.pdf
     https://github.com/PulsedLight3D/LIDAR-Lite-Documentation/blob/master/Docs/LIDAR-Lite-v2-Docs.pdf
 
 properties:
   compatible:
-    const: pulsedlight,lidar-lite-v2
+    oneOf:
+      - items:
+          - enum:
+              - grmn,lidar-lite-v3
+          - const: pulsedlight,lidar-lite-v2
+      - const: pulsedlight,lidar-lite-v2
 
   reg:
     maxItems: 1
@@ -56,7 +62,7 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
         lidar@62 {
-            compatible = "pulsedlight,lidar-lite-v2";
+            compatible = "grmn,lidar-lite-v3", "pulsedlight,lidar-lite-v2";
             reg = <0x62>;
             vdd-supply = <&vdd_5v0>;
         };
-- 
2.48.1

