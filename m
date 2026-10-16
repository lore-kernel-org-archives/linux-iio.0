Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421CC3812F6;
	Fri, 16 Oct 2026 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.31.26.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161799; cv=none; b=h4z0tgKtQaZCoaFCcBV/ET0e5Ftxa/3WqIeDx/w/U3qxQu5h4FTkF5W6osf9vGQtAijF3KPVao65DQXZUU+24yPODxtmBrPc9xoTMJ3F+Tg9STtJtmaiB9MAVf9V6dQkFwqER4rUcTwx7EdBNqwwQfynyvYOBQ3s2oo3W1jL2dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161799; c=relaxed/simple;
	bh=GIMQbzx4AtnTUvJ+L/g+oXlNkn9cVnW9vEOeFZoWYPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SFQC4HtuIHEaR+CIi4nicFZYGMr56I8qza19TAffjw2WDPoYfxQhKj3EN+JrqLSsHuCFlAxgceuZ+eKtzftAbaSVTR0XyUTE3EV7EAwDfaxbbWPq6Dk9ypYPXMaiPgdIGJs9kfoxdCbHnmRDxV8KYNkZdGmq2mKOumE/DRj2UVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com; spf=pass smtp.mailfrom=rudorff.com; arc=none smtp.client-ip=193.31.26.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [127.0.1.1] (dynamic-002-211-221-196.2.211.pool.telefonica.de [2.211.221.196])
	by rudorff.com (Postfix) with ESMTPSA id 3C7264063C;
	Fri, 16 Oct 2026 16:43:16 +0200 (CEST)
From: Christoph Rudorff <chris@rudorff.com>
Date: Fri, 16 Oct 2026 16:43:07 +0200
Subject: [PATCH 2/3] iio: light: Update DT bindings for GP2AP002
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-iio-light-gp2ap002-v1-2-7c93312fa8d5@rudorff.com>
References: <20261016-iio-light-gp2ap002-v1-0-7c93312fa8d5@rudorff.com>
In-Reply-To: <20261016-iio-light-gp2ap002-v1-0-7c93312fa8d5@rudorff.com>
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Christoph Rudorff <chris@rudorff.com>
X-Mailer: b4 0.16.0

add missing vled-supply

Signed-off-by: Christoph Rudorff <chris@rudorff.com>
---
 Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml
index 99bddf31cbed..2b5025043168 100644
--- a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml
+++ b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml
@@ -33,6 +33,9 @@ properties:
   vio-supply:
     description: VIO power supply a phandle to a regulator
 
+  vled-supply:
+    description: LED power supply a phandle to a regulator
+
   io-channels:
     maxItems: 1
     description: ALSOUT ADC channel to read the ambient light

-- 
2.39.5

