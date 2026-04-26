Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9409D2E4257
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777195048; cv=none; b=Zi8uWXODz3/PY5dQErmnfs9RyHqiPf0HyOLWWkdrmMY71cpHkyW7NPOP9TnXr4y11q//KxTQhmVFKmNC7TeQ4DXvUHM4+KmOePKUtCL24E95xb1lWX+L+RaP6VuPZgdCiYlgtrjUZMEDCM1qA3E15tSZuvQeKVeqL8slOybut7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777195048; c=relaxed/simple;
	bh=6ODq9VgEd6Nwwf2jjt/2iBXCKt/KjEZ8geOEm7TFKko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s8CREOjtb9uClz/uE9HF1pFIZbYcIswYtKfb/TfJJUpKhxYDotCHIo0SDcsj8Re8zI6MWadwHWd6jhfkDFGyWprjjIQYxwsnYkwkbvKm1LojNKF4YJV4Dy/gAAlRHaq1L/j3mS+BO8knExeiulxepX393DlHPljVOOectlPo8s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTMxlUgP; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTMxlUgP"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82f8b60e485so3851869b3a.0
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 02:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777195047; x=1777799847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8qReSYigGO+ojCpdoiAgNHEHSCcI92dGlQiTWsfj1Q=;
        b=VTMxlUgPAUSZedJDgs/tjOmFNMEAIYbse6yP9HUZIOai6BUIlxMKRG/TUsBIfB6PuC
         Ad+/J90Lgh3PqZtlUQ1wsfKyM8d6McKxAAy7BOp9Xj1SyVFb6dvceHtgW34b5tlATjk7
         aKYVuxfGN9W0mcHKtjEvwMULmqjX7lA6ZDjb8z7nB1Kqt+tAOtT8/34cThLliypV3f3X
         Y9Z8Vav9TmyKvhmtMevhLT0n9yxvkMf1RelG/zSFhW+AVy1gDtS0NUaLTEJEPLrTvIb9
         ApHmURVqCpw6j/zYVnCidZOSwDVFmJVlWAfOWpd+03OvNOORg6xa+jcuuC90IuX7zk+t
         t7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777195047; x=1777799847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m8qReSYigGO+ojCpdoiAgNHEHSCcI92dGlQiTWsfj1Q=;
        b=DUG6gKiiz294OkLe8VdxfkhBjxUpWfMFBLaHs9CIxJPYG0E2RGy7ARUrO8WcOFP3uL
         LbCc6amOR5+UdfDQruKcsThahRNBdkM6uiqznDCzYec5Ed+EtRkJ55TicqsBKQRNQpnq
         Sw2XBVao0qPL/44gHnZGpwyG8oSaCeFEF7CYvPASY7DvgSERGiFlkNOU11zzp1JiYHi5
         /0MjBTSbvxstI7tfoApIqPqgiDZL1ZsIVaKEf2zrHVTsh0bRPAsM+6AQGpha9YNf5Emz
         qWbmNypmzAF6gefGqIwqHt0Ey6xNg+dDnSXoRC3uOp8rVSlBnRViiROBOvStx1BWFJcU
         gR9Q==
X-Forwarded-Encrypted: i=1; AFNElJ8GJ7ha03HY4UlClySqYHvZWKH446BjvDL72mIY4HU/JIE0s2qA/gcGGL7Hrs/xaofwprUKea2M+pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGpg5gWOV3J0DMNvwBI70SbRWVgfChfigjWLAZbciIM/4OfLoI
	+D8ZELBwLoH1FgmbJYSRj/kbsqDIbvEqYG20LAj0SvbFan+eY+wjUqnF
X-Gm-Gg: AeBDiesSPsmAlrbd2EqtvNmsLPN4l1qH0ngcXVvpT7VsVBJjCsOdvYPli5Ds29D1Xns
	M6issgRRLEU5iJVKB51eUfSIszsMhqDrmNaao7W5Gm784cPz8tkhIxsqsx8k3DT42D6+JW88QGM
	yOWH1KyWNZD3aoHWVHlNGmSygN7Zc4BYsPuVcIR6+m8Yb1mKBRyqVytqDB0jKFIYwQvOF6D6HrP
	qcRDEndEOq6a2KAs3RsX/ORlJtz94Iy29b76vG7oijQ70cUqLdZtEpbQVoGQT717WZbKENL/PBV
	rZ/wNo3MgUecEtT3DnoxE8elowTzTfWWAlbvk6O0Rz9Yv3WxUa8lsOFkQz8U/5wFLYgo7IVg6a0
	2E+9SSXT8ujlecVu0Y2G8TJUCCrxiF03UjfCqhGd0PofGVn4kF/M8ti+LlA5fhYjdLacrKffhDs
	Rh/rgrVAb1NhtUOAGus3eKiCsEvUtKsDOKF2pemT0aq6WlxMVSWpss2Ej6q8w=
