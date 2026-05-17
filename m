Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B1A3CEBA6
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779042397; cv=none; b=q2uXYsHo0otPbQfN0Rou8KFx1fSCZkhe1dJfdzPg1buRxxczqsS+oIPMlmeHIMc7eT7qQLFHRf42sIxoCwtGSBg914/itgE237aV0b1K4bTC7J+J1K9Mev9z6Klgwoj1w/ZR6nf1iCYyaZujVwylsei1r9olcruOAtJSQJOAymY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779042397; c=relaxed/simple;
	bh=Kr+wRFKCa78PP/xIkl6wWb5vru7OSFdDl39shroWsq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o0Hw0An3vAMzr0NIUaE9bkYEXxKZOKYyy24HqT27Tq6p/tKdJPU2Pq2Sz1RUJG9M18nNz2yy2YjO2bhms75hVd8z/O6iTohyyGp18UFpNSCs/n+A9iSSvU0LjUlfkM7C+vZosyvlG7NJERJUA6dUYewOy0fe/aOCi12Xv/vGkow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9qd9H9S; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9qd9H9S"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48fde653997so1874515e9.2
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 11:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779042388; x=1779647188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FdItoqgHnYFyIUQVhKieBd/PQ9Fluw8ZpOdySHOHHGI=;
        b=b9qd9H9SX3BzXQr5ypnz3K8T9WC/BntkKBhCfHvGRbLUGuIC/3l/RQ3oINeMaPPGVQ
         Z8lGvfNgG1qag12KpOukck4H6XYyTg/5RhqkZd4+uTzCpJWlS0JJcWTY6BzepWcWOi+U
         cK+ATQkGCDNlmPqM3bn3IBIqhQZeMgyPFCepqfYo1z/TtNdJ/TwBN9pfu0txg4XVtcsR
         b06Z3zpSV6P21JhwoB/TulhIjLr9ZetoAnl9gaxJ3RxhutXYER4u1JxSFWSQF71PYK04
         9eOeNNd5io5RkHRYza62zbLnCh2wXX8bXPZBO/y2VkG6zfHVY6sgOLQYsNPTN95WIfty
         IIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779042388; x=1779647188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdItoqgHnYFyIUQVhKieBd/PQ9Fluw8ZpOdySHOHHGI=;
        b=iJFGrCY1KDhHr7+jTrd29/7CSDp6fAe9uORHgBcUNc4inatKn715mdWmwgaQF4yv6y
         lnxWqOHxEsA33sDAI3MiAv/SOcQDdE4bhmZSSerI+rwuyiIIVudOmCPkOQ7JauHdmSkv
         Oz7VoWdXHnwPZx54sgJ14xuj5JxY+0Tx2ixlxKBmDtGBqrjpflLDamiuVEc8FHD80pIN
         lWizTcSA7+fKl/lqAvxRBWavRbo6CvrNyDw96wrwMF2GEcM33pAM99UarW8CHg1cOzCq
         z6b0nDpMcYiPwb/C4agHlHgbT/hyP4Lpx0Cpc12j7sqArht3jFwR1i5reXRkjGURfS25
         chSw==
X-Forwarded-Encrypted: i=1; AFNElJ80MR+PTjnO2c0I3JJOf60cHDGif8qZD8yL5kpdW0x5y5rxKawYniQzbBA7lVthISZUhfetNqX8VRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxPstonoZLJhpSPLfmIMkkPNeaf8/sJoheoF2i0lWuHGU7FBpC
	6D/hqzQYPRSUXxaJoo+9LvkVfJv9dGlsfuq4rzusv73UwdVZeFr7h6TU
X-Gm-Gg: Acq92OFxkSQzwuA/hCG6FUo2x3PutZX+jCkoXOBVWMi9OA5foXqUlDOYLRtnBho4hZg
	1gA+9e6Uz0eX+BkjBWmGz/4h0JkpRB5snRY0YXgF1mD5O+vM6ra/ogv36KYwLcBWjoGPk0iU3vP
	XGzX5u84RGSY6uJewgXniYTPHi9GH8EiGyL8KpR5RMdh91sUsAalJmK9fEBlTnzwPW0JfRLbPVA
	rN5Yt3dOcozjQyLNZFOH4nTpyDt3YFcQXmB534+wH0tkLazSV3A0A3lqkzYG9R170lTVL4pjg58
	kCGTYtCneOlcvqe1o9qJCgv8bN4jD0mJNHczqr4eZtEpcQKyv9bxPG6XKdqlSNuEIKoLlGpRIa8
	9JIhm+uK7GEBAsYwOQ4KEj+dLOtL8zwDYviNgD7NIkZdNkCtcQlBlGyDIElUQE/jyD+MviXGmlM
	YcoumQnoIucphjf9jdNRQzx0rsT1zUyeyRazK+42yFWbhj
X-Received: by 2002:a05:600c:3b07:b0:48e:6db5:76e6 with SMTP id 5b1f17b1804b1-48fe63099c6mr97084715e9.2.1779042388030;
        Sun, 17 May 2026 11:26:28 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe81b2dsm64676625e9.34.2026.05.17.11.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:26:26 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	hcazarim@yahoo.com,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] iio: temperature: tmp006: use devm_iio_trigger_register
Date: Sun, 17 May 2026 23:26:13 +0500
Message-Id: <20260517182614.218-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tmp006_probe() allocates the DRDY trigger with devm_iio_trigger_alloc()
but registers it with plain iio_trigger_register(). The driver has no
.remove() callback, so on module unload the trigger stays in the global
trigger list while its memory is freed by devm, leaving a dangling
entry.

Switch to devm_iio_trigger_register() so the registration is undone in
the same devm scope as the allocation.

Fixes: 91f75ccf9f03 ("iio: temperature: tmp006: add triggered buffer support")
Cc: stable@vger.kernel.org
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/temperature/tmp006.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index d8d8c8936..bf62143fa 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -350,7 +350,7 @@ static int tmp006_probe(struct i2c_client *client)
 
 		data->drdy_trig->ops = &tmp006_trigger_ops;
 		iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
-		ret = iio_trigger_register(data->drdy_trig);
+		ret = devm_iio_trigger_register(&client->dev, data->drdy_trig);
 		if (ret)
 			return ret;
 
-- 
2.43.0

