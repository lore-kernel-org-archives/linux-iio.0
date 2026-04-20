Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E443C39BFEA
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776683354; cv=none; b=bngaCW4FN980v9AaWS8Dxx5fY7M6UWpObgz1VCTBCtZotAZ1CNyhqUeXtWDj9V2/7asJzF4OG1hTZDkSu0ec+XL3UfdN2+KIvMmzZKhh/GcKJ5BYiAnJ3JBK5p4HqYS8PJst3n+9f/J7iROZwMqlus0yJSnOY1cyBBKpYx4NIpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776683354; c=relaxed/simple;
	bh=9EC4ju2DHsOZx5ijCzHWTryDjvPnuPg0qvd977jbIXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SiayrXrbFM/oizLH+saDcVwdIEMG5pG2H+zQ7utq0oGVMr/6WWEmgMNWku8Xg6LqghWSOm9AtoIWgamd5ior4w59dZDAI/mEW1NBgBUXlfWj6CpPROlQDoiDCST9krOD3bI4AEVEPPpCvdfEHqmox4IT80Z0R6B8B/DA28tGuWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7KPgDIV; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7KPgDIV"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-671ab90fc1fso6003089a12.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 04:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776683346; x=1777288146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pN9x54Amq4+6Cb4RkUE94Cy9r40ThREBiWC0BX/e9oM=;
        b=C7KPgDIVYcDMgfWFkV9EIZmUTSY+BVxDkanWvVW31j6hNXsIARG1vv/+0RA7t3snbi
         oKj313g7SsTjU8CYSUxXgF2xcWQbvPbubILK2MeWTD7xgNw7gga7RbhdQBtxHH4Inzx4
         oqwVd6cDlNaSEZUAhF2mftjib0ldJO8l3N5RKIEZH5NAbnj5QzALj+m9JAm93kS28Dmr
         6cdXOQHG53dnWeB4Fi6EPjxk9EIrU4LZmNoIQnY4a3+S2H5LvCnnqn0Q2l2HmhrnoEO1
         wV/yww7vHqgLp+38rcBGyocyh3TvipmdgaZCvwaRsINki1VyhJxTBFHlN/usr7FIReMm
         GtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776683346; x=1777288146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pN9x54Amq4+6Cb4RkUE94Cy9r40ThREBiWC0BX/e9oM=;
        b=brwDM8vXlZ8VLp8U0vwqTmM4P7wYj88nERex5gZoUMXcbBZOdkcVhOLkBNSxSAZ0Ve
         +P30y5hi+jc30ziSpnlucVhqN5OJKKKVeB8NYQ+IQCLHuRMTX9XRJo27r5BclTOw2TLb
         4NcJCJn6VBX70Qqv8lejmzFEdAQWviJXDxdGgPx95DS7VagJzJxE1Cswoti1k2oP3HZo
         NbkN9MhEZCtW6+9MoF+KRzqIXwYdB+DjfNkDNE0GTotM2TNcg+X6yjUIHVhaXod53Qhn
         0FCnaIW39gZrhcXmx5xBju9mRb3a0V/nQzmgx/r+etCmNruZDHFbq3+PiWURABNsrfxA
         b9OQ==
X-Forwarded-Encrypted: i=1; AFNElJ8+CdYed6Xwf/pQgRzZ3xLtTu3CS67XmWY76XsZiq/kjlbREfFe0U12j3C7eqqmDF4mKkZnVn2MZdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHtsYxwdLW/GnEtSKl2tBg7gWNnrDdzbY/zF/S+AxBSri+9xYZ
	DQ52YYL+9BKFWV+T9o0CEypX6yhkKhcz6631fhifE3ifzCxNCPai5v+TbftcS/WqKDARTw==
X-Gm-Gg: AeBDievmijID+nTmmTHP2tvae6qMRctjaL6vCwFfyeOyVTrwmpVuH6NAm3ALk72D+G/
	fO28kiPcfNAyGUb1zus659hetpaSLuEAvE/ayiVxTwFVw/EvGqDQjORKzlDv8HMgNp8mYwM+aHs
	BQX6nkoHfvjeC8g5mGK5PsqzdxY0vcKy2ZhZtBo+Mr4h4Rk56jaBecAEvf2pIk2yofWF7aqUUKV
	BAFr4HutBUzk1iFjhxhK3oQXJbAd+jVI14fMsEBtvYjxuVdFdO7IBnEzfdH8qQ1v0X5kySQ2ity
	F34QijV5kFjJsRZsAr8CnAKZw+dbt5AKoCree49Cf6lJs+b5Sana9WwGqayc8oYtlc1UPMP3nFG
	VF8zCcY4wK+Ugbxx1CcInV7OCAvVQRcBuotiCLIJ1x148WNcImPd80+RfaXFFIQWq+64+Y8BRpT
	Isek5dECfqNKqKXS8aPLYDuCSx/gFEQIHSRqXs4oZcOAQmi33bcrJtdfEozPFzmmzkc2ophHj+l
	6kCxXMpQnRUz8jeWwzExyhI5zWLrpCPRRKoCVMMJDV/fJas50alt+oFuKXZqj+7RwhbVREzHo6l
	XVxsbsbz5YOmyvic47NQ11YmwHME8uWsiL4q8OBbr0HFWPSTB1EDpXT8xWipwYVZZZ68AQKifcA
	mqsTAcuw2EFRI4tgjQDtjpLTjjr6ijpa3bnpztVk1orVxqDVPiTaZD4UQooC6cvtQ6uenlen06R
	7NwSXRxZM=
X-Received: by 2002:a05:6402:2790:b0:671:c322:3d4a with SMTP id 4fb4d7f45d1cf-672bfddcdeemr5846261a12.22.1776683346122;
        Mon, 20 Apr 2026 04:09:06 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.od237066db22328bb-tp.internal (254.196.90.34.bc.googleusercontent.com. [34.90.196.254])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c47fe8a0sm1947664a12.5.2026.04.20.04.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 04:09:05 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 2/4] iio: magnetometer: ak8975: replace usleep_range() with fsleep()
Date: Mon, 20 Apr 2026 11:08:02 +0000
Message-ID: <20260420110804.1353-3-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420110804.1353-1-joshua.crofts1@gmail.com>
References: <20260420110804.1353-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace usleep_range() calls with fsleep(), passing the minimum value
required by the sensor for hardware delays.

fsleep() automatically selects the optimal sleep mechanism, simplifying
driver code and time management.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index f45dca0a6f0..d4ba96a5630 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -461,7 +461,7 @@ static int ak8975_power_on(const struct ak8975_data *data)
 	 * and the minimum wait time before mode setting is 100us, in
 	 * total 300us. Add some margin and say minimum 500us here.
 	 */
-	usleep_range(500, 1000);
+	fsleep(500);
 	return 0;
 }
 
@@ -551,7 +551,7 @@ static int ak8975_set_mode(struct ak8975_data *data, enum ak_ctrl_mode mode)
 
 	data->cntl_cache = regval;
 	/* After mode change wait at least 100us */
-	usleep_range(100, 500);
+	fsleep(100);
 
 	return 0;
 }
-- 
2.47.3

