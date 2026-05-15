Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E627F3E8321
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866835; cv=none; b=McwzZXLIxStnmq7VGfoKfgn/o0BcOSlGuhFBQo5TGnOH5y3pVcRWRmBxgcmokgBwzRFrNZJfmoLLE/AGOZMpHkdHXo4f5RiQoxShTXm0MDBvDcq7qW+43ZQNp3mlBCXCF9r3sD0om3jSy1qMiSCrMUyzjnrHpAaJXPoW52dAY10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866835; c=relaxed/simple;
	bh=RN/vwHhek3NUO7D/PWN0qaSY9GTno4kjz7JVIMu0VeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bYCGeqzLTMxW1XErhCoAc99m2NxVck6DR6gFutEM3Z6RLZPTuLSrywaaHzaGejK0KgoJOfcvU8QaOuI7XvhlrdfUerUaTvZJOtOQHmZjaE+2MQWs5VKd9MTDTUoXyujJHV38V6XyX2+KJw1Jn2b5vbRSI+4s1Wqtsa8v1lpy0LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7Ac3EJT; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7Ac3EJT"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-83538fbd0b2so60723b3a.0
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 10:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778866833; x=1779471633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2Fwa3o4kXuuMSCYHAiMYt+UOUcR4mq7OdjkF9wTUSg=;
        b=Y7Ac3EJTCafgeTc8cQkcPgfU6Sw+7XDYuTxlDyZ39jwLEl7rNcu5pwjeCgXai9Z1Np
         DMOttaEW74pDqbJTyruyRQLU6IcHUrgTlwT53aBGiY6zQ3oCkK9Y0637/0nh/3glcQVH
         kgDDA7Oitzhbxiv7BDGYW8rK/z0BvIOFr573lOOxZMlW0mze/0VxsK7/Xt8YVKJTL9m1
         vrUps7aNy0W4tJ2Yr2Mk8OL4xxPcaFbIroenlN10p58yx1V65Sw1HjY/QSdc2m6WSsUm
         l2GM8fhKQPsTZdubLc1rphp+DnJdcgYrpxRKHbgfo5aH6zY/GbT1r/WOd/ICIkrEnqAR
         v+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866833; x=1779471633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C2Fwa3o4kXuuMSCYHAiMYt+UOUcR4mq7OdjkF9wTUSg=;
        b=Z8HiZMyvWNnNUivBhEG0s8rLs2j0/ikw3Y2efTF7NkHvRNCquckEQsCdU9l6pOYHXc
         j5W2XMQEbmGHrMTh4Kk0OujZh67/EWkv6GMDVvBwBEfejSJYRMOktvdsGdw6qXqSUWIa
         G1ehXRUPq6ZRZf4GwOlNtEI+CHzLCmNqyeGq0KdRIPi12TpiASUHutLAedTs36sWQH4j
         d4HCLELGt4gDKqM5Jk3Yu8SIeWMpC/+/xyXoV2GSCx1ac3Qw5oq4iz1iFVC5/57KN2AW
         87ZulkmHixk1IMYirA9Wc+2e3rEi1b4IAffQBl8FkV2exAUv+imlwppu/LbxpqVD/TPs
         fPVg==
X-Forwarded-Encrypted: i=1; AFNElJ/l27q8/7qKcqEW/HV21N0/rGeXZsObFaKjZgBtys2XLY25kgr6XrcWXq51KGrVrojU7yhUiEm3B1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6xkyLJ1uf5P8uI+s3pEstnqN/UJZULtDci7oWRSLNGqnnUq9T
	/YL+T8XXLYU00oPgASqgP+Kx/eF6djoeyEoUccItFDD+q/hRRaQJw17Q
X-Gm-Gg: Acq92OGnlr6ah7BO0YcG7FNFl4KiRJchN6326guiyLXptKHPATwwejM95j42UwHx/0f
	KHQTo0Lym+C4ADV1ub4qSxrakTm8oS+aXhj4fXzFeTKnG24ANTli3PDoLrT29oEYm7jP7hu2o2T
	U/4SOIB1QRMV27inx2FrRPILge+RPCaUQzimdLODwBQ74ckh9K/pcFG/wzX6yKiAFoFx8veNuKr
	xq7W83W+t9G/WF/4whRyu+z+yLzP0n3zQ0zMafymABG7Z/FH/d3/l9Y2jsKv73xmK54P73+Ud5q
	lt3DWfE2J0JkbLC9ptswcGXmVarOoqZ+nyO16KELEqQIY0BSmFdxNU6ER00bC0uH1CKdYxrWNLI
	sVkhe45cZbMcnbtPclwNd6wUdBWb53RmKbQhQM+oUz5eN9D3ye/xfTdD+AeD7jlzbw+M2q7kSr8
	rhnWHrj3c73RhnLLib55mMmTTNsLplzNMmE/aUC4G9mJTniFrI
