Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744588;
	b=SfPusuw5Ii5v6hpZ7RPKhAKa0TNPMO5F7xlR21XwaY+5QeMtaH6mQ7lj2Kj3KZwGKwoe
	 6CMFMH3bK43DhxlSQ+zT2HZ+omWhCzEpj5nnnDIXAY3r3Am9gdWrtWv23USmQrEO5cW8T
	 87/a1OP4v66Tt3XPvQ5vZCdZgtbPEZZtnTOwO4LkLrvlufgomnziIsWWto7smgakAyWi+
	 SRRx9fdali3n0mOQhfW4M1VFEbZgwQHFq7TjQFnV7KOk4K9q6Ut5CxTxys7B7WYl3R4su
	 QmdK4cCIHhSSlMexczhMPTso7xlsrO27iQT3MPmviZgEsNxJV/ldjKDeEi4ZT8VDlPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744588;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=f/GjwPB9R1GefsC7sb/ZiS61uSaQkMOnfI2lEQvw+YY=;
	b=LJXvg/JIMWC2hVw/c+KYUSS3yQSgP2g2fXP4ipHd2QoyVoU1OyxhY22DAofBR3zeiq5X
	 sYQsUSuST/Gv0OVwT8Fsnhi2p7VPs4mEkh1ATKtsop1XSkuuqECVQuV+zESZVl4aTrt60
	 vjLsnKXhqs0LGZPo8iKsd0Ekc9pqiMrV3Kf57CVyydtiRfoNTaK9SSdqTAcEraj+uc3j2
	 ME9kwo5EJVlFe7yG5t8c+A52nD37O2oxKBlJsN/2OAYZAyecyvbe8UYAMz5LkhUJIrnnJ
	 AVykJUbHsP79X8nggviVxCdw9EyB1eTJSk1/iAeGSj5Lmom1nqm0x4dybs2gmv2tVvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WZ159z0d;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EB6606A338
	for <linux-iio@vger.kernel.org>; Tue,  3 Nov 2026 22:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5EB6606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WZ159z0d
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-14394530ec6so176618c88.1
        for <linux-iio@vger.kernel.org>; Tue, 03 Nov 2026 14:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793744587; x=1794349387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f/GjwPB9R1GefsC7sb/ZiS61uSaQkMOnfI2lEQvw+YY=;
        b=WZ159z0d3cdyU5ZVhyL5x/B4/1Ju2qWuATdw6DxScbh0z6/a1Qj4iPmHsaGHAmRD20
         XBK/glreKqfgoKH2lJatjUxFnN942Ieb84oy4GbFNnqldIrenK8Yo0S5eBsKLefsKiO3
         qSK33XMlfPyP5N7vavJ78UHFBeM4n3HQ6+7qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744587; x=1794349387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f/GjwPB9R1GefsC7sb/ZiS61uSaQkMOnfI2lEQvw+YY=;
        b=GCKeptFy7RRxzESKEYuJlxT8fz/hrPRfJLo0wfIglQ2spQQgQHjupYHJD8DcKGXRfR
         QBxeL8yScbsvArePPEeTldjYDcKF6WrM5Tq0puwX2U2K1VF/Q3A/94InYLrCS+4FQMOd
         EJ0/mo+FMdlejmBadRtTp3IshUsusj+ATythV6/ooV/Ri9HHOHSGTeZVIQQ47ISsOt79
         qvRjf5SNdY8V4KzOqEKe7NJpolLMShEgm3EZ8+4n45jdMCakmleW/TiZl/PluZkdgToG
         57ITsHwMyDNej1Mujdao/Bl4X/EoRN4yHvg3lTitRGA35yizMwoKSshPspy5ciVkjWOk
         zenw==
X-Forwarded-Encrypted: i=1; AKwUvBwss5muSYb8J0xcIPuQQjVMrPFtmMkv6e13qieJCJqvYTU2BkEqrysIgl2L5gjzVPMRbwuMDAFbUvQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8mKRMdTd1AG0gp55P/RKhxZXy2xPLE+Ox0Q4XZqXQuyzAThQK
	Ms/wKzZmh1vo9nAABDXttuf/q0kbgiY5yjU8PhP+BDT2g3dY6oxgKteScx7Bi5TRnw==
