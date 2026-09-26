Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com [34.2.90.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E813E4100
	for <linux-iio@vger.kernel.org>; Sat, 26 Sep 2026 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.90.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790437330; cv=none; b=h+n4Ofb0FJwLY/J1aabAv26foc6XLigKFiM4Oq+3yPlvEkGMg4AC8kpvZ5CvlsMwqvSo2mR8OFPrdI60DqIbCD6zskbRmlFbhLrnixa2ibtzRqViOrv8uBur9yO4KLnU9yiADJ0xBB9+oo51KYf1lGE1qWxKc8r8c6oWXANtS4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790437330; c=relaxed/simple;
	bh=MMo2tU/uFTcuGLaeRQMSBsciZFCzKetL6uMoGpvo8vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWTnJ9ors+fUDsvYNmGXVocUk3FC9BbUkAcTLrYCO9yZG2EoaTx2W2nZ/V4Qy+at9KinOcPbMNDFq1oPRIAXkC0akBBA6ErdIupySI8snkX13zOrkAINjwwWA4bDUjcRUq6xDm+hY/CNtreqKWBj9OGrslopWXLHlURoaNXef20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=HuoaUQCZ; arc=none smtp.client-ip=34.2.90.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="HuoaUQCZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1790437326; bh=dtbE9rIWnBabBb9zh2Iq6Z4Ip9wNcn5qrngxLVRETZo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=HuoaUQCZOet6XlOfH469eoBpdlSO1/5PrnVErKlPcYwntiVSHpEvjsQ5zZ7pvx4vHYp9Pq2MHrQdIXyjvaDrpyJVq81lNHcpyVYf0fg9/A9knvh0PFiBp9zgwF3yMEZzwDX9ss7jI3hJ1Jpma0W0gdtvbpjC5aYvzag8turUSu97LKSJoBiazFE7PvtusLZahNV4S48ID/VYb08+ylktfMid2WcmqAZun/2VwDpo0J7a2TrVnenbeYF8lIG+ybjMZSeKGLYzioEfWU0ZTOVlRc276Y8DK7tbnkjdlwx4U7rQPF7IbHbJllXMnaCLoNZp/2sKQVOUGI0eGKMeNVD3Sw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1790437326; bh=vetu/V3iFw9epEKdrz2Z2/cnxwy+gDlzIHgWQB3tPV7=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=fqxLki+uET+JSg0IBReY6sXI2FfiydYn8NeoPhTWop5fgdo2GWQSzamk87S1SzWRixzEzNSyBBSZ82VPnwH3DcsSeDKpp1Chzw77UbpaTzy4RCjN/eaIPyKSKn9L1fxI+8WTjeMB04W/ubuDv/XQ9vidjEnJLof0367GBFpDj37mjfsk7I3eJb2pOfu6KVe9qI4B3AbyFugb9YNYQKx+8pRwWYEN+Ri+1tqfZ/GYkvRpWMYNxCw4tMzpRi9vWD36qX6p0RC2Vlj8J9qB0lnqGaY0hGIwADLPi/bDnzHDq+Bf4vyqyCvnI1yCaqYyklLWGN7JVGy0sSTn03LbSozSqA==
X-YMail-OSG: ofBv_CYVM1nGtAFTpXRqC9GikFsjAMBPJOIEOO6iF4DCnag6X6Iq_Y2ulVxsA2a
 TNyVEZUwZ4xVikHmb_31j6U.CmkTz3pFSxDbscdJCNWllrd8gEloR6faf1vBTvlLjPP3xh8wHPRA
 KIeUw71xa0ouUEGUsgR2WxEQEGU5Qug_WWRZ3SlQItFMHfmntL0fEGkcoaUdhGcbCBXEycGpAKSk
 wxFL5M5CuZOUaSRQc.iXbhUru8ff1V6RldsW9CUrvT64jDQMz5cdQY9rtk7DJaEUECdsmDW2S28e
 1szoclveq6ETGJLaBRCDGoIzF1fDU5BDDdu3YCUDg_ltaVF5YooZ_b_QTOHe7XybONFebKd2MLJY
 tmpGx36tTnKxO3ppkHFGGi.9GEBHzptYw6SWCq7flWQYawagNXMd97vweIWkr2ZE1FiggopjMd6t
 cKCcYnfmuxBsiru2LXOd97DpGIn6EMZwtSxtws7I02sQO3NDMlIzD4OZN3p1AcmLYgZ74JwG6Um3
 FQEgbKUbhW_TV5N.HcYIlxiIhQyRZ0fizOl0BiIEZXVHlh1dHYUqqW.MUw9TVZmtZp1wutGnO34V
 _FTVmzOlez7f.hEeb0LFqkoJ38pV7I4SWvhAAspUUy5z3WCMZ4gdwjKY6BZZuoXJNSUmk5XEwVgz
 OXqs9u0tyqCQFttNTIV9G1uOQMH7937ii2jiTdQEy_nZzdgODAch9ghUmpz_KUdD258F9GnkirfD
 wosS484_bUjrqyHkPF5Qo45dLGG1lr37JmzZAPTEFPxq2PSS2jom0vx6WD2bVXUL4QhDqevsYh_o
 hUBh1oQsn038teMCg0GqVY0AJpLRYwS20FT.4tdZ0Qc3KB6fWhocDxw1iv15vvz9cfRHtMQtjeUO
 HjAMaSprKB9mDt5kEbEgEsyi3l.HHdqCW3vzw5SdUZDd7DXomEr5lX8xjwLY2nejrpHebT2zs7Lo
 BRh9rU9M7GDergmQQ7VT9OJ2laQ6pqt8Boit554ThDCvEw1AJmciYY0Lt22b4uJH27TkYFIYtHEg
 qq3zlMI_PLwFQkeV01liFd9AhtTVueXEOAsJfF5v1PBwiXhdx2uFymvHEt4Lj9cyrzlqrj8EndRO
 M.vtAmbLGfPbmCk02EEclAeYlcJZ0jsl7o82zX74v1203UBVUitKE5yfpfK8VwYnmBA6CAMem1zT
 A4MIyNPaa8EaX0eyWK0zLoJr8t9WZjVtu9wjFsFBc2PQi_5.ZsBZwYd0mfR1jV3snjxDz5PmswXe
 iYJwxwIhAp0KgFx1ZI6ko1WJba90EZrMHf1i_VbbIpaOCgel2xxW8gjjmSK6SIRJTJerzBc90lWE
 fR.UM5osChBF03JyvHg6VJD5aDRx.JSYju1sKfyMY8J80D9olVl8B.VkocTfPbtwSxBbMy3iP3C8
 XPhpmykV9Lq9gk8GnnPmPgFwvp9b.yIqLLHHPDhVaOnXc63ykCZmJlOJfG0wsoh4wZIRvHk_HXvd
 l._IHw4nbWZsWEVPY44LfGg52grXd_kTM4FdD_vHpH0zXGpYcNyHbmc2Xyyg49Z6SW4NCb51DQ63
 _PphufChZp5h_HYJOj2x_7bnZQtWKKLOwEHH0gjGaibgKz_cSqgS8eaE_6yzo3W1Mhz29gkELUY8
 uRQnbXgqkT_jeZTm_jq3LWHy_bQ95y_rXCTTCBW5JtdmPz3_Bvsb3QKcZzkzMrlgYhOCgw.6rhX1
 IQ9zYuf8AVRKyrJLTYPonMRopPy5ay1SNhvsB5frZZOSaFiCO_btUFkv_Y.7U_bRM3_2Y5THEUST
 TpfJr9Qq5hYHnyoxV6djKP6VNYDG25Nw9m__ryLHwVkpfndRptaa5FPL3XQ1wa097ARUwtMJ3T3a
 je2WiSzpCpDwWTYYahvQNf4T.LbC7kZuZZ2nNr5Xt6v4wyFnZmtAHu5DvK2Pb_j2EP_Sux_Tjwul
 DNXC5wkmIDWgGudu1gmh9VMmBJXju1wacxG2FgnFB6Ule5j7y2c7yfAcBPzqAT527Ai6kX29.nsU
 c7VvQOPqoM3BzUxtzLAaHWQOi..9aWq2uHDFHT5KBwjAQUXLGkGUxvMpxhWVosbbV2mc-
X-Sonic-MF: <m.abubakar365@yahoo.com>
X-Sonic-ID: 9241b316-be17-4976-85af-661ad6f588e5
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-101 with HTTP; Sat, 26 Sep 2026 15:42:06 +0000
Received: from dip33.lsn.bf1.yahoo.com ([67.195.177.42])
          by hello (SMTP) with SMTP ID 46afa743fbae7daefe6e6367ec9b72bd;
          Sat, 26 Sep 2026 15:42:02 +0000 (UTC)
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
	Muhammad Abu Bakar <m.abubakar365@yahoo.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: pressure: add Sensirion SDP31
Date: Sat, 26 Sep 2026 20:41:17 +0500
Message-ID: <20260926154118.5471-2-m.abubakar365@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926154118.5471-1-m.abubakar365@yahoo.com>
References: <20260926154118.5471-1-m.abubakar365@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the Sensirion SDP31 differential pressure
sensor, an I2C device that also reports temperature.

Signed-off-by: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
---
 .../iio/pressure/sensirion,sdp31.yaml         | 41 +++++++++++++++++++
 MAINTAINERS                                   |  5 +++
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
new file mode 100644
index 000000000..a98e7c97e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/sensirion,sdp31.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sensirion SDP31 differential pressure sensor
+
+maintainers:
+  - Muhammad Abu Bakar <m.abubakar365@yahoo.com>
+
+description: |
+  Differential pressure sensor from Sensirion with an I2C interface.
+
+properties:
+  compatible:
+    const: sensirion,sdp31
+
+  reg:
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