X-Received: by 2002:a05:6a00:88e:b0:829:7e6d:cf22 with SMTP id d2e1a72fcca58-83f33dbe4famr5056871b3a.43.1778866832998;
        Fri, 15 May 2026 10:40:32 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f2875f0fbsm5579034b3a.57.2026.05.15.10.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:40:32 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	tglx@kernel.org,
	christophe.jaillet@wanadoo.fr,
	mingo@kernel.org,
	kees@kernel.org,
	nabijaczleweli@nabijaczleweli.xyz,
	kyungmin.park@samsung.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 02/12] iio: ssp_sensors: factor out pending list add/remove helpers
Date: Fri, 15 May 2026 23:10:07 +0530
Message-Id: <20260515174017.3962168-3-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515174017.3962168-1-sanjayembedded@gmail.com>
References: <20260515174017.3962168-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

The SSP SPI transfer path manipulates the pending message list in
multiple places, open-coding the same locking and list operations.

Refactor the pending list add and remove logic into helper functions.
This reduces duplication and simplifies the transfer flow by
centralizing the pending list handling.

No functional change intended.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
Changes in v8:
- Following discussion with Andy and Jonathan, handle the flag
  and have preparatory changes for subfunction help of critical section
- v7 change: https://lore.kernel.org/all/20260426091710.3722035-3-sanjayembedded@gmail.com/
Changes in v7:
- Following suggestion from Andy, keep helper API definition in single
  line and re-place the comment section
- v6 change: https://lore.kernel.org/all/20260415050749.3858046-4-sanjayembedded@gmail.com/
Changes in v6:
- Include tag for the suggestion of helper functions
- Drop completely use_no_irq variable with review comment from Andy
- v5 change: https://lore.kernel.org/all/20260406080852.2727453-4-sanjayembedded@gmail.com/
---
 drivers/iio/common/ssp_sensors/ssp_spi.c | 50 ++++++++++++++----------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 08ed92859be0..3d377a482161 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -174,6 +174,28 @@ static int ssp_check_lines(struct ssp_data *data, bool state)
 	return 0;
 }
 
+static inline void ssp_pending_add(struct ssp_data *data, struct ssp_msg *msg,
+				   bool no_irq)
+{
+	if (no_irq)
+		return;
+
+	mutex_lock(&data->pending_lock);
+	list_add_tail(&msg->list, &data->pending_list);
+	mutex_unlock(&data->pending_lock);
+}
+
+static inline void ssp_pending_del(struct ssp_data *data, struct ssp_msg *msg,
+				   bool no_irq)
+{
+	if (no_irq)
+		return;
+
+	mutex_lock(&data->pending_lock);
+	list_del(&msg->list);
+	mutex_unlock(&data->pending_lock);
+}
+
 static int ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
 			   struct completion *done, int timeout)
 {
@@ -202,35 +224,23 @@ static int ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
 		goto _error_locked;
 	}
 
-	if (!use_no_irq) {
-		mutex_lock(&data->pending_lock);
-		list_add_tail(&msg->list, &data->pending_list);
-		mutex_unlock(&data->pending_lock);
-	}
+	ssp_pending_add(data, msg, use_no_irq);
 
 	status = ssp_check_lines(data, true);
 	if (status < 0) {
-		if (!use_no_irq) {
-			mutex_lock(&data->pending_lock);
-			list_del(&msg->list);
-			mutex_unlock(&data->pending_lock);
-		}
+		ssp_pending_del(data, msg, use_no_irq);
 		goto _error_locked;
 	}
 
 	mutex_unlock(&data->comm_lock);
 
-	if (!use_no_irq && done)
-		if (wait_for_completion_timeout(done,
-						msecs_to_jiffies(timeout)) ==
-		    0) {
-			mutex_lock(&data->pending_lock);
-			list_del(&msg->list);
-			mutex_unlock(&data->pending_lock);
+	if (!use_no_irq && done &&
+	    !wait_for_completion_timeout(done, msecs_to_jiffies(timeout))) {
+		ssp_pending_del(data, msg, use_no_irq);
 
-			data->timeout_cnt++;
-			return -ETIMEDOUT;
-		}
+		data->timeout_cnt++;
+		return -ETIMEDOUT;
+	}
 
 	return 0;
 
-- 
2.34.1

