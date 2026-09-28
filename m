Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E15475348
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584020; cv=none; b=uB20/ERFMs11BATTF+hqNHCsIpcdE1OxpHVs4/f0srmEPWT59iy9bUZ5wbd8WOwYckw2jVVLUPG0WsBbd8Pzi9Tv8Z0nWlPB0/3GDz1uRmoIBwIpkrv8T1goHOXtUjrWCZDmdtFxDDjcivwj8QV68kzsT0EPPJ6H1akddWopPz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584020; c=relaxed/simple;
	bh=K1jPbnIpn2vPrtvqzcNi7Vjb6hG0x04g8LVYMsnM6gY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N6WFFzIu/sX0Pd2V4QIgn6P1He0b4U/OpUbabONS3KaQQX41F1MTw7/OroT6XH9jmAtv97+AnJkfGhBfQoqJ/7aYUZlUUdrfFmj1cWX0OROBgokrIvOFcn9CCVHVl+FewJfZSdNIkkNmfWMWTUgEUfZhp1BcaTVu9fGBQpJFu2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=SAkM/9NG; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="SAkM/9NG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1790583998; x=1790843198;
	bh=QCIfMsx6KjKXpnoxBI1XGkxGk4Y7Sik+nYV7bSHmLbY=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SAkM/9NGJ3VcY3M2BzND+fCxorHLcBG3ZFDSBST6Sx/1wUl5RYxkLyzjKM5TiKzXB
	 cI7B3L+oN89d6cLY9ixUUAxuJ4sJd+cHzNse43h3W95xk40AXLG2xgATUDyH8paMX/
	 IipJKFlzp9PrvV9A8Nf/jVmHymd//nh22lpvzvak0Frhzbu1AU71rJrLsQCxOdfpkg
	 dkdA/JEeUHgPv35sSHSxk1qLBmsb+JvlV56pEUdBFKradZF+6C2fIQkhMpCq53OXTp
	 5K7+Z8aoaPvFBvTJ7NZES2K6fQrYk40cJTY4Dsd7gsGojU3giFq8Kz59xkiLbhsDNd
	 fnMhBPk4Fxlrw==
X-Pm-Submission-Id: 4htZCc4b0hz1DF6h
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 28 Sep 2026 10:26:22 +0200
Subject: [PATCH v10 06/10] iio: accel: mma8452: Fix unintended comment
 indent
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-mma8452-open-drain-v10-6-b906fb408386@geanix.com>
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
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790583982; l=2166;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=K1jPbnIpn2vPrtvqzcNi7Vjb6hG0x04g8LVYMsnM6gY=;
 b=qJdKs2Xt7zSoQ7rvCmwU1/ZF3pwXf4Ud0z7Hyl/UdwOLZXcYruTOi0odto9YhsaJXmanItsTE
 ji/aMTIyg/2A1A11HtHShn/HXQDrR2b+nN1cAubAVv9r+4Cq7sQULB3
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

The extra space this block was indented with looks quite untraditional, and
does not align with the common style used in the kernel.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 72b4ab32775a..b70bc8638128 100644
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

