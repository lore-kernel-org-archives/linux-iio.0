Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9703CB574
	for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2026 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788700344; cv=none; b=NhAMgpcfKheGjBlK5DlP1gl6Kvlmpb4TZ4YGc0oXVj+NGf8t4ArVKVdwxpjtAwmfRkClnKlXiH3b82VZJy7fdi/t9e/edZXxI1uzJykTZzk8iSUR+gSsM5AiitZYEZnCd8EnG39XD0kso7D0NKhS/krdmPRU72gWbL3N75eGe84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788700344; c=relaxed/simple;
	bh=U/D74xfwjlQoi4TcPWdP4ton1ITDg58mY6Ce5H9y4kw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OfLiGFh6DcBNBpIljxt5p/YHn2JOAlCTid44of+JsSEc764eSLPok6lvFt0f310bflZhRtY/Ul3bDqW0qbakqt5HW5QcAKrYwJhC59EU1JbR8HCjhIwuSjiuudxQCZiKue+Smm0zXOVAnEclk5xWrXurU4SERaQRDtluSOUXTH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHRZ6HTB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHRZ6HTB"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso26204505e9.0
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 06:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788700341; x=1789305141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+jOjUhdp/9Aa1j3qlkqbSJ4A0AmCxK8SeGVuNoBGBzQ=;
        b=UHRZ6HTBdy60QOVH8/yjMZnOS1/ZskwNUgpL7WW+swRJ0WNB7u6RxAwg+oQEYdr16/
         TIizC2UxBRSZClIJ9G2a4BuFqGA/xnPryZFZs7pmd0vYBe+diSR7EH3oN6RFSswP+aI7
         1/iLebcl2gunu0K9krOmWVvtdFHFVtcUlB6mDca9sNgEjie8iaGbwU2aGApQGJPJIh+J
         FcwaSCYKSEMtdFoJ29509QkxX83p4gvmKpFZh281gc4Og+P8e9NKeBZT5Yyw49VvZ8fM
         XCBOdib8sXUM15l+fK3NA2Mgi4F7rf2SWGZaSjGl9aDuHzaAYXAa2Aq///Y94LWa7394
         u21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788700341; x=1789305141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+jOjUhdp/9Aa1j3qlkqbSJ4A0AmCxK8SeGVuNoBGBzQ=;
        b=n33Hf3+GjTaojOa2skDJE5i9GG3nwWl1aCOM2i3bXAonO4zUqwdUgF63CLqJxzVPGh
         +3mHBYvB/q+xYtiG/IH4Mvv6vZiTWse7Lz2wgGLzeieoeVm0POS3sHYe9hzl8uGaw0Vg
         IIx1AuHQ2QiIPYTqKGoogTWgAvAqLpIiGmVmjQMfmAx8s8i9YVzXPh9WV4fcP5kM66J5
         gYbOOth4LOLvG1vAEijAKHjswuAOuXlA2r1Flnac2E5xDQAG10PnlnqcMdXPDaFsnoQL
         QDDhNTXrr0FGsY0pM0lZVXfZH+OJ449bE4ESRZXL0vpNwQbhKFFW+zlF8VvLMsXEEjlp
         /JRw==
X-Forwarded-Encrypted: i=1; AKwUvBz+B/mRpMoIPGe3FUBwus+DebwuNrOJGR9kqA0HcCMmyKHPzQ+rbE4GXB/Aqg1mNQSea9Vv7yNbc1Q=@vger.kernel.org
X-Gm-Message-State: AFuF++kjrvP0NTauYuxHQnQTEoPZsrB9tkqFBLqbZsb7TeRDLD6cwWhB
	UymXFgIUkrEO0e+1uGVi1yxA4tqfnkC/7olxM+y5BeSr1OyZkE1S9fIM
