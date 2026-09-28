Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5A44734FA;
	Mon, 28 Sep 2026 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583999; cv=none; b=NGO49pxAKstGJhLAw/Wb/UPZBv+RojhG8e38+dKToJsnJ1p8SRu9gwlOFEpng/uVkNhPEsZUlmbuTTEhHtIUV3I+b43LBatCbZ5KVACnn5UkQlnQop3aveiKYQKQbsXh/6gW/Doa7l1xPScuRdkNefcUeQKpawb1bSnSKQ3NUk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583999; c=relaxed/simple;
	bh=ZsRWQ2cy4/2MshimBga9KEvo5MqZ+GDpAPXPf+c/Lk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DmIAim+AoH3XJZ+thxw5w/6r3eBYM1JAXH9+gTVCLDE/6gDYChRmvpzpGu4P15he3gcDV9wp2ue6rRpjPHbEVCybq90L4k75Eg1q8MDyvBZadpvl/bSjP4GDaP/WwLAb/tdbLs2W12DXX3MLZDL/UKNVK+k6cubBibFTa96N+Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=bTQTSyj2; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="bTQTSyj2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1790583993; x=1790843193;
	bh=hvvSu4jQNAlUbHyw4OnEn6UGVnkOGTmR1TTHMd7EAHk=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bTQTSyj2Wh6yHEMqKBWRnj8u278eOz4VE46idtRD97rFf4OQfpTykuaga65V4Y2/d
	 UV0h4SWwtQpblN5OIfG20a3JAiJKxWBKOWtD5hYSc9mwxuptI532tG1uVlqBJkaESv
	 +XVSv0z2m0FQm+2D8G+EPcQc4qJx7mW4+TvxseOVXNqiYnU/TNva8c54mdmP5U8Dif
	 BP7gq/AsQEMvLYxUEIFobOg1EJxkVk6qrIN+JKTQYGp+NY1LcfSlHXoMzSr9eCHeRE
	 7n9V8kLvTgNAPNBOgqXYn+wCd3GU+c2keIh6KvvbIx+Glzft8UVUZRno3BTCXeX22p
	 HTSyzYWkHcWfg==
X-Pm-Submission-Id: 4htZCX0QnDz1DDr6
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 28 Sep 2026 10:26:20 +0200
Subject: [PATCH v10 04/10] iio: accel: mma8452: Optimize struct
 mma8452_data member orders
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-mma8452-open-drain-v10-4-b906fb408386@geanix.com>
References: <20260928-mma8452-open-drain-v10-0-b906fb408386@geanix.com>
In-Reply-To: <20260928-mma8452-open-drain-v10-0-b906fb408386@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>, 
 Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790583982; l=1020;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=ZsRWQ2cy4/2MshimBga9KEvo5MqZ+GDpAPXPf+c/Lk0=;
 b=+CiKrUilw2HCNaA27oIiGHyuAhZLqIMYW1ZUQ984TBc6ADN6P2AqMgEE32SrwvyG3pvnMpSJn
 hQNn50LMdntCyBLYOHRmSfKuOIe3TaGgW8W7xFzgjV4uAsXn2yDrAIE
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Reorder struct mma8452_data members to avoid holes.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index a77c4b88b61d..8d70fe89110c 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -108,10 +108,7 @@ struct mma8452_data {
 	struct i2c_client *client;
 	struct mutex lock;
 	struct iio_mount_matrix orientation;
-	u8 ctrl_reg1;
-	u8 data_cfg;
 	const struct mma_chip_info *chip_info;
-	int sleep_val;
 	struct regulator_bulk_data regs[2];
 
 	/* Ensure correct alignment of time stamp when present */
@@ -119,6 +116,10 @@ struct mma8452_data {
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

