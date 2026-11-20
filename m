Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182617;
	b=SXwZXpoyYIvgTpYCAlPbAMAvKXW/0V5AuHS9Lc0u8IzMnLtcLdO/D1EyuXHC0FjtwL71
	 AW9LvuPNv3q8q7bJgRkE1S7zMMuxqJj+iqgAwYbEMH9XvIopPsyIiddFzjPhM2H/SeYBt
	 4EIfx1lCZNydwnpmbWYZbigeyl9kgMHm5Tj+X+Ro4sjQ8sMStkEAYBWybo5l3tMeW2RBG
	 FIQuEprX/mSnHTQ0F7L7PKpKZd0kVjQ0H9FyF8U1rw44uaMAEDR4V8PcKx9xZHiB0OUuB
	 B27JbUUQ3KhFcCWfkcaHLfWbIvc7GX6Fgrl9Z2QcbhnZ9vJBw/RFOcgJps/etGFsuKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ztkmG2EzFlJYzHneyZc8vQ6gywFDzTMFIn6AR2HWO8o=;
	b=AYHbOKE0TnoxV564SjnTjGM1qR3GiMovgP8mWX8A77k33a2mmvzM8kYCSayjoWZI/YKn
	 Nt8WP9KW3TQGUUIUi5TbOT4SiH0AEV+yC43EsF3PWHtjeDpz3EWaEwuOoynnIhQnpgHo5
	 7YHoGH/BR02i3xJn3CpjZVPfVTOR0iqS5gjl8MNAKVuBx4Acf3pYJs4ZN/9kn4bV4Lg+X
	 1zmND6keLZBhAtELNYPw2ORTTCxuAg1Qq3l41pjTVWRpgeoB/gy9BoyQwPSKqwODnOoi9
	 Tt83PAseG1i3Lx0KI0ynNQrx8Mdfenp5Y2PUSyOFdER4/jI2+GAC/bJt1BtZVRSxgDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oux43k8P;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10868606A326
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 13:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10868606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oux43k8P
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-886e61fa30fso385967b3a.1
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 05:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795182616; x=1795787416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ztkmG2EzFlJYzHneyZc8vQ6gywFDzTMFIn6AR2HWO8o=;
        b=Oux43k8PXmTenM/jfST0wFJSahrgdwOk/+WkiFOrtOq+E0jwgkafDtlFhLUkRT9OjS
         ro5B6Fgcmno392b+U27ndrq78LaKuD+eq/yYNOlVFylKoZ6GOxh2tS0gaQtS0dLBoiSe
         1MJBeyJ6mlbuWmrzzVMfv3INJ1srXHrYJ4D+YopErn7w+IObxGOdlCRAPYriiPgwOyMJ
         clprnLU+4VlFfytVSN4jscO6gXXiqW11r9RXOlli+3c8jitaLwY5SqIzcGVJ0ORy+ZzT
         u2M/dmh1rUuOnmOsaZDX04mMh1KZXgJrZBTrnaLVAgBE9gUwG9lEnLlvraHKvZD/6dOt
         Phww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182616; x=1795787416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ztkmG2EzFlJYzHneyZc8vQ6gywFDzTMFIn6AR2HWO8o=;
        b=aSAhsA8J4k2rAJ08albhCCLkDEXJqSWjKRQ7Iq3NYlNPTSim9ch027aDei7VHS76MC
         tGupql3/Um95LLsE+tku7SkWwM48fKCqD1S8MJFxgYl2rI7uOGeM/NGXeh3WHSlsJYVk
         +hRWwT/5QA2ZhogMZY1yBfCz3YTnim0T/T1oLNXT5boFI0PnYnIV/6Bu7NC29sQTaPvi
         5gN1G8em5dc/VlELd/yPYTWFJDooJLyIyWHt89w7LY1dowGh9GCBYV6F5u15824Qg5ZA
         5K8B3xdUN2eUHPq250OrrH0602Vlfax1K2eL3+A/BZqVeyW8LFSuWmFgK7ehzNOiRBJO
         affQ==
X-Forwarded-Encrypted: i=1; AL+hErE6o5vg5DSPTYAr/P8dB5XtF4WpboyfaUma8WS/QQZyOsv0n7mPpdvOFN83f0a8IvOgveTK6nOZ3wY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+MLhQhpnJkTmA/VR1tiv6V6aioqnIRonMu3LLL7MmwbELz9vyW
	aRkV6VMbJBbINwSPEGiHXdhx173EycrOB5fjdBn0hHqeskzIF+7FrIRq
