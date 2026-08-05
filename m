Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C361E3E3DA6;
	Wed,  5 Aug 2026 07:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914520; cv=none; b=A79tfx1nzBpDxK1JUAXQ3c/AxNCLvCMhiMCbU/jZKdN+vtzq0D8VRaKEhAGPyckG/u4FFJ2LbYPyKUaZcalsAOLxDtEHnLcqU+LLgeMyjpR2oy13B+iqMuRoB/E1jBWr4/Ng7CQUVYH8H6kUZriDjuX6PKI8kmv/s8vKFQhQ+Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914520; c=relaxed/simple;
	bh=DcA2x3+/k37BO92LD1p/ylm5SKaGYZeTNs5yevtyg+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qCprkSSbGob0VM9/Ys521yltpYsAEy//H/Bk6w+5+YnZJMUJcjK9REPcvG2fpoyuLSsoeiC6j6POBI7JcuFHdigcCPdzG8ywi3Pime7izp8pc6hMBQAWo+EwwmdV7i01WbrhNF8aOl6YKjWibiqp3yROMwXZ+lUE9sd4ZVVimRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=BnHwtdv9; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="BnHwtdv9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1785914509; x=1786173709;
	bh=lKyK1WFSI62qz5cEOMEaGbIYltlFjbWXiQGcFOldJuk=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=BnHwtdv9b49YtqY+y3Z7/k8Ff0dGhoxxNJGLGI2F75honkNeLXZjICmJs60F/ypAO
	 oGo3DbfK0T3WlXynXBmbH9vUqX28eSQySfcKS9rKAnjJf5iFs5xevoWO2E8gOw6huT
	 K0pPIvZ3eDde9NVN2d/VwKWz4dU4tOXJQXuHQ160BZL2JCuYEGwaXEBTO1ZT+6Q0G/
	 USh3qu7sbVRFizaeLo8Al4APBhdD1DjrapEjq17rzc1BVkkQNYIzSb2kM/KE7Rh43M
	 SeKbLOnJ7MbM9Cg9DlVOvyBvS3shCZeQ5FYIWxrNyHXzRMpaQoIpSrzHCW/lmaL8Us
	 DaaVzFDYK0uhQ==
X-Pm-Submission-Id: 4hFMKm62b6z1DDrZ
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 05 Aug 2026 09:21:36 +0200
Subject: [PATCH v3 2/4] iio: accel: mma8452: Optimize struct mm8452_data
 member orders
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-mma8452-open-drain-v3-2-6149f406a409@geanix.com>
References: <20260805-mma8452-open-drain-v3-0-6149f406a409@geanix.com>
In-Reply-To: <20260805-mma8452-open-drain-v3-0-6149f406a409@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785914502; l=922;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=DcA2x3+/k37BO92LD1p/ylm5SKaGYZeTNs5yevtyg+8=;
 b=NGNcO1ck2HjQVqKHWB0y654f2csFGqJDnPQogd9Q33I0p9F9NK+xJHqQfwqc6iB40btwQp9KG
 JQ62xQZYd6rAD6nQIy0L2tMofWnrlqpbpr+361nhtpncLF6NfS25eLp
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Reorder struct mma8452_data members to avoid holes.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 7d683686dd9d..f645a5c6fd1c 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -106,10 +106,7 @@ struct mma8452_data {
 	struct i2c_client *client;
 	struct mutex lock;
 	struct iio_mount_matrix orientation;
-	u8 ctrl_reg1;
-	u8 data_cfg;
 	const struct mma_chip_info *chip_info;
-	int sleep_val;
 	struct regulator *vdd_reg;
 	struct regulator *vddio_reg;
 
@@ -118,6 +115,10 @@ struct mma8452_data {
 		__be16 channels[3];
 		aligned_s64 ts;
 	} buffer;
+
+	int sleep_val;
+	u8 ctrl_reg1;
+	u8 data_cfg;
 };
 
  /**

-- 
2.55.0

