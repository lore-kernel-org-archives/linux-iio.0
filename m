Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BBE2BE655
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776194453; cv=none; b=qHxiD/dzwvDQceXCrMr1BPmsaIID2CPD/hiBJtd3n7NTyyD0sszlkq9pS5iotnO0xD7tXPwViWBlRgdy/mbd9GCaD0Ibx42WIYwApTrTN4IqIrkDsXQvZCWyqoXlCfNKvRzMj5x6He3yWJsDTMWbuueJVV6tkO5UPfTHHogKCIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776194453; c=relaxed/simple;
	bh=xf9U71+HN2MDMd9BJrUzZQJ4H3oJNadiw9CcQzzV50k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bstmNchmOQC6Gtu9U9kZw80c2tl0VPDPUh1wPJ1m7oZ6U8SkLl6zpnLRGntxQXyPVHZconieaZVMWnDZXCYT8dyxcbiFc1ahgrPo+qjvyr4sJ668ACu/lbUWjFhY65IGY0VLdZxxH1aeB9ByclWoIxtX9MdFLMTTBY42qAi0ufE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6eG6Dam; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6eG6Dam"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35d90833cacso3606634a91.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 12:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776194451; x=1776799251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wj2VwVqKMzG7UWku83Fv86KFnQXu2AODJQTwQwZquGA=;
        b=D6eG6DamBEQhxtMeayvhCFPqYvDTjdu/QbCQHqkV44ar5Lu1VU2Q2FJi3/wHMlZrvf
         y+TNAIkltYtSrMqDv4iNKV+NoTDRqNWYcCJMW0Iz8b+CjmJqU08DRVPCA5mNBn9DjE1X
         LSrod7rPWZrEPAra2zMtMhZCOnDAn+s+vDYfD8PgSIGCeK2Y4YVlHEF1m2m4Fqzoz3Vf
         2330jobO4ILr62xBL51oYZ6f7BdqGbkXQy8LBOKjgb/spUrSmZ8WmrTvcXMkR6uZTRMj
         9hGOkcanmMwXMj4e8ANO2YLJAjy1ALnQHa9iQDT3ScAW4PxiHdJYSs6TdJXQJrAdNWPI
         wlvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776194451; x=1776799251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wj2VwVqKMzG7UWku83Fv86KFnQXu2AODJQTwQwZquGA=;
        b=k0Zx94WkFHriyYPQ6N4ErDtgLNKGGXmh9Z5ZFMu6VtGkMNzn8TPlRdAOcemnBe2yp9
         eNgAQn67R4l3rgZdy5LsIgRO745roa5ZLU//J63WkYpkkvtIaAOoAQEQLAsx8W6DygKG
         m0UbNYAbFX53aCGe820pkBlGKMdMgJbGj2IH3k4W2ceXMZ7W1ObmIuFIuv8zhezCTgTS
         ojdmoh7Rb0hTl8rHJL97+5rVa9dTg99r0PX3LqL70dKz/XD0deMe7wtdDrHBYrBzhgJ2
         W8+5/9UNCqXnyqSThyTYSL6jINA/hS61cozMFv9+Flrk7apiIevYtT+8Wo/H3FCAoYDE
         zuzQ==
X-Forwarded-Encrypted: i=1; AFNElJ/s2TG4V4AQYjdltyn9vcSj7tqx6NjJDCrWDkzfihLngmATCJNiKazqjHZ/8dn3rmKE4+FQVW1KigY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzX2/RLbXDhGs8yPk/O4fwnem+93p01XcQ90pl43uyB+upT34V
	K8gDwsmADNhRiUsYUl39keY+IE8gp52JaP/954P3wVlfcZSSHtY+jmlM
X-Gm-Gg: AeBDies1ItfkxJeXnZ8m3VTCZ7Gb+cXTj+cAlh0sFDfS4GkUdexUjkWOy3VbYMrK4Ma
	zU+8kCD+TJHfB8gMkEb2/TDIF/YrXt44PqZ4OhIB8m6Q7mc3AOMQ+hNHh/qMTzCdcBU3o8kJaie
	rmPC3018CdnS3qbAuNgrVU0MjHf9htHRO5bJGX95c9lQZPKbuBdQ1Rjk9vVaVGqxMeIM/8TI9o6
	Tw5JllrMSQYxHQZzOHQYN9IlTIYrpB+oDP5yJXSnkTLZkFufNsdX+0Rr1KvGB2lfTwUlVzbbrMe
	+vIxJknWmK+9qYVgG9/4mckhK9oobQmccvlHcYkQY/owFm2jSs/QyP8if66sMMvaLIYVrgmxerT
	m9yjJNHzMZae73Tg9CBICnlrxWGKj92DylT42FEYYC5jiiMnxMUv+B9QKH7ScoI7kFnjEpb8oM7
	BTn+oTLE4Bd71OHH+lVrMVj2q7jVSWho5riGX+C7aUPt7/KMY2y/rpNyei29w=
X-Received: by 2002:a17:90a:10d6:b0:35e:581c:6bca with SMTP id 98e67ed59e1d1-35e581c724cmr7917600a91.3.1776194451177;
        Tue, 14 Apr 2026 12:20:51 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fcdfb923bsm496773a91.15.2026.04.14.12.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 12:20:50 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: mma8452: use pm_ptr() for dev_pm_ops
Date: Wed, 15 Apr 2026 00:50:45 +0530
Message-Id: <20260414192045.3598010-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Use pm_ptr() so the PM ops pointer is automatically set to
NULL when CONFIG_PM is disabled. This avoids unused-function warnings
and follows modern kernel power-management conventions.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/mma8452.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 15172ba2972c..f2b71077574b 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1744,7 +1744,6 @@ static void mma8452_remove(struct i2c_client *client)
 	regulator_disable(data->vdd_reg);
 }
 
-#ifdef CONFIG_PM
 static int mma8452_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -1812,7 +1811,6 @@ static int mma8452_runtime_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
 static const struct dev_pm_ops mma8452_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
@@ -1835,7 +1833,7 @@ static struct i2c_driver mma8452_driver = {
 	.driver = {
 		.name	= "mma8452",
 		.of_match_table = mma8452_dt_ids,
-		.pm	= &mma8452_pm_ops,
+		.pm	= pm_ptr(&mma8452_pm_ops),
 	},
 	.probe = mma8452_probe,
 	.remove = mma8452_remove,
-- 
2.34.1

