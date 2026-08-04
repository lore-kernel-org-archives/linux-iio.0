Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21353ECBE5;
	Tue,  4 Aug 2026 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862973; cv=none; b=PGXJZuZliQacKuZUqehhpWmw1NTRLjO53wJmJcRXP1kK8/cXUEpB8rp5HP1afywOVntqwNfbdkimOLZzss8KxkoQWCwzcAIlCkrRfWWOu88mkbTCVULTgEMqUVQhsTvBJeGy2UBQfG1mpWlaFc8M7k9nBVLcZrZslhwY0zGQUu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862973; c=relaxed/simple;
	bh=chSx2lJzLdFN5R/TGmmzpmF0sv5tO+hbYYUIO9ygA04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q+QIl0/934ejzjkLB67nJeh5QveO+X+Y+8uI7jAZSvfdDVzDOYC+gpibhYpl5YYr0UwMSzdtc+WJ9UMWV/ev61mN1tdkpFFOvhiZVrF18oIHnoYi/S9kULxSj7ySZzPMXQnOH1zxeMibXzXlfHOfns8vWbTYliMs7Hmf7xw3NMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=uvC42Xep; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="uvC42Xep"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1785862952; x=1786122152;
	bh=evxTxET7ULEQIK9aSBquN+mpS2+hq109UcF239xLq7o=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=uvC42XepPc0qzk3gQh1S6ACbxySI+cl4bjpjsIuUg8LRdWs1PYO+s/eloa2uAovu/
	 5rlCNJE6hlPrcuopzWR76TltjOJKHMMThapT+8fLHHdwBPHz0xlR5IVjzwP81hYCKk
	 WfbskVe7o02bNMBT+167thdJrhnOynVspQ2UZFCBRWIybOylNZaLnc1KQFyEBhiRtw
	 jFoK7iMgBguge1xxRXPCbZVjkDXLul5icDYBPBpJdU1uEH/JI0AtVp46xyI/LMFfuo
	 NGLpA8v6CCA/Cp3mj+RPs5Kh4phHjWZUmxjefEAqGqVNdxcsVQYR7ijGOk2RP8YbAC
	 bDxarGMznqwrg==
X-Pm-Submission-Id: 4hF0GG5PYHz1DFF3
From: Esben Haabendal <esben@geanix.com>
Date: Tue, 04 Aug 2026 19:02:12 +0200
Subject: [PATCH v3 1/6] dt-bindings: iio: light: ltr501: Sort compatible
 enum array
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-liteon-ltr329-v3-1-c6b768c7c745@geanix.com>
References: <20260804-liteon-ltr329-v3-0-c6b768c7c745@geanix.com>
In-Reply-To: <20260804-liteon-ltr329-v3-0-c6b768c7c745@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, 
 Maslov Dmitry <maslovdmitry@seeed.cc>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785862947; l=783;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=chSx2lJzLdFN5R/TGmmzpmF0sv5tO+hbYYUIO9ygA04=;
 b=ECxa5aYePo/YDDZvf28mH5FgEO/cqbtsQhPahwMpu0PMMQhNTVGCnIao9WHhOJVfaikSNMkwW
 1bOdaxyyvLvAa6V3dy2+Gy+JUhy5YFVLRJoEiVWVFz7azGGM9IFRuXm
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Restore alphabetical sorting of the properties.compatible.enum array.

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

