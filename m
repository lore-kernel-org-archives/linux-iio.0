Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFB82E736A
	for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2026 22:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788734265; cv=none; b=iUDFvQq0inimkPhrFZntxJqnJPVF+tbF9FMZTxRXmpKihahr+r7iRhOLKQ0zWEIirGPNVnhEGT5k4DS+k9smj4Te8k1Yd8sHz0m7F3IjeRM5qR7cqhymxnmS4uMOx8KoQcd61k6IRXn8wp9Xl4C5EIkNiLAjajTRw3eKbxOII8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788734265; c=relaxed/simple;
	bh=1nyGnRR7H0bApTzHX7MBbxqgr1IQhdKxtm5fS0KuE9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MazOra3tA2MKDqPpNnkslSuKkaGhZFFeP5Ku1ZY152+2EazXcF2nfB7BlO0DCsuBo/fyftWBnrUCQ8IDbJvyo+zyaKuQiZtH5ENakpgawHNXpCs1fszstiX6UbQJgcwKiSkGywewsFBmhIqfZctnn1TlWbnv7hUyhKEaF9mHzSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6AL1OPi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6AL1OPi"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49b9320423cso32090935e9.0
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 15:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788734262; x=1789339062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WAPzz0F7ZYpxewku3mWPEkL5SYF6ac62winU6eKHPNw=;
        b=b6AL1OPiZkxwD4ZFJq9SxmsH6pR/3o5gYs94qiNe8WqAdKMZcXdjkmhDMmq/jntbG6
         uORmP3OuqQ3P1WIrN8AXYMWwRDkK+kqxWmxEMl5N1QQo7wfnIN78rKZu3y8ALZ4G0Y9Y
         Ls1d/7RAFEhTsEot+IkNnuMgFhy8+NXRRwz71MLrC6TrSyvuf9KWoNQpcuukowzHDOKh
         mKcRBRgKyCvX9Zllb9716hFN11mf6dOhYOZmvEjc3mTFx5avXLgGbbo48pCjfRuy6mhX
         pkO4lobCz8osi6DoNxVHJSBf6f1Y84WGoi/p26wh8bqEfdTkKS+p1lIBv8xoJIjRSZwC
         WuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788734262; x=1789339062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WAPzz0F7ZYpxewku3mWPEkL5SYF6ac62winU6eKHPNw=;
        b=ZjD5ynoEbh+vcBPN3JJ06rHx2yLLNlu7iHXjxopYE+Yf4zXatKBIqFqDaRujxkgksz
         DEjUXdJ/V7jPqX5W9c+Evqwnz+zV8R6J0MaGNgSMhg2jxFy7CdpEc3cDm7ZPKEUc6CvM
         WSKSZXzybQjn+FYEEzdBOv0vTJXMaHMv7DkHc7CyoycyCRRjZOyqyr1ZDub5UsyOMiRr
         kIPHxIUedYH5qazs7+mQvj5Nhf1wg2ioIYiTQWIa0bE2Wno8TKWrJeIBKrv9MigAXIif
         VbITudA4G0sHYScHXMY9+sooPrZNN5wMSj9iptysInuPAjxSeloiZ/MwOCnptNYFsEGp
         2X6w==
X-Forwarded-Encrypted: i=1; AKwUvBztQknSO5qgzTtCHz/nOfxs8Y6C/u1MC/E/7UOp+q4DqVjmqVwxFkMkDAz3ZHqBRA8hSXWsokh6nNM=@vger.kernel.org
X-Gm-Message-State: AFuF++nSSgoIbBZ7AK1D7pOT0wr01y6oOYxsOMXtwRUVzSerKwp06FBE
	UabT4AzjshXpMycsPITz28P0FEiv9ps66PrWSIzg3ukBReLOxrnXKSVF
X-Gm-Gg: AYBFou2pHsudQMmK1IZ2c2mBMw1FIoEAuTMKAk9t9bTaKLpExQHKrXT1so6ySm4USid
	YNo5E4dkUD3yGa5zk5GYCsvryLrDLOhy9KhG6BKw8Iw3b00bISGeCZ4oC5lazq3lKMMjLMDzS3G
	vAYBVFj29aKae+Rt4+S6w2PCo+bcQDmn4HQwJNIbXdOXt1lcFhn17qv9dNQZh1pL2OHFHnkFacB
	wJmujcnP+cnkOwspM/GsbpLK842nuLq05IXYHqOPpy0wEQYxWNrfPSyNA21IORoY1rasZU3nFVR
	eLuwoo5sb4Pniktfc+VHAZ2KtMcg2txPr0NjWdH3iLoZv8HTTfntN+/ELsNK+ebhM1avya/XmCA
	zCrE1v6aeYDunS9AqEa4/xn6KqLO9ctFrIhAPaGbWrJCC+/GIS2wUR1fJqp4SW8zUOwr8cGRE3e
	CX0pstx87Burs5q6CFGAgv9axQ4AQ/NSfJFSkkkbbeV8CANAv4zuyH3Ad+3WJibgz0konRmk3Ps
	X3WN6qGby6IXJu3ffSUiOhMH1uIonirSxlZSF/YvoLlQ4jwLyi+Ii3fpcO7XTO3TTYIZnkkE2oG
	NXD8T3ahaA==
