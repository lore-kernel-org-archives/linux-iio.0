Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCAA3E0C74
	for <linux-iio@vger.kernel.org>; Thu,  9 Apr 2026 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751878; cv=none; b=Tf6Y/8Gp770qA8ppJoYmWBip1Z0CSu4P8zgAP9mFudnTuUCTv2hb7RG3w6J3cNvr+kAibeVpu2FWOnsY0h3uUiC2FwvtUAhRcND/A04IfRsxoy67FNxXVimxj4Xd9jXRVhLowfAYQ7V+it1XWcbvwP7e1+MoScd2EVkhPTbU/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751878; c=relaxed/simple;
	bh=1pxZBrLmy2pMWIo0LdsENmdYtsvl8jy8EOqABhANfgE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYueetRbiyNh1dKfCxRDZfuktYoY4DFiYrxPhoT1Zv0rg6uuO6UO0dWc1UQluIUS3/BbWGmoWeteFMgHjqPF+5KSnP5i9g5AQMIKS4GC0khG2/kpapeqkgs4RldIKqhXTqgcxLmXtt6BvaYyrLav2cPQsHNMdOuXy/RdEEoWk64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=iRToTGEC; arc=none smtp.client-ip=79.135.106.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="iRToTGEC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1775751875; x=1776011075;
	bh=1pxZBrLmy2pMWIo0LdsENmdYtsvl8jy8EOqABhANfgE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iRToTGECnVE+8mvp2PylT9VBlBWBKMJjXAgcYtlTlbO5Mm5I+/1nHDD2S9Oh8e4ac
	 rbHnmucn39RU3PveCgaHiRTWygCvfh43J2km94FCqkFSreqdtphlB/TQAksSr26aej
	 p6g9QToDUQxQKm2yTMW/z314tUqJ7sRqtZKG01mShW1BW7bdbiOVbM6PBjVJCOB6wu
	 WL1dyxVbgVkEXLVb5yqYjhgcjPWa/02x2ouKqvfMfrnxf9EG8GIQUKuJZVIjV0hlyd
	 1ac/8SQ9oNTWirsIufvtt6ps6LmlG8f9z1+kqbOADDhl+uBR4n+2S6u6ybL2iI1xsX
	 JGwceMQsaKv2Q==
Date: Thu, 09 Apr 2026 16:24:28 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Brigham Campbell <me@brighamcampbell.com>, Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, Hardik Phalet <hardik.phalet@pm.me>
Subject: [PATCH 4/4] MAINTAINERS: Add entry for QST QMC5883P magnetometer driver
Message-ID: <20260409162308.2590385-5-hardik.phalet@pm.me>
In-Reply-To: <20260409162308.2590385-1-hardik.phalet@pm.me>
References: <20260409162308.2590385-1-hardik.phalet@pm.me>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: 2b7baa0548efb5feb749682b4d124577346ff50a
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


