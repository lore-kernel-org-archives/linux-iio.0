Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116059;
	b=irccb7b8n7CZj15hSs5HySux4cZUugIzkGxwQVZRcD1AOH8NZ9SJQJ46+Se7L8Nmv+9P
	 vhag3+JcGCLWVDuhSDZ75zt4P97/WVcgmuGKQqtJCISz72nodfK4jNKBnDe4KRKS5xaML
	 qkgwxlbltSHYhavQoPqpLY/JSGDHXoATM6T1AD6rYDe64Q3qtVA9W8NIcl22vdxO38Sft
	 u7LgjiLY6ut8lItidOuASceh1om5ebqB9R/6cW3kC2OTocB+QQX2Ft1PIz+GcNTJKouWz
	 2dHCWb9OhmSVWa+UajyQ0pUIrBiQvpx5v1682n4U9Amt8QDUwWG+zCbtRVzF0UeF1dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b0c6CGAGUF6g8vtfSwTL1Y354j7cyJnIuNNGjuPfWNo=;
	b=Vz7gaMEwOwAubhxPfIQwAsAeHoTZ0TDRGRMlGQFRN8nJKhnZYQJoNGCCofPsAKgaZhrB
	 P2t+KtXkVwMcLoAslKRgWY7ASDwL1DFDvv7nPhlvoaOIOe9NA5B5qRSEcLpWvXLQ1PNda
	 MhAs4kBTTeKTvZ4TfioKQszoQpBiY0ifmysqNujcSAl0boS97W/EU5WYc9Eth6Rn1sTt+
	 vWyJR2PkpCWqewQDBYPKazPN+Dn5MabvJEvwrU5v16iG+xOZGISbR54fdyKSflTI0Ut+S
	 9ZJA1dJrCZlWWwR8VYAWQMqIhHNiMd3kSSZQ+LSRUOGcVJ8UxV9S2sjKSBKENAXRbew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qNv+F2up;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A39606A32A
	for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 19:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62A39606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qNv+F2up
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e9e53d011eso718485ad.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 11:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795116059; x=1795720859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b0c6CGAGUF6g8vtfSwTL1Y354j7cyJnIuNNGjuPfWNo=;
        b=qNv+F2upay5nHaiW1qXWUZPBc0wtvYrsbaPLKxcBjuBMxIfvcKIMBkAVP7tef86ztS
         8GydGE8h32QinKjD+nR0s+whfjhhclwBKtHCTyVmwHWbRkFe6QlTTFCCyeYg4/7UejnS
         jZc7fskxiat+VCWRrP/uU0oRaYek6TTznytdpZmd1/2ewt6YJCuXb+BYX4ipwMn1QUDo
         DL5zFGqRH15Sm+c7lKYXtjYzcqYdtMMgB02Neiiwd71EVE3VEWqeDTRaKKsZ9UlOfvfs
         3FIslBoUlo/U9bttxtetyDa5a8bJO5nRV2HVPahgSDVDyW72hFSeuPpxTNrTSh1Fxnmc
         TaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116059; x=1795720859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b0c6CGAGUF6g8vtfSwTL1Y354j7cyJnIuNNGjuPfWNo=;
        b=MLjO6QDki7Cz/U5m4vf3fbVVlZua1ScXObs0oDd0vuvRIMXwknMDNRVr9Q3causFJA
         QCeQEHVhrntWatnIqmU9RSXyt4xqVstrxsGtopB2Xsay89ad1ErEq+6WC0ivE98C+c6J
         ws86pexyhQfDctaBa57nTherUCyyb/fNpqyAN9Dlv4yUQIrj+vCKAjY6DLbqa5Oke7v0
         RHP4vb+DSdljgA5jjVbmsPT2L3KSJSl1VSesOjZtryEyulhlXysUbJgof4jLV+kRVdAW
         qa1QXSF/8FuKeu3zLGSI28Pz9SCEWR4cBzuCdgy+j6bHkMfnssU0xsR5T6rZSQ7kWYlZ
         LsiA==
