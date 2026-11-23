Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438046;
	b=NLU7HppoxS6PDCLCBVcg0r0qTjD893zEk8dxgD0MxO4pAyPDnC+kRjCg65hOcK+yfKYA
	 dLuPgxXt22z9uUdH77KeucIlwcU/i0iVaq+/f+Woy7W93hXMJOVK+BJcPU4/7i86qIpoM
	 RHGEXh/6VpwBqC8FhP4+6lXc/rm3lJvwNxNIbfXOT7UO4EHtDgK/Hnc/5fUlRxmGurBts
	 GkUCK1d98RyXjw5c2Mf7f28svvAiCKxl95R3Qc6CNhqKx0MqVz+WK0FQoCm8bEq5WD9JC
	 ZT9VKSx9eM7GkB0e5o4zVTgqe7EproQO3BKxT0uY+SgMPYNPz2iRk2c203dhzWPWplQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JLWRIyW6L3H78bd/BFlmj2ybIy9WVHoAXMpJ3dEd5x4=;
	b=JgpwHJCo+qr3mE6WdlLFqIldvkz2aS3fquT+tNndtak3SYC+NiEvOu7eTtmsNv/L3GwJ
	 Dt1du4AjAiQQGQsI8RYzcxY64GUs84WiD8x2ir93c5btFqq5RVFI1J9T9avEPgPGwr0FM
	 VcU0qIP2Ru0CjnmPzLid9MCrljRcQYdi5YCDmycQSoafXH+v5Emh4rLwLT3Om7T94xGWD
	 SieXQ7Uwtj7kIOk0OKQGV8I3yGC9ovqaJ8LSQdvTRdmMAEfO6JOKZs/Yi2XU6uBErZuOI
	 WsWh8pp6sgf2D2Dvqdb2yM/Ix66JZy57ED7WH3j6hSG9cNuX1hmu2g3sOk8Zj7gIjuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="DbwGP/cw";
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923C4606A327
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 12:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 923C4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DbwGP/cw
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cde1479f76fso1960387a12.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 04:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795438045; x=1796042845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JLWRIyW6L3H78bd/BFlmj2ybIy9WVHoAXMpJ3dEd5x4=;
        b=DbwGP/cwdpTOtGUruhFiB4Bmbuh2pxwLCoG+NMc7KVnrn5W8cxeooMpUbVXi4UvOi6
         hS5h6/P1Z59KqHBq7Ng0wA2hkJqtDssAYfcAkXL7UJycIZaImTndQpoyc+ZKGQbqJ9oz
         7RXaj8VKPYVwUW+V3RM91bTPIkbNnN7NbjE6FnRfs2Vzp7vxxyyMLDth2in5ckFdfbbE
         eC6Nuufo3B8NI9pxMF6q5PqWeCq/gWXUFCbq8MFeqFtXU+myIoCeWnRXitZKpiJTUbFN
         zPjU1+BFBmn6sI3GuLspEKKoFSsj9eX2fCFuHQowYFDZTf5b2bispBLdHQC3nFW3uZ2e
         apyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795438045; x=1796042845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JLWRIyW6L3H78bd/BFlmj2ybIy9WVHoAXMpJ3dEd5x4=;
        b=o0nNqR/NFfAg9rQqD5kSpg2jzELHqybX1zD5L3zIkeww1zeMGHcW9BatHAUbcPdKCl
         4ziQZFwEearolYv2tuXUSWcqy4N8edgYyG783L0VMwJZyJEDvg8b4EhsM6ZapoF9f3U7
         KgRNHd6NqeePlADTaPK0zgnPCFFR6+vJvm7DsSsvzAaeFAz5IzoBeSf2I1atTeuDol/M
         C3ENF4PyZjyC6i2ACh3i/ZNwEoT63llRmmmrSaDBvpA5vfzW0EkZODsdK2Es6g4klqh+
         YTmdiIWelMnM4IvOiLN3Mmd6/E5ty5HmyUAlL3UtTWswnAtZsB6OUC3LS+R7Nqx2w9q9
         Pbbg==
