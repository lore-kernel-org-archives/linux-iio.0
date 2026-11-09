Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218257;
	b=dWc8drz1M/LtHQ2V1KouvWwAHcimMxSm7iV5VNSc+NoRbKr4VxXz67GjsgOH2yGRFu2U
	 8UNJUudh9UETCY0YmQyi7N0KaE/xRqt06UqY7qXoBDz2A/VjVXWJwxP9Azoq1bxC2oxjc
	 pSt49LAz5yZf1QRU5qh61wwXXl9VjUm4JuddSP84ddDkx1KlicHCB/UElhL7tphC7mPWw
	 NZOk0RBMTiJyFb9oukI+A0P1/RHar/hpJm9hK+0jFCCh/vDIdHgvlvRyEsJnW+aQBg43Y
	 Ix5KqAqBD39gCWV9xZ0NhaLXeFotjQ/WNov3dc2hebnIQcXzpL6gE9FJR8ZAd7ZukrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YSGDtAVI5NKCQhTmv1CpbLpCOuvRYrihGznKJ/oZidE=;
	b=jkO7nPaBslMg/TusJNZ/dOQInTeQ5CoAXYF1pl6XnS3ttT0cYJsarJtYO5ZXEeO5M/TI
	 RgCF5/gf9+moqRt1NYn5BAjBPEvfV+FuyJNm0/vDj0RhA1CMY4NYTxRFY+rVUwnYFoFBd
	 jOmgSd0ZUrR4P65Of08B6jbMa4uvkKikf2ouJgkAiqvCJP3eemBuJHZetEH9b9Z5ps/nv
	 FSldvDPhX/UY7jN/Bu0GxML9UzlMFf00++FWEbQHW/Hx5Z88OSAIQNraILDsG1gN59/Zi
	 qkO+QMtDRgylfKwsIJpaZ0aCYNxpcQvkn8Ba+YNuLlbImDPxjd6cmUx/4+Nn1hMMHuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wc85Q+nF;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C63606A323
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 09:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7C63606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wc85Q+nF
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b0a519049aso403966a91.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 01:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794218256; x=1794823056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YSGDtAVI5NKCQhTmv1CpbLpCOuvRYrihGznKJ/oZidE=;
        b=Wc85Q+nF1L2NMmYulDMI9aHB8p+FTQdXo5F+8CbjBRtWYH68b2Bwvh7/ZJ2pK9C+xn
         sBXII6wFQ/t7jVRthLl/G65GpVfewrKUj2hPnwrnn0Y0pmrbRMF9l7uIX0ubuDDRo8UW
         j3Im7WwE18LzBPuWlwcRS6c86YSGCa6r5n0lSWSsZqm9rTAtHlEy+OovuAmH6I0Fl9F3
         Puxs/BhkJ/Bex926XJjYWGxy+VhivyXh5B3GNaiSjWzuUb3ldlULylZVr2AKWZx5a1DD
         7e7+dLIhuWaNKsPh74d8HD/k/29VkQprS2yfq+DA2RlxzLazhMAuFNc3ADXTLuK3NT4o
         p2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794218256; x=1794823056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YSGDtAVI5NKCQhTmv1CpbLpCOuvRYrihGznKJ/oZidE=;
        b=me3HQWLJlEfVJ0D3JZ3gxf6xXYCObPDHAEcgsv8StaAVn5YFZU2TIWWJAvgWGRChxR
         MQY8nsZNSHQ8d5r4tV65IIr4Pbyzx5A62cgW2heqlGOj+PuvkoZb2ko1DPHXicQpUdF0
         rM+DHor+cIuV71+k0fhDZJp9E5T+EtyyMb34/dHpW7C+5KbSL9xsRFeTQuzc+1jDWwWO
         a5Jj11TwfYWvTVkmzoNRRyBdh4ozuiNkPV2nFzOlLcgeT54jg7hYq/cm+eTdUXy6iPMd
         UslcyMQt8anm35OnhkW0SVVtzw30aRRnrmmI8fxrVwOEPr/JLMJsDuvuOyxz1PQBTmco
         uAog==
