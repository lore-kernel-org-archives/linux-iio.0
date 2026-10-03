Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com [34.2.90.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970504570FA
	for <linux-iio@vger.kernel.org>; Sat,  3 Oct 2026 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.90.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791043825; cv=none; b=u/oJnZqR85MNLevITHHvQ4Omk2aGlzkAa8GfC7DjLOHCh3KK472sHxlGu8cT1DA/pHAQKZHePtVhPBHm6m/0Pft0NJRk6g8cBFWwXnUE9CC7GUCDP3XRXR14J9TuCB3qE2AnWRYtOEk71R8ohKeogTtP8dU31jSHywmGt+Ebrrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791043825; c=relaxed/simple;
	bh=e3CCT0DLZEQpnh1fqF/XELY4fZlwFEbtVPxyc3yVSqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkVJFI0OpV9ipFfoPIOSht76WqOuQStUFoedswgI3P+aEJjondH1BuPlVs5o1FpG+EhhRRaaIYOuZ8BkcRSiN1TCo86iUXdjvu9HX+QWwLbqKisY5//Z/XrRFThpD0Wh3jmNlB/XFYGkxlSDNqwYNc0lpL4qRvg3NC0dVzdCI54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ix1Da+M/; arc=none smtp.client-ip=34.2.90.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ix1Da+M/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791043817; bh=U0ezCLIesnCu1jMuCcz6Br1sSFqhTA1WNDrJ1EmBhDw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ix1Da+M/sohsm5bnP2chYWKj3OnulYKiBslczqEYWrq7LEvNrtv0zoZJhdSlxL4SNHyCruAZ4d19wony2+ICeB0Bg3PAJEiEHAlQal5g2gI3kKI8lQN+DUdtvm0qAZSp1x+pKivEZdlbOZMGs4i38vZkZtKYMWGoK5ZJltVxle49m0pkhCztlr4rhwdau5bF/yDVPn0Y9B/QI7FAq3RmJJmTmgyhl2OaxTohyLpM+QTYgnRnjwc6EdNakr7oTKNlHMZvgQDhArWnwxRWjxlluKDcJY1ORqVK+TZcbea7QT0C7125UFMOCYZ8O33vMqiKmGqXx08rmNRRshfs3sBOzw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791043817; bh=GKI2cyBDZ/IEYh8a58X9adGbJdxOUQIKGAJVNbxunyF=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=li+UmdbP4yxIOFy0BCmgSKMULD/X4WDH4GBI6Rw9OVYVuVoWzT1A+Tm7+GEYKPfvfvsoiF/VD7ZL2qpbR5BOasRv5IEMLFGhCfDquExbvgdQykS8j4hwqGnH2KxhpF1DbRBVhN4RT5nx4LWUUPbH29xo5efFeB9r0IBTNDYd2hfgL2NXMAcRzQJH1EwkinHNBtPXso8RGNvYcLZHJEZV7egmRhabuw1kmAAW5YCE8UwmiVgDDPM15A03u650UVveu/+1kwiMUWiTaqQZAaTmRm7uCl/mGHTz8avn73z47OEmD8fQrDq5BDwxuLowx6WbJhVuNDS0xputDdYJDC3+3A==
X-YMail-OSG: _bqPFyUVM1klTkjyx7bYeXbO2jeYy4jvZyhvv8r8IWN.6ZLBiD50.vQz3MvGWaV
 yLrPSIRYNQRcKuwwg8vFx.zhKoFwkhk3QdT62ZitjkAhiiWTxYyqrQdkEajvLURaUeimcYJLcWqQ
 d1WUfcUXvF_LVUs3nuerPYR5WvKh2FPmKBCIyV9vRl08DNmVweVGce84PQTTf6yKrRYQXE1Sslpd
 z4fII0ufKo5stsa02_Y0c_9EzwTs.H7Mr86l5oXeMyBCYM28NBr0_UKxMrqOewp2n.APNis4chJJ
 dkhF295u8geiY_VRPuwTwM5b5I9o0Z0C4mK5GUEsrFDzf6evk6W0wjurrHRtDq9.94adWtEH2jJc
 OMlDO568WW7lyTo9QmUSjfYegPjj.gsM2MPgRwQnwgvjhEmMAMc5x.Sf0mDcMngYVA_S2l6Km7SW
 aT6z3kwA1UY4UXN7xDOAkIahjNQN3.BjStWzwnh.Ti8f2zOB6WimHc5hP2N17UXyaAt6FoVccNv.
 XISiy5Edu._z6IR8jRgl7RMx_lbjgv3BVjOGyjmkPnYk6CXeAvGjyeq717ru2Lqjf6ifnrPsF.Mh
 aep_oEc7AWkcDsBFCqScZinY8w5lMPlGKq.5O9J63Hm0RqPzia7q0RMj.nWw9w5RednTNLUQZh_E
 lq.lAYiVuoK3ZPSIDGEdhCcU3.aDPfVaBtf2kJuhl2dGUzxwq8tkCqySkltvwrPZrnmlru4NOqkU
 WtfyuLHq1h3EgEot_kENWu0PSFFbVgBC8QiA5xMvxK.cllk0LRwmD_j1eZ0OtsRUmBKi4SRUr8JQ
 NjtEx6sW8YBC_jxs8CFYzoKpMF4jObIgitQKCphE013AHeeQM58jmSng5kNvNK0kXudDJWQ1cg3x
 5gLjzkfdR8cM2Eg6j_A9omAapWLeIEzn3EVSfAS8nINkriWhSFHnGwGcU3VwDAzpJW5w4kIx4n0X
 LgVwcMylwCVyX4yqAGnB4FW6wpzfgxn8biQCDuVx4afrkkt0AQLHblP8cgsuSY8.S169TFEwP9OO
 lBFejvdZ3wSWb84SlX8MnGi7jIMRyDu3A3T.cu8xtGSehb5TK1iZ6.og2WE5aVTvI091_IU_FGI4
 e4cc3vsR_zOy6OKlrZnvefASWgj4XGGJ4FV4FqobmTiXTcUXbclKvtekYKfG4KWNPhaDHehvOO4z
 LjeiwtDGGzn07wByNWemt_looNX34CNT57qMYC.YAL7S_OZ12GsdrXX4FGF8ZwFNpeDCbPlj2Tqt
 uDOWwCkTo8plklxS4cpml3zpFZIuWMfuYD2dnI8PeIQwRffrq3eg62VYkdf4vRDj0dRtPmZ70tzX
 4sbV2YnggjbhbmnslF7g4kC2jkhwjO6oL_DvwXwUFSlAeggd1TbICgkf.d_QxFxTlOhW050ZsUhT
 I0kLceBlvkvHmFk9PiIN5cwT9ynu69oOsmij9k4.Yx49QtmP.AR3aMKDJDvRYaQoP6fW1bEncyXw
 Of5M9RMEsVwFT7CcHCf2eSeEB_FQuOCop23g4NJQ42i6P2sj.Gag7BOjMsr60rSF.brIMmO.wGWA
 Jr987xEUYV7qw.hqJ.kycGYrLz8hvkWycaWhzwQgYZRGhA55Q6FyUnLuRj2ccCT810H7ukDcVo1h
 p7kDQLqpr_mLnQdupF.zKckumwavYLDpGBoOaTOYepkwima5mDw0zM1SSbXYiWoEk.n8dwW8z65M
 f.CLTEg47OOD2w1B3ltuijKZ0t6w0SX6JRyMF9lmd.B3FMk9fzCbLnpzEJjEQvHPu7qbP7QgWViC
 otwj0x.tn2vN7KEdJqBN_CpFB0f.STAGw2OcPp.YVIDV374Gn8G8wt7lP1HonudYft1YRxno.PkT
 RRZFZgbognYk8KGNLZHTx2OqIrzOs2Rq5pKYaKjnhiIvhOkYl1gWmnKCmSp356JEd7fM9hWmzYxn
 oubyPm3mNbLdu4ZaNNzx.oio4q2d8KOitXnkW1MILIxG7.qU93ZYV0y2Qi5VUSHaHJoNSlUvDP1x
 IdtjK.0yWRtq0Hmuz8loahtPgPxhsC1CNG0PC.x2nz9EKsFvcXsh3i4Y2KvZYyMIsZDou
X-Sonic-MF: <m.abubakar365@yahoo.com>
X-Sonic-ID: 07c6ea70-02b4-4506-9fb7-7b464a9fd1cf
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-102 with HTTP; Sat, 3 Oct 2026 16:10:17 +0000
Received: from dip88.lsn.bf1.yahoo.com ([67.195.177.97])
          by hello (SMTP) with SMTP ID d1c6d9a7cda80a7ad7051028df1df544;
          Sat, 03 Oct 2026 16:10:12 +0000 (UTC)
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
	m.abubakar365@yahoo.com
Subject: [PATCH v5 1/2] dt-bindings: iio: pressure: add Sensirion SDP31
Date: Sat,  3 Oct 2026 21:09:48 +0500
Message-ID: <20261003160949.4657-2-m.abubakar365@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261003160949.4657-1-m.abubakar365@yahoo.com>
References: <20261003160949.4657-1-m.abubakar365@yahoo.com>
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

Assisted-by: Claude:claude-opus-4-8
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
---
 .../iio/pressure/sensirion,sdp31.yaml         | 51 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
new file mode 100644
index 000000000..ed02b639c
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
+description: |
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

