Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846B7453A3D
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523295; cv=none; b=K2mEVdxmycw5iUxRk4jRaXuHPNrv30xkdpa7vcLFn2XOsmc56HEo+JSF8NJ9ZUL4RuwErumUvPPuTB7fKS7XU0MKXHxK5GbN30C2N8LpbzktOldNQfRntiBgAiMMZI1Gj7yJwp1yYXxC1SvCqORezfQufNAZOUYOxhWi/MBigls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523295; c=relaxed/simple;
	bh=7LNFTMs6nkB60Ajw7pQWpTWA3laGLhCMvmJrV0QSrCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u55nzDThJ4ZNRZz3wGmtZIfe0mDktu4moKokQ3Y8gaK+Lu68rOmKOGhjlwykTsNM1TCNdCG9/Y/4nIeKxbWNgzyN9u0ZdMaufGxAkt3dELtHEQsJntQRLZxHmeUi8JI58GVmETPGOQCdNVbq2rrUuzgW3exHM9cMR8X3TQJwhcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJEje0cH; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJEje0cH"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ef1dc934d1so8494046d6.0
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 11:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785523292; x=1786128092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CTMjmGFusOMu1vcQVsEPcYR4aahhp3Y9Dwu7CieMQ38=;
        b=WJEje0cHOaTLlr8VRVoEm0WZDvEKmZdhtPheKDfj/CE9w74laTCkN7od6Mw7DhRsIL
         a2590ytayi5qpFk2cM064bCx0TS3M3cr3QecuWSoObUQkAL7YifAZaVZzo4qvwx8CPEP
         37ZDeXc5Zlrj+z09NN08q3QbTjoD+25Tw0Cq5DJogbGh96PWzfLH2ktyINgN/QQxQlAE
         5GwkSoT76aeO3PaHF5rr8fXQD42TocEbX48R4UVhZ0EhPNIljWFsP89AMEzPZ/oGcs28
         9BdQD1DABvm72+bbpaRl4vSLxZ/nTK1swhdTbVTrGlGW3csIrhD/5rQ2oraK5Daex09L
         cJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785523292; x=1786128092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CTMjmGFusOMu1vcQVsEPcYR4aahhp3Y9Dwu7CieMQ38=;
        b=N4tffIIf83xDCyyw7BqLTLmisZjLTyXeDDcHRh/m2pYXDUF35NKvBH6fFPlkhUcHh6
         nbiQqD9yFAkDLvu/4XV58lVHddFA7EH1BpKipJ9xl+s4ipQAVPnYhG9kBEZ+h/wVvc0f
         bZyFwSbO0ndp6yHrDGd+TZecv0ynX3aLQpUXrV9fbnV/WKimOa2Xl3ucboP8l01VYP1f
         AvsqvCmXcEGQ/3BLZTHAW4fcyW/7XwAYvGLNUjhz6w9gf0SX4ua6sOGHrRRSFt0TnLl+
         Apwns8EoO028JqQST6SGvZ6AlPMoRc/kgzF/qJbFRwzCgOuxPqAaSBh9JVuT7kFPZ/0j
         zLLw==
X-Forwarded-Encrypted: i=1; AHgh+RokyxGGpvZfIeeQ/JPXd4LMOWWPc95cfi3M3XcxtIggLeV8ETOBG2k20HtcL63rFoL66CsgD/7bzI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsrMWkOq1dFHdhS3nezDL8+1XURJZkMJ0MHbb+4IYdejZP1BaX
	Nf5l4/YPS/w/p8mbdGtdFnBwN8ukKwwrl7z93/uFc9CylqojzUy+2vOv
X-Gm-Gg: AR+sD12P5+9quZjpLyX3T5pKUFHzIdYP/1t3NW+bzQm1orDqB7oNarYMEEywXm1Mka4
	mAhAgx1XqCEfQzpH5bxJWq+t8T2moE5Xn5XMx9KigOqKDWaDJla384AWMQkV80HA/FcuWwi5pWt
	Kwu1TMPAziElR30Qp8Lzi/HMdjMSSI8y+MQY/tGZHm/ZOQYQx/ZmPTgzzTay6XILRReXkWhbh6l
	vwcFxs999Kye+hylFmEaj/dBnUs21vV1QhEYdtw2N7BTHEcaxZ9d75CaQK4J/VvbLyo8dlm6+/r
	kKyI51Dlzv0U2+sJ/mw6k+F+F4zpirz6UprSW5PM77r5chnHznYUtaZGTCUuvCw2jZOqF1ZCSfa
	tr0uj0ZjuYR1sVjv92gyuHd11BZ1QX6MNVbgUifQqR6cqgq5f2bKBeS6qWUVdQ9S+AY04aNH4Uz
	MWR7omtICb5nGUJ0TVVFJ4cWOGHqNaAu6kkDbBh8y1mSOvm2KxifsMwYHJm1B5QxnSNYg=