X-Received: by 2002:a05:6a00:1826:b0:82f:2384:212a with SMTP id d2e1a72fcca58-82f8c961ef5mr41102085b3a.26.1777195046954;
        Sun, 26 Apr 2026 02:17:26 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e982fd3sm36145226b3a.10.2026.04.26.02.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 02:17:26 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	mingo@kernel.org,
	christophe.jaillet@wanadoo.fr,
	nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org,
	kyungmin.park@samsung.com,
	k.wrona@samsung.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/9] iio: ssp_sensors: factor out pending list add/remove helper(s)
Date: Sun, 26 Apr 2026 14:47:03 +0530
Message-Id: <20260426091710.3722035-3-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260426091710.3722035-1-sanjayembedded@gmail.com>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

The SSP SPI transfer path manipulates the pending message list in
multiple places, each time open-coding the same locking and list
operations.

Re-factor the pending list add and delete logic into small helper
functions and drop use_no_irq variable to avoid duplication and
simplify transfer flow to follow.

No functional change intended.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
Changes in v7:
- Following suggestion from Andy, keep helper API definition in single
  line and re-place the comment section
- v6 change: https://lore.kernel.org/all/20260415050749.3858046-4-sanjayembedded@gmail.com/
Changes in v6:
- Include tag for the suggestion of helper functions
- Drop completely use_no_irq variable with review comment from Andy
- v5 change: https://lore.kernel.org/all/20260406080852.2727453-4-sanjayembedded@gmail.com/
---
 drivers/iio/common/ssp_sensors/ssp_spi.c | 58 ++++++++++++++----------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 08ed92859be0..870214551f0b 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -174,15 +174,35 @@ static int ssp_check_lines(struct ssp_data *data, bool state)
 	return 0;
 }
 
+static inline void ssp_pending_add(struct ssp_data *data, struct ssp_msg *msg)
+{
+	/*
+	 * Check if this is a short one way message or the whole transfer has
+	 * second part after an interrupt.
+	 */
+	if (msg->length == 0)
+		return;
+
+	mutex_lock(&data->pending_lock);
+	list_add_tail(&msg->list, &data->pending_list);
+	mutex_unlock(&data->pending_lock);
+}
+
+static inline void ssp_pending_del(struct ssp_data *data, struct ssp_msg *msg)
+{
+	/* See ssp_pending_add() for transfer length logic */
+	if (msg->length == 0)
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
 	int status;
-	/*
-	 * check if this is a short one way message or the whole transfer has
-	 * second part after an interrupt
-	 */
-	const bool use_no_irq = msg->length == 0;
 
 	if (data->shut_down)
 		return -EPERM;
@@ -202,35 +222,23 @@ static int ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
 		goto _error_locked;
 	}
 
-	if (!use_no_irq) {
-		mutex_lock(&data->pending_lock);
-		list_add_tail(&msg->list, &data->pending_list);
-		mutex_unlock(&data->pending_lock);
-	}
+	ssp_pending_add(data, msg);
 
 	status = ssp_check_lines(data, true);
 	if (status < 0) {
-		if (!use_no_irq) {
-			mutex_lock(&data->pending_lock);
-			list_del(&msg->list);
-			mutex_unlock(&data->pending_lock);
-		}
+		ssp_pending_del(data, msg);
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
+	if (msg->length && done &&
+	    !wait_for_completion_timeout(done, msecs_to_jiffies(timeout))) {
+		ssp_pending_del(data, msg);
 
-			data->timeout_cnt++;
-			return -ETIMEDOUT;
-		}
+		data->timeout_cnt++;
+		return -ETIMEDOUT;
+	}
 
 	return 0;
 
-- 
2.34.1

