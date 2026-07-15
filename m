Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4441543B3CB;
	Wed, 15 Jul 2026 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118823; cv=none; b=ukA+iBNUhN8VxZqWFJNcFom+4sO9bTVwl5IzBaHj1LKyHNjWlblzhsTYRd9fA2v9jiipK4+p8Gd2WWKhc54EQ6U9Ge8DZrHUEFx8Fs6L4xkkk2dALdpFaChCNWbXrrFlx8k6HZi8rLC6CX48oIEyez4tBJmbQl9G8vg/hwflIEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118823; c=relaxed/simple;
	bh=6qSTrUvFoQpzHMu9UB1C/X7u+Uvg4QnliIJn2ES26V0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HsEp294DKokvIC3yldvrInIlLcpXy232GIcTn+gLhj9Mg/LfwdV+skDIL+oofyxZR0j3zDru61Hqc2T4saC2YA8krDgXTSJYD/zsJXAXynzt8zkoLyynNbr++uRNGNo8EhAyABkyYAsTQGb1QATwXVyIVBZ4w1oXpjn12o+qHgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=QJRhwzv6; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="QJRhwzv6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1784118820; x=1784378020;
	bh=m6moQCYBnu8QTM7vejDJipQ1bYlwLXWyq1Wkmw7JC0E=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=QJRhwzv6b9LeKl7IOdIDQypQd+qjnQs36OYDsg7NwaoHZLkJ+dPeMHAEwgrYlkmak
	 7RYRHF0rm4JUpLLN2bUjQhae3R2+Y8EyDjLf+T7Rmsq64dAdv1IMJrOoph0SyoTK5Q
	 rCQhUM/b2GNZN76sgxpWDOB6SJTC267oytk3C+2Wsa7J2nqNQJeXKpcOJoZ2ELb+tN
	 5n72cvfyFWDH7seemZH3v50S7oEQE6xVY/wwXIFGXZE6aCjr2oLK+3MCFd9jV2IDsb
	 hs3GVY+pdHAcVaOI/5I9FiFEMw8nel38dm2kyiMIfmpughLUmgeOEdHdIUzKgKtLoS
	 5PVXyys+MwWEg==
X-Pm-Submission-Id: 4h0bFG540Pz2ScXM
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 15 Jul 2026 14:33:29 +0200
Subject: [PATCH v2 3/3] iio: accel: mma8452: Optimize struct mm8452_data
 member orders
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-mma8452-open-drain-v2-3-95be9f5f4795@geanix.com>
References: <20260715-mma8452-open-drain-v2-0-95be9f5f4795@geanix.com>
In-Reply-To: <20260715-mma8452-open-drain-v2-0-95be9f5f4795@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784118811; l=909;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=6qSTrUvFoQpzHMu9UB1C/X7u+Uvg4QnliIJn2ES26V0=;
 b=XxJV/wJj3hb5C7EdFcLUhpdQbTGn6llFIL00e5BiciReKdA1T2i5c71jY20MjJ8w6d4cUajPW
 LsBbHH4jyj3APCjhIeuubPQ7Khvvuo5mHhipI0GwtfLyOY96Y3XLDSM
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Reorder struct mma8452_data members to avoid holes.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index fdf7364d7fed..537263085215 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -108,11 +108,7 @@ struct mma8452_data {
 	struct i2c_client *client;
 	struct mutex lock;
 	struct iio_mount_matrix orientation;
-	u8 ctrl_reg1;
-	u8 data_cfg;
-	bool open_drain;
 	const struct mma_chip_info *chip_info;
-	int sleep_val;
 	struct regulator *vdd_reg;
 	struct regulator *vddio_reg;
 
@@ -121,6 +117,11 @@ struct mma8452_data {
 		__be16 channels[3];
 		aligned_s64 ts;
 	} buffer;
+
+	int sleep_val;
+	u8 ctrl_reg1;
+	u8 data_cfg;
+	bool open_drain;
 };
 
  /**

-- 
2.55.0