X-Received: by 2002:a05:600c:4f89:b0:49c:f617:7cf with SMTP id 5b1f17b1804b1-49cf7f32d0amr303208485e9.0.1788734261704;
        Sun, 06 Sep 2026 15:37:41 -0700 (PDT)
Received: from kdev ([81.56.8.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf75ce49esm457882755e9.1.2026.09.06.15.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 15:37:41 -0700 (PDT)
From: Fabio Cesari <fabio.cesari@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: light: isl29028: fix runtime PM reference leak on error paths
Date: Mon,  7 Sep 2026 00:37:30 +0200
Message-ID: <20260906223737.206730-1-fabio.cesari@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906131203.125407-1-fabio.cesari@gmail.com>
References: <20260906131203.125407-1-fabio.cesari@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both isl29028_read_raw() and isl29028_write_raw() take a runtime PM
reference with pm_runtime_resume_and_get() and are supposed to drop it
again with pm_runtime_put_autosuspend() before returning. On their error
paths they return directly instead, leaking the reference.

The usage count is then never balanced, so the device stops entering
autosuspend for the rest of its lifetime. The effect accumulates: every
failed access leaks another reference.

In isl29028_write_raw() this is reachable from userspace with a single
rejected sysfs write, for example

  echo 200 > in_proximity_sampling_frequency

which is outside the accepted [1:100] range. It returns -EINVAL with the
reference still held. In isl29028_read_raw() the leak is reached when
the underlying regmap access fails.

Take the reference with PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND()
instead. It is then released when the function returns, on every path
and without an explicit call, so no error path added later can leak it
again.

This also stops the result of pm_runtime_put_autosuspend() from reaching
userspace, which fixes a second problem: that value reports whether the
device could be suspended right away, so -EAGAIN or -EBUSY turned a
successful access into a failure. With CONFIG_PM=n it is a stub
returning -ENOSYS, so every read and write fails today.

PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND() is v6.19 and later, so this
does not apply as-is to older trees. The adjustment there is to keep
pm_runtime_resume_and_get() and drop the reference on the way out with
an unchecked pm_runtime_put_autosuspend(), which fixes both the leak and
the return value.

Fixes: 2db5054ac28d ("staging: iio: isl29028: add runtime power management support")
Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for < 6.19
Assisted-by: LLM coccinelle
Signed-off-by: Fabio Cesari <fabio.cesari@gmail.com>
---

Changes in v2, from the review of v1:
  - take the reference with PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND()
    instead of balancing pm_runtime_put_autosuspend() by hand, so that its
    return value no longer reaches userspace either
  - use the Assisted-by form documented in coding-assistants.rst
  - move the note on how the bug was found below the ---

v1: https://lore.kernel.org/linux-iio/20260906131203.125407-1-fabio.cesari@gmail.com/

Found by auditing IIO drivers with a Coccinelle semantic patch for
runtime PM acquire/release imbalances.

Compile-tested only: arm64 (native) and x86_64 (cross), defconfig plus
CONFIG_SENSORS_ISL29028=m, plus an arm64 CONFIG_PM=n build to cover the
stubs, with gcc 15.2.0, W=1 and sparse v0.6.5-rc1: no warnings. I have no
isl29028 hardware, so this is untested at runtime.

 drivers/iio/light/isl29028.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index 33deb1726689..03ad48930231 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -342,8 +342,9 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
 	struct device *dev = regmap_get_device(chip->regmap);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret < 0)
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
 		return ret;
 
 	mutex_lock(&chip->lock);
@@ -392,14 +393,7 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
 
 	mutex_unlock(&chip->lock);
 
-	if (ret < 0)
-		return ret;
-
-	ret = pm_runtime_put_autosuspend(dev);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return ret;
 }
 
 static int isl29028_read_raw(struct iio_dev *indio_dev,
@@ -408,10 +402,11 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
 {
 	struct isl29028_chip *chip = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(chip->regmap);
-	int ret, pm_ret;
+	int ret;
 
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret < 0)
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
 		return ret;
 
 	mutex_lock(&chip->lock);
@@ -461,18 +456,6 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
 
 	mutex_unlock(&chip->lock);
 
-	if (ret < 0)
-		return ret;
-
-	/**
-	 * Preserve the ret variable if the call to
-	 * pm_runtime_put_autosuspend() is successful so the reading
-	 * (if applicable) is returned to user space.
-	 */
-	pm_ret = pm_runtime_put_autosuspend(dev);
-	if (pm_ret < 0)
-		return pm_ret;
-
 	return ret;
 }
 

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.53.0