X-Forwarded-Encrypted: i=1; AL+hErFWbRl9tx2Itr+ye0WYemGskdhDdCI28ah1LdH+0XrVOpD5dIcVzMq2mFgISg7m32IWX6qhTDUEfgI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/jBVHKPzdChJA91zxOcO+C5cwTlYY/8dO3Aqha4O+Tw8IjPsS
	ZdpiAXhGeuGXd5807MKXwWZQypYrGi7e7A/DHLjL/ZI0UMwi5rVuxX4W
X-Gm-Gg: AYBFou2d8yTreEDYsrWKKmHC1brV//tXNRiuIR3YfjOmo8o849f4OfVVL9VarpnfiKE
	8Ihhf+YdhWXG3Wp9KsrmiBuTFL1oD3vXr1jxP+vSWpOcrvubb6YTPYMD+Kvb5MxakpZlnemUvu8
	XBgWsfOwYTME73ZdmP98gRiHn15XwdpnZG5EHX9bvIM6ZSp5BjpDCZBROIG2W9RQglMBHk6C3Jl
	uxRqwVEefXJF/fIATj0rfPJCd83iaCJYC13kYOBuykq0wXtNfbXfZGXdQa/RbLCuX1PBghg3zwr
	LKMZslxWvyJi0+K+eHxkpEK5prmqdr1PoOsN53q/Bh5KXILOP/Zg3Z7pedPnx7LQdQA4nQ4fJtk
	yoimzsuCU/m8CXyEuneGQQloIXkUyvRhKahXrmGe5HGnMxckKnMMcV/iYK6sQFAWzHfAAYA3G99
	J23LcBtMBGzHWym5NH04R7fhfr2RVsnDctBYFWA7Cmcue0yCaabtAqZRQB1TR77GQuFaQbWs0Ak
	UTuuhLAzfPIXkYduHSpZ0NSYo1HytjzAmYJeJn3jA+N1Fz8wSxZ1XddMbQ21rQg0YOMgjVOm4yA
	LHVNK1o/YjLJ9LK7pmrU4gkGUZ7i5aBYWrytkuXmyADbRasT/HYAck5PtC8VPKK3k+4aP+n8/iA
	3vm2VOdVmIagIPRk3zUQt/Sr+5q6ajaAA6eNq/wIv8joe7iASYd9Vif8meg2hQ4UkYgP9uoIRus
	QrSA==
X-Received: by 2002:a17:90a:fc4d:b0:3ac:9f24:44be with SMTP id 98e67ed59e1d1-3b12d441a33mr3608057a91.29.1794218255891;
        Mon, 09 Nov 2026 01:57:35 -0800 (PST)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1278d1191sm6728852a91.8.2026.11.09.01.57.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 01:57:35 -0800 (PST)
From: Yu Zhang <yuz08559@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] iio: trigger: fix use-after-free in current_trigger_store() on concurrent writers
Date: Mon,  9 Nov 2026 19:57:28 +1000
Message-ID: <20261109095728.59024-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
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

current_trigger_store() holds iio_dev_opaque->mlock only around the
INDIO_BUFFER_TRIGGERED / trig_readonly checks and then drops it. The rest
runs unlocked: it reads the current trigger into oldtrig, acquires the new
one by name, stores it into indio_dev->trig, and drops the old trigger's
reference with iio_trigger_put().

sysfs does not serialize writes to the same attribute issued through
different open file descriptors (each open has its own kernfs_open_file),
so two threads can run current_trigger_store() on the same
.../trigger/current_trigger concurrently. Both read the same oldtrig, both
overwrite indio_dev->trig, and both call iio_trigger_put(oldtrig). The
extra put drops the trigger's refcount to zero while it is still in use,
frees it, and a concurrent writer then dereferences the freed trigger.

With two sets of writers hammering current_trigger between two software
triggers on an iio_dummy device, KASAN reports:

  refcount_t: addition on 0; use-after-free.
  WARNING: CPU: 3 PID: 3467 at refcount_warn_saturate+0xbb/0xe0
   kobject_get+0xf6/0x100
   current_trigger_store+0x15c/0x4b0
  ...
  BUG: KASAN: slab-use-after-free in current_trigger_store+0x168/0x4b0
  Freed by task 3468:
   kobject_put+0x125/0x220
   current_trigger_store+0x2cc/0x4b0
  Allocated by task 3454:
   __iio_trigger_alloc+0xc7/0x100
  ...
  Oops: general protection fault
   __module_get+0x27/0xd0
   current_trigger_store+0x192/0x4b0

