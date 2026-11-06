Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988279;
	b=mXMKZ/Et47pOpBAnxj1LyvaBDZpNSCqOIUm5M41vUO4hXngzkuicN82W54wAirJ3W/QR
	 2U5ozC6Ay/cAuwbs91qsFbISloI9cAAq473w+110jOeGeDjnTvBIcVT7w+Sc4uqRWe0Di
	 oW3kSk8qoW3hz8q7qo62HCzWoX3mq2IlF/XLNcMXgFmPUS7pVdmydRYSvLSWMY3vFpp1t
	 n6X4e8CSKOvBrqegYdDe1gPWkfwAG+sNmsOvfJV05t2YVhd73JntX3png9x2qEsjLuPUH
	 fDx4VYe/9RAAib3tEtNxYCzJsNaBWetb6NhI35iKllOMGITvHgvfPGZ0DQDsNchYJFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ol4HWN1JMq7gbwHCjCL17fLj4wvViav0TAizd9NAY/o=;
	b=3lIQpgAiJtXIK1tfGTcozBjV/fOWERIcF/TQU8obHMSZaMGTziJ4iJAYtw6ApVQBe4E9
	 e4eby8gK2PQCTZU6BSpsyCvqIV48yvpMsuUN6wjFyaonoPzc0meNXzah60OzXkivm8wBq
	 h0Fmxu51Ma97Tm/RBCuISfn8gJ4wWBFP8D1U9Ho4uyKdI9tCLMQe6SpknMHDlFpM6+vkg
	 ryUsZc7ecVUMLS2PHi8L0hZw0B0TxLKB708jz/HTOkFtrxeFI2wOene/a/do6amAJJvB3
	 Tku2VcPU4xm9q+CiIi7g0bPTqRcxu4aUyW5eAlBYHkR4M8XW8xWbkpYz8vROVtRJFEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="goFTCv/D";
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D96606A32C
	for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2026 18:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91D96606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=goFTCv/D
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93f1e5d7450so89607385a.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Nov 2026 10:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793988278; x=1794593078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ol4HWN1JMq7gbwHCjCL17fLj4wvViav0TAizd9NAY/o=;
        b=goFTCv/Di5F9M3h4vRpM1KegaKPyd4PS+ip4ABx34kYWVW1PSZf1uHnCkrx/lS9l5o
         DXbDFMxYt0avQ+b3NgdcBy6R+Du3wSfutCe7CnS8lroTC5qb1uQRXko4A+1CxYG8dFlv
         JKlpmu1Nlf/I8dsE/daYFLhJAyIoeKF3LCjLPBqjnwLAyXvIgz+szPFBiNP7/lG5fQdF
         572LUrinPBDRBrW4MLhASm1WdabFLdao4BRLNhBQZdMZxa7ZK67m2/RTZkFyB3DJMwBK
         9bzmexc0bz1R4JTV32arsKjWimswFC98IYnqMBsyf1hw8rINPKw0BWT13MxUh84qCsFR
         JcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988278; x=1794593078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ol4HWN1JMq7gbwHCjCL17fLj4wvViav0TAizd9NAY/o=;
        b=vgns6AFkdBSVLMDArp2jgl4YOJSjtBuWe7DKIdQIsfaEjSP/SsOwuF+K0jYLUreYL+
         +GwE3a5SwK7Rmsd735l8whhZYQTXgX6IFz3dwV0GkPtbdwwhQP7pEq9smBhTPNvFKmpJ
         ZW+8fuP0aUCiC4i2To5XB3mVoDfUHu8n+hmHxF0XyX+NtUk3lDm1zFIPdvTcaD03g5y2
         nQCgBLs27wtxLU23mLEAYjYgZs9dBe6IdufwlzYnRCSVnt4uTyVA4WIyugc6TkGLSlbZ
         caduiVo+mShyn2XeF+Ts2Vk+zVJ2j0dWCbF947bRqfT0SfPImpa2iIxWcfona2sdmkQK
         kabA==
X-Forwarded-Encrypted: i=1; AKwUvBxC5am08a+lpj+i0GM85zeenmTXH1I86GJpZ1p+YgT7cwHNGsHMVyMlXTixlxA1z/aJjQVg3+ahHBA=@vger.kernel.org
X-Gm-Message-State: APuU4Z85VPdpkJcS9hNtnxeyZVjFZ3yDBY7rMtgCF/njMlPbn68dx412
	s0c1r8K9tGslGKnSZxhthJtLOoJbb8x9yRsnNgfo2NpAvVEXxBNVychD
X-Gm-Gg: AYBFou0fhyLAiJGqtH1yZQavKcYYWMKfdI+KEln2zan4hIa8culMLi1HK/uCPwZF3Uf
	IAGzeeRDwDLSbaW+OYAbJBZMYMijsx3wgz1yz5nLPhG+9z07YfjsVp3+0OWUg6AYQbXBRSVDQHe
	Yqo6gNZwQVkKguz+j2JXoIRLd9gXmYhUBdi7Aks0tQI+KNzSF3uOso9IlDQtJv/SwYXVsDFLpC1
	Tu/nQwqlUx8a7ADUA6pJY16m2ynvrKeM+h8WFMfSNLBsmmcYTiz071NzxDXOQVctbCipMjM+S2X
	7JX6Sh1wjh10VVWoEmgJvyzt0p5Xb9g0cHgzRoOpWM3Xvy0X7WexhUM/RoXiRBh/oarfBBOwZYt
	jZdsbzHvezFcgaVgTPtY+VYNWWsqPEXw/78pz7MYB1OSZWN7V+bC6s1c8uOHoxNcovchWZHtskx
	hHjUt3+RnJu8QPa4NKWUdCl3VttJmw0+XXh3yuLbv8O34FA0ZC1XBPlD8JBCf5CKcf0ER+leKTN
	s+sRgWdXYcbe3+ZQJmI3/lgaIQGazlzVFhsCtmPT7h1BO9/J36shoHo5OOj+vNMSIQpjEYHgyrQ
	4Y/6dnA1LYr+L3Qqldw=
