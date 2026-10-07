Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com [34.2.90.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD8C412280
	for <linux-iio@vger.kernel.org>; Wed,  7 Oct 2026 20:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.90.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406290; cv=none; b=WvHKclUOiJz478qeN8AZKmKaqP3GHnTiYJRSq8w2dDiAV0AVPaO5jiv/8/bI80WL+FZqsJmbpbKxDGu3qkqQZk6ErTHJEl3FnIUZDVh0FKIAhz8N66WHW+LJuBco1Uh9dKT6K+7/7UMdanNzrsu9WGGvvesbYUgOWUmP+/Vzstc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406290; c=relaxed/simple;
	bh=wpZv/Ksc7GwqDtayWLXTlLfZV8iU3q+h7rqKULYiJZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDL0vxNAzSw8Dnd/cxhuz4bPdLqqx2BP4fkPr2IWhPgBGQRWKnuA7bc0EtSjgRi61d962D4tD3Su+KCY7sHvcu6Cype7ZoyjkriIJrTQMwIPXbJ+/zJHLUUqK2TjBP+LO9QUb6R6wU/J0To40LvaiMDVtp6s0aY93y3EitDzOo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=W9s5OK1V; arc=none smtp.client-ip=34.2.90.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="W9s5OK1V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791406285; bh=VM1o1x3O1X6VXjGH/tQ253F3VhnLGANLnqnODOLejqM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=W9s5OK1VH4B3dMSpEyE5QhwJEzJf04+I4SdUiAX43yYknh4bdDRebxcBZMUjAEjXRaRuFFZtBt784MKAp/Cn6HY5oPOSWm+GuHeZ2ZEKXdDyOJMMV5x/piWbsw+TieHLGPp9hA5Iou7RKt33Y207tTCmcRwmY9dAmHJpFsNHJlVU9KrMa9pofDzUQyvxfXh0lX7A3RATxLfbyH8FICdhJuu3ILW4Lhm5BBFGxjjXlOvg40XpYxP0SDhhOjiTXefwxY+9gHkld9K2VcWrk65nMylggBbofhjoF+JQJwLJZ+g+OwcQ2NsYj3b8K2tlDudzpfoP1zh8LIH/wCLIK35WSA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791406285; bh=9i0y6CbvqegJy2Yo69NT/xzmbtG2CLOJy5TypEtkG36=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=nxfhbVbloNc1RmoGR91ez9ig6w5ViFSgmSZ+NSWG/5wTL+XvCmXOgoY7sDdk392QUVVMAEQI65WMZ6H3ePtF/qRPG3pHZPtWbLS+AGqJKObBrFn6SvakQ0ISrRZR2eVWAF5aoyxj+zsTrjpmFDPrbnkUWplYQccMFlEMqMZM+zIDf7LlhJ7tC3vXTB960RjOBQZxWNJzH2db6wAN8P3kdv6K4z6QkNPSchShLbrAdzhSHEP3nzoZQ07X+MLmzbPVKszOQxfOity/Fx0LAI5sCUCmqSOEUUKN9g7oJ1gj+KHYR6wQyDrhgkjf7I7ybS9JuX/wjLqvtIQmjdx0IRmQ7Q==
X-YMail-OSG: h8M0oV8VM1ngPdrUfhoRBG2XgE09EpjW6YjTra.dh.BwUqUlRjJpfHeQRb2O0vD
 ypZ8waZCAWRePxZY4U030z8v8X7WUI.HW44PC3cmwpgImHVAS3w8T5XW4ra_hVHYbmpa.R6r41QC
 bY3YIatMVXGYRzvzA4fkrIiuttaZ7.po6jWeh.Zj5zk8xcjdmACyX6q6Xid80VdjfHGFqGNUtn1t
 PhmPaablyaT1of6jq_VKgZULiWZQnrMvh2ufc_g4gkSXFECyQkkek6Fc9dUK3ZooGxTlLFK5S4BA
 2cgRAhJggkMF0J_C5E8KQsDVEjQZNleqZfZilTbTTL19aWgtbCCUbQylKq4WeRMPRgb3OKyQ7N4U
 wpO.q10DE.p4PJRnGX3erdMW0UibTnaDibESoowGhcBYw5znA02zbjQwqhJzLe0gUuwfSqg6yP4H
 _IEDCF2oN0Ltr5kn5bHOMT2JNWQzbVRalSlRN5iaMuc9MX3bRBWpdeTQjQsCJ9ki14IeAmByk_NU
 enMcAh0XtOWIFqI_uNZQSk32vUk03AK0x_ti6KULW6i4X2Fky8n_iJGSklxIMz2EKsxFClJUQ.ZC
 B1TComzjFV9awTztAoznsFsEiF6mjE8yU8hsLiVnB8lS_AsgP0TWmHZJ80QWAE8XD4AExeMSZiFF
 jRfkJmVKPAdV65PBE4k1WPrgQmALNGB0yqd2.VpH0hh.MbML1n1FSeS435e7aGQrYbi274mPiPYy
 fvL5wrHJtTaNyP1bHnFYF5G.xMaJ_.Yj0kJW_V.YRsLah04mk8R9iPHj3oSxETcpG9R2XxZb2LRz
 B2Klkv9Gy9keaw2qMqVVMEFyIQ54yawAf9w2OHzc5ZjJ1kUVdMshLf1rz2sgbFpfrq22MOw0j3Z8
 AIConMMWVr5lkRwtqRqytNbsAgI2sYnWHl17nhSXDYuRMIDSwn0U3nup_68rPOBzbcPbrBrzCnoD
 gQVwKQ3CKsG9divfDtz2MhPApwt5FdAylksPVXdBn_Zfm7M6c5ZN_c6Geu30oW3sVFQHxcM9wNA3
 iG_AehpigXQN2YwMtxLfYkujcjYbi6cfv.jN617geUocFF1uXEimqDYvd.wjcuquKIoc4fNqF9QY
 BAhjMQQILbuVYs24mDdikXdeKlLw_cedVDcN0Ykh9n_zA8sRLGb6sWVEiChacNoMT50gEauO.7B.
 xSnyr7aOFVG0vIjtrFkNCQFfXOn7aJj9purJHVkO2k2LJgRqUBjDcax0T9nYwRNzfBshdcNWiOAn
 HJAVdK9N1myMg_zxsXXVWGaXPcLd6l0gLZazlMRrS7MFy8hfu0sGmlzb7x_2Y4F5YEm_DCgCoVF8
 7PCY.4zfvV3CD87YeYI3YZuCzEp1ngZDnwWNUfZD6FAYZOtPqaA9zswAyR9Jd10WOkOnmf0jEz8C
 prk0CNx4wXfcUt4det6xRWyM_JZ3UMRVMxMlJ2vYNP1b7Jl8sHXe78afCIzuhEqS7b2EqpF5SRtx
 6sIQihOMZ_Oubn_chahGT3OmityqdCGQoDf2HkPIQ.NRhR55qQLni7rmWxRlLyfdzk6W46FySFhI
 yeuulOP0ZjxDFznSI_olwf_AUxJ5WnGoNMuNxYQ45.xEbhYRFczgJpvtVxEsViO69axEj9KFhKcP
 iv9wJRz8JBig3uSPnP32y0DeunnK9LGezZpnuya9B1gJD2pmnPBv2bDFAm1rWv.O8kf3x1lbtD9.
 .I2Gn5pDPZ3i6p08ht6aPck9XsmMwpXr0NL6zGPqBMky_Uuviig6DVs9hDHYq4Vhz0flYFo6tGxn
 HSfVlbSESMLG8P5NxUR4uS7kkGbhnChWyoFxTE.vURXX_vUBlk3JkfC5bQeAM93h_pMr1pIqNx3x
 cCcUggEFTSrpLtBzTg3xxxYXXIi7wUvvedyiSU36MA4_5Hc_mcOWa0c9mf4wri98f4ykJ3FLGSJi
 O9mFYqCcZjMTyIjMcrr9GYTjbC7s39YQA2ZeSTrfFCf5PTFP0F0x6RvlWR1Fw1g0WXwVY6oWo9qo
 c_MYJHGgqEWXiMKItalUHPXAKIm3T8XDFx_Y2iYD.IfXuCQp9DIh.xJxQzFxiL8ph1eR0Qw--
X-Sonic-MF: <m.abubakar365@yahoo.com>
X-Sonic-ID: fd0150ee-94de-4d52-9e49-c2109409a517
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-101 with HTTP; Wed, 7 Oct 2026 20:51:25 +0000
Received: from dip106.lsn.bf1.yahoo.com ([67.195.177.115])
          by hello (SMTP) with SMTP ID 91bb27b55516d1fb42642a09b5dc36d3;
          Wed, 07 Oct 2026 20:51:22 +0000 (UTC)
From: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m.abubakar365@yahoo.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v6 1/2] dt-bindings: iio: pressure: add Sensirion SDP31
Date: Thu,  8 Oct 2026 01:51:03 +0500
Message-ID: <20261007205104.4694-2-m.abubakar365@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007205104.4694-1-m.abubakar365@yahoo.com>
References: <20261007205104.4694-1-m.abubakar365@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the Sensirion SDP3x family of differential
pressure sensors (SDP31, SDP32 and SDP33), I2C devices that also report
temperature.

