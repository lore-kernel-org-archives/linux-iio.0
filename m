Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CB6385D76
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 01:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778636205; cv=none; b=Xe04eDA0cvz8hZbLY0x0G1FJfhsK8LuuW3zkSBY8No2hJQG6N0ST921bGdiUtHgRdfy9qj/MtSWdUd0/6lFyJaU5Wrfn4ndujKnqqwc6mh0oI506dNcnvXTE7KuKJ1GkGmai6EJ1LuD7f71XPoXTkygdIzfQxiSCT03FAqi/dWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778636205; c=relaxed/simple;
	bh=XQK7Rj5SxTOGJeHdeR0dlvQZhO+384rs0z0IsWLwfhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rdRLch0PNwOKFtw/R/SSdKTebuwonhIQzhChG408vTj9XCOho9Sk4erws/AoP+ApRSX3gfZY5KXA43SrXbvdhQHTjzwy99eJPEcjfpBnVcOajSHnu85cvVbQuwKa3W4bVnNxKMPXYIXAsNTWhuVne30V/S6ho1k7GHML+PG834w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWfUKdYI; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWfUKdYI"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dd73b7c757so3542005a34.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 18:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778636200; x=1779241000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=647KizCmT0BV4mGCMhIP+6nuRdxNDMMBx0b8A8P9hDI=;
        b=YWfUKdYIFX1/Mi2z0CIZR4HbQa1jjGPBi8NyF9UAIA5sg7WPB6ryYgcLKk8cY3FZxv
         02Xd7JfEJljtKcO9N0fMkLRMJWAPWFnaIgA7QAGF6SvXPO5b58BeymQj4MV4sy2hHv+f
         JNaEzHeJ5eArmPLPyDbgEieuhMQDERzx83ZvpFBxVDsxAECyhYqUmMRogG9d6XJw4enq
         UZRUEIVp+lO+jT4oUKj6Nq6f/ONZyw2hHIDOqJLCfSnAKxhymgCyvuRBfETTXi7pXqFA
         vfXK862Ozw3MXHPm09sLEHjj9IzcLIB4j6N26xJENty0UzcTceiMgzifrLFXs/9mz5t6
         kG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778636200; x=1779241000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=647KizCmT0BV4mGCMhIP+6nuRdxNDMMBx0b8A8P9hDI=;
        b=Pbg+AeoKZqh9riGZIOJ/2zzsTB5sijftf28uaGCZHaVArHz1A+lm/10H4pmmOOXDS4
         jigOOUJ30ZV1oEN9NPoTDmU14h4F4Tkl8XatOBFn644TyhRU6CbayK8BdW3f/dRWgyaG
         CYV8II4ee45chUJ7QrEQ4BxuxQGHcdph7se00auXsnvdvW6BbqiR+pxOpPh2Hh1hTeN1
         x5eB0jw1do7EN4zJekq8wtp+lu1ozUWXAA+HhkRfJl0/n7aQx7VbNuf0jGblcVdFYUCw
         HA838S8pplxnJw56nXnrNwArO8GZk/yHwden1xtA/UwRu5OXZht/wLbE0k81bglAV4nH
         qhDw==
X-Forwarded-Encrypted: i=1; AFNElJ/QyF2D6aZ6tclfYXjiy1GPq4indprphpbXrubS/Ti0R2FvH3KFs/ZRugZnDx9kFO4ZGaUVWDOInaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0GNqsX1/HFtr/PLt5fCqDPnP9SFD/g2zwvhsiKg0eisoL4Mbs
	ZBwssU1EmcF7cR1k5YlZ+ZR10YuWsUrVBoLVie94/sVH+pAefu8mhb3k
X-Gm-Gg: Acq92OH46M6ypERyERH2w/2sOHAc9V+Zwoqmyc5mG4q2dyTJHp1YslbDvA5B6hgV0Qh
	MPj7CajSOotwpC1JJfrHv7Rt6YG6BkFho8QoM4E1CJx1WtIMtpKonczg2LZZSzz2yLFunH6WfuX
	KBhFGrButuuwfqPUJtddMDS+1G62TY7fS86wFAjrx2pQ3Sl5oOx1yAywyQHpxEv6hgCoi6jSUhd
	BCmn/NCB+2dCFts3/xZVZ8FXqklZNgoxh6iJCbdGHEEDHIZ0NPsY7gcro71lFvMpdBh7P40FOUS
	K7IEWLAXuMNnY55d1xqi0kZ988hWbNmfKmHxItPkRO3LjoqqXSSqNz+YdBDlkiijRv7asF8acUE
	SYO4C/lsEPcDCS+2wb7T+qEWMc9do9k0zX79bxOl8xRLqiC7mU2h/fP61XKNctscBer+90Wdn3i
	7ttp+i4mOXUv50q5TvmiovcEpiBGhPAroNL8AISHjZVLUplN0+lSiMyCA1pA==
X-Received: by 2002:a05:6830:6102:b0:7dc:cd0b:58af with SMTP id 46e09a7af769-7e3da03f8b2mr837514a34.6.1778636200232;
        Tue, 12 May 2026 18:36:40 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367d90148sm10412083a34.20.2026.05.12.18.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 18:36:39 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: sashiko <sashiko-bot@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] iio: imu: kmx61: Fix potential time-of-check to time-of-use race
Date: Tue, 12 May 2026 20:36:38 -0500
Message-ID: <20260513013638.147606-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A time-of-check to time-of-use race condition exists in
kmx61_write_event_config(). If two threads enter the function at the
same time, both threads may pass the check and get to the lock. Thus,
when the first thread releases the lock allowing the second thread to
start execution after the first thread modifies data->ev_enable_state to
force returning from the function, the second thread continues execution
regardless. Fix this by moving the data->ev_enable_state check inside of
the critical section.

Fixes: fd3ae7a9f21c ("iio: imu: kmx61: Add support for any motion trigger")
Reported-by: sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260507223337.48437-1-m32285159%40gmail.com
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/imu/kmx61.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 3cd91d8a89ee..3afa369de3cf 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -942,11 +942,11 @@ static int kmx61_write_event_config(struct iio_dev *indio_dev,
 	struct kmx61_data *data = kmx61_get_data(indio_dev);
 	int ret = 0;
 
-	if (state && data->ev_enable_state)
-		return 0;
-
 	mutex_lock(&data->lock);
 
+	if (state && data->ev_enable_state)
+		goto err_unlock;
+
 	if (!state && data->motion_trig_on) {
 		data->ev_enable_state = false;
 		goto err_unlock;
-- 
2.54.0

