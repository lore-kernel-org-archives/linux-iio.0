Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D17D3806DC
	for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 06:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789021513; cv=none; b=alw08VuIfBeqF+52ZyBlwPz1BYiyXA5yO/AMnUZpoJuelWL8TpYdu6DN0ZqPoNG9LNCt5xKLxggY8oyeEfNqzRsCD0rck5B6b54aBcpVQMPCVY4UtV+99Kx7/yu1yKAf4lQ6ZlJ6I5H+r8ztaKwGr5ATqGRCC0cZJQi+KdOVH8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789021513; c=relaxed/simple;
	bh=I5MClOXEbqskNcAspmGuUM4ja+PF7IuFEaI5Ha80a68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ByE6SiesFUGsmg8Z7GfZeUB3/+i5Mx9KfOhcz1HpgVH+JgY3W92wm2WHZjxDDgwwXop/a4EFgBKFODwV+F6GSkKro5OPWAhvFWhnmPEqE8o8JJXmC+vvt1QdW5xwjxEj4BY/nnWbwld0hKxGJ7JouP+AmEUPdsmg7n7iJhVCQeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2IK7QMD; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2IK7QMD"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49ccfae359fso56700855e9.3
        for <linux-iio@vger.kernel.org>; Wed, 09 Sep 2026 23:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789021510; x=1789626310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PfVfrQTuR+HDLz8F2yzaRGMQ9tlRQuS53cGhmVjSMFU=;
        b=T2IK7QMDaGUgHJK3AS0jZVHdzP4xNtdOvqOv7Z71Rmyw0lEcm1H//pPimrbN4jVinp
         HxLS4EPuiVRRU7DbeKWexwTkBWDd7H+19Dkb9ozgepKBUD8SsiCzW1NWv2M6L2hl0Ky/
         +mGsV2M3kHTKvTqsFLeB2GSU/zUiB/kW3q9NIjFqbzxS8RrHhCAaVlnNU24lqtQDfpKt
         J6m26dV01VrVRXYY574fN0b1CWhJKEnTHMHJXLLKQrou0fdUjPFkfICleae7EX5etduL
         PP2kxbRosZ6ulAgzbsnoNefCetUVKRp0JLLrmgSFUc/uvwY+rEzgbxOaiTh6lvWYfbGE
         vqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789021510; x=1789626310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PfVfrQTuR+HDLz8F2yzaRGMQ9tlRQuS53cGhmVjSMFU=;
        b=kYG/CBsAK+TAFrQGtIHPrUVw2hT2gT9OAJTN3dc1fB66pOsNcgxBgQCrEnMHKGSQoW
         Vlm+FFGTgGuWnoB3vvSrESBYh3uo8+vK0AoRJOXH6EgOPlSPKqBUSadTmTZgtcAeizSE
         CYPeRbKvGrmqW/+GyFDBrJh7jZ6SNVbNShgZDKD0oENR3kcGzVn3KFWi+wMjrHJbLdM4
         CB8JUEwD1a9kf5Rw9LF8EJNsYhD3zjkUqnc9k7SmhCoWz0RN5ad/qESO1nyCV6SRNuC6
         dKPo2C1rUydFGRMSKOTsl7l9bVQ1vODqhPMqhpwKBhBaLxC57/qkR6Z8GK4TUa1uDZmm
         K1sA==
X-Forwarded-Encrypted: i=1; AKwUvBxHzq6H3iZB3jtbM6UBrJ3SCrauzUslvjDQtKy5ii7+aAfMsQafXouU+Sccs9IgMm2ssF9x0/j6YWM=@vger.kernel.org
X-Gm-Message-State: AFuF++nSZrEWayoCXGKkaO0dyqwkppuazYtrBmVMSESNQnoecPCwJu5Q
	wvMdc1sV81+CpsJoEES44flV4YJ4ktaHrsz49ZHnWfiqKylpylgJetWI
