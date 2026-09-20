Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com [34.2.90.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E0146D567
	for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.90.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789922905; cv=none; b=Xthew8Z7pMuz7ZvHr7EWq5lVxWyicIq9OOuchrXChDKGXvDzT15RUHQLm2mDRhiGsWXQ5TYoRdrRjgrNaipRNVPxjYjkUMccKk1E05MkW22P/UbU2O5Zns+pgar7VbNQyfofreQYIQLi/duWBNUyL9nU4muUOUz3YqZGhpIISKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789922905; c=relaxed/simple;
	bh=MMo2tU/uFTcuGLaeRQMSBsciZFCzKetL6uMoGpvo8vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eE3I4Frx3whr11D9EWqNpwjgkhZHhQHlQBVTuF50A+2x6260V/8p9wsPQR2NIgdxKOdPUs4zIqbwo+noi4899+9kZfvlH+q/Cl2sFBm4YdBmvSz9nlkMginFbppWzGUlZF7QkYBKjwCxfgQmqJKFD+QgQv0qmtwSmxfSN8xhrzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=J44/Ly9w; arc=none smtp.client-ip=34.2.90.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="J44/Ly9w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1789922901; bh=dtbE9rIWnBabBb9zh2Iq6Z4Ip9wNcn5qrngxLVRETZo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=J44/Ly9wczaoHMAQqnP+BxsJIYN8fX3uQ5FG4vPO64p0jQbA9lF3Tpknr+wzJEl1RFNtHDsJC+xlxYaTKgI6junqPuEsYnmIYVsbkWPNL4yuclFwVlV+o7AdicdTUlJtQWlQ8/2/hkhkD5fQYcDkyorylpb7QpHSozrk8OUUC/wO41uVDmer6LEY2gWmTsZYF6W2T739mJLy+SisKk3D1u3mmryIEeXAJtLwxC4C9CGioRQaEFwPiGobFu0D7QjEE5IeTQLQXIyFE78K+Ul2EiO3GVykahnwxBVC0G0gaQ619qEpqc5cDeh/bLNRhb18uITx2reMeklH8NefkcKIYQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1789922901; bh=XePQYKTxjfr7S3OIXwjGe8R+h7JMcpalhxn7hJWilu+=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=buA+jxxPPlu0RlJ+Ar34Nc5yY7WHI04q+um7MT1eP6bD4iUBFB7YHqMAw2Y5WRx2CmOS/WnudstmTB4dtS1CulkXm+4DdtWhOMmW6ZXZ6Cobq/hONx9/U05ZqH3iaKVjVdgc+gBqgMS+pFmPWcS7BVdG+BtGuxrsZ+qiQNKp91zpFPgsPiQl3Ur/aV8bAkEwXgmTSI/AEQ2wUdMfw48KMZEbi8qXmfujC58Z6fEdHJg8Npb40oal8YocCQVqUwr7vR1gyjISIudWo1zelBRVAkLayvDkUViWGIRJNNXCsjXGgp/9khnTBOtBoldnJGLFIlnmZsoDtobXQHfnhTdvEg==
X-YMail-OSG: ttRd2FgVM1kk4Sin6RBo.AtZqxCEaSMVSiPz8bQbXOKqtBgdAwh415x_5biJfq2
 Il1g0WKVKxr_XGZA_brHD6aSnPH0E9xyXeSXr0Z3jzQdUf4h6goY7Nq8oj0B8WmL7kfG3ekBAXzz
 7J4WERGy5zOmDkZqLPhtPT22THiMRdQWGESCel5eTdQe61BnIAAmRonS5Nbkp4NT.bRgV_2qsbnv
 c3DdMP6k5hPxOfPA.Cou9at30jv6rQcWHbg1vHmw.guKQzyUolIPt2t33sqWlMnmKFzQLnzoiXkZ
 AB.vyKAnNTW.FGlh6iAQF8BwFscd5UubsmeZ4C1lHathZtGM.zZjRMvrNBossFkjqDOLF.C.fNM7
 qx77I1gaDt.shZeVP1I3lePaKML4TWYJVo2PFyKWQo3sW5ZV33AEcb0bEcTQtUknDMyznrVcjXw2
 iS.EUblIBOQpNqa3bPkzw7AdAkAK5VY7WwB3qZYJmEnCDkAfzXVwIn.390L97P8xkWx4B2xif51E
 TyUrWitcHmf76sJCd3ztZApHQIElqS3iHnLW8UPJNb88X2KVNy9yFldhNgnYRIoTW.nfnxpW43jP
 8X7mXbAzVh7LX1ayVsxlKIAZZ.MDvw9bBW3JRMEkBo1hjs2CEcbT4RP6bmT1k1xw9nnKGYhqcuxG
 mT6zWUTB9awyebjAJhwvEoTYzqa8rTvXLzRVC1NHt0rabvWjMl0W3hREHQxNv_bFheYfGH673dle
 VoH_KDBs9Iooa6XrF7KN6ab.sfZcAV2KaVT5CtdgiW8KtLE1XMtvD6MXjBeYhHCAADNQBwv9UmbW
 iXxcW2k5T6kp2Ri.A0C_n7IEWgc5ORlfqzEZ8UUvjyLXY3KMTjtFHdpPPmqfR1Rcza9lL.JyWKoC
 CuEfQKk.bgG4TgRJRDnFL8pLa8mrwt0Hi93A0vSsOPulxZrQ7U_pcIwbEuEkvMf.nZH8.eFlT5Su
 yj6.oVbNgXrgiu.AGx.jY3rbb7JETc_TjtwpUpRB.8OxI7I8tvkJT2MGLFY_atDKoHoDsENlHtGX
 M.0vrpCBvEtBDtK.1c2RNnvvdsQ6CbFk340gAThP_5PWF0kDZvOORzd3SakkPOfx.YQ2ReW8yIKV
 e4xa0CYjF17mzpksMxJpNXrKpiNAAAwXu.NMivekABymwEKGxjxFH3XRqBjtXQUXe61WK8aenlj8
 kXVzig2fX9Uxeswmzi1Jc3UVz8_RuKaVvyC2v.jzRoJ5AKosP.ZoZ9rTaWZxMiWghzwtexjYZKhI
 Igs8TcFY6ClWTuOJp23d9Kg.q.smJb6uhm2H8DV88t2iKDVgvYH0AWLUwacD_qHzEI7Qzhj016DH
 1J0NKkaymsdWyjb.jM4ts6NWUPrjuuyVByIn1Ha7GkGU7nsKnHdwg4JctSMJ7j6TcKZ94bYG9Tk1
 J5RDhA6Bwu_cOi2FbUbG1CFnbygBzpO4ntObxnUcbRnQ3kCOblnl4_gtcZhKyUjCeJh9fTHPJNie
 gFxaqbPR45LyQeCzPOGWqip5ab.BWAdhbnWAis1oCIKUvMyC1IqTcvvnX.R5PgWXsjvDZ5Erf71P
 fi4cZIDiCNQIc9JIThP7ptIwX8MK8H9ENnzUyp9nkmkcLyvpHrXmQtqN3acY6NsMVx4kc4_r0LDz
 dusg0A4K6fJ7JENrdM2dAwirWD5oWX0HAx8wpHV7OuMgsn_OkdAWPMTv1fYC0qjnr_25Grt6oAJY
 beBv0japV2V29s3uhGC396p4URaAOpkc6VH8NlS5E_TFSillRXFUiVu0JGaleDsPs_cEoksthzN_
 CCT6TF75XS_eLS5eetp8zIM9QwBmrvdAQAoxN.p6uRYaJshfuBdttoV6bQJ3XhvoSdfTYFTMDHkH
 qpN9440byegy.tsflOvscvxvlc6_ZBA16q8ULN8oEQ1S75kHgyvgN._IFGctEtDNR7S1Sjp9BW3o
 MfHk1ubtu0nDeh8Sirtz87GbLgLT6.rLA74Cj044CLgcaWQ6EeeKuo1ZjhpvMnGrIdrsbC3TsuZy
 mTKszTkiLFbtFW2_WwMJJw0kWWck9NQvm5ep9XFECUdD9gkaE3mSRR10dOVwzOc2PKr4S
X-Sonic-MF: <m.abubakar365@yahoo.com>
X-Sonic-ID: 7a11ee8c-bb38-4796-b7f4-30470e453cb5
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-102 with HTTP; Sun, 20 Sep 2026 16:48:21 +0000
Received: from dip55.lsn.bf1.yahoo.com ([67.195.177.64])
          by hello (SMTP) with SMTP ID 523daeaa0215dea57efbd4c0222e20e0;
          Sun, 20 Sep 2026 16:48:15 +0000 (UTC)
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
Subject: [PATCH v2 1/2] dt-bindings: iio: pressure: add Sensirion SDP31
Date: Sun, 20 Sep 2026 21:47:23 +0500
Message-ID: <20260920164724.32019-2-m.abubakar365@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260920164724.32019-1-m.abubakar365@yahoo.com>
References: <20260920164724.32019-1-m.abubakar365@yahoo.com>
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

