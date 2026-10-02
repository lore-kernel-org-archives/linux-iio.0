Received: from mail-lr2-f14.google.com (mail-lr2-f14.google.com [74.125.230.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1067641A502
	for <linux-iio@vger.kernel.org>; Fri,  2 Oct 2026 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925935; cv=none; b=NXOTmcnQ1zHB0D2sagLVekiavNuqxmkPFTeMaJBdJHBkbVc9uVCeQOoC+ClZ2Ct60wULhffOuqjX9yu6H9jzorfcxDeNiqMwTI3e0uOUhNVNQf0QF884bGLeIBDJV4r47w5wpqUWE34GFItPzk2DsoYUv1jCjM8+yst7+7PXxQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925935; c=relaxed/simple;
	bh=FGNpQ0k1f6g6f+/w9U0t9YLOi6n+7uAtJCsAhAa80EA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrmOc9ZeY44a2CvXzQ4hFcUbs1mWWOtuas3XHbM9ASqo6xbQJlKPSJYfTq42lN+J9GbeJAlPqk4GboJ6hwbKoQYpRkjgM8yBNRTDskKJqD5AD+MwMxY6s3x7pCLemhCO18I8psk9I2xPf8z4QRW+2KF1Wfq9oWaq6d5QkmIWBSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUuyyWI4; arc=none smtp.client-ip=74.125.230.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUuyyWI4"
Received: by mail-lr2-f14.google.com with SMTP id 38308e7fff4ca-3a783ec301dso13266371fa.1
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2026 00:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790925928; x=1791530728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L7/xBuOunV9HtMjo4A4DjKBufd9dH+BXioKMJcmPy2g=;
        b=WUuyyWI4XFqAGwmLdP5pPkxiJF3JJ8Al8A8YxREke2PaSC9gqRxMans0XIcFfEXWSl
         7qntvK3GMUYb+1SqBAH5vj9gBfTn1n6nVis7SyxdK347PfO2NJRkO9kacwodomrmuAK6
         g9pIv+znosPDLxkrNxD9m6Rj4QWagkUl6U8K33YkKdZlbBCW/+K20BVSFKVwFsqwAwus
         Uj/dDwuPPoeuF466avf2OMOLuUY6HZrhOebAgUpXtR09AFe2oA2T3qqKBhE81rC5UkPB
         McuNhwR70s44MMj5yi9SJPLbKc+bLFZlO7TZ9FBOYdE8OF1RPCz6qgOSEAn4ION+kfFN
         5RQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790925928; x=1791530728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L7/xBuOunV9HtMjo4A4DjKBufd9dH+BXioKMJcmPy2g=;
        b=zxLvy+9dXEp3FdUc1BySwyoqG9c2N0lEOEhPEu8QEsSv+djz8lmml1Y2oZuFOV18Ip
         Bz6q1CjBR3eo43q2Sx+/xGTtnVvM4CU8izEQumSrB9KD867MqQQCdrLa8fdTTiIWhGY3
         8h03+TSTjWrjmseZ0+gh8VeUdeCqw4fz60j75rVbZiAqL3Ggue+prUxoVbbSEeNZJ6xU
         905uBqTe2J3rGSojQGhBo4Y8yeEb63jCbKG+N8caz7/wshD7kIMEQfyI5xN8HxzrQf9t
         UNrPkTyq3ps5/mZr0GsxXj1L1dsvJcDfC5akB0fEaAgpEp5TbTEGtuYMpWkkQsfJzb2y
         72Nw==
X-Gm-Message-State: AFq9FYLaCLJDnvASBGPX9TkBn5ShmGgBTgnBcQxDD4aGcmwYJ0d7TU64
	9do3fLS0zq8EWeknmVGL1bFpvbl6w0mgwQ+EGK2zPgxxbEGeNC7MLUhG
X-Gm-Gg: AYBFou0CvCWL2FecBW9Fjg9k3I3MI0D5OkA84VQ4+QkMZcImz61w+IzyapIkQtL0d29
	7IZnccJzo6zo2C7krARzH8aQO45LTdvbePcN/OBHpi7JnWcuAV+WD4KGOrUwOJBkz+S3ClrSmGc
	gDgGzAyK/VQG5hsE4Mb7JwDFRZylF2C3FId1heNaV0LcQj1SFmkn3kM4qT1M6s9qYSknok8mYsL
	eVJze11Rh/YEA+AM2RbIviNesS3xtJTZErTilLKMcmf/asxxCR6RkJmPBmBY/LxPKQMoPvo0YGG
	6VEC3Q3QZaqoyt+IM3IKhUAQaqzA58aAwHFu82/KacgliabPi8zbv9IK+P7BcwSshK1xAv3Bilv
	ulZ57rtIYf0xL6eX7zTZwm8uEdvtJVZDffd7unwnHi/Ar6fngfUYzXzE5/0SOcRKqjIkjbdiz2r
	JfWZLLmGtx1mknSfHxP+4r83PTsMPckDKLAKs0F4lvq+fR6c5pj1dKpa+n4vfxlAJJ35WgX+8gI
	dSxdX3o0RsCXiTG9NegiveRLYLc8IagTRePpJRxR4Mbf78I5nrcHILW/eKSkpc7TbZbvJrcp2iw
	tt60
X-Received: by 2002:a05:651c:3059:b0:3a9:6f4d:b345 with SMTP id 38308e7fff4ca-3a96f4db5f4mr514611fa.14.1790925928336;
        Fri, 02 Oct 2026 00:25:28 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a87e324350sm6724731fa.36.2026.10.02.00.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:25:27 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v11 1/5] iio: pressure: dps310: use devm_mutex_init()
Date: Fri,  2 Oct 2026 10:25:22 +0300
Message-ID: <20261002072526.250081-2-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002072526.250081-1-zoone.rupert@gmail.com>
References: <20261002072526.250081-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Destroy the mutex on unbind so CONFIG_DEBUG_MUTEXES can check it.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Assisted-by: LLM
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 85df58ac1809..f7265df2fcb5 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -19,6 +19,7 @@
 #include <linux/limits.h>
 #include <linux/math64.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/unaligned.h>
 
@@ -996,7 +997,9 @@ static int dps310_probe(struct i2c_client *client)
 
 	data = iio_priv(iio);
 	data->client = client;
-	mutex_init(&data->lock);
+	rc = devm_mutex_init(dev, &data->lock);
+	if (rc)
+		return rc;
 
 	iio->name = DPS310_DEV_NAME;
 	iio->channels = dps310_channels;
-- 
2.43.0

