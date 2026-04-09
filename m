Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7683E1234
	for <linux-iio@vger.kernel.org>; Thu,  9 Apr 2026 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751849; cv=none; b=VBep7C8dCYWxexoLCOp5hn7bIEwmh+Im+jTu+rMbsKrw31XULK8PHMujMO1Dz6CicQJ8HAvc+9Fk4XQ23EnrnvKY9Vl5b1myazxN/VD+V4BJ7onGK81Epi4EvlZ2fEYwYTsjz6ntu9Dmfliy+hmfSg2dUGkYuwpWGpnbxuVo79Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751849; c=relaxed/simple;
	bh=rt69GKfvtm6r7L6ZdS0LmDtC2CKxY+kKDxYTToslLME=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0FCEIrgEuS89lmnIGRq3r1JKkv9kcyRC0agHmDjolIsWcyTQt2T93hiNGWsK9adM9V5ljpCRTKxZr60Uwam4bIuKcGyWeRV8IxhV/LLnXe2VhHcmT16Amd5BhlCpkEMGLIou3gph3iAyR6N69GAPcIkAXDNtfCpY6LUrHNcmTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=TLvXAfcG; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="TLvXAfcG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1775751839; x=1776011039;
	bh=W/g6MIBZ3+LHjZsDhg8NMVRAvD8105CPrmbxQAoiqUo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TLvXAfcGlUIzXKBLeb9f6W58aVdB+B5MkHrgh9D0LEucpZQNAedg4X/04HPssC1LA
	 f4NwweZkCfwEC7Rwu2wdnJHr53D1OaiA+3pTLfepcoNFje6YFtlfn2eoDeAopocMPD
	 pf37+m/O8mktsO5fnEs1OBg8Ld51Qq7UX6Tkobf2DM85xEEnzsYlbPmeUyJRj37qK1
	 Z02wrzBNZ8oOxo27+rgHcPtp+nxFlPXwiI+GHlw6sOytfzNTIHhA+HyQm/2h1kxFXX
	 ksZnV8DPWqUKrott8saTU9oPXWc4UdC7tO+ZDYFOGRmxYUY6hdmOsMz5j5/JKhFivl
	 aoM4ShiSx0Ctw==
Date: Thu, 09 Apr 2026 16:23:53 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Brigham Campbell <me@brighamcampbell.com>, Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, Hardik Phalet <hardik.phalet@pm.me>
Subject: [PATCH 1/4] dt-bindings: vendor-prefixes: Add QST Corporation
Message-ID: <20260409162308.2590385-2-hardik.phalet@pm.me>
In-Reply-To: <20260409162308.2590385-1-hardik.phalet@pm.me>
References: <20260409162308.2590385-1-hardik.phalet@pm.me>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: af7bf9a7adb12b7898c0e4fbd07ebd168d8a52a8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add the vendor prefix 'qst' for QST Corporation, a manufacturer of
MEMS sensors.

Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml
index 5d2a7a8d3ac6..71a1b9087c5e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1244,6 +1244,8 @@ patternProperties:
     description: Shenzhen QiShenglong Industrialist Co., Ltd.
   "^qnap,.*":
     description: QNAP Systems, Inc.
+  "^qst,.*":
+    description: QST Corporation
   "^quanta,.*":
     description: Quanta Computer Inc.
   "^radxa,.*":
--=20
2.53.0


