Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352132E8DFC
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778587440; cv=none; b=f73J7BylHP6XwxsOI2xs1ydIZcv2Vy70IJ+WLOf+uAF7K7eRQ3R+6FFmB0SfVVG6+BTYOsrQzaEIUj4EoREu8FSS+Qr1mNxMsvV60H2AOZuSpYA3cyOYA1Rfwk0LanjbJxBchFG3X6sj/SF35O2/BOJdXVYki+KTbiBN47AiReI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778587440; c=relaxed/simple;
	bh=1+6MYKvV+5BS+eAUvaNLAeFQNXYVxvknnLg4E9YZMo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sqTrqkenR0US+Te7fsBXcBAzO0QAD301Y3laDeSK388Wg6HStPBEXGZy9R2Wr1515TApiSu96hTFA2M8idCOP39pnVOaGLCU5dtgQYFIf1tz35ru9gBIWEuNZsYmpbc0guWlynJSI8YmAx9nWbzwenvwX6IwMh5NtMyuvOMU+l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5wFDjR1; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5wFDjR1"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-479eb8bcacbso3442606b6e.1
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 05:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778587438; x=1779192238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1nftdodi1LgeZkHeml0qMiUT6XfhDfN3/n6bj1crBc8=;
        b=k5wFDjR1aieZAW6VwR23PwAaUGJkcLuWmLzEOZbpBga6T0PaVprJqDnRJwDtbWGZqk
         nF098ALiNoll1VllNRZrt6tT+7/GgobR/p/X9is6hWtC7JOp5luv2FrBqHTuYWJX/fzt
         EIqe8rgkZUTvAE7PAnr5ytJarRXWEQhSFwBzPm/PZdgNesfghdmJPwl00rLKrWWXNryI
         WHIWT2Hngh6d7socdL/S40TsJ7jitj9kfTdl9oniGZ6Nb2fFYd3NWy8U9jvLtjJIosd7
         mUD7z7cbnA011iudjCeMqjbQPOCswvHwAOV3LrWLmApFrUyrjwv6D+KGY5/uN4uxGl5d
         torQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778587438; x=1779192238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nftdodi1LgeZkHeml0qMiUT6XfhDfN3/n6bj1crBc8=;
        b=GyOpiXaF63IinRC6Ol/dnp/h0cwwA2ua9X085MJO36S/8C7kHaHcTrHQeIqHu/SdFe
         lIvFpLbkaj3uBixU3w86KwxTnPY3oTNV7K6bPiu5PoLwDAuH3ZTVSc6wo4l5EIrU0h7f
         oNydTvQp3SujFhtdPK9rBtvjJlJP3hahvttpzT/NNPcFeZt710kdgIf88P+h2w1lTwoe
         CPQv9zI6rzjnTHkrN6mwzQkNgknxBDH4FL4p0c0BbY5mZ0cdyL9MzHv+f6EaVuC5T8YU
         fwL5sYtV7HDvZjpILa57e6lHuSRGKOEdqDO5WR+nHrW2z7ZABXNI0UNR96WaLQYXxgBQ
         rhDQ==
X-Forwarded-Encrypted: i=1; AFNElJ+sPz+KlrL5IyvCg5DBvD55x2E1oydOnUl86nsN1XZXIyGyBhj088edhj/BZh2KnAqAOljRLZI4KKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqJNqndr1U4fhgJum3217PitgdD58qXv0mQfSMZE5ez8wu/bTw
	/DVBlYs1SdeO4DK0mJsns9Fd4WuXQlcfdcbQrUngeVtRkZTZqUQ5rR5wSNM7IyJJFzk=
X-Gm-Gg: Acq92OHy4SyL/k8QksTX75Na3eJPYHcHpP/vTI4PnqDIXYgynZcsdjcGWdlwXxDKbcX
	3w+eijoaFy/kmLik4FP/3jHtazLaHDTR7mG0ER4gfZ/3deAM87JliiEjFI8cq3kEKkbbF0oFUrM
	56LWdmxis0QsE4BRRtiEoPYlOxuPmFqarVHEQiOt6/R0hHw/3wg/Rpzp3TJjtA0sTyPS5rvTKkw
	k1w4LcWq20Etm56cbjPxrFrAfmZDIvdltrrdHP4nzArT5PvfM90L6GGh6sSh00jWhx+hdNx112P
	Hc8Oa2q6ulJyn5etU1TCTgqZIfuJxNS/v2CzjzMOfOIEjl1KC+8dHq+o9xn2aPwtDPMndhU5KSA
	pZZ4iuP+gFHckq+uASrjKhQMw1nfMVoDkDche3pBgTz+EASbPPpDLtlECOX3o5iOyE2MNx7FNFP
	FANZyMJgPJofE9rMlFlLvKjj66/lNd+HlNMyIWaeGSDZMf/QjfBqflBvwbNOlnUoOsMxpq
X-Received: by 2002:a05:6808:2507:b0:47c:6c9c:6016 with SMTP id 5614622812f47-480420569ccmr16956686b6e.5.1778587437914;
        Tue, 12 May 2026 05:03:57 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-435570ad8f4sm12296325fac.4.2026.05.12.05.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 05:03:57 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iio: imu: kmx61: Fix TOCTOU race condition
Date: Tue, 12 May 2026 07:03:55 -0500
Message-ID: <20260512120356.40839-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A Time-of-check to Time-of-use race condition is present in
kmx61_write_event_config(). Move the mutex_lock() call above it to fix
it.

Fixes: fd3ae7a9f21c ("iio: imu: kmx61: Add support for any motion trigger")
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/imu/kmx61.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 3cd91d8a89ee..9aa00acc7f14 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -942,11 +942,13 @@ static int kmx61_write_event_config(struct iio_dev *indio_dev,
 	struct kmx61_data *data = kmx61_get_data(indio_dev);
 	int ret = 0;
 
-	if (state && data->ev_enable_state)
-		return 0;
-
 	mutex_lock(&data->lock);
 
+	if (state && data->ev_enable_state) {
+		ret = 0;
+		goto err_unlock;
+	}
+
 	if (!state && data->motion_trig_on) {
 		data->ev_enable_state = false;
 		goto err_unlock;
-- 
2.54.0

