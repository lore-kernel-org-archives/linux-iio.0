Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795445716;
	b=sw6FeQeHUfL7dwSqGFSnkEehVNpwWn1khXTaJcUiHyn148FwIc9A5oZw4fawqr/hGy9K
	 QLU0jilHOpUa0/u77yoeX0+aTMYmKgpp8+FJMEq4E6keorqRzXm9t2IzZkbK8CPjF9dTq
	 71ibxmDqAe6on0oX/FPsX5iJrNzvETYUh9PMRL5CYqekL56nnpkwgozvbeVvOsGyYHVjn
	 VLtFX/B+qQVGmWeLRiJv3nbgF/sVp7kUOjv0LGSwZPsQ3P6iAtDRIVSr3tpye8ex0Pvs3
	 LMKGLbvfnE0naOJs1+h3UDBqNJ1lC1ikOP13N+3FVEiONoVUzgv+n+Gkgj1hoKvshbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=56730xMYZebP2gQVmKnamiuKT7NX1L/jSC1LBCJIUSI=;
	b=suFKERxu/BNhLl1IhBhYcz2tmTb7ThI8ethhiUuC/sHkzk4F1cmt77QPgH6cI9X2JcSx
	 W1J+Y12/46xG9qhBgwD6HiLB+ttt26hMwME7ftHNOShAboETgDVqpGOI3ivdAQ8STGLbn
	 PkYn0cRVxXR4JDfzktsnduzW3VMCZEkEWUt59UVosNa8bNqSj4ZT9l/ztDoteIUhiHD+D
	 UrV2DDYHO7sIvwqlFO8vDoF7ewXFpUiTlke3cwEYH+pPrwei+iMKpLXyRe1AEZGFjZD6h
	 r1byD7jxF1VD3W5TKTygtWfhrLKBKcqsLK5exeW0i9rE3DsuN0buDUr867MNoip+okw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A31L7zOw;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8B2606A6B5
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 14:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD8B2606A6B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A31L7zOw
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f045b921caso18757235ad.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 06:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795445715; x=1796050515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=56730xMYZebP2gQVmKnamiuKT7NX1L/jSC1LBCJIUSI=;
        b=A31L7zOwCtdkbcLTXJ6Tu0igRIE6xljUg0BfKhdnPk8VrHvNJYFF2gCcjt+AcgvWmh
         I7H0tdsN9mJG7nm9PsUCZxL2uwjsVEunggNJqOruLnSpXfeMAfNCqQzsscxYHhHcaV4y
         k7U7n1jYNDhDo9NEQGT9Od3b0sJ4x17ekUDCI/XNfJjooP8ziSBRE5684s2MuFY6H4eH
         drIzKgeaehh2VK6/JhnqE7vDwPiKs7j/GBD+5LMQabmkLhPThKOOsWIlAekVjNFSy6MQ
         cjC1TUzk4x8Zu3DoydirW1+iXkUa0qtekWXzI2L8yvTrW+CJYr3a27xLAvZXYhy+guj1
         zZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795445715; x=1796050515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=56730xMYZebP2gQVmKnamiuKT7NX1L/jSC1LBCJIUSI=;
        b=DkktXujo8Uw4bI6R133eNXkK5t9ZqjLfRLyMdCrqt6qvqg/p4hfaTe56c4CkZ877V0
         yirRHu5PuoJVb/1oJRdM7mgC/a05AkiTFuyLN8LMU3e/VFALz1pGu+VeIvYcA9Hr2vlG
         yot+Zp2K0wWF2emtYosQXYmm6vXiZD9wsUdPIQoOw4gPSgp2vyu4uhJGtVHFHkEKm+em
         TN+ODPp4OSvERmpRqHoQQrP3tuJxpFNTkhLBZH25Mu5x+YqDmLRZg/IEe5Cd3Hjc72Uh
         qPWXMiUDatbvCcTZPI9Bfz26Dk/ugKgVbcqT1dSSr3MBjRc5DNoeID81+3vsAJzP3hJb
         dmsg==
X-Forwarded-Encrypted: i=1; AL+hErE5WqLaQz4RhuFtQGFUO8SpIPNLW2/3YGH4/PD8FZJmJL/KGzVxDsPc4R76B0q1W4noGwo1ImtvAqE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9eqczP1UfsfI41NZP9AtAaU45rkJ9jSPDYOeWBwwHAdpNuPbuK
	ELA1eYxQt4Iq4qNWzKQgh6MYt5lYIdfeiOPVE+IAQg7opNROvhANkVYrTZPwTA==
