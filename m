Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C16F48383C;
	Tue,  4 Aug 2026 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862991; cv=none; b=Sp64oW06/g3RG/ZirqOKK4QfoJn1JOxNcHia1S0WlGuRcsjO5JrkXBxk6jVhEhbQQRy9QeKUuZbkyK+N8qgFz8ZEaM+ugw1aeofeTRPBCoUo31Vy92BWSMQNt1xRxXobp3oR8y+UexVt1NUN+K4prgwnMzyblCstlGr03gRZsN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862991; c=relaxed/simple;
	bh=x31SJrXOIjTrbMAkq9hHMHKq8LaiEfoLkJ2njfoSJa0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nDUBc8q4wTPcaoj5dOTB1XDo3i+YR/uN11hoxuuZgvt/q/Lx7akPgScu5BRfwojqApsqZx81F1FLXum+8fd5fVAszcCl6x8+b1sy+fHOH9Vt5nep+Q/GStUfpi/a8BbAX5PwCWtKiVKxJm+iEsI5/ULdhdPPkVVeXD1ZDL0mUig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Ci/Ojv30; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Ci/Ojv30"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1785862959; x=1786122159;
	bh=peG498DFEuWY7RvlZBKros/WMPQrKDMn6L/VmDkEcY4=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Ci/Ojv30rEau14BqKJ3uLHiv5xCgf/SOIFLCDEI6sKuBYy3M8ONdOp4FLYp5NYgrb
	 ZtttSl1ic7sF2uRVzELA14R3U6EOLAZDAXzbAn6r+UwnJ7Bkd12DXL9jxj2Rw1B9Rl
	 vLNcKnwm98uZGBJ0jL0D4kAqM5h1b5T7btMinz9hGre+qi6JHYm5jjK5Qg0ATINwZY
	 psPZBF5vMG1b5iDWIg/G+s7uDp6HG7AxoRWrcVXi+GaavYu7sNiK5WM2+U5B8hspGx
	 B5eyxKvJtdV/nSnltKbrjgqn14rdh7INTnrm75dfVnmuzg1jmEGk510Xtsax9v9KYV
	 EGIuRdQBi8JUw==
X-Pm-Submission-Id: 4hF0GM6Cxgz2Sccy
From: Esben Haabendal <esben@geanix.com>
Date: Tue, 04 Aug 2026 19:02:14 +0200
Subject: [PATCH v3 3/6] dt-bindings: iio: light: ltr501: Add ltr329
 compatible
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-liteon-ltr329-v3-3-c6b768c7c745@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785862947; l=768;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=x31SJrXOIjTrbMAkq9hHMHKq8LaiEfoLkJ2njfoSJa0=;
 b=2GLdhXYo4ACWrz7XYTkr6ZjRjthBTZmrKOl7dnu2U4e96pRZzqO0O2//4ShC4pu/D1/MOcP1L
 thDi7/eo1I4D3bFFqGJxByS13t62R4poOciMdaRUzylhyal5fL+ja7H
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

LTR-329ALS-01 is an ambient light sensor similar to LTR-303ALS-01, but
without interrupt support.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
index 6234e2eaec2e..8c9d6cee55b4 100644
--- a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
+++ b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - liteon,ltr301
       - liteon,ltr303
+      - liteon,ltr329
       - liteon,ltr501
       - liteon,ltr559
 

-- 
2.55.0

