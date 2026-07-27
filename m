Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC463C10BF
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785178154; cv=none; b=XUWn1aCTJEUuABJQdKST8kjeXGVYbPSCJshVS03QR+t8GkL+QPhrvMWOsuRK0p66tERgDCSxzdWuGm97PKJ4YPUD7BZsJv520YKP1gijkUE01b++JktVkPqMC8BWdAVN7mmaXxHFSqaj0ShrZqscJ20n38Nr3Xxkr0xDO6W8HQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785178154; c=relaxed/simple;
	bh=gjRCHi7E9q40XAs/FtWoHLouOKq6U/tlfkiEOPIIiwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ih8Z19wnt48Sfn/nJvw9NRfQFoLHNBmuPZJzSlSpKIc2t8H8SGGdsdRzBVSB0T0kCvmIqPg82HJsm0kxpDtQ8YC7NRkN6dLF2YxH1oCbIoP4y59fxnjD+EzuD5aQspRtBI5+apZN/doJ2quTDXQY2TmSo0EnCuwN55/x/lVpZ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CErUkmGy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CErUkmGy"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ceab75934dso38680235ad.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 11:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785178152; x=1785782952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+kG0TOSSfRZaOeIFJQE2yOSnOHWGL8m22qKwF+ZDhYA=;
        b=CErUkmGyNHufS3//MTi4wsai6bXDXpVkpzx0R/54BIj8Y92aLVqS/nUNz2MiK2xy9o
         f1iu22Gq6QE+/sJTp/Jx+8jD2UrZvbny/gabJmKv14d7MjrRRhowgEa0Us0Kx9y+vfww
         H/JTnRCw5suTzxuwN+qC5kFJk7rO1nir24KayvFX9TfasH+0ijTRkkJVCiDUKGexMuyj
         ACqwwFlLmbbtTs5aQTofA1AXqrX92R5Yd2+6OwdyBlEcspenhqznDbTETMnCnOvu6mO7
         STUmqMr71P/YPkrc+VHR1tmKIT57wlru/nOZYv79K5qR9hNvZzumPWl2r0rPKsCi29l2
         UGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785178152; x=1785782952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+kG0TOSSfRZaOeIFJQE2yOSnOHWGL8m22qKwF+ZDhYA=;
        b=lUF7vx9VsKNNzPkIVKx6exR1JySh2uhzxNb9WVHKCV/Jtyq6aEs4LfKoZnHKxpg2Q/
         yvbiAjAhIF//OAV8SIj7q04vQyOjao/0+EIluFXPaEXp+JarcStS5OL1vzdnCdszB0U4
         uHGQ/4bQsWvGtl8w9fOiWLToMeGt5jZsSN4hirc9cJjgLbTTgW1xoPd8atSZBOMa+iuM
         hv5ExOUxw02fced//grMUGK8J8UtMviNZG1Vd8w7cTCPbOChz0mIyz9HQMINkQCkjGAe
         gsOeYjsAqLBlyrC+tTKyKau4Qd6ngmDMGV0O8t2fOjSOU/eVTwtFl8+4Uvv7EBaH6nUi
         cueA==
X-Forwarded-Encrypted: i=1; AHgh+RoYZYDbmPv8QyKAJZ07eYG1ohGiTw5xCMKGLEPzZ/if8hNIdhp+/+kY3TaRKxb/pLeXkfzkWgf51KI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+8Zk5C1OrKDJK+ztPlp+bJ1CbawO75zqaGR8JwKtAQjZ+lPA1
	lERgVFTNJEUQY2FvqAWqDnp6nc2bzn/nj61U9ABGUL/o8+A776rSy53Z