Assisted-by: LLM
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
---
 .../iio/pressure/sensirion,sdp31.yaml         | 51 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
new file mode 100644
index 000000000..14d780962
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/sensirion,sdp31.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sensirion SDP31, SDP32 and SDP33 differential pressure sensors
+
+maintainers:
+  - Muhammad Abu Bakar <m.abubakar365@yahoo.com>
+
+description:
+  Differential pressure sensors from Sensirion with an I2C interface.
+  The SDP31, SDP32 and SDP33 differ only in their measurement range.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - sensirion,sdp32
+              - sensirion,sdp33
+          - const: sensirion,sdp31
+      - const: sensirion,sdp31
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      pressure@21 {
+        compatible = "sensirion,sdp31";
+        reg = <0x21>;
+        vdd-supply = <&vdd_3v3>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 214aeee76..e285147be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24855,6 +24855,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
 F:	drivers/iio/chemical/scd4x.c
 
+SENSIRION SDP31 DIFFERENTIAL PRESSURE SENSOR DRIVER
+M:	Muhammad Abu Bakar <m.abubakar365@yahoo.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
+
 SENSIRION SDP500 DIFFERENTIAL PRESSURE SENSOR DRIVER
 M:	Petar Stoykov <petar.stoykov@prodrive-technologies.com>
 S:	Maintained
-- 
2.43.0

