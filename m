Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07F5394EB7
	for <linux-iio@vger.kernel.org>; Wed,  5 Aug 2026 04:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785902785; cv=none; b=K7TB6l1f8kREMjhE4q2gKfClec5F0tYyLZV6eawUN/5TPfqVZwKMmt141j7xCALWVmNnYYEOEYDl5TishxFEXaFNEJJXWAOmQrWL1jnfxDwmnSw2QR00DpdrZWW1jdNBZnf92o38UVwCK0/c4HHi8B0hZ7Il4IftmFgAH69idM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785902785; c=relaxed/simple;
	bh=K1hRLC2BYPCN8oR7RYpVvCb4izC7Y+GoYerOs/x1PE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bTuEUo8rLuj8DN+u3alwtVqwFy9tOEv+GSwoH0Gm5OAmNuXszTEgRVzhbiGIdmZiJWuf/fuYrZcJIb3rCrMefOaOpVIVyN2zfAek4kACPovCKFIy9MN5Xd4qajdlsfVNODpv+Ql0YX92UTF4cznVmu1F4e8Qev8uwe5vVoZsM4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKg+d7BS; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKg+d7BS"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e602d2c0fso111868285a.0
        for <linux-iio@vger.kernel.org>; Tue, 04 Aug 2026 21:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785902783; x=1786507583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WxaAfBUroPynNZsFayGkalIpvtqiMx7fZUN9X52De4I=;
        b=DKg+d7BS5rZvplBL78K5ECR72LcsAhAXl1e6HC/KdSriTXTh8aNZ0GGvxtcIHgi9k2
         aJ0uh5dLR+HPQZmgptI8HQJYYyRDmB2Ls/NG6xutLX+U7Jv/mVtPQXa62qC6kbW2GlTd
         Bs18/5t6U+N83/pCEwrQJADTCaW4p3kWfF1Z81XPjr6607faXIXniPsrfG2uwwy1FKu9
         DQz6U2966oQ9df5TKHolxQwl7O3qeGxt1YeelvUKpltHoDIe57nWF3z9fYuEa1WGR+R8
         crH50JYGjhCWNnBpoOgTuwi/2r+C66G0DQZTOot4x6yfYpFwP6CQfz1sO7qpjQertQ+E
         7lPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785902783; x=1786507583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WxaAfBUroPynNZsFayGkalIpvtqiMx7fZUN9X52De4I=;
        b=qhd1CDDthSiaDkTmau+fSO/cJoI/3vwTd/CVISsnh++HRadoZhFiLmvNqPWcD0+soq
         5je1OYz5TEAuQ7v9R7vnPlJ0JPTPXvAGPam9B5OrC+mAtLe3a/ChxIdvHduua1XFxXUd
         1dfbNtil6u9tZoeL9iwclNy2cl7hqtBewfdSOmpJdiPPaz8drAeAiCdpWaO2D9nEVL3h
         HShAz0xcV/qdZBFReFNYTtAMMKbYWP9yFkb3Hgn2WesMeNjSNne5V/kHerdhXmbTcFie
         tUOyQLweFfTTk04apjzgYEw5c98VRsI/iDt5s1l3i+GVjA+hDtMMn7883lrqpg5XGNIM
         JEMQ==
X-Forwarded-Encrypted: i=1; AHgh+RpXCOm//4KJnS7RN+INjVjQemVnX2q2tw2SCEpcvmr/OsmceY5hBdYCVT2haNgbOd7nHckTl1fAp8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVnlrNKCQe2v5x4Aa3r7EzxmwARApjpY09PN/UvP1WPWxoN3Ou
	ts+o9j2XOZoc8KJ3dJ2ov0C7bWz3qoAywuvdeWAox75oqvDB4eS5o4PB
X-Gm-Gg: AR+sD13bZE6AG5/gjcxb2hsINQDXJA0JMjMITpLldrQqyYvQwCZ0MURbl3yBN3Tir2s
	r1KjU5be8PYz+BffJfA7UXyNuME4gcemmRjtv14dd12bHdSTfolqs1XQuQSgnSvHNG4apgU9p0d
	p6p7fB68fA3tDEKcTpq8gOsJwztPMLWNCEpLJJ7Oq87nplVYtXvUeJ23bEDVyEhqqkCWg8BKjAs
	afR8tj/76Pdrsd05/mGQCJ8k/YFVAwiJPupceAjzNGZlsSqzepq6B8C0p73wkl2AN/eJmxV3Aer
	iJeF4IUmgg8rwfYf8KDYuVTZdr2Q3JHltkvjDUBjJoYXPjQMeE+qovv7HefYkd2+wetzjuEOKaY
	4/mxhyrVubroygEIt2REtq81U0/dtVFTs1YAbQJXj2OVjKM/xrQqmCapyQAFrFxYuLMeBvFNdnm
	lx3f/G7Ldy+lgcV+gImYp1vM3V/4RLHBZ3ywDCm41nnnKYwEmDzX8uulhClk3cnEjR5eU=
X-Received: by 2002:a05:620a:3f95:b0:92e:5b63:224e with SMTP id af79cd13be357-93631971224mr780414685a.22.1785902782750;
        Tue, 04 Aug 2026 21:06:22 -0700 (PDT)
Received: from localhost ([2600:4808:5693:8201:bb19:d9f0:6e53:91ed])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9364a42b761sm76276385a.13.2026.08.04.21.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 21:06:22 -0700 (PDT)
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
Subject: [PATCH v3] iio: health: max30102: fix NULL dereference in interrupt handler
Date: Wed,  5 Aug 2026 00:06:21 -0400
Message-ID: <20260805040621.84843-1-marcochen.dev@gmail.com>
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

Call max30102_fifo_count() at the top of the handler and return early
unless it reports a FIFO sample is ready. Because FIFO_RDY is the only
interrupt source enabled in max30102_chip_init(), an invocation of
max30102_interrupt_handler() without the FIFO_RDY interrupt status bit
set carries no data to read and can return before touching
active_scan_mask. A negative return from max30102_fifo_count()
indicates a failed interrupt status read and is treated the same way.

Fixes: 90579b69e94b ("iio: health: max30102: Add MAX30105 support")
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Marco Chen <marcochen.dev@gmail.com>
---
Changes in v3:
- Reuse max30102_fifo_count() for the early return instead of reading the
  status register directly, as suggested by Jonathan.
- Return IRQ_HANDLED on cnt <= 0 rather than cnt == 0 so that a failed
  status read also returns early. 

max30102_fifo_count() still has the odd name and int return you mentioned 
in v2, so I will send a follow-up patch once this lands.

Tested on a MAX30102 on Raspberry Pi 4 over I2C.

v1: https://lore.kernel.org/linux-iio/20260731184124.112124-1-marcochen.dev@gmail.com/
v2: https://lore.kernel.org/linux-iio/20260804234355.65319-1-marcochen.dev@gmail.com/

 drivers/iio/health/max30102.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index c37316c86f14..aee96167f01e 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -290,9 +290,15 @@ static irqreturn_t max30102_interrupt_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct max30102_data *data = iio_priv(indio_dev);
-	unsigned int measurements = bitmap_weight(indio_dev->active_scan_mask,
-						  iio_get_masklength(indio_dev));
-	int ret, cnt = 0;
+	unsigned int measurements;
+	int ret, cnt;
+
+	cnt = max30102_fifo_count(data);
+	if (cnt <= 0)
+		return IRQ_HANDLED;
+
+	measurements = bitmap_weight(indio_dev->active_scan_mask,
+				     iio_get_masklength(indio_dev));
 
 	mutex_lock(&data->lock);
 
-- 
2.55.0

