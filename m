Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8171A5B9E
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303632; cv=none; b=DahNGJ3Phe6/YllS5RBE4MPXViRfIaoUgBs5fy9Wg9btiU414ktrKJ/5F148AZaWZmzEPzQvX7mOWWLiIJIHjeYKbNUZ7z2Oq+PeywQ4RzquZVgXVI+6YPNNXAFfouQsiplxDi5GqaL/VcjT663+rLnykH/nru1JKKZvhWgwp9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303632; c=relaxed/simple;
	bh=utsr2wFERS1dweRxRw6x9TMZVrqawmdGB2Vg8I7kYpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYewv+Kv5ZI6UON9qqxNP9lFQ/I5NSNWsqSze/wWSYm2jFUtqJ32Q0tmPdc9fdjGTteaw3QfqKEfwY3M8WzOJDSrDgUMCItoYfK9u1Jj+RPDDxdEvVYrJs88gcNwQL4Br3fBYfRez9dGcRlFFsphQl/0PFY2ABGsq483D8ELv20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bK48kZMF; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bK48kZMF"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ad4d639db3so4406345ad.0
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 01:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773303630; x=1773908430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQzoVC+zbsYW93M6OjzhineZstDtj2uD7TkTjyo4rvg=;
        b=bK48kZMF2bLtsZQ9S844dQppDK8b8pMYsTbY76/KewJnztp78eD17lVBnBijsyI3Dr
         xJJAhEJmluWgLDrzPVwAOtVU5hHa5Ei56nLjN1YCA3wxJ/GN0R/FzOYE3zLwrsKklbhH
         jJS1AFJFBPbqkr+GBuIZiGHTccNiirezm1MJwgnAyrOPc/HFawztREAFCZzJ2vfb5xgb
         4938CTfPk24PJS57AciGOBJj/5xTYA9rZHUinxV2Ppssnjs0o/oVpBXhd2TV0M/4SZrR
         iTdvz+KEBZBiI/3XtZxjVAjeAZSpu9pwNQ07QKdb98apFRg/bPcRfaCo15TgmTmi2CVG
         Ez1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773303630; x=1773908430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RQzoVC+zbsYW93M6OjzhineZstDtj2uD7TkTjyo4rvg=;
        b=BY79yQbOhrZh2q/tnpCPvZPO/c+JrHhXzJ7CV8tIZCJVBlUlGSqH2Nn6RcHi3OwAne
         SoTFVEitClKO4/HjrkLXqHiOqMoMByfshwAfcxW66RJ8QRY22AeZE5ovhAqZhCXMpuaD
         XPg92g3x2CPpMhIDrpWo6v/fMn6FFGEfTYdGrwmQ1zWnTRdpnralNxecnTv87rZ2pEGI
         8LbLgo5uJ8AL0wsbrHuvCuflTQcD3H1w2S+a5+CGeiuCUDB2wStPAjmvIGgDaluRoWpB
         ODj0IWDAgG8E29j43IqYOHHQq/Fg3AyxU6YxfhFI/WJ/ClG2uMEydDvCpSqOTqA3mHKW
         lGvQ==
X-Gm-Message-State: AOJu0Yx9l9odPWJxPudFlhpUs5SIn+RZCI0FVqApCrH+lHQeVbob91l9
	tE4b9wS+ueX0d49i5U07M+jAlTt2Ejegaf5V/9MuIbTbb2h7kWkE+e5J
X-Gm-Gg: ATEYQzw0ndp8eBKCgk5ZwJGPbnj8aI+cVu+ehAU745Xr8SzXJwLT8xrGmBS0rxCZGlA
	6CFd8KgU9L2WUsXruNBkPHkPlnNhYbJ9VWYrgr3ebezvgKaHdRwVU/1sKvqzcq1uii1f5+72Sci
	jMTelZ6AR1ay7tmrnthHWO9H8m4+VHXDTMtif9b/z9e6w6qorGHvjP1JIb/o24W5CZfLABjdPLq
	2ANi9medJfjriAuoN801upUO/G3Sv9iehoLO+pZBeqMKu+JbYHt240Mqpmw5ZGUO33wv6qTtDF8
	xRbOh85LeS8W9f+RXrJphKanmcqNIq2sC7BHdfP+7zbzoEXguXHwP2lZPjxQ1IRndhjPh9PIQPU
	d/e7f9zwr+fcC8AEFO9ssWMkjuEQj9NcgjpI5fQv11Zxv8hVjyvxN9ZO4Q8guS9OSkL3qtzx95r
	WWMNH3VY4yrtp6b7J7Qa8xERO/gj9DZjBSox+yXtiIZ24va3HqY/EqRYhB/55iEG7ZLoMKlv177
	v4sQXyLnQVU9I/hQgsYDq0=
X-Received: by 2002:a17:903:2288:b0:2a0:fe9f:1884 with SMTP id d9443c01a7336-2aeae95b193mr56649855ad.55.1773303630577;
        Thu, 12 Mar 2026 01:20:30 -0700 (PDT)
Received: from fedora ([103.92.106.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae24a91dsm64388905ad.31.2026.03.12.01.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:20:30 -0700 (PDT)
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	waqar.hameed@axis.com,
	linusw@kernel.org,
	sakari.ailus@linux.intel.com,
	harshit.m.mogalapalli@oracle.com,
	antoniu.miclaus@analog.com,
	andrew.ijano@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Subject: [PATCH v3 3/4] iio: accel: mma9551: convert to guard(mutex)
Date: Thu, 12 Mar 2026 13:49:41 +0530
Message-ID: <20260312081942.23858-4-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312081942.23858-1-rajveer.chaudhari.linux@gmail.com>
References: <20260312081942.23858-1-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock/mutex_unlock pair with guard(mutex) in
mma9551_event_handler(). This ensures the mutex is
released on all return paths and allows returning directly
without a goto label.

Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
---
v3: No Changes

v2: Dropped Header alignment change
---
 drivers/iio/accel/mma9551.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 02195deada49..65a913972ce2 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -9,6 +9,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/iio/iio.h>
@@ -337,7 +338,7 @@ static irqreturn_t mma9551_event_handler(int irq, void *private)
 	u16 reg;
 	u8 val;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	for (i = 0; i < 3; i++)
 		if (irq == data->irqs[i]) {
@@ -349,7 +350,7 @@ static irqreturn_t mma9551_event_handler(int irq, void *private)
 		/* IRQ was triggered on 4th line, which we don't use. */
 		dev_warn(&data->client->dev,
 			 "irq triggered on unused line %d\n", data->irqs[3]);
-		goto out;
+		return IRQ_HANDLED;
 	}
 
 	switch (mma_axis) {
@@ -373,7 +374,7 @@ static irqreturn_t mma9551_event_handler(int irq, void *private)
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 			"error %d reading tilt register in IRQ\n", ret);
-		goto out;
+		return IRQ_HANDLED;
 	}
 
 	iio_push_event(indio_dev,
@@ -381,9 +382,6 @@ static irqreturn_t mma9551_event_handler(int irq, void *private)
 					  IIO_EV_TYPE_ROC, IIO_EV_DIR_RISING),
 		       iio_get_time_ns(indio_dev));
 
-out:
-	mutex_unlock(&data->mutex);
-
 	return IRQ_HANDLED;
 }
 
-- 
2.53.0

