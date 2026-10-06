Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519FD472F83
	for <linux-iio@vger.kernel.org>; Tue,  6 Oct 2026 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791300782; cv=none; b=A6IGwPdq3MUyOo63gdi852gEJWgIZ1ejFWbLPS4ykxSwJX3I72LwF5CZI92Ki8HvbpnfNcunvHJpK42eDWmQzXb4I7lsZfcB4dyFN1sf6/K8R4DW96ferh9Jgp+gtxNVCma/nfXQ4ic/+cKcAumnIzgklfUMXgK5TC3ThFYhnNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791300782; c=relaxed/simple;
	bh=pGX3W0MRdyTf2GMyjlwEx0j7yPjZCPsNbK4qBRkR0wM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4VCODJ3mf4Da7RtClWh1yL2zuKRNeJeYebIbE4W86YrreyMMwGNRvmwIXMyG1LYydzTmGwD9dnAajU7HnMUrCz/xKWO3xeC3ZjtTSBgk4/jvZWrWUoB1bRXYFCTbnOdZ38SJj7AyHrjM85zgJWULcq7zdhhIawG0Po0Ar5hrAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net; spf=pass smtp.mailfrom=arkamondal.net; dkim=pass (2048-bit key) header.d=arkamondal.net header.i=@arkamondal.net header.b=C1XCVq09; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=bMgP+CCV; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arkamondal.net header.i=@arkamondal.net header.b="C1XCVq09";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="bMgP+CCV"
DKIM-Signature: a=rsa-sha256; b=C1XCVq09AAzEbkLJlD1rcsgEiBRIJQsOY1JK8xJfuYZmUpXCxoRc2w+t+Fl6XQHGAGdFReBaHk1jp4uNKb8e/hJJSDbXlOoXo99rNSJ0XmPijzrkagGdqpv1FanDDpGsIQEflBhMkmII3nE3lQEprOKF0ZDoNMuzwOF8KBEnDKtY5xJ7k4WfjZIIgZJhWqb1+/DF4LUflcpM5uv4mQLO5+bfu989B1JxdtjeLsDyjQKOKfkSll0GGU2xpYpXPFZGKO7m9mFcDUUZun3aAROVPZJ+ImrB+qjvp/svbnamdi2WKgJHfBYjJt3TrgQpWZM0JUrryB4FAztcjag62An3jw==; s=purelymail1; d=arkamondal.net; v=1; bh=pGX3W0MRdyTf2GMyjlwEx0j7yPjZCPsNbK4qBRkR0wM=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=bMgP+CCV58Gzne0LVrKmyCPdEXUrVIZr40e/V4D3sHo7zoyRmR1kyB1WvlHZPw79sNGAjPaKR+OTWlaCo9Pm4lvhNQ02cTot0dZWjLo6AMEJnGWnUVI4pD46GDSFeQKWUjbnkuQ/l3WRLskHkimhkIybtiAsmIHMexDeVNA844U7unCO3GLR8FE46LfMk/bo7iAVcOA4jWlijyk05MksCl3dBOxTCc4/fqwcA29lm+0SAGdWabdg72HOe6ywZ6D5GUWgVffte3+XSqheIyMrByursWrLJh11tlZoZhzoSNXFDQEegwr7dvM/mk4hwB8HWAKgVqNp7+VX46EvHtovSA==; s=purelymail1; d=purelymail.com; v=1; bh=pGX3W0MRdyTf2GMyjlwEx0j7yPjZCPsNbK4qBRkR0wM=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1246644:48769:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -836610108;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 06 Oct 2026 15:32:31 +0000 (UTC)
From: Arka Mondal <arka@arkamondal.net>
To: Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stefan Popa <stefan.popa@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@analog.com,
	arkamondalofficial@gmail.com,
	Arka Mondal <arka@arkamondal.net>
Subject: [PATCH v2 4/5] dt-bindings: iio: dac: adi,ad5758: Fix the 4 mA to 20 mA current range
Date: Wed,  7 Oct 2026 00:32:09 +0900
Message-ID: <20261006153210.364862-2-arka@arkamondal.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006153210.364862-1-arka@arkamondal.net>
References: <20261006153210.364862-1-arka@arkamondal.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

adi,range-microamp gives the 4 mA to 20 mA range as <4 24000>. The
values are in microamps, so this reads as 4 uA to 24 mA. The original
text binding described <4 24000> as the "4 mA to 20 mA current range",
and the data sheet (Rev. B, Table 32) confirms range code 1010 is
4 mA to 20 mA.

Replace it with <4000 20000>. No in-tree device tree uses this binding,
so nothing in the tree changes. A device tree that still has the old
value no longer validates.

Fixes: 777baca07ef1 ("dt-bindings: iio: dac: Add docs for AD5758 DAC")
Signed-off-by: Arka Mondal <arka@arkamondal.net>
Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
---

Notes:
    Checked with make dt_binding_check; no relevant hardware available.

 Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml b/Do=
cumentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
index 5121685337b5..a0f2649129e0 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
@@ -66,8 +66,8 @@ properties:
           - const: 0
           - enum: [20000, 24000]
       - items:
-          - const: 4
-          - const: 24000
+          - const: 4000
+          - const: 20000
       - items:
           - const: -20000
           - const: 20000
--=20
2.55.0

