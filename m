Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BB045FFBA
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986557; cv=none; b=Ow5Nj7NRKg+L23bTPZX8xRDET5hv8RJASvara+wCT1JB9nsmljTMVWBfmllg1X4ehA1KYB4bEFXrN8JyokgofuxmRZdX459MkhpL4nhvCvDwIyG7anpbNm80lIUTU/J3DZeJCJlcp2JjKk5Cwyqan94m5DeEhunojorpTyIxa3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986557; c=relaxed/simple;
	bh=KGc+Z0F5Jfw8ScvcfiFrvk9HhEyYqd66fY0XDHsFkhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sEss8MYerMgn8UlAyNdEpBM0NxdJq1Hr/EzGUCxnBG1iA9E2/Tj5Iyxk4HIp62wGSwrFSD/ujCKCBqPKqjWyz4va+7UB8ckhQL9QcdQB58YFK/qIEBWbkAre9OjQlR6ngRuvsG4DYLGLMpauMYlw6OSaLBGu13eoPWhv8DB4VwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=7/vwbhbO; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="7/vwbhbO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786986550; x=1787245750;
	bh=Mo3LpkcaoyYE6UusSztfOfDPcFiBUeHo7hDZGdqFz2E=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=7/vwbhbOsFV03mmCQf4/do8Du+vvXSO4Dp2MK772NmK1a5N6IaDwXA5nE7W2UB+5S
	 VCdg4Dd1IYziQp0Wh0nJHNyejzhRALvBAIo2UZuK/zG6OZuldzf9uFbz9OoxittDqD
	 DMcGvXUzsi244/Vn0gUlpKCgbujkgiIJP4yvzuTzKMrcDMlS/YYC39RAV2zp2P/JVD
	 4pmtYbkm6vz0uOenLAbgcFvYE9gLf5fDLefER98nUvUYARBer2B9WMIRN8XuqdfI8z
	 FFgzFBqtARmFBSv5B/FjG2t2EFKJNGgvcWiFYTl298JR9ST4LrklHsBcXSv68axftd
	 YsWvpQ4owpHEg==
X-Pm-Submission-Id: 4hNznw4lbZz1DDs5
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 17 Aug 2026 19:08:50 +0200
Subject: [PATCH v5 1/8] dt-bindings: iio: light: ltr501: Sort compatible
 enum array
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-liteon-ltr329-v5-1-6f71ab2b0588@geanix.com>
References: <20260817-liteon-ltr329-v5-0-6f71ab2b0588@geanix.com>
In-Reply-To: <20260817-liteon-ltr329-v5-0-6f71ab2b0588@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, 
 Maslov Dmitry <maslovdmitry@seeed.cc>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 Thomas Gleixner <tglx@kernel.org>, Pan Chuang <panchuang@vivo.com>, 
 Yangtao Li <frank.li@vivo.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786986543; l=936;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=KGc+Z0F5Jfw8ScvcfiFrvk9HhEyYqd66fY0XDHsFkhw=;
 b=SVOf7iYTOvPesirRVVo11h62eQNWaPxsQb5XkO7vygzMDxYlM/RUsq5LPNLDy1JmSwvwKAzgv
 pjJ0FRCxt1YAl2eDq75PCMnvBMF9bjpamLb3GqbXG618STbWR4Y37zI
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Restore alphabetical sorting of the properties.compatible.enum array.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
index c8074f180a79..480523ca3750 100644
--- a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
+++ b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
@@ -15,9 +15,9 @@ allOf:
 properties:
   compatible:
     enum:
+      - liteon,ltr301
       - liteon,ltr501
       - liteon,ltr559
-      - liteon,ltr301
 
   reg:
     maxItems: 1

-- 
2.55.0

