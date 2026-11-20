Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176791;
	b=M3YOHVAybcRbuaYTrOJMBzsXtNGJo684cJn/ybdj/SiSXY0BdG9XpD+AMbPrBWMrZY6N
	 P15lLMHon1tD+Nt64BEBumenihHaJZcZYDuGopDv4kvYhX+EqsmLL0fzxEZV/C3YBRk1d
	 vVSpk7fJdM4Tsdxn+mG+LyqHx513SJEt+0gkoyIovwnGJnZKqgc6l0yrS68FOhF05YdLw
	 yaSepl0WyMcU+KHK0KSPnMMgz41y2QepwdHcHniCxmrocdpGoCLBOina356DoiIDhP2mq
	 NeegyqUo2EEtIjmGeDgJHURllhSqRXsoIG3Zm0+hhH+rupm6kjZU4hV+2iYmABRuA3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=m6tPHsL9Rz9UVRE/EWNWK0Z61K0edsr5OFdC9JXo0fE=;
	b=k/Tl+k9lXygqjX+GuVflfBS5lhzY3r/l+UpIF5kSmJqqy8rtkBrGVZPFdB6eQ1n5U0zT
	 2OC/ZCUsNTlnFiimZm4RXHIdm2jIX7jrlfor0H0WVJiBHwmwju1UzSewnqoNnsKI1E77i
	 2GL5fJFTAQEspFP4Z1+0ELe6Vyg7FbgrKvqdaLoueMWUwg0wwrN/Zrye75lwYSgJICGrn
	 taQetXVPAVQdHRjAY4w/G452jR9XO2CPV8hbsa2PCDp9Yrpeaa55CMnSG+RfGswphIZrW
	 yza9ohr9c7rDJ72vNiqsTGA50glc/ZntwIFuyYKKTRLrYqxpHtVHHLK9Mfrf98j7dSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RLP9QAoM;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1F8606A326
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 12:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B1F8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RLP9QAoM
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b40f4d4b5dso394702a91.1
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 04:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795176790; x=1795781590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m6tPHsL9Rz9UVRE/EWNWK0Z61K0edsr5OFdC9JXo0fE=;
        b=RLP9QAoMuEkQUYfb3jApABtNveJJP3px+NbmiksGLdl7+ObkB3blouXLdlaJ4ZGC2Q
         bGDPEpn77aJoCskRVMhCc9R92Iq2o1bYVlQvyybKsWVSwqf1dAEWd3eeEgj+voIBBEPX
         voluYtglHq+oeedHwt6/G7mNy2cBDOxezVn/Z3Kqa3BxSte/hPKbARCslrKr9lLUQ4ka
         kMQRi6Qgn7umatfPKLzyWV/wL7BiuV8iR7DFA0xcZq/gtQUmukHdaJoh6CJHx7bNrl/n
         R+R10Gb1ILkf2ACeQVsaBNs9R4JgRvlpsPmpDr6tek/GZVBZHsH3FwxwjRHRagrzKhFQ
         Dddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795176790; x=1795781590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m6tPHsL9Rz9UVRE/EWNWK0Z61K0edsr5OFdC9JXo0fE=;
        b=GJv1y18oGiCvaiJXm7Tyt1uRDbSm5KUyt96Y5HfiSK505zazmDesYXU4krzotOl4yh
         5JF+YF4jYDMh7+py52cPT3OK930T/AiFV1v8NWTIgmbC0BHboPNw7gHGNxr6h0jJnCfE
         Rc2W64o2lGMmJFFcVBgmv6a3emZNgSkXnuuodG+n1bKMaEXYeTQGOPzfqBNF7DCBBAwK
         I9hHdq4D4//qDXBQPTr++37n64ZYP90IMoc5Q34NAamA38vOfob0zTthwLxxYzlV84Hy
         Z3X8MbUOpjZuUpc+Osov8d5z3TZiAJ0wi37EdclfLFnM+HdJWDIgaJWCJyFCWLKDhMYB
         eCpg==
X-Forwarded-Encrypted: i=1; AL+hErHIe/VpNvDEqpEjtMxcnT/r315RXtUzeSzy+atdY0MlKJ4zR1mc6Wfm/l5iZIxUGjBVIVzmJTEEclM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8o7ec7X/QmJVypQ6jTLi1OgZTuLcA+CxYFXQhsWoAinbCXTpCU
	DVsPlY7fiJuGSBtFTg5N+dSjz8E5Vwwv57G+UydglxEJRFr8vYHseCwC
X-Gm-Gg: AZFdTZcuglDzQ7Xj2iWpuKoGjYIUVkz1egCKx+H5pIX33LZEEcyzswTRiiVhqCdG+Co
	HunpoiDceW3+zEQwEd5tN+jS1sqfDh6AMJ0UMETDBiF8dbauCLu62A1+kXeOsU8zCsdpz8b7atY
	ezavTMCB1SPmm3sG03Umi26dlvnpZ4OL3dMVaeIml1Br85NSxCqDkxDe9AZ+j/ToKmKytwZV0cp
	URUnn6NcOBfP33KayMk9Erqw2DNoJUkeekIqrIEtpdSOyAP+swSQtlYu5QBRyFokSeGg14MtVc3
	X+zoXXcErnd29X64Z5bE4d/ySJrhKEZVPR3D7fyFR2EdkcSX7iQ84Wv6c73S1WDRitHUKCgfetZ
	bGLSXDVt6npyOg6hI+d9mEAf4TJFvjeO5oJ6P3egH9Q+Y5p8YB6X4nAZm22mbUJc8blRrG6eJos
	Xn0zA48KA2wwsPXSwP5OysNE1keu7ZpYkrWVJExJPc1GoDdlgszix56xYT68NZMQymdSe0ZSWJP
	UzlHCK8Jm+hz7tfeot0zOY//l14vFfzKBLMzQm8xLVbaOUuw1/WCziYZX1e07q3b+WDEbzw6lxM
	IbfC4YCTm/KXQCTjTQYJ0Qlxo7Pa4+E482SWuR0Xy323d932nYBEdXb5kw4T8W3UbgtdHI7Z
X-Received: by 2002:a17:90a:e7d0:b0:3ac:929e:691 with SMTP id 98e67ed59e1d1-3b41c8d5a52mr2637365a91.17.1795176790444;
        Fri, 20 Nov 2026 04:13:10 -0800 (PST)
Received: from gb05.tail50fddd.ts.net ([139.5.199.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41cfb48basm1513592a91.2.2026.11.20.04.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 04:13:09 -0800 (PST)
From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>,
	syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Subject: [PATCH v2] HID: hid-sensor-hub: avoid lock inversion in sensor_hub_remove()
Date: Fri, 20 Nov 2026 17:42:56 +0530
Message-ID: <20261120121256.35339-1-ayaanmirzabaig85@gmail.com>
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
Changes in v2:
 - Pass 'data' instead of NUL to device_for_each_child() so
   sensor_hub_finalize_pending_fn() does not dereference a NULL sd pointer.

 Tested against the syzbot C reproducer on linux-next; it runs cleanly
 with no lockdep warnings or oopses.

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