X-Gm-Gg: AZFdTZchIcEWIe39orps9tKr3E1TijaAvzRufC/oz2nUZ3oR82RgH51nXwB7pOamf8R
	tBrdaJNuj7i7i/EijTpRCZ4nOJOFQknMV9sr8IHpN8t6vmGcHMWqpgkkgzhvkLqpyTEtReTnP2r
	DC/6J83fFjqOfkHaiWRmEM5D+Ju6hC3i1V5Ss3RVcUt0gAtk3IWqFRRVd/WG80XQ+pY96OxeMlR
	0Uvtkfaaz5uC8S2nHEXEhfSeFn98+gEdQ5loyZsYvYeB2i1Rn5OP5PrLgeSJZEGTYboFPm7d60O
	Asa+bHmxM17Tj3NkUun6k7UiBsdcDzZFHZyHoY+ASChP07mTUkv9JGgidpP7u+BY1kB8zzPCfCi
	R29hp4iK+OSwcKKwyTnL6GCTuXX8VM6fpunSwXWIOb6cK1H1rnMJu+F9qnJUwLb0AJ7rkB4VBUK
	5HTmxiAriBhUyfcxfL1voqCAC0IaLL318ugcugg6dDsiAu1u1frivEazdZpC4knf1upnYmasSdW
	ACSogNNAKQfM+ImLMEueDUhaGujgDpbb+V4OBd4BUwVj0XxXl8sCAbg1va1RbXGlnb5kvtb7Db1
	IopecOwITuyWPmbuwBKAsQkhYa77Fms1100GYsamZfa+pKx0IXc=
X-Received: by 2002:a17:902:e811:b0:2ed:697:884b with SMTP id d9443c01a7336-2f03f156073mr120276035ad.12.1795445714916;
        Mon, 23 Nov 2026 06:55:14 -0800 (PST)
Received: from gb05.tail50fddd.ts.net ([139.5.199.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f118c88sm55480085ad.56.2026.11.23.06.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:55:14 -0800 (PST)
From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Zhang Lixu <lixu.zhang@intel.com>,
	Zheng Shuhao <viennaoffh@gmail.com>,
	Arnav Kapoor <kapoorarnav43@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com,
	Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Subject: [PATCH v4] HID: hid-sensor-hub: avoid lock inversion in sensor_hub_remove()
Date: Mon, 23 Nov 2026 20:25:05 +0530
Message-ID: <20261123145505.1295929-1-ayaanmirzabaig85@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In sensor_hub_remove(), spin_lock_irqsave(&data->lock, flags) is held
while calling device_for_each_child(), which iterates child devices via
klist_next() and acquires the driver core's &k->k_lock.

Because &data->lock is acquired in softirq context by
sensor_hub_raw_event() while &k->k_lock is acquired elsewhere with
softirqs enabled, nesting &k->k_lock under &data->lock triggers a
SOFTIRQ-safe -> SOFTIRQ-unsafe lockdep warning and risks an ABBA
deadlock between process context and softirq context.

Move spin_lock_irqsave()/spin_unlock_irqrestore() into
sensor_hub_finalize_pending_fn() and pass data through
device_for_each_child(), so &data->lock is only held while inspecting
and completing each child's pending state after klist_next() releases
&k->k_lock.

Reported-by: syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6afddf21.a11fe2ad.1b4426.0003.GAE@google.com/T/
Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
---
Changes in v4:
 - Actually pass 'data' instead of NULL to device_for_each_child() in
   sensor_hub_remove() (inadvertently omitted in v3).

Changes in v3:
 - Rebase onto hid/for-next over commit 41cb3076a221 ("HID: sensor-hub:
   Remove clients before stopping hardware").
 - Drop the NULL platform_data guard since hid/for-next already checks
   dev_is_platform() and !hsdev.

Changes in v2:
 - Attempted to pass 'data' instead of NULL to device_for_each_child().
 drivers/hid/hid-sensor-hub.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index e9d6eb3b3831..ce9602945586 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -808,6 +808,8 @@ static int sensor_hub_probe(struct hid_device *hdev,
 static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
 {
 	struct hid_sensor_hub_device *hsdev;
+	struct sensor_hub_data *sd = data;
+	unsigned long flags;
 
 	if (!dev_is_platform(dev))
 		return 0;
@@ -816,8 +818,10 @@ static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
 	if (!hsdev)
 		return 0;
 
+	spin_lock_irqsave(&sd->lock, flags);
 	if (hsdev->pending.status)
 		complete(&hsdev->pending.ready);
+	spin_unlock_irqrestore(&sd->lock, flags);
 
 	return 0;
 }
@@ -825,14 +829,11 @@ static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
 static void sensor_hub_remove(struct hid_device *hdev)
 {
 	struct sensor_hub_data *data = hid_get_drvdata(hdev);
-	unsigned long flags;
 
 	hid_dbg(hdev, " hardware removed\n");
 
-	spin_lock_irqsave(&data->lock, flags);
-	device_for_each_child(&hdev->dev, NULL,
+	device_for_each_child(&hdev->dev, data,
 			      sensor_hub_finalize_pending_fn);
-	spin_unlock_irqrestore(&data->lock, flags);
 
 	mfd_remove_devices(&hdev->dev);
 	/* Clients share one HID open; release it if references remain. */
-- 
2.56.1

