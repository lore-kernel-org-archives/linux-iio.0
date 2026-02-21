Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9425E237707
	for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 07:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771659198; cv=none; b=mx2J4HSIMKjQkm7tYavq8j3CGvTZIfRFsRBwr2Bho8KWD63KYa5XxQV0D/ohFsUwNiqc+yfJnWGl3hVk3MxOV5IiNfHzw+TBmczVHAwaiKa/1BDYNq5xl9pd1Z5/me3m5H7mcVihwog8ixtFyU/XCXuUM24Mm2O/Ipzbyir35Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771659198; c=relaxed/simple;
	bh=JBLp57T2rH1A64A7q8apja8cyBEzsnE2qvklYDn1YJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K8ATqyMRjZZJZNdpraHow7Vc4AhLEE29pIa6OMQuZ6j/OIvWLk+dY0Bugfhd47lU6sAKHlzxcceDw4cvAXdD+6pBwCXd1Ss4RowlzbW3GXz5K+MHfmr087oBjU4+LsleYp8DzvZNvDQmQbfghOMmMBnv3lDcRH678LIoOzwad2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNn03214; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNn03214"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48370174e18so16070805e9.2
        for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 23:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771659196; x=1772263996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DIDvOyw8CGCfP65CRhRJUSgrBkLbuDLQEI5t55r/3B4=;
        b=hNn03214BnPZM8zDQA2OWXjaTm6kROnGpAqXfahWbXiTeq13zAwu9fsbnK1IvjCZ8g
         GSsjgvQsVD0nhnI+PpVUbwN73rcDtr1vrw/gstrlcX2utXUDku2CBIiHi4rricJIOPHe
         gNEeKvKvC/u/x2WbesWdVOmVQdI4aSHH1epik6m0g6XmYT0JOj4yKDLdk9UXcwhFi6Ib
         ra+WUTT2b90gYvAVyZEtkej44IJYXQU/FEbKV2803zzNijTnM/W2xnjo1AoZ44Kvlnhs
         kgkNp2jJ0iD9bCfb2k+Mm6OPNCYglkcLgJ8n2O9KbFCp2dxpx/0TAmL0Eu+u2EZXAKEG
         uUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771659196; x=1772263996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIDvOyw8CGCfP65CRhRJUSgrBkLbuDLQEI5t55r/3B4=;
        b=Rwr0pHPccUJx0AZJl3ehEk3cDNboxYxSktCNdV6fGokSiI1AmUI28pRM5EYVaGxymd
         4pZeLu6yI7YQnBLmzhYRNvtvUbo3CdB7sIksnEJ2Fcno7TH1Bt+ZEsW/yP9OOAV2BpqW
         jz5ANepMYMFGafczX7HCi16UBy4nKXW39UQu4NgnVVJTpugEY8YLkLBG7R0cY65+TGgn
         fd7/032v3lsrW7UveSOuGEBL587E4QImcx9QhodAELN3pg46jH5RLXJb8jSXwaAOayWD
         zfvAGiFAJcPwPVVBoBvt7VD8YPReRDOfx5vkKu9aiyXraZrdkpu+goucbnDVI0Ubn0AT
         ISRA==
X-Gm-Message-State: AOJu0Yyry1y+wdkc5D0+Vs8qYp4XRqe8wfrm250EIbjH70mIw/bT7Mqw
	pSsdrgNIh/q5t339SxY7hl5wmDGZqAihCnx2bjnWJw/tScFKG+3djGEz
X-Gm-Gg: AZuq6aL+ML0tmQpKlL8QhlRqugsXBoDXZEOiW9YgDYz/Okn6v9pNZ1V57KbNy55T1f/
	Fd8FqNJskDUNILchH6YjK9n3qcDmH5OZsyYda/rHp0ADU2kw9ar4O8aiR0ElPYMaWOr3BHiNTcL
	ZspOihzMwc68BMmHrI7SFfdZcQA5D8Dx3pwwC8sclI+x5axouydbd320ZjiVZyANXRULwZK/kAT
	wsa5FIM1LIl1h5Byt0zeo3eMJIMh4u67yAPZwofimWcnNmsugFq+2itwewbiequ8BS4ixKc5FJm
	pKzLOVmuwMGHounf0BFuHzP61cNrwbZk9n4SN6xPmbEgboye90HAFt0MbgjPwx+ksfU8gPmu2/4
	pUiNe+IcBpaNOqLvWmytVkwHREyUJ2B5dV6aCyUJb3bUlMUH4NZh3F+TSGS8ve+SUiJsTThaai0
	9ER3Ag3TxlM+tEU54b9qouK7R+v/IDIS5xgleUWTg=
X-Received: by 2002:a05:600c:6296:b0:47a:81b7:9a20 with SMTP id 5b1f17b1804b1-483a95c6774mr35319915e9.9.1771659195647;
        Fri, 20 Feb 2026 23:33:15 -0800 (PST)
Received: from localhost.localdomain ([196.235.238.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31f0330sm103093365e9.9.2026.02.20.23.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 23:33:14 -0800 (PST)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v4] iio: core: Clean up device correctly on viio_trigger_alloc() failure
Date: Sat, 21 Feb 2026 08:32:42 +0100
Message-ID: <20260221073301.105080-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Once we called device_initialize() we have to call put_device()
on it. Refactor the code to make it in the right order.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes in v4:
- Move device_initialize() after all potential failure points (kvasprintf and 
  irq_alloc_descs) to avoid premature lifecycle management via kobject.
- Revert the use of put_device() in the error path and use kfree() instead, 
  as the device is not yet initialized.
- Align the implementation with the pattern used in iio_device_alloc(), 
  as suggested by Nuno Sá.

Changes in v3:
- Rewrite commit message to focus on standard design patterns.
- Remove the "Fixes" tag as the change is a cleanup/robustness improvement.
- Simplify the description of the fix as requested by the maintainer.
- Change title to better reflect the change (not a use-after-free).

Changes in v2:
- Remove the manual call to irq_free_descs() in the error path to avoid
  a double free, as this is already handled by iio_trig_release().
- Clarify the error path and the potential for memory corruption in
  the commit description.
- Remove the blank line in the tag block to comply with kernel script
  requirements.

 drivers/iio/industrialio-trigger.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 54416a384232..c995311bf699 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -561,10 +561,6 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 	if (!trig)
 		return NULL;
 
-	trig->dev.parent = parent;
-	trig->dev.type = &iio_trig_type;
-	trig->dev.bus = &iio_bus_type;
-	device_initialize(&trig->dev);
 	INIT_WORK(&trig->reenable_work, iio_reenable_work_fn);
 
 	mutex_init(&trig->pool_lock);
@@ -592,6 +588,11 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 				  IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE);
 	}
 
+	trig->dev.parent = parent;
+	trig->dev.type = &iio_trig_type;
+	trig->dev.bus = &iio_bus_type;
+	device_initialize(&trig->dev);
+
 	return trig;
 
 free_descs:
-- 
2.43.0