X-Received: by 2002:a05:620a:1b84:b0:93f:1af1:7952 with SMTP id af79cd13be357-945f32d0201mr435212585a.4.1793988278234;
        Fri, 06 Nov 2026 10:04:38 -0800 (PST)
Received: from linux.. ([8.34.174.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945f599bcccsm195308285a.13.2026.11.06.10.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:04:37 -0800 (PST)
From: Changyul Lee <lcy8047@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH] iio: trigger: free hrtimer and loop triggers on configfs release
Date: Fri,  6 Nov 2026 13:04:35 -0500
Message-ID: <20261106180435.2638701-1-lcy8047@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Removing an hrtimer or loop trigger through configfs causes a
use-after-free:

  BUG: KASAN: slab-use-after-free in config_item_put+0x1f/0x60
  Write of size 4 at addr ffff888001bf322c by task rmdir/71
  Call Trace:
   config_item_put+0x1f/0x60
   configfs_rmdir+0x7b7/0x9f0
   vfs_rmdir+0x291/0x7b0
   ...
  Allocated by task 70:
   iio_trig_hrtimer_probe+0x46/0x2b0
   iio_sw_trigger_create+0x11b/0x210
   trigger_make_group+0x2f/0x70
   configfs_mkdir+0x477/0xf00
   ...
  Freed by task 71:
   kfree+0x121/0x390
   iio_trig_hrtimer_remove+0x86/0xb0
   trigger_drop_group+0x78/0xd0
   configfs_rmdir+0x7b7/0x9f0
   ...

On rmdir, trigger_drop_group() calls iio_sw_trigger_destroy(), and the
->remove() callback of the trigger frees the structure that embeds the
config_item. The config_item_put() in trigger_drop_group() and the
final config_item_put() in configfs_rmdir() then access freed memory.

Free the structure from the ->release() callback of the
config_item_type instead, which configfs calls when the last reference
is dropped. Documentation/filesystems/configfs.rst requires this
callback for dynamically allocated items.

Fixes: ac5006a2a558 ("iio: trigger: Introduce IIO hrtimer based trigger")
Fixes: bc2e1126eccb ("iio:trigger: Experimental kthread tight loop trigger (thread only)")
Signed-off-by: Changyul Lee <lcy8047@gmail.com>
---
Found with KASAN.

Reproduced in QEMU (x86_64, KASAN) by running mkdir and then rmdir on
an hrtimer trigger and a loop trigger in configfs. Without this patch,
KASAN reports the use-after-free on the first rmdir of each. With it,
1000 rounds of mkdir and rmdir on both trigger types give no KASAN
report.

 drivers/iio/trigger/iio-trig-hrtimer.c | 13 ++++++++++++-
 drivers/iio/trigger/iio-trig-loop.c    | 17 ++++++++++++-----
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
index 57550b581593..469bd83331b2 100644
--- a/drivers/iio/trigger/iio-trig-hrtimer.c
+++ b/drivers/iio/trigger/iio-trig-hrtimer.c
@@ -29,7 +29,19 @@ struct iio_hrtimer_info {
 	ktime_t period;
 };
 
+static void iio_hrtimer_release(struct config_item *item)
+{
+	struct iio_sw_trigger *swt = to_iio_sw_trigger(item);
+
+	kfree(container_of(swt, struct iio_hrtimer_info, swt));
+}
+
+static const struct configfs_item_operations iio_hrtimer_item_ops = {
+	.release = iio_hrtimer_release,
+};
+
 static const struct config_item_type iio_hrtimer_type = {
+	.ct_item_ops = &iio_hrtimer_item_ops,
 	.ct_owner = THIS_MODULE,
 };
 
@@ -176,7 +188,6 @@ static int iio_trig_hrtimer_remove(struct iio_sw_trigger *swt)
 	/* cancel the timer after unreg to make sure no one rearms it */
 	hrtimer_cancel(&trig_info->timer);
 	iio_trigger_free(swt->trigger);
-	kfree(trig_info);
 
 	return 0;
 }
diff --git a/drivers/iio/trigger/iio-trig-loop.c b/drivers/iio/trigger/iio-trig-loop.c
index 580a465035d1..e6bea96cc565 100644
--- a/drivers/iio/trigger/iio-trig-loop.c
+++ b/drivers/iio/trigger/iio-trig-loop.c
@@ -35,7 +35,19 @@ struct iio_loop_info {
 	struct task_struct *task;
 };
 
+static void iio_loop_release(struct config_item *item)
+{
+	struct iio_sw_trigger *swt = to_iio_sw_trigger(item);
+
+	kfree(container_of(swt, struct iio_loop_info, swt));
+}
+
+static const struct configfs_item_operations iio_loop_item_ops = {
+	.release = iio_loop_release,
+};
+
 static const struct config_item_type iio_loop_type = {
+	.ct_item_ops = &iio_loop_item_ops,
 	.ct_owner = THIS_MODULE,
 };
 
@@ -111,13 +123,8 @@ static struct iio_sw_trigger *iio_trig_loop_probe(const char *name)
 
 static int iio_trig_loop_remove(struct iio_sw_trigger *swt)
 {
-	struct iio_loop_info *trig_info;
-
-	trig_info = iio_trigger_get_drvdata(swt->trigger);
-
 	iio_trigger_unregister(swt->trigger);
 	iio_trigger_free(swt->trigger);
-	kfree(trig_info);
 
 	return 0;
 }

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