X-Forwarded-Encrypted: i=1; AL+hErE9VLAyz8UyqzsXP1thrnEsJJwaRAc/jFWX1phxXP9Dyut39Au4gqR2dL9GHXc2a2pLZsf5oK65VME=@vger.kernel.org
X-Gm-Message-State: APuU4Z8sCXIZIOFqoxQIh/0Ds1GADdzS10HVQ8VfeUQbBj0Tr25Ei1md
	Yb02qn3AA8hbkhrPeh7IS16dGW+3bdQVRz9jABfYFyS7vFzEf0+GQ9zw
X-Gm-Gg: AZFdTZcQOZkBmIrz091QTqoawiw1JO6yQSqoxQe9ebiqxCqZ77H5rww9moalzzukVyH
	BpnOpQHXuI6GCk0rOCBWePV45hq7TKGCl+8X2CsnrDpDd//YSqgJSPYC7dniluxIec/nmrPJjHQ
	N/cllmtyV+QiUgKmQN/+1HGi/ePlT7d09CBzGIj/AMF1kadozhxXeR4e6mMU6HTp0TMfMW/Qk7a
	5LiadrZC8nv8J1hQ0yI4xfIcJyK5U5xS1Ag3r1N+ErvNerjLpak1Cc1Qp0/SS0kTlmtQihmwh24
	cTWZzXfaB1uCwu1tw7Hg8uMAhlap1kKOgodOJTPYRIAWJWy0/E4gYLZtWzLbboONuu7sYr7Tr+i
	Mfge3QtWhhQldEBGoaBIM4wvhU6l0Mv+7eCrRbIplWkmkkN3mfkzfOgd9Ej7m/y1EP6UJSMScHE
	4o04UJBa+md8qegABZ8/l9bL9r5rStnKtR/AtcWFAqaezJVXlFWzNvjhRs/qZyqxUvwrCJ3RZnH
	TV8x81aO2/1C0dhaTImULYZZT7wQvKKwYfRt7Qe3PbV0LJIsh7uBZPuxNKh/xIq67EBkxpPrZro
	ulTmFP5SCbteAuFLW05dcXNXw1n6yscIPtbw4s7YgXgbR/j1u8Z+mtwMDOniV5N5plwVs2iC
X-Received: by 2002:a17:902:ec8b:b0:2e9:66f6:7894 with SMTP id d9443c01a7336-2f03f15c27amr7776685ad.40.1795116058661;
        Thu, 19 Nov 2026 11:20:58 -0800 (PST)
Received: from gb05.tail50fddd.ts.net ([139.5.199.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c1935sm3948805ad.26.2026.11.19.11.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 11:20:58 -0800 (PST)
From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Lee Jones <lee@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>,
	syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Subject: [PATCH] HID: hid-sensor-hub: avoid lock inversion in sensor_hub_remove()
Date: Fri, 20 Nov 2026 00:50:46 +0530
Message-ID: <20261119192046.1015750-1-ayaanmirzabaig85@gmail.com>
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
Fixes: 8a5b38c3fd70 ("HID: hid-sensor-hub: don't use stale platform-data on remove")

Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
---
 drivers/hid/hid-sensor-hub.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 028e70ec7bac..4ade5b5ece56 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -836,9 +836,13 @@ static int sensor_hub_probe(struct hid_device *hdev,
 static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
 {
 	struct hid_sensor_hub_device *hsdev = dev->platform_data;
+	struct sensor_hub_data *sd = data;
+	unsigned long flags;
 
+	spin_lock_irqsave(&sd->lock, flags);
 	if (hsdev->pending.status)
 		complete(&hsdev->pending.ready);
+	spin_unlock_irqrestore(&sd->lock, flags);
 
 	return 0;
 }
@@ -846,16 +850,13 @@ static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
 static void sensor_hub_remove(struct hid_device *hdev)
 {
 	struct sensor_hub_data *data = hid_get_drvdata(hdev);
-	unsigned long flags;
 
 	hid_dbg(hdev, " hardware removed\n");
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 
-	spin_lock_irqsave(&data->lock, flags);
 	device_for_each_child(&hdev->dev, NULL,
 			      sensor_hub_finalize_pending_fn);
-	spin_unlock_irqrestore(&data->lock, flags);
 
 	mfd_remove_devices(&hdev->dev);
 	mutex_destroy(&data->mutex);
-- 
2.56.1