X-Forwarded-Encrypted: i=1; AL+hErGR+gRlTIOQqntih1JEUATXut9AHKffHEVtXiYrB4hHuHzlM2Zsj+nh5gjKlHh2jQvSjKVNnCI/qJM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+mRI0S39YBpK5DA6GuKb8HwiB/FTyfMohzuq0uA3VqhD0DrgXT
	F+1NE6blvHvJb9BIIZ0YUl+317yISF15O/b08C2zfLt4vmRchdvL/6ug
X-Gm-Gg: AZFdTZfdEidPFQS3oIwf7Km2XqCm1xtSE+c/j7DTUyoLZVbVQRzqWUbD30QLDnuXsol
	6lRnB8ybc2vtShBfBL2nMcbUMzus7je+R3g8NeMnQYqscxZSrE2jCvLmnZRRY+ISXivIG/3OGeU
	Mb7ASjdxrOEJR2hrRVqBtxtO9Zw95mPA2DK2rRsdMEkntHKlOSpn8EqnB6/oSHUQ3db6opC/2EG
	0/tBecK+eYrMDCNPsXTosKgfep2dPiN7oYp7G3Ac+EZqccqyCiqKN/pYW2qmzQpieuHdPYSbyhX
	IojOb+DQP0vYtdlqbKIDkAdIXs0rSz69j9oaHaGw4R9/dVZYZ322v2Dbof/TQ0VJZ3zLJAJPU53
	NzyNUgw+X+br40NLiy9bujYYT/NCz0gXeO+cA0aWueDzdb3iKWtgwVkCnwmB3ZCqX2E/DQ+wL4U
	BlTiG4T1ksyjLJXBuhQaFlinrgVDCarsX/Xogp+dAF4mwCmidUtapc5iA4ilHEtibcc95zzavyS
	MLBpn0ujOMo/ooeQob9cCCznJ+l5mKj0Iw7tRjJIRD2zaVrUDhMxMkOPIU0GvgpE2HyTHi5/1T+
	YniCTiUDHtATLI0O5Auzk1F7R5p2WuRNJi7h1DZNuVY+FB9dTNQ=
X-Received: by 2002:a17:902:e803:b0:2ef:effd:4606 with SMTP id d9443c01a7336-2f03efb019emr116976325ad.2.1795438044765;
        Mon, 23 Nov 2026 04:47:24 -0800 (PST)
Received: from gb05.tail50fddd.ts.net ([139.5.199.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0dc0f8sm51919435ad.27.2026.11.23.04.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 04:47:24 -0800 (PST)
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
Subject: [PATCH v3] HID: hid-sensor-hub: avoid lock inversion in sensor_hub_remove()
Date: Mon, 23 Nov 2026 18:17:15 +0530
Message-ID: <20261123124715.351511-1-ayaanmirzabaig85@gmail.com>
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

Fixes: 8a5b38c3fd70 ("HID: hid-sensor-hub: don't use stale platform-data on remove")
Reported-by: syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6afddf21.a11fe2ad.1b4426.0003.GAE@google.com/T/
Suggested-by: Zheng Shuhao <viennaoffh@gmail.com>
Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
---
Changes in v3:
 - Actually pass 'data' instead of NULL to device_for_each_child()
   (missed in the v2 submission).
 - Drop the NULL platform_data guard since hid/for-next already checks
   dev_is_platform() and !hsdev.

Changes in v2:
 - Attempted to pass 'data' instead of NULL to device_for_each_child().

 drivers/hid/hid-sensor-hub.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index e9d6eb3b3831..090e5a232efa 100644
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
 	device_for_each_child(&hdev->dev, NULL,
 			      sensor_hub_finalize_pending_fn);
-	spin_unlock_irqrestore(&data->lock, flags);
 
 	mfd_remove_devices(&hdev->dev);
 	/* Clients share one HID open; release it if references remain. */
-- 
2.56.1

