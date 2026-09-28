Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com [34.2.90.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F111501F59
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 21:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.90.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632501; cv=none; b=r7HvgpoiyWA5fDgSnvw+V4DqHxUP1ZmlSIbgcV/ggU1sP3AP/Xa8/oJrhNhC7vph97RWfHLDpyKKrf5Mxgu6kZ7a9l4pe5vmbIroYJMBFWHfhJMaEPK4kbkuWbSCOPYJrxy+XKYmFCXWDrNRm8r2RS/x5+E0WVL7ldbNuGGYPYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632501; c=relaxed/simple;
	bh=Komoog6TYgMX1whg125zQiuqj15A6X20O4F+jidyd4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3KKH79z5+hrE0FwGccTaTAzOBTazZZxkdi/4543Aeh9aPkfdABh7fqokiopf7PCR842yqvoNGPY2x5e6m7CnhDZJDruFIF8O9GS1LCyRLk0hXg884x6UaMO75Rpo8bCeQQI7wB0dFULMuQbbRz5lio0NXNHbk0bvFwggKUfF/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Vmeom0lC; arc=none smtp.client-ip=34.2.90.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Vmeom0lC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1790632494; bh=8X/nHPNtLDClkpto4XD1s9AiMt9qFAbF6BrQ0an0Qps=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Vmeom0lCOX7zC/jYAMjJqgksNPy/UFsAE7c4EczPO3tbO4Yu94CW4lEBYS4pVsIVYHJNN6xVVj2VLeR/t5LxtCgamWUnqAtgjKEkXeaVQ89O2gbQe0wI03Qo/G9Mgc9Gbu3N2Q4i7IfsJD0DL7oOZXmYo347EZ1A+5k3aTKlDdWtlMYj9wO/TS51/h1GAHQTO6vRlcRrEBFKUL4GhnX+BWaZFSk0spau5L5G52Ei+4zR/TzVYFEeQIF9elAfF+CQpwUQDQO/dvmtlhy+eDX8ZQiad9DYUqaVRI7Ycc/C/zscAbYFpgPPZO04E1hXas/XTFlmevc3PmXYOcvlaLY5dw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1790632494; bh=7YT1J7Klho7p2qElldPc7nyUPAFFtY9abEBXnKXmRwP=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=JAPgPPz8xEgkTalDIA6rAud+UDxPFTjNWrIf6+k8jkwHzYJfCqesY6ljEHZ0B1zNigosixJain5kCIF3KVyRq4iiQq7iv3zuJcfpVW8GRLcXQpIXl4ZR208fZQc7uIEvAuA+BSxgwHwP5gVDpGCvoFvSldguFWpezAxgAQOOMay1JSil0F+fvRPVsL+DsIjy7TG4QVScfOYxp3c2+mAtKtuVLRVqDn4IlrmSL1ADIdB4KokbsHwtAoqaFGdfvRSLazCMaN3wkW6h2LCVS8NcYfHoMELLxAao+SE0Tc2dCJ2sOVMV2UjDH4TCdeFM9qmlDHpCQQM8hKCJIWxy7VPYtg==
X-YMail-OSG: g5sy_UcVM1mYvx0HnzEsYvD7.NKCEzfXRiPUzR2LYHeXHDYBn.Ogln9e.n5Xo8O
 YG0bz1ukqWIuSO6.xV0ct_6VfcqXrl0DP0wQA7nIreIi59QseEB8Ia_ynhktU3nIXLxxdj9bcBnk
 vc7ljb1JHijMJJ_gfUV3k0Yuoi.LsGtsHHsdAQnydeda3GiEDojnqGMkvCHUPMuhU0YzUUXVGgHB
 lemj2_jz3ti5DMI_p459ofHgFXlz2iKg6aqoiOfRAU8tLEjzOCXnRGZjYXjP.A6d2ya2I8vFlShs
 JV43tgfSt9oIy5aqRqSI3guuf36NMHDp0ks6ks.D3R1JUszCAFiI21NiAY9EF4j1QBH.LrR9ZScp
 Yeu8tFgtm9vb3h7gHnsZvZIyZ9smcTkj6mH4cyvFczzIk0tvhg6jXaBiSyFCtDuqPeywrYA_K57o
 n3DzFLA2EbanMDR49wLcicLviyjG6bczsmyGlf8XoUdDQ77JuynOUz.x0TLSB2P.9B9Xr2qyPMyw
 cQYuHlGxfWLJvIdZjH_w5cLK8ZElcJX7cI7nRLXsW38oek67liDyiSb9bw_K_KjJaYmXJwJveA0h
 aU04DEejvbnphB4vz_5DbuTt0PFwzf9HSKwH_vXWj.hNdVQrFTqTcI5GidWxuOj_HqUcBKpVC8Z2
 6qcWo006Cwx_8q33vbk.w38HHXIpSkMPTdVKQluMNNw7UL26vvWXJKXTVRGjoGJndCy2G0L0CFCj
 qcCg2VBuSmZK5gUJsoSsWYv_FgxZRP.5Mrlymnkc9GwHTjabB1jVx725YK3uwuD9jQmSlOC3h9qB
 kGUoByFXnQ7RkSJQLGy.iIkhsz5YL5D4fNuNr7Em4zamS922zZBkq3Ndwx1bPYNNU2gXi2X93aNJ
 ail3GIRPqi0lMo7BNpFZ6MiKiUztAEJ8jEqPJfNFISvmZ9LB86xI1_iuWXgvOdqo8drHSVqK9IK.
 DHMJKk8rS7Cg_JRKLOQfTfsid8c6PZJyfGJemRCZs0z6k8xOf9hWzSv546mFH_La7Qzrj2dajaif
 sovfqqP3A6e.5qiXU9fO.ku6Y4hfGgphtLjIJIHgu_n8W.lhhaWbUI1AtTfH.d69EkLHrB0ocm6g
 .CLb8dlEbuT2wSRaMyfurm5nELGdH_8aDRu.adFEiOVtxX.gqZahHA6NyomiGMxGkXM5K79qmVvX
 eVR.0naICfedziYp1xNxlOpKwzRmwIfQ8IrGYl8FETD8Xp2llNUXC.SRmlMENR6tUB1qVjndoAfj
 0zdAKiiOE1TgJnMk.7zyWUpW4G7B8sEaCk_J3k47HHIokcfOrqM8NXFBWLE3CDYS.I8_FE_D8wop
 b9kIgcBtflWHq1DQAINZBKZ9abSzuRQNT2MNFNk2EDlvp2deKiWSq9Ek3mR_YbUZ_oSMugPaItB5
 WO6.bOKy.wZyLfrXW3pasT6Xzl6nmZhBfAZO5tVKDVQo7PN_PfIThi8O9fZ50hyu4osYY05tf6H8
 KFdp3DkE9KCmJNKO9V8RK6Uw.SirLki7TwnFYwxjrRSZxh4l7jN1EIkPMDOX8MbmYfkL1654i5Cb
 QOm4Eyj7RtP98cE_uSoWmmrX_cLRIGu4pWXOmoEER0FNfpTzDzBvh7ngzmAX8YOpuAdmkks_zXQU
 vIXlryeesKSSmFUJX2oiz.tah0fvMoyP6M_2BWDO5sh21KuMRQQVGihtJ2z8h1ibwBpwH4C9b.N1
 MzT65vUxrVmxYWyVwt1tdUbY35q4pW246M3AVEpH01o7JG.JbJwo7E70fUH2PACw5ml.AiJU3mn9
 kcVOH2EfrxwDiPpB9Hs15YKGDXN9bQiW7X3Ah05Q4C8drv840Fv8Nf466YYfaoOCJr3CF_VtPt7E
 og4qxNyhxe938zjbS494b9ZiNDUEMb.TSFOTjurII6SREUonWfQjQzx6IyTRMrKH0RCl802cNGIE
 LZo6_GK0FHJhSr0otGfSenlJK6KUqJDynuR1ntIf3g5xjyGYryrR.Y0A0QKuYDsO0TJPxvRJkPOQ
 R0j4vskfso_iw5_ilZuObf_90ylx8pzdx5t4LXKgzzHCpRzvjvkXUE1pwxU6kKEOziw_0uA--
X-Sonic-MF: <m.abubakar365@yahoo.com>
X-Sonic-ID: f54ecbd7-ee7f-4409-8674-e40419f81f64
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-102 with HTTP; Mon, 28 Sep 2026 21:54:54 +0000
Received: from dip75.lsn.bf1.yahoo.com ([67.195.177.84])
          by hello (SMTP) with SMTP ID 76ff639862f4e2dcd2f1f2eb210a11ab;
          Mon, 28 Sep 2026 21:54:52 +0000 (UTC)
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
Subject: [PATCH v4 1/2] dt-bindings: iio: pressure: add Sensirion SDP31
Date: Tue, 29 Sep 2026 02:54:21 +0500
Message-ID: <20260928215422.3720-2-m.abubakar365@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928215422.3720-1-m.abubakar365@yahoo.com>
References: <20260928215422.3720-1-m.abubakar365@yahoo.com>
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

Signed-off-by: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
---
 .../iio/pressure/sensirion,sdp31.yaml         | 48 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
new file mode 100644
index 000000000..b9d3c6441
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
@@ -0,0 +1,48 @@
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
+    enum:
+      - sensirion,sdp31
+      - sensirion,sdp32
+      - sensirion,sdp33
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

