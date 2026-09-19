Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com [34.2.90.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24327376A0C
	for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 22:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.90.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857581; cv=none; b=kcuBn/JdvBGIKTQyp36kJ0t++rZx2gbzLhPQpvgjpzCMLGg3WLcpKn9O0PHARaWBEg0AC/V5bT/bEcTPMLfg7gsito4mzQkva+nNQD2W+5fnb5tjwgyEl1qW2JA7WTMNNkEuUUtSs6aNzs/9xZqBaIHWUcrD+r1cdwLlWPiPOIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857581; c=relaxed/simple;
	bh=qGH8s7vQndK0AGNW2k3uw+dBVN1cygpRclDTZPjn9tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/YdatuIO3kNH6oXbdzxreVBAlrVAHM5T1mbjvHqhCwjVVmxbEs7JmTk6aST+BNJ77rRUK5EkSqlmlHMVJK4Zw9suD//0ackZlvixAJ+1K53Jruy8jQaUV9yQ9D9FHGvXjU3HBiZLEpCE7GBlRE95w2bk91jdSUOWmu2+GPesQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=LW3HSI9u; arc=none smtp.client-ip=34.2.90.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LW3HSI9u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1789857576; bh=JDpR/tXJX8bD3GWbP1hKo+vJNWcXpvpwsK/JlR2YpWo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=LW3HSI9uhRSuGhynHM8Cpovn1ZKaWWm2yYxvsKB3nNiIn2mxl5H2suPWa66bG+AL2aebvu4Ql1BosecUAfq2AvY3exW+5rPUrFfL957fAZxi3aRk7jccqBSoEMmQzav5KP/QmlmD/uqtiUioVc6/WiESTCLm0pgsG9Tsvmpc/SwThZG3j7ry+JwlvZMcRXV6YWJeBlNLEIPhBDU4crpVp5v/5J7+JeTll6r8AhGrWNLi6SraWrY9bcckpFJtz6wWwxYY49eNdGIjygC7ppvVgUkWLbsX2neeH00vdm/Drv4jxPMtq+NV4GslxIGjYrHn55Y2woofJ5PNd9IOJ0Aezg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1789857576; bh=FmyCH1DFYid96B7JaZoS9AP+YGe8c+Rf/sZvqKLGQDw=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=M7yef1BFrW8gOW15/I5iZaep6/Gh2r8ObrbrzMbJDMOYBvD1ESwMeWpB3pkukVP0aNQu786oYzFSn9OFgov6WdM+0YfwM1/SKK6AtHcJ4wp9YLtjg86s0XNeI6FhMndVX9/3P1ZTKcq0pkta7c/X8QDeW3WBTY3BuuXn3kqDr05OwxYzi1QfsoYwhwY9nCDVDaVEim1umSLfLnK+b05ofSK8mz83lIot9+XVlvce2IYYelmEpvtsOs8qmulysqoG0RgBSp4/fwa6fEasutO1oaYww0jLf3t52yag+U6uQhGLK11Mb6401iLy1ujDN+X7yyG0EnmtvoaNZ83QL8DXOg==
X-YMail-OSG: GzvGF9AVM1ls1fR1IcJdeoyyoyQ5aCvRL_uWsWiBqB1O8RLm7nFrAWD78_ilTzb
 V.zyCSpFhQe8byW9RCMRi_5zNJzmOLjWeA0xYGdhS4u_Ggw.U4QNiWZPwsSHt0jiZhPdXGbK1rWQ
 qGVSJSg5_lXMTFp_8MnRyjWrSiUg9Jyyfe4mUbuTRGaQagxHxaXvErSw4QXiZSTL599wy0kj.lfs
 AIDChUY48VPQAntNKCYiXBQXh_wZk5mAUGWnyhfOcKvu4EIJ9sf_2A5GPXIiqR4RCblRamCNEjBZ
 wQsw6jkSaCh57vREuExg7HKtDA40Z9lrZnAlu..MWF4xZDBhK37SlHFwEB4Q0D359r4v8W0Fahfo
 QVHnXJnW9tFbVGWaFkLJwd22zo_Trn3UQIgpvcik_2P3Eholk70r04zrE7eFtbMCrbrNIrkA2y9X
 W0Thm.q30lOxaro3ogP64J1zW_zOb9VI0xA9wMRsUPwW5oNSrvNZLkjtOHxb68Mru_2Q_J._uONY
 RyoP7c1eep_PRPasDI8UooBBCBGf9PfnT1NhaLjFAUFrFxWB5R82eO_qBQplLuG7p6oE32cKOxhX
 MmSKYDvMSpgZtsgUG3sHSFm1ziLEIIfJiekrhYac1uyDtghHoNjxOvv24Guql136G2ey4QuRYeTE
 s7biQ4AJrvGc88AsiSXASUtJE1TE76xNZxWz2J5Dffoc_mgm4BGKz5irQCAjjyxNljaUHDAFe5hG
 gKUWzW1J5eyCQ_V7SZav9vYB1mC5l5zGNUdDx2V4Ad_bK23lYgMLqhR1ISVcZBNLowyYg9jkCcGw
 ex5f.KTcOGpkXkRBzH8a0ry8UTXW_A5H.uB5o2Tlm7GgAASdZey16jVvemz6gLc3DjJxH8Xk_i4Q
 Am0DUtIrkF4xjg7Oc4HjkIK5n9QGeQFODfNCtJV4AmsznuaOTFxsLZUZ6kxxjnfSTav03s_TWDmN
 J_eCv6v6LFrgJP26AEvRxNEsGzO0vPciz2B4._Z930BPFjkkfkIIqMCkiLKj.OJRpkN5NXWLxrwh
 NdTtQqLgdXT7W.lHnHqA4DLtbOyWNFnSocFobE7H8hJXz9MaHSnw4319mBEKBX.hxTVhjcbuquC6
 _IJT.duStVsX_hg.2.DhBTPnxq9dllI_exd9vunjrmMeW4_2hoHr9z3lgV8q5pmBAp_fVmIcCFui
 Z.EXkzTug7OuUZMtZXTrxqFuFZTOqw570tsIh5e9pywDz0u_DpF..WTLXzVSFQhdoD819mplkEkM
 BcpyrKXOww9.mE5_Ov8aPzLZOsSbggikGNi2mVxuzuZNGN72jbsqG6gOKLruXqpOojouK3FIqS6x
 4OZ1qgnCnlyPaf32F7ZI2HwzdNa8xJCByoPltWfet0rG.P5YI4rAhUonQAVd7zh1F0yrE9Hnax_b
 BZs29oncEOVaUfebYbByK5OecbbnJ9DYW1cOyGXIsBxCsOYSgMNNNhca3CwQffFMNG9mw3GCIQv.
 4d4WEJItHCRM4Ka_KRMHlw2NWDGV8GxQ_Qe50Cns.H9ht8hwh2N6lgmH4IHVZpL4j8v4zm0ZZVEU
 Dwgs1zvVBMaVE3eOjtYoO8dsAi4tiBfInoqCqnny6yRQq2DjB4BoAcYSmV4rWTGWoHVELqGMBWeq
 hvZUZEPCu_zN3_JaHcZMcsZmgMBd5Ga.ixGZ5Q06uxH3.pc6tYTlgAT2uSGq.c34NzombkWpgYm_
 D8CTDMybdL8uwEZ4Sc.QptZ2hOXFog_op3kq9qwQ9CY0MpKGydCmBg_bdGMEmtrslqwftyb_Tous
 SDReLjq.e8SGCe3FWpHIQEEp4xZVGSg8fWFSNgv2dFcX7A1pyEWbl1a47aSwjPfPIB5S0EzbIvQG
 xjAp1ApIEkckXYcZdosRh4KciaO9jZMsW33qCGGkdtkm.qioKcIGeCVn1_PtinpIVx25j9S9Tdml
 9oXdD82srB7_ktQhOXlG_db0RGz5SHXxCi9aJrOv0fE4vlX4_LHsRVhozRt.x1xFVBVxfN1eWmB4
 0f9FPpkCxERjcz_YGsA6BhWToPDdPmuy4MB.fF0RaynKrebIbvNmfx8f7BAzB_QVWXqM-
X-Sonic-MF: <m.abubakar365@yahoo.com>
X-Sonic-ID: 68621158-39c4-46f9-a241-31f20c65e6dd
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-102 with HTTP; Sat, 19 Sep 2026 22:39:36 +0000
Received: from dip84.lsn.bf1.yahoo.com ([67.195.177.93])
          by hello (SMTP) with SMTP ID be03fa672c94bb6c952363286c379f38;
          Sat, 19 Sep 2026 22:39:33 +0000 (UTC)
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
Subject: [PATCH 1/2] dt-bindings: iio: pressure: add Sensirion SDP31
Date: Sun, 20 Sep 2026 03:38:53 +0500
Message-ID: <20260919223854.13437-2-m.abubakar365@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260919223854.13437-1-m.abubakar365@yahoo.com>
References: <20260919223854.13437-1-m.abubakar365@yahoo.com>
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
 .../iio/pressure/sensirion,sdp31.yaml         | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
new file mode 100644
index 000000000..fc646eca2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
@@ -0,0 +1,40 @@
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
-- 
2.43.0

