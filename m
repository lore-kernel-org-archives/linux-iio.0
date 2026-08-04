Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38F6485CC1;
	Tue,  4 Aug 2026 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862975; cv=none; b=cwE7sQ28Tx0O8aK7azf2YX+NLRzwUxbgrGYVmKfhL73np4TDVc7NuX1OnntIyHpU9y//vIGZ0mAi2IY7FWVlNVGdFTbl9AQnc4TqNLgLMecR+kwMczXsadmSf1Hjg1uMwYIPIQ9P/72et9FppssrmZLKB43AG6YcDFSJ4YbqP3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862975; c=relaxed/simple;
	bh=mvNJmDmVsp8KUVgsp1225/noNvG1ucZekie3JkvhBfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mJM69CSlftgh2qJLUZRX0J9eRWeWpJfcG/UdU3MU6rF+QOU+EfFK9dTufNy1IRmLIqOgDqE7xT/agkPg23z0D7sMYAmhDu0CAnvWlky7lYEXN/Hx9PqjnzH+iB2ahxt7cy5hb5+yLdzWQZYFqZiVU/tG4GkkQJqcDPVGQYyLC80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Gac8kTm9; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Gac8kTm9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1785862954; x=1786122154;
	bh=lx4b8MwYSUgqf30P2GLTCz9k8BWV9/z7MLxR4uMDIeo=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Gac8kTm9vDqxJdrwd+QBEEKGBhzUN3NAbJ05bHpNl6gKLLAzV0wE0/zKKZZW4IjdW
	 SYhzKNi6ecQBJvfv2k3ND4mpgdZZJiD8V6qUWDWDw4usH1dlEzRB/2sUiZ84s8hnXf
	 dp+I0I5dMm7z6A/Vubump7aoGnDgrd8g77YZIm4aO7Eb+jnJljGGek5m31tzK2SmkQ
	 54lF1pXlajXsCWFq3P8Lw8YnVcDf8qeAIMtK7IxFne1mJ3Lrqns81mV5Em9mVIiQhb
	 zZtr4mgZcBCn6VsMkUlSqOw8DLG7zluGL+0+Bnejrm6KlNzxuj3zh9DSdSqFByGfni
	 3V+jv29McwrGg==
X-Pm-Submission-Id: 4hF0GJ54DNz2ScQ9
From: Esben Haabendal <esben@geanix.com>
Date: Tue, 04 Aug 2026 19:02:13 +0200
Subject: [PATCH v3 2/6] dt-bindings: iio: light: ltr501: Add missing ltr303
 compatible
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-liteon-ltr329-v3-2-c6b768c7c745@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785862947; l=833;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=mvNJmDmVsp8KUVgsp1225/noNvG1ucZekie3JkvhBfQ=;
 b=7XyJcZuf9rAR3b+5GoZ0U0xlEHhEDr6NLTQOlcjfeHGfGumZeZOmBvDpHp+v6ktR02PBSNvLL
 imjqFGbrWhpDUijXGZupqeXwtAXUCstj+3tOmVNEraEpz6H3QqWBKgY
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

When support for ltr303 was back in 2021, the bindings documentation was
not updated accordingly.

Fixes: 7d71d289e1ba ("iio: light: ltr501: Added ltr303 driver support")
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