X-Gm-Gg: AYBFou3NuA3vXjAXMPB8WutjuH16KFnSVK31Y4ddSRpdkkLr18tBLgFgFe6aUFDAcoi
	VAEFVFLxq0s9Reru7piOgK46pj27wd0JOfFjuUBuxw7fzNlAgWJjrGHqoaOGzThZmXL3u1mY8RF
	1H3kaSNnacc9rXQoxopAKGYDtcZydNR1qfnjyQP/Q0XfWYjgY8Nr9bqDgELYRqAYgIs8NkaxpUh
	NzPkDn1SkKc3xko+FPqsaQHPkrvEbUp0K3wrm7YsktNOrgxT4TmBGt5qgxa+vbKWO+d5AdqW5yI
	yF+pf6ZWAhX22f37MOhZSSccpQw4Vr21rjZy6KGrLOwhNSykvajggppT85sl1Rey3V/a1o1tE3e
	5QcY3ciUqHjkQXzhqRw0xS1mrYAHqS4jCuTDOnVdRijvqDy0cMbxHxS3ZPPFKJePFDfWBS1sbeh
	TbRQ7G5OBZtswUh6rIHV0kMM7mQFgY4i/V0rHHSDgQ9MDA7eNHK3tEiUeSNmrcJDtGc0Hu2/I2Q
	GR7knREIVDbLM6Ft11281Oe8yTeqqt6Zo2tWdX8pF/0ywQhqhR2Yb29JrqDUGjaf6Z1kiIdZUt/
	bchr+G767Sem8ThwFhf2
X-Received: by 2002:a05:600d:650c:20b0:499:8ff5:8ecc with SMTP id 5b1f17b1804b1-49cf828609dmr302997135e9.15.1789021509632;
        Wed, 09 Sep 2026 23:25:09 -0700 (PDT)
Received: from kdev ([81.56.8.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26bf2bb2sm44803175e9.7.2026.09.09.23.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:25:08 -0700 (PDT)
From: Fabio Cesari <fabio.cesari@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: light: isl29028: fix runtime PM reference leak on error paths
Date: Thu, 10 Sep 2026 08:24:35 +0200
Message-ID: <20260910062449.331749-1-fabio.cesari@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

isl29028_read_raw() and isl29028_write_raw() take a runtime PM reference
with pm_runtime_resume_and_get() but return directly on their error
paths without dropping it. The usage count never balances again and the
device stops entering autosuspend for good. In isl29028_read_raw() this
needs a regmap access to fail; in isl29028_write_raw() one rejected
sysfs write is enough, for example

  echo 200 > in_proximity_sampling_frequency

which is outside the [1:100] range and returns -EINVAL with the
reference still held.

Take the reference with PM_RUNTIME_ACQUIRE_AUTOSUSPEND() instead, so it
is released on every return path.

This also stops the return value of pm_runtime_put_autosuspend() from
reaching userspace. That value only says whether the device could be
suspended right away, so -EAGAIN or -EPERM turns a successful access
into a failure, and with CONFIG_PM=n the stub returns -ENOSYS on every
access.

PM_RUNTIME_ACQUIRE_AUTOSUSPEND() exists since v6.19. Older trees need
the manual form instead: keep pm_runtime_resume_and_get() and drop the
reference on all paths with an unchecked pm_runtime_put_autosuspend().

Fixes: 2db5054ac28d ("staging: iio: isl29028: add runtime power management support")
Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for < 6.19
Assisted-by: LLM coccinelle
Signed-off-by: Fabio Cesari <fabio.cesari@gmail.com>
---

Changes in v3, from the review of v2:
  - use PM_RUNTIME_ACQUIRE_AUTOSUSPEND() rather than the _IF_ENABLED_
    variant
  - sent as its own thread rather than as a reply to v2

v1: https://lore.kernel.org/linux-iio/20260906131203.125407-1-fabio.cesari@gmail.com/
v2: https://lore.kernel.org/linux-iio/20260906223737.206730-1-fabio.cesari@gmail.com/

Found by auditing IIO drivers with a Coccinelle semantic patch for
runtime PM acquire/release imbalances.

Compile-tested only: arm64 (native) and x86_64 (cross), defconfig plus
CONFIG_SENSORS_ISL29028=m, plus an arm64 CONFIG_PM=n build to cover the
stubs, with gcc 15.2.0, W=1 and sparse v0.6.5-rc1: no warnings. I have no
isl29028 hardware, so this is untested at runtime.

 drivers/iio/light/isl29028.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index 33deb1726689..e481ac908fc1 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -342,8 +342,9 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
 	struct device *dev = regmap_get_device(chip->regmap);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret < 0)
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
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
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
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