X-Gm-Gg: AYBFou1l+p6b1C1cVBEQGnMZCQ9RZL6DGUONpLvVyl7NVoDpH+BpakuX11Fz87H3FTH
	/EKqHHfuUtP14YdDgBQufM4M0AwKGUlGYXS4ngtwg3Vne+yFqkvzdsogqybvp6pk9OMd0jKiDql
	sHDYVl3ywv0G2TdEphMuc5pw6X7pCq2vMKBmqp1cDCDF6zWzKdlEm0FHU9x+rbreN1KCqGGM18q
	y+kWBX45AJL1D+r/zYuTGc9eLLAu3drThAeD25AzGMRy0oHmpoYfP8u5Q1yaHtcuEq1RLg8o7lT
	1p61dZ5zWOwETGrZQUzu2O8TI74nOJeZhJ9OQhhqZu4ArmjqDewqrTdZoUBsj4odcUj8luvcvQz
	st2IwJedaC7Ifr16AyEDZIQS5x4iNka7f9oZubvUBLKryVN/2a1A1BgZCdN0E90yDv1Ymx5rx9x
	lk7Q7QorpiZQYAIpGpj0MJHIGBICpZwUJYHJSMZrepvsx3gL5NCXPOOkWqm2jY70srah8ZZ3zKe
	Oi1dgIxXMxRBYRU4KN9MAtJMVs8KkWEWCk1PQ33BfqmQ39/FIVQt7MlvGMf2XCFvXYtZZAhHnVY
	DcJxmt88aw==
X-Received: by 2002:a05:600c:8b8c:b0:49c:f13e:e52 with SMTP id 5b1f17b1804b1-49cf893b58bmr158874795e9.15.1788700340506;
        Sun, 06 Sep 2026 06:12:20 -0700 (PDT)
Received: from kdev ([81.56.8.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7740d44sm526300925e9.15.2026.09.06.06.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 06:12:19 -0700 (PDT)
From: Fabio Cesari <fabio.cesari@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: isl29028: fix runtime PM reference leak on error paths
Date: Sun,  6 Sep 2026 15:11:40 +0200
Message-ID: <20260906131203.125407-1-fabio.cesari@gmail.com>
X-Mailer: git-send-email 2.53.0
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

which is outside the accepted [1:100] range, or

  echo 999 > in_illuminance_scale

which is not one of the two accepted scales. Both return -EINVAL with
the reference still held. In isl29028_read_raw() the leak is reached
when the underlying regmap access fails.

Drop the reference before checking the error, reusing the pm_ret
pattern already present in isl29028_read_raw().

Found by auditing IIO drivers for runtime PM acquire/release imbalances
with a Coccinelle semantic patch that models pm_runtime_resume_and_get()
and pm_runtime_put_autosuspend() along the control flow graph, flagging
functions that take a reference and then reach a return without dropping
it.

Fixes: 2db5054ac28d ("staging: iio: isl29028: add runtime power management support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5 coccinelle
Signed-off-by: Fabio Cesari <fabio.cesari@gmail.com>
---

Compile-tested only: arm64 (native) and x86_64 (cross), defconfig plus
CONFIG_SENSORS_ISL29028=m, with gcc 15.2.0, W=1 and sparse v0.6.5-rc1:
no warnings. I have no isl29028 hardware, so this is untested at
runtime.

I also have a version that takes the runtime PM reference only where it
is needed: isl29028_write_raw() validates its arguments first, and
isl29028_read_raw() acquires it only for the reads that reach the
hardware, the sampling frequency and lux scale being cached. It also
stops propagating the pm_runtime_put_autosuspend() return value to
userspace, which fixes a second problem: with CONFIG_PM=n that call
returns -ENOSYS, so every read and write fails today even when the
access itself succeeded.

I kept this patch to the one bug, since the rest changes what userspace
sees. Happy to send that version on top once this lands, or instead of
this one if you would rather have it that way.

 drivers/iio/light/isl29028.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index 33deb1726689..c5146c1d9f39 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -340,7 +340,7 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
 {
 	struct isl29028_chip *chip = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(chip->regmap);
-	int ret;
+	int ret, pm_ret;
 
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
@@ -392,12 +392,11 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
 
 	mutex_unlock(&chip->lock);
 
+	pm_ret = pm_runtime_put_autosuspend(dev);
 	if (ret < 0)
 		return ret;
-
-	ret = pm_runtime_put_autosuspend(dev);
-	if (ret < 0)
-		return ret;
+	if (pm_ret < 0)
+		return pm_ret;
 
 	return 0;
 }
@@ -461,15 +460,14 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
 
 	mutex_unlock(&chip->lock);
 
-	if (ret < 0)
-		return ret;
-
 	/**
 	 * Preserve the ret variable if the call to
 	 * pm_runtime_put_autosuspend() is successful so the reading
 	 * (if applicable) is returned to user space.
 	 */
 	pm_ret = pm_runtime_put_autosuspend(dev);
+	if (ret < 0)
+		return ret;
 	if (pm_ret < 0)
 		return pm_ret;
 

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.53.0

