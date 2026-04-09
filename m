Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch [109.224.244.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E26336E494
	for <linux-iio@vger.kernel.org>; Thu,  9 Apr 2026 21:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775768882; cv=none; b=mwSPnKxBxJdUjFKKYW28nIBrPJKIRNyqg48EYYGT2FI4O5wCND55v8jhK5MjmdoDLwFX5PYy4bk0fPGFfpix0mEFS8sD0JxdEhjHwZ+oFg3nBSvFAh9svjO79a8G2OUbTd5lYDDF7DTDXGVGqy1GGc5EqXm9fW7kB5ITRkTGL40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775768882; c=relaxed/simple;
	bh=1pxZBrLmy2pMWIo0LdsENmdYtsvl8jy8EOqABhANfgE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jawyT8tdhDC50tBsS4IZN+G4Q/LScPgnwLAW5PA0vljgad67Cuhh0hZk56CN6WXbXpNeDEqxRLcldDsyGFMKUR4JRiY6mSoIrdgh6evKm4CgCOMIbD6pGJGcRR6HHGNUivtWzi2I6wciOxRHmWHA7Zsq6Wd1QMk1KGWl5BVuAqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=KSBHuaOe; arc=none smtp.client-ip=109.224.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="KSBHuaOe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1775768878; x=1776028078;
	bh=1pxZBrLmy2pMWIo0LdsENmdYtsvl8jy8EOqABhANfgE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KSBHuaOeuOGUAYf9I+42K6s2n7ZmMStQOE0W+V48xxOm+3NFiR22Ff81ZsLT6Z/+2
	 qkeQtrsEYU+xt8U/LSLc9wKU+DKpPZRw2G5DDzDpT/cP7d9Oj5wVmhT+Ib2AjZuHXm
	 uwkh55NmTkg6qTQWpJV/0lQHlSlYmNCE7ESFnJHv7k8NxJE6ndYcov7hbcKVkD6Yi4
	 dWzydMIzHwO5QjOsBQB3tnpPW17Z1eOC2CBL85qlQBBmEFgRPChL4ADX6UB1LCb5TW
	 P8fJdl2vXsECCTmYCQq2+X7KKnaWiuPJAX4tMy39dyDuhBwaE+5qW9/qObMj631Kpv
	 A1ZkaqBPCqd1w==
Date: Thu, 09 Apr 2026 21:07:52 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Brigham Campbell <me@brighamcampbell.com>, Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, Hardik Phalet <hardik.phalet@pm.me>
Subject: [PATCH v2 4/4] MAINTAINERS: Add entry for QST QMC5883P magnetometer driver
Message-ID: <20260409210639.3197576-5-hardik.phalet@pm.me>
In-Reply-To: <20260409210639.3197576-1-hardik.phalet@pm.me>
References: <20260409210639.3197576-1-hardik.phalet@pm.me>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: bcd1d8ec985241d919eb7e370ca903db6e73bbdd
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add a MAINTAINERS entry for the QST QMC5883P staging IIO driver,
covering the driver source and its device tree binding.

Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa16..d0b9bfceb283 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20274,6 +20274,13 @@ F:=09Documentation/networking/device_drivers/ether=
net/freescale/dpaa2/overview.rst
 F:=09drivers/bus/fsl-mc/
 F:=09include/uapi/linux/fsl_mc.h
=20
+QST QMC5883P MAGNETOMETER DRIVER
+M:=09Hardik Phalet <hardik.phalet@pm.me>
+L:=09linux-iio@vger.kernel.org
+S:=09Maintained
+F:=09Documentation/devicetree/bindings/iio/magnetometer/qst,qmc5883p.yaml
+F:=09drivers/staging/iio/magnetometer/
+
 QT1010 MEDIA DRIVER
 L:=09linux-media@vger.kernel.org
 S:=09Orphan
--=20
2.53.0