Hold mlock across the whole operation so that reading oldtrig, swapping
indio_dev->trig and dropping the reference are atomic with respect to
other writers (and to buffer enable, which the -EBUSY check guards).
Acquiring the new trigger with iio_trigger_acquire_by_name() under mlock
is safe: it only takes iio_trigger_list_lock, and the buffer path already
calls iio_trigger_{attach,detach}_poll_func() with mlock held.

The trigger swap itself keeps its goto based cleanup of the newly
acquired trigger, so move it into a helper and take mlock with guard()
in current_trigger_store() around the mode checks and the helper call,
rather than mixing guard() and goto in one function.

Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
v3:
 - Add a blank line after the -EBUSY check and drop the one between
   current_trigger_store() and DEVICE_ATTR_RW() (Andy Shevchenko).
 - Move this changelog under the --- marker and send as a new thread
   instead of in reply to v2 (Jonathan Cameron).
v2: https://lore.kernel.org/all/20261102034532.33246-1-yuz08559@gmail.com/
 - Move the trigger swap into a helper, iio_trigger_set_current(), and
   take mlock with guard() in current_trigger_store() only, so that
   guard() and the goto based cleanup of the newly acquired trigger are
   not mixed in one function (Jonathan Cameron, Sashiko). No change to
   the locking itself.
v1: https://lore.kernel.org/all/20261026100246.68005-1-yuz08559@gmail.com/

 drivers/iio/industrialio-trigger.c | 60 +++++++++++++++++-------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 76926fe..74058f6 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -421,37 +421,14 @@ static ssize_t current_trigger_show(struct device *dev,
 	return 0;
 }
 
-/**
- * current_trigger_store() - trigger consumer sysfs set current trigger
- * @dev:	device associated with an industrial I/O device
- * @attr:	device attribute that is being processed
- * @buf:	string buffer that holds the name of the trigger
- * @len:	length of the trigger name held by buf
- *
- * For trigger consumers the current_trigger interface allows the trigger
- * used for this device to be specified at run time based on the trigger's
- * name.
- *
- * Return: negative error code on failure or length of the buffer
- *	   on success
- */
-static ssize_t current_trigger_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t len)
+/* Must be called with iio_dev_opaque->mlock held. */
+static ssize_t iio_trigger_set_current(struct iio_dev *indio_dev,
+				       const char *buf, size_t len)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_trigger *oldtrig = indio_dev->trig;
 	struct iio_trigger *trig;
 	int ret;
 
-	scoped_guard(mutex, &iio_dev_opaque->mlock) {
-		if (iio_dev_opaque->currentmode == INDIO_BUFFER_TRIGGERED)
-			return -EBUSY;
-		if (iio_dev_opaque->trig_readonly)
-			return -EPERM;
-	}
-
 	trig = iio_trigger_acquire_by_name(buf);
 	if (oldtrig == trig) {
 		ret = len;
@@ -492,6 +469,37 @@ out_trigger_put:
 	return ret;
 }
 
+/**
+ * current_trigger_store() - trigger consumer sysfs set current trigger
+ * @dev:	device associated with an industrial I/O device
+ * @attr:	device attribute that is being processed
+ * @buf:	string buffer that holds the name of the trigger
+ * @len:	length of the trigger name held by buf
+ *
+ * For trigger consumers the current_trigger interface allows the trigger
+ * used for this device to be specified at run time based on the trigger's
+ * name.
+ *
+ * Return: negative error code on failure or length of the buffer
+ *	   on success
+ */
+static ssize_t current_trigger_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+
+	guard(mutex)(&iio_dev_opaque->mlock);
+
+	if (iio_dev_opaque->currentmode == INDIO_BUFFER_TRIGGERED)
+		return -EBUSY;
+
+	if (iio_dev_opaque->trig_readonly)
+		return -EPERM;
+
+	return iio_trigger_set_current(indio_dev, buf, len);
+}
 static DEVICE_ATTR_RW(current_trigger);
 
 static struct attribute *iio_trigger_consumer_attrs[] = {
-- 
2.43.0