X-Gm-Gg: AR+sD10F88pvSZmU74NIOuxmCTXt8Tyiu8xctC55nx7rkNDZr9UBP1tj2a3/oLvI8cl
	i3o5MrHmFE0p7r23wdepAA2ueV3X953A9ENz6/0uUOU52Jcph7JjiUEbv3gjbU3IWAhmDYrxy2a
	++M70NjwrloczVTXFb4/v+r6ttMTgTMXuXZ1AH8m+PbZpDSFQox94D/NdCqbJz833pBS0s678Yo
	eLBtXgq7FRQo6gFjwLA1GK2pF5mbbyA5Q0Y0oUPvlDCSCDUiN5LudiCGAIbXEOXFySoHHfo/SOu
	pfKdmYQra3uaJO4JfGH7sYBDOv7HxWcBLMTnlXmygYUpQoAHs1h5nLZ2eGYZBXpybVDtAd1hm7q
	D1GVkYMR9yyCmluVud8UG7Zt3Ldeyg4G2DOD71HSOo+jVCG0Qvgn43It8WfGacl8wbwORSjGt
X-Received: by 2002:a17:902:ebcb:b0:2c9:97a8:afe7 with SMTP id d9443c01a7336-2cfde8a53f3mr86689705ad.42.1785178152163;
        Mon, 27 Jul 2026 11:49:12 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7d7b87sm40186245ad.57.2026.07.27.11.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 11:49:11 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linusw@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 4/9] iio: light: tsl2583: remove tsl2583_set_pm_runtime_busy() helper
Date: Tue, 28 Jul 2026 03:47:41 +0900
Message-ID: <20260727184755.2055414-5-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727184755.2055414-1-ekffu200098@gmail.com>
References: <20260727184755.2055414-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tsl2583_set_pm_runtime_busy() just calls pm_runtime_resume_and_get()
or pm_runtime_put_autosuspend() depending on its bool argument. Call
them directly and remove the helper.

No functional change.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/iio/light/tsl2583.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index 54fa426c5755..06da145569f7 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -639,14 +639,6 @@ static const struct iio_chan_spec tsl2583_channels[] = {
 	},
 };
 
-static int tsl2583_set_pm_runtime_busy(struct tsl2583_chip *chip, bool on)
-{
-	if (on)
-		return pm_runtime_resume_and_get(&chip->client->dev);
-
-	return pm_runtime_put_autosuspend(&chip->client->dev);
-}
-
 static int tsl2583_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -654,7 +646,7 @@ static int tsl2583_read_raw(struct iio_dev *indio_dev,
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	int ret, pm_ret;
 
-	ret = tsl2583_set_pm_runtime_busy(chip, true);
+	ret = pm_runtime_resume_and_get(&chip->client->dev);
 	if (ret < 0)
 		return ret;
 
@@ -722,16 +714,16 @@ static int tsl2583_read_raw(struct iio_dev *indio_dev,
 	mutex_unlock(&chip->als_mutex);
 
 	if (ret < 0) {
-		tsl2583_set_pm_runtime_busy(chip, false);
+		pm_runtime_put_autosuspend(&chip->client->dev);
 		return ret;
 	}
 
 	/*
 	 * Preserve the ret variable if the call to
-	 * tsl2583_set_pm_runtime_busy() is successful so the reading
+	 * pm_runtime_put_autosuspend() is successful so the reading
 	 * (if applicable) is returned to user space.
 	 */
-	pm_ret = tsl2583_set_pm_runtime_busy(chip, false);
+	pm_ret = pm_runtime_put_autosuspend(&chip->client->dev);
 	if (pm_ret < 0)
 		return pm_ret;
 
@@ -745,7 +737,7 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	int ret;
 
-	ret = tsl2583_set_pm_runtime_busy(chip, true);
+	ret = pm_runtime_resume_and_get(&chip->client->dev);
 	if (ret < 0)
 		return ret;
 
@@ -786,11 +778,11 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
 	mutex_unlock(&chip->als_mutex);
 
 	if (ret < 0) {
-		tsl2583_set_pm_runtime_busy(chip, false);
+		pm_runtime_put_autosuspend(&chip->client->dev);
 		return ret;
 	}
 
-	ret = tsl2583_set_pm_runtime_busy(chip, false);
+	ret = pm_runtime_put_autosuspend(&chip->client->dev);
 	if (ret < 0)
 		return ret;
 
-- 
2.43.0