X-Received: by 2002:a05:6214:590d:b0:8e9:cd74:87bb with SMTP id 6a1803df08f44-908431e1f25mr60578946d6.18.1785523292065;
        Fri, 31 Jul 2026 11:41:32 -0700 (PDT)
Received: from localhost ([2600:4808:5693:8201:bb19:d9f0:6e53:91ed])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908436071b7sm16241546d6.48.2026.07.31.11.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:41:31 -0700 (PDT)
From: Marco Chen <marcochen.dev@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	pmeerw@pmeerw.net,
	matt@ranostay.sg,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v1] iio: health: max30102: fix NULL dereference in interrupt handler
Date: Fri, 31 Jul 2026 14:41:23 -0400
Message-ID: <20260731184124.112124-1-marcochen.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interrupt is requested in max30102_probe() and stays enabled
for the lifetime of the device, but indio_dev->active_scan_mask is only
valid while a buffer is enabled. When an interrupt arrives while no
buffer is enabled, the handler dereferences the NULL active_scan_mask:

  Unable to handle kernel NULL pointer dereference at virtual address 
0000000000000000
  pc : __bitmap_weight+0x64/0x98
  lr : max30102_interrupt_handler+0x48/0x160 [max30102]
  Call trace:
   __bitmap_weight+0x64/0x98 (P)
   max30102_interrupt_handler+0x48/0x160 [max30102]
   irq_thread_fn+0x28/0xa8
   irq_thread+0x184/0x30c
   kthread+0x118/0x124
   ret_from_fork+0x10/0x20

Return early when no buffer is enabled. The interrupt status register is
read before returning, since reading it deasserts the chip's active-low
interrupt pin. Otherwise the pin would stay asserted and no further
edges would be delivered.

Fixes: 90579b69e94b ("iio: health: max30102: Add MAX30105 support")
Signed-off-by: Marco Chen <marcochen.dev@gmail.com>
---
I ran into this while interfacing with the MAX30102 over I2C on a
Raspberry Pi 4 running the IIO subsystem tree testing branch and
learning the IIO sysfs interface for the first time. When physically
rearranging INT pin wiring with no buffer enabled, the kernel oopsed.
This happened because max30102_interrupt_handler() attempted to
dereference active_scan_mask, which is NULL because no buffer is
enabled. With this patch, the same situation no longer oopses
and the buffered capture was tested to work normally afterward.

Some things I am unsure about though:
- Is IRQ_HANDLED or IRQ_NONE preferred here? I chose IRQ_HANDLED 
  because of the status register read to deassert the INT pin, but 
  I am not 100% confident on this choice.
- Should the regmap_read() return value be checked? I did not add a 
  check because I do not see a useful recovery path from this I2C failure, 
  but I can add a check in a v2 if it is better.
Thank you.

drivers/iio/health/max30102.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index c37316c86f14..c30b029ba8aa 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -290,10 +290,23 @@ static irqreturn_t max30102_interrupt_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct max30102_data *data = iio_priv(indio_dev);
-	unsigned int measurements = bitmap_weight(indio_dev->active_scan_mask,
-						  iio_get_masklength(indio_dev));
+	unsigned int measurements, val;
 	int ret, cnt = 0;
 
+	if (!indio_dev->active_scan_mask) {
+		/*
+		 * No buffer is enabled so there is nothing to read. Read the
+		 * status register anyway to deassert the max30102's interrupt
+		 * pin; otherwise it would stay asserted and further edges
+		 * would not be delivered.
+		 */
+		regmap_read(data->regmap, MAX30102_REG_INT_STATUS, &val);
+		return IRQ_HANDLED;
+	}
+
+	measurements = bitmap_weight(indio_dev->active_scan_mask,
+				     iio_get_masklength(indio_dev));
+
 	mutex_lock(&data->lock);
 
 	while (cnt || (cnt = max30102_fifo_count(data)) > 0) {
-- 
2.55.0

