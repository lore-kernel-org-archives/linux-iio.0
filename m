Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E844FB9B1;
	Mon,  7 Sep 2026 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792697; cv=none; b=JCiotOPQSPi+oCDwZG28WmFW8yekZQ3I669QyrDklko8MSCEU/0jWJiGpKfIFB/Pdb9eHpNaiY0BGZpulhg0ZeRZ6NtOxkMakBY9sB6hyqJmw3s3K58PuJphvzXxv2vmxQqegf2GhJP1qR1R24B5r85cvuSPrP1lah8s2BM5KfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792697; c=relaxed/simple;
	bh=NN2LnoCdHfS4ylhxuHPETWJSkY6TTaBOKGZCXk9fjG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BvPRo/2qvkcLCYJu5RTGiARUt+6y9btyVd8lDCaPOCK+exQNc8lgm8rnQ4JjgW+gOPAQ/N+vP8eJNo5mzFhbfOVr4FBc4Fk0LFUYhNgJ1/XjqX6LLFJGz9ORuV945EWP+4mWBcOv9+aIPN4smlumGQ7LzHdu1KQ4/F05DIFU7ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=GZyt4zc6; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="GZyt4zc6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788792682; x=1789051882;
	bh=I1LRz5bGR3NXE1FNM1AxIMg31OS/Wgjc9VK8Q0Q63o0=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GZyt4zc6fDz082/QnLVzRMJvKJmj15mEiIKqI3UxsMptP/JCwdiZlMCPW7hW5PrYN
	 d4Vx5lwjC4/g3zzIK6DBP1ZVEFkQuBrxA9IweZlgDd9e/c+dVeNdA66MBEh2O7C7c0
	 gfRVvLSDX2nK26cS/fWpnosvXXAglnv8ul7nxkeGo6918Z4/QYLBetP+9Z7GOVD7uZ
	 3dVraOQhLf6C3eYv1+KLRwGDVl7xqfBkxSP2bcCAFhUA+XHLRROqFdril7qQr6s2zP
	 j8SBilbX9M6kKf+JgtgBNdrhJkQdcZ0mmEs+PSXjydqKCs4tWJfr3Mzv3dxPerokcs
	 pCBocUaTlLKXQ==
X-Pm-Submission-Id: 4hdqlD50NSz2Sd4k
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 07 Sep 2026 16:51:00 +0200
Subject: [PATCH v8 5/9] iio: accel: mma8452: Fix unintended comment indent
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-mma8452-open-drain-v8-5-c17407e22118@geanix.com>
References: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
In-Reply-To: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788792664; l=2111;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=NN2LnoCdHfS4ylhxuHPETWJSkY6TTaBOKGZCXk9fjG8=;
 b=IxzFVNTY2Ep9omKe9qlxJEkUA5bU5LaZsgjZ/FWDeyulL2s+J4Qvem/Uwsy4r6kyAAhZjmDZj
 zrJfkiDz0MxDez8FVaP1n85EyeHMdLlcQRD/CTZRea9d/6U3d11Zq9G
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

The extra space this block was indented with looks quite untraditional, and
does not align with the common style used in the kernel.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 05851274596e..c6af68d2a297 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -122,21 +122,21 @@ struct mma8452_data {
 	u8 data_cfg;
 };
 
- /**
-  * struct mma8452_event_regs - chip specific data related to events
-  * @ev_cfg:			event config register address
-  * @ev_cfg_ele:			latch bit in event config register
-  * @ev_cfg_chan_shift:		number of the bit to enable events in X
-  *				direction; in event config register
-  * @ev_src:			event source register address
-  * @ev_ths:			event threshold register address
-  * @ev_ths_mask:		mask for the threshold value
-  * @ev_count:			event count (period) register address
-  *
-  * Since not all chips supported by the driver support comparing high pass
-  * filtered data for events (interrupts), different interrupt sources are
-  * used for different chips and the relevant registers are included here.
-  */
+/**
+ * struct mma8452_event_regs - chip specific data related to events
+ * @ev_cfg:			event config register address
+ * @ev_cfg_ele:			latch bit in event config register
+ * @ev_cfg_chan_shift:		number of the bit to enable events in X
+ *				direction; in event config register
+ * @ev_src:			event source register address
+ * @ev_ths:			event threshold register address
+ * @ev_ths_mask:		mask for the threshold value
+ * @ev_count:			event count (period) register address
+ *
+ * Since not all chips supported by the driver support comparing high pass
+ * filtered data for events (interrupts), different interrupt sources are
+ * used for different chips and the relevant registers are included here.
+ */
 struct mma8452_event_regs {
 	u8 ev_cfg;
 	u8 ev_cfg_ele;

-- 
2.55.0