X-Gm-Gg: AZFdTZflqEHEaz9wyt5P8T1o4brvQxm0GnXiURaGb54w3KSsh3YtRoN+ubGz/BzHgZa
	sBjZ9CnGc62fAQrQX0AV/8NeykfggIyfnbOwstKBPI2GXAYvW0MNQvzQkc5YDOrWhwuHCcZhjr0
	CPG3p3LMYFFPtP3TGKrtOH0/wPWnrfpX/8s7hxd4Cw6qXPd97JYg07yvwjRvOTfefRuNMP6iZwn
	ubFV2tSCAt4ZKNSM6GtBdA3IBN/lUlIjlPvVGjBr9A7eAcfKJAahj2xlS9n2ZQ0R/1vYa49a1KY
	ETWw9pIscukkEuJfX8PSux0L1w0ZuB/xlgxwHzr85mvx3IHAMcdQ2CAXn7dubaJbq9jBmdcBsKf
	ruh6gPST4fjerosaugcjD3vv4N1IPwVoZclhIcZCgmeXN59i+0D6V9yZB7fQoSIcZhY4Q07U7SE
	EOiaUHiRV1Smy4fAiGtndpR+gXVVDviAwz1g7FoS5OQW1nVyeG53vU/wbOQmOz/PC9S0li+WwQ9
	7WD9OynBDe/OkWkK6Kp3z3q3olLphiOHCZl2BY3H0JHnGkjGGbsVm4rmRsb+K/XQ+HP6vp95kDY
	Q6ZsekeRhP/GjMkQWnU93gUC5F4Nwn+nuUmH7RtIrrzktw5ykNTebQ==
X-Received: by 2002:a05:6a00:2290:b0:874:705d:f63e with SMTP id d2e1a72fcca58-8c87c38b850mr2646210b3a.32.1795182616265;
        Fri, 20 Nov 2026 05:50:16 -0800 (PST)
Received: from DESKTOP-UCPRL76.localdomain ([113.200.174.114])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c15asm1525086b3a.20.2026.11.20.05.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:50:15 -0800 (PST)
From: Zheng Shuhao <viennaoffh@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	bentiss@kernel.org,
	heiko@sntech.de,
	lee@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ayaanmirzabaig85@gmail.com,
	syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Subject: [PATCH v2] HID: sensor-hub: Avoid holding spinlock across child iteration
Date: Fri, 20 Nov 2026 21:50:05 +0800
Message-ID: <20261120135005.566-1-viennaoffh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1795161418.hid-sensor-hub@viennaoffh.gmail.com>
References: <1795161418.hid-sensor-hub@viennaoffh.gmail.com>
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

sensor_hub_remove() holds sensor_data->lock while walking the HID device's
children with device_for_each_child(). The child iteration takes the device
core's klist lock, while sensor_hub_raw_event() takes
sensor_data->lock with interrupts disabled. This creates a lock-order
inversion.

Pass sensor_data to the callback and take the lock only while examining
pending.status and completing pending.ready.

The callback also visits non-Sensor Hub children. When HID battery strength
support is enabled, the HID input layer may register a power-supply child
without platform_data. Skip children without Sensor Hub data before
dereferencing it.

Testing:
- With CONFIG_HID_BATTERY_STRENGTH=y, ran a UHID Sensor Hub/Joystick device
  exposing Battery Strength through 15 create/destroy cycles across three
  QEMU boots. The power-supply child was found each time; no Oops, BUG, or
  KASAN report occurred.
- In the same configuration, hid_bpf passed 45 tests with 1 skip, hidraw
  passed 27 tests, and hid-core, hid-apple, hid-gamepad, hid-ite,
  hid-keyboard, and hid-mouse passed.
- The full HID suite was not completed; it stopped during hid-multitouch.
- The #syz test request was rejected because syzbot's automated patch
  testing is temporarily unavailable.

Fixes: 8a5b38c3fd70 ("HID: hid-sensor-hub: don't use stale platform-data on remove")
Reported-by: syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fb951970a334aaff00ba
Signed-off-by: Zheng Shuhao <viennaoffh@gmail.com>
---
Changes in v2:
- Pass sensor_data to the callback instead of NULL.
- Skip children without Sensor Hub platform_data; add a battery-child test.
- Add Fixes and correct the syzbot address; remove the self-added Tested-by.

 drivers/hid/hid-sensor-hub.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 6470a290ebfc5..4c447f62480b5 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -804,9 +804,16 @@ static int sensor_hub_probe(struct hid_device *hdev,
 static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
 {
 	struct hid_sensor_hub_device *hsdev = dev->platform_data;
+	struct sensor_hub_data *sensor_data = data;
+	unsigned long flags;
+
+	if (!hsdev)
+		return 0;
 
+	spin_lock_irqsave(&sensor_data->lock, flags);
 	if (hsdev->pending.status)
 		complete(&hsdev->pending.ready);
+	spin_unlock_irqrestore(&sensor_data->lock, flags);
 
 	return 0;
 }
@@ -814,16 +821,13 @@ static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
 static void sensor_hub_remove(struct hid_device *hdev)
 {
 	struct sensor_hub_data *data = hid_get_drvdata(hdev);
-	unsigned long flags;
 
 	hid_dbg(hdev, " hardware removed\n");
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 
-	spin_lock_irqsave(&data->lock, flags);
-	device_for_each_child(&hdev->dev, NULL,
+	device_for_each_child(&hdev->dev, data,
 			      sensor_hub_finalize_pending_fn);
-	spin_unlock_irqrestore(&data->lock, flags);
 
 	mfd_remove_devices(&hdev->dev);
 	mutex_destroy(&data->mutex);
-- 
