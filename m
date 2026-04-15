Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0276B1E5207
	for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 05:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776229690; cv=none; b=nTTehcx1cyL69W6h8AMAIAoAgd88DIm4dVPW8SNjitYUVT59/8KBmbhhF1QhNroFN3CnMdZWeZS00kOzimwPBuH+OIJS9woaeFUTc8MdsqJv9mtdbzYX6gLp1KszHvc374sPqzUg9MAui0LMCzVIkYwxvA0e9WZyQ1d31uryy4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776229690; c=relaxed/simple;
	bh=UF9GAEqRB3HQjUw34L9XQFabmsBUcBIRhv1k0WYRFqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ox3CMsdeFD6v5MFwVNza7NCsxRDA1yvFUUTvKGsugZQecQ48gUEeQqzJD7fRTc04+nb3rFKRc6ZW1bbk5C0fwrX7ZC0RZ/sogxX+1yB5vQCbrtS0Oc5S7PYchin9AzC0Y6Ony7a18an3pwnFlr2xyv3t2DrXj237LKqEaPUtG9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9DAmXb5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9DAmXb5"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f431c0ab6so1308010b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 22:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776229688; x=1776834488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCuWTPIrAoEUGe1y5cea/5QdVJHDC3QtCN+aWosMD8A=;
        b=f9DAmXb5W+STcUWA7U6huHTNGz4mkIKIg6KdL7ztufN6iOP2cyxDgCTn5xi+X7B9fj
         rfDGqRXIFCsuTEM26oJD8WBxQB16ynyRARr1OcDA0UGcSYIh5d51ELJvtYPE19aSZ9B7
         5UmSjlSyoPkg2ZKAs2geor3qywLf6JOcr9oCiUjP5/VeyU3lEGyLSY+usPgBaMvPVUz9
         gJ6eqsUu72hZN7fRskylSiQ6ys35XZVBdnIoSrpSwKzl4+P4lvD3fs2KmiXhd7pMj4UC
         FAtlgYQsf8R7AIatA/TiAnmVS96+Z+FPi2pFnJ7ARzzLfDG/kSx3r0vSYLAYY6rI+QBQ
         0x+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776229688; x=1776834488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wCuWTPIrAoEUGe1y5cea/5QdVJHDC3QtCN+aWosMD8A=;
        b=X2Zz/3fjPJajKOD8EusFvqkTiU0kCyiL43g8eTkQFt3qCvMRADA22b1YfjLsyY7x/n
         hjaP7B8e6dGBtgH3Ww5fIM3wn5GEtkp6RFpOQdLQYmGpPMDW6W7kDNe0iFejMu0PzxQZ
         R5ZApxSXg0fh+Ooh2ge+08MjaQ33gdpxpHOws1OHMiWB+SATuae2KOURzqzwOTHMkM2m
         r/JS1V/yGe/S6Zm1Cfdxre2H4Ot9b2IN4FuXZ0DI7gHR2tJxHGewPV7ubjvz2iKXp1eH
         fWuKPUbl87oZ++wiT0n6C7IKK4HpgfvEJTjNJRo0+7x/8x2e9UpXtGewgk02azml9jk0
         7guA==
X-Forwarded-Encrypted: i=1; AFNElJ8ztQCasMjtiBIeRhc13zSk7e/j80sAhauS0aEX06R4Yre1r7PqFNS1hgpVQiMxQCFYMBa0JchkCiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyE2GK/REHU+vcqb+V9yVFtEndjFADUFbr0e4pERV6D/fP6p/N
	XjqEwMYQRUIwQ/3zkzreCnn4fZBsdEoG63nmcvBWbL+3mHjwZOqiPCaa
X-Gm-Gg: AeBDietrGsF49k0yfArYbE2X+fkZpZ3GwVlvV5b+fBLiqxiFy3qmw+M+jWYSWWVYJ/9
	mHI8OFa2fvacpJEsma0dXuj64W4an2iaDFkwRRrKVroXwKvLLY6kT5fmJ1JeoeKgfdQ/0TOXIZc
	WbmDkFtvzKgK1A8W7FOWNQ0018eJ7cA2qVr98wvK22/KfQCIiAjUur8PemcH7lynzSMrk8nXGIS
	EK3OhRC+/shAi5h1Ylodkc+qju6h3vTipUFDR9Bsnr/0/i3Sm9fVF0M/kBtJvxeh59XFdagrTba
	NWJz80Yphp7RjqcrFdCu7LwMG4MRy1z2/c1dyDSZq1WROR6Y/cZ2ALdyEuFb/2Xcm2II92bLyqa
	BPzYfmZKMSe0jV6vY8pV5mkfXiW0U4snnJNM3jOjuwfGgZfgvrXyfsRePT9OKWnDMaCKau/GX70
	jbNm8Rdzp5tsobVCQTJQGnFAdw8mrPif1J81/rG2aVOW7BTUqcCIjIGi32aXI=
X-Received: by 2002:a05:6a00:3a25:b0:82a:7893:e14b with SMTP id d2e1a72fcca58-82f0c3168e4mr20529886b3a.38.1776229688360;
        Tue, 14 Apr 2026 22:08:08 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f67469dc3sm763706b3a.58.2026.04.14.22.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 22:08:07 -0700 (PDT)
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
	nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/7] iio: ssp_sensors: factor out pending list add/remove helper(s)
Date: Wed, 15 Apr 2026 10:37:45 +0530
Message-Id: <20260415050749.3858046-4-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415050749.3858046-1-sanjayembedded@gmail.com>
References: <20260415050749.3858046-1-sanjayembedded@gmail.com>
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
---
Changes in v6:
- Include tag for the suggestion of helper functions
- Drop completely use_no_irq variable with review comment from Andy
- Link to v5: https://lore.kernel.org/all/20260406080852.2727453-1-sanjayembedded@gmail.com/
---
 drivers/iio/common/ssp_sensors/ssp_spi.c | 55 +++++++++++++-----------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 08ed92859be0..92418721ff82 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -174,15 +174,32 @@ static int ssp_check_lines(struct ssp_data *data, bool state)
 	return 0;
 }
 
+static inline void ssp_pending_add(struct ssp_data *data,
+				   struct ssp_msg *msg)
+{
+	if (msg->length == 0)
+		return;
+
+	mutex_lock(&data->pending_lock);
+	list_add_tail(&msg->list, &data->pending_list);
+	mutex_unlock(&data->pending_lock);
+}
+
+static inline void ssp_pending_del(struct ssp_data *data,
+				   struct ssp_msg *msg)
+{
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
@@ -202,35 +219,23 @@ static int ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
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

