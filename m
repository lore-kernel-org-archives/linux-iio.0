Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C963A39CCFE;
	Mon, 10 Aug 2026 07:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786345899; cv=none; b=QEyCO1JHkYEJnEMk+tC0mP1nvlBcH4XZAjgWe7kBS2wC7pdlofa9iKmo0V51mPl4BA+OOqFuA4k7Na4KaZiNutCA53sOc+R0LvJdMuLJX5Cc4ueSQxcQATV/tVcKXHbp56aac13YAcburtfQKh5J9ydhHkCEwZjfX6fbPmIBNvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786345899; c=relaxed/simple;
	bh=yRmQjSr/b1n+2ZKNAqLdatA7z7rC3bcwWePK4c5tw0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dkBvcn3Z+1dC3WewE/u4E7xH0dEptMXux6bxTmI0CUs9enSMOVmDS4CS/aEGxBxn/my9PQZElRSb/ZMROt56NoVm3iw4BHukU/T3Ne3EeGY7HdMKrPp18h1IwmlU+G+vBKadL9BYa22/xiSJPktL0o789tSaYw7R5O5nnmA/938=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=ErQsVGCa; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ErQsVGCa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786345890; x=1786605090;
	bh=soeIyYa5aMdUFjj2kbEEXj+tc74K06S6inGIFF/6l6Y=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ErQsVGCa6FQqpvdzrYGKh68O3BZ/mJ80bcG+1dN0T9yWYMRpkQY62K/KVIojHZVcz
	 Vb/2jFUiTUWde4hzDtsf4aTCWoWxO9sKOkmhvsh+CAZM8YNbfmb2nLM2S/XnQpUpbM
	 XfCnEonS8e8tg93UKZahbZ7IJN2C9jf0f5kS59u6XQqriZwSSao2x1sy2KFv924/Rm
	 J46GE9HjcdVh8qaDblrXlyOWbMH6gSSvefHww/HUCO7QtUAZ7TWsmOIr9LET9zJq2u
	 7ZoMrfmwQGzXDqV0AFtf5SjWwAK5OPDtWIqBVJmjBsHrKTXdeIMhLJFu9UkVgoIiHd
	 O3zOimObJxX5A==
X-Pm-Submission-Id: 4hJQsX57jXz2ScX2
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 10 Aug 2026 09:11:12 +0200
Subject: [PATCH v4 2/7] dt-bindings: iio: light: ltr501: Add missing ltr303
 compatible
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-liteon-ltr329-v4-2-8bd3dfd15280@geanix.com>
References: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com>
In-Reply-To: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786345884; l=986;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=yRmQjSr/b1n+2ZKNAqLdatA7z7rC3bcwWePK4c5tw0I=;
 b=KoUI7FSPWqaXsQjFLAmeRH5yPg/8fq/UShe14rlCvaY+UIjrHeP1J2+Y3Eai02KN+ycFWz93f
 kCIGPr64qQgCV/Jx8ILP5OFm8iR6M3/YaQNpO57cLoJAHxHznp8WCbb
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

When support for ltr303 was back in 2021, the bindings documentation was
not updated accordingly.

Fixes: 7d71d289e1ba ("iio: light: ltr501: Added ltr303 driver support")
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
index 480523ca3750..6234e2eaec2e 100644
--- a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
+++ b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     enum:
       - liteon,ltr301
+      - liteon,ltr303
       - liteon,ltr501
       - liteon,ltr559
 

-- 
2.55.0