X-Gm-Gg: AYBFou1FNBAOjxDkH2KHY1IoctiOGidfyYko8v4A2+HlJKx/5eJ9lm/S9J34reuCb7p
	I0klTPClMZah3hESuhnCW9cH0SRa7hnm8mXVPyY9mZmDZUmN57np8lIL/c0fw2WYQ7V0ykNqGvv
	eH/5nbxMNmFdzyFMdB9C/vn8TIhe40H1jIDv2D02LjHH2zn18eLcoc7WWdRSMS3pP8gtV2Z2xxG
	erQf6oL8WBvlbybuxF6OOFN2iuLI21UNyPW6jg87RbJ4oxR1Lt0Htb6VUeUCuDTQg0yzSl+Ml+a
	5eF/pi1EBKqjldMCA4UaxeqjUdeuiKHTxlKrHhrD/J/TUzgVv242nGHIbU/2T85C6DFxo3J1tHD
	A+EJV9XOtL+Em6UBIXiaeBV/ACW9kdGSycLI/uMZBtW95H5Cew/HPjM0KI2xJReHgH/27pIEEgt
	yLDlepLsVIEISiWBh9tGuJ5xBkc4SjbbU0W1wlMe7Awvof6Ucx/cCc816IuLBuXJeMRBNMs2Ux4
	Oows4tb3hGzDgnDlBLK8t94j+fy2CWvb4sIQEFDaiunYpcuSns7akbrEtviCSGdsir0vpG6K1Af
	Mc2SRCNW+TVWYukWXgTsKOPtrjmYbBPlGJCgoRhAGgLfi1h9XMxFzIgVRHVHhgMooF2i
X-Received: by 2002:a05:7022:7f17:b0:168:3243:c937 with SMTP id a92af1059eb24-1ac5cb1c8b3mr24793689c88.16.1793744586621;
        Tue, 03 Nov 2026 14:23:06 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ab71:b3df:693a:fbf2])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-36ca390df28sm1162364eec.18.2026.11.03.14.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 14:23:05 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 2/5] PM: runtime: Convert last_busy to atomic64_t
Date: Tue,  3 Nov 2026 14:14:40 -0800
Message-ID: <20261103141442.v2.2.I998d26c0d635b80496ad12daa33b8de602030eb6@changeid>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261103221717.3840215-1-briannorris@chromium.org>
References: <20261103221717.3840215-1-briannorris@chromium.org>
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

I want to use the atomic64 compare/exchange helpers. There are no
similar 32-bit-portable helpers for non-atomic64_t.

As a side effect, this also should avoid some minor load/store tearing
corner cases on 32-bit architectures.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Add <linux/atomic.h> to pm_runtime.h too

 drivers/base/power/runtime.c | 4 +++-
 include/linux/pm.h           | 3 ++-
 include/linux/pm_runtime.h   | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 9d3508d9b4a2..2a117d6a776f 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -5,6 +5,8 @@
  * Copyright (c) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
  * Copyright (C) 2010 Alan Stern <stern@rowland.harvard.edu>
  */
+
+#include <linux/atomic.h>
 #include <linux/sched/mm.h>
 #include <linux/ktime.h>
 #include <linux/hrtimer.h>
@@ -186,7 +188,7 @@ u64 pm_runtime_autosuspend_expiration(struct device *dev)
 	if (autosuspend_delay < 0)
 		return 0;
 
-	expires  = READ_ONCE(dev->power.last_busy);
+	expires = atomic64_read(&dev->power.last_busy);
 	expires += (u64)autosuspend_delay * NSEC_PER_MSEC;
 	if (expires > ktime_get_mono_fast_ns())
 		return expires;	/* Expires in the future */
diff --git a/include/linux/pm.h b/include/linux/pm.h
index ef3f1310e749..531e46ff878e 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -8,6 +8,7 @@
 #ifndef _LINUX_PM_H
 #define _LINUX_PM_H
 
+#include <linux/atomic.h>
 #include <linux/completion.h>
 #include <linux/export.h>
 #include <linux/hrtimer_types.h>
@@ -812,7 +813,7 @@ struct dev_pm_info {
 	enum rpm_status		last_status;
 	int			runtime_error;
 	int			autosuspend_delay;
-	u64			last_busy;
+	atomic64_t		last_busy;
 	u64			active_time;
 	u64			suspended_time;
 	u64			accounting_timestamp;
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index ae68a9dc7fc5..da537be94732 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -8,6 +8,7 @@
 #ifndef _LINUX_PM_RUNTIME_H
 #define _LINUX_PM_RUNTIME_H
 
+#include <linux/atomic.h>
 #include <linux/device.h>
 #include <linux/notifier.h>
 #include <linux/pm.h>
@@ -242,7 +243,7 @@ static inline bool pm_runtime_has_no_callbacks(struct device *dev)
  */
 static inline void pm_runtime_mark_last_busy(struct device *dev)
 {
-	WRITE_ONCE(dev->power.last_busy, ktime_get_mono_fast_ns());
+	atomic64_set(&dev->power.last_busy, ktime_get_mono_fast_ns());
 }
 
 /**
-- 
2.56.0.398.g882cbad275-goog

