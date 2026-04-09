Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196F634E777
	for <linux-iio@vger.kernel.org>; Thu,  9 Apr 2026 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775768854; cv=none; b=Y+SHiYjMAebrMe3aLYxYN9okkdXsW1noP53jqEcADw34w6EaVFggwdc9GeTZBnUbui7hRjocNfc0vfL4aO3P39PjFX2VuZ8xQgXiAKvuvJ3/zQgnDqM+UcxAu7EzBNubqaWudjrJ6DiVcJ2EsUVTuwIVr7PZKY26/irboA01W10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775768854; c=relaxed/simple;
	bh=rt69GKfvtm6r7L6ZdS0LmDtC2CKxY+kKDxYTToslLME=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhpeiklFUH0pwrVIPcs8cG7y/pQVb6ZuzvsTVq/61Xx4a8QDDklOu2IOYSjOQlzOAwAh/uc7gnj/Y+oQkxrzPBktwWOOlpeCiG/DZNbc7W78t5kl/2d99nJoToWI/o4sMzi0jdgTdGcQ62H5IsBeNmCB8/FhkSrggoCaFKR7axk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=h34GJ/ag; arc=none smtp.client-ip=185.70.43.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="h34GJ/ag"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1775768844; x=1776028044;
	bh=W/g6MIBZ3+LHjZsDhg8NMVRAvD8105CPrmbxQAoiqUo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=h34GJ/agGB0xDWzm/czd6f8cAs04Q5MlsvFAj419lIdFreINTKwOb6b+PjuOso4l0
	 OPS1dV9loKZME+/oPX1mM4zwNuvAiEyIT3+o+5C/mYSI9IBjkVSEJVZ/uI7174CDqd
	 6JHmEWGiLEqTtitdNpf++hi+7xgLpcdJC9/HTqQWK5BeO4os8jAbzEU+LZV8KmQxaB
	 R6RnVDxvXb8lioq/7xPExeATIw5WCv4Er5WGzfh5wy+EqlrjVtjVfQN0ZA1gkuo+BA
	 3asb/XqS45JifNMLKxbd9EZs4hVDbLA4PP1kidYW/b/NxISb8NYIVrRRhVmIcFvhLw
	 AW8vbx2O+Bhgw==
Date: Thu, 09 Apr 2026 21:07:20 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Brigham Campbell <me@brighamcampbell.com>, Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, Hardik Phalet <hardik.phalet@pm.me>
Subject: [PATCH v2 1/4] dt-bindings: vendor-prefixes: Add QST Corporation
Message-ID: <20260409210639.3197576-2-hardik.phalet@pm.me>
In-Reply-To: <20260409210639.3197576-1-hardik.phalet@pm.me>
References: <20260409210639.3197576-1-hardik.phalet@pm.me>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: beca96a4de86b48d45a58fc9a7c37bd18ddf8222
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


