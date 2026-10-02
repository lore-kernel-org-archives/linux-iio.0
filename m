Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EB63EB7F4
	for <linux-iio@vger.kernel.org>; Fri,  2 Oct 2026 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790982448; cv=none; b=MRuBsQJQ3A1JforLM0ZGG6iTuNSmX74TEAlfOKLI0t92e2a2Pjxpu8zDPuXLbPjyxB2V19d8Unk33DtAE94eJS+rjk4altweAPFArPV4honU5MuZObHyYuB093FpfW3DktzVhspAvcwx1EDYMs9FepWiLcILtnLdJOGxVuwXkrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790982448; c=relaxed/simple;
	bh=NXfG8BYbOogjZEXW8d5prtXBSKsGjWq60veGgTm2Dvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFKExFkPtKp/Ft8I+314U+eNPDfsRFFgYmGbpoHqysRTX3dkWSJBbAzrXVgle425ID4gTJsoYiUTe1C+DRtCVm4LZ/fz1JDj6BBhtQDD1VuBhfjjBidRmK9EqujusBz4AuP8WXVOOqYIHDjS7THRGYNESWTmkYlTZz0X6g9rnj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LmACTRqO; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LmACTRqO"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3282db206d3so345288eec.0
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2026 16:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790982443; x=1791587243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cj31ExEyFV3PoRNZbMP+vqda3AvxSrb2+xWS+DVF+S4=;
        b=LmACTRqOrDbKZhY2o8Hlq2GzDweKDH5JvnYjuL110WhpHEljglVg8HKdFETGH2AieH
         nqf6UmXnleKUSD9lo8jWyovQ+mRSkeK6zr9PrfFMEOk7A2Xqvm7zHT8jCo/ENPHU3uEO
         fhYunj0xtl/cUyKcqlk62one8V5N0elEy/xfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790982443; x=1791587243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cj31ExEyFV3PoRNZbMP+vqda3AvxSrb2+xWS+DVF+S4=;
        b=Dc2GF9NAJTDf7b9wJGte7qTHZDFdAf16n6dc/+Z00ba4gcyxVUudf68wc5gCdZNjI7
         JAk+vq+uFDafCkO/Q+Q7wAlaU1slm3Yg7awkIxYp7nOa/T3hlGMh2Wsma/s5znIicjdA
         s2u/osGPSOvl9evRmCpiKS0neHp1IFxIcv6fVXYie6ArCBqU1JpJBxN6MPbLIjg0b6Zd
         cHB7i1c8qPkJwRip/lc2Cm26MbP4EpqMZk4efqX9Gk9M/vaDnC+q6m6R2yO9Rk7DdjTg
         lfyv35y+JpJxQ69LQPUKmS7EsV70sFxPjl1WwLpFpz/z/f0X+i1FKeY/eWIPBNFOVtQM
         4fhg==
X-Forwarded-Encrypted: i=1; AKwUvBwPfI6DtBhvCHG9OSpkYPvI1KuZfzg52ko3VLLpCThko44JAbvkcW2g3ifVbtNWQE5DWusxdkNcbtM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgbuHlN+JucycPqU3lGHFXi/PlrgG1JEyZyusaBptZhbA3sJcJ
	nsTCLFEMfvca4Q24HJvMNGk7X7PVIXX1Ad8MdeI1t9dp/WnUtoOTdKdaryMsEu+0Vg==
X-Gm-Gg: AYBFou2+O+dqnKfkGHVO55Y6C+CvVKAk2AoTH3Up/uMr0QpMtvVdM0R4hpwQxeGO0HB
	G4tHehjuW+0fTKsvO1voxbZbtF/oFMpzNdCxgmCOOduKrPpwaZUR62ujFvnJ9tHrq6Y7imnQ+fQ
	KkeKnrpM0xT0Xbnluotxyzer7xNLgCZFmRpFUnenbjiMrkU1mSFjku1Rnymkans9gzpZbCzmrnm
	6GTaoR9NZ4AusGt8M0kgOBY5eR41/86Q9/1UlH/C8rCkeK993FTMuItvBRNDXg/UNVWGuLLABz2
	3gBWQ5z96aWX2veCKDRacVkSgH6U59mbLcWrE1mHMM0t1WhaOd8tB4X7ydI23E+wT6GVwL+mTeC
	ZIMYtqULgJCXYNJERIkIt90WH5nkL+oIt4LqTlQjJey6N4kVsDwsJAe/lYNXiOAX10zos/YcY9y
	isjcvnTl/H6+KueHNK593oSb4AkWBC9ENDh3AVA6dW3FwvTutucy2ljlmEsb1fWM2rcyZ2Isdtc
	MwyVhFPuV2RU1vhUOt90tM9QZxsGdOlSKlHWg==
X-Received: by 2002:a05:693c:41c7:10b0:351:13b4:9c59 with SMTP id 5a478bee46e88-35113b49cb0mr571453eec.2.1790982443465;
        Fri, 02 Oct 2026 16:07:23 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:b0dc:e72e:e96b:3323])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-34f0672c2d1sm12058791eec.4.2026.10.02.16.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 16:07:22 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-kernel@vger.kernel.org,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	linux-arm-kernel@lists.infradead.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/5] PM: runtime: Convert last_busy to atomic64_t
Date: Fri,  2 Oct 2026 16:03:06 -0700
Message-ID: <20261002160309.2.I998d26c0d635b80496ad12daa33b8de602030eb6@changeid>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20261002230714.507921-1-briannorris@chromium.org>
References: <20261002230714.507921-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I want to use the atomic64 compare/exchange helpers. There are no
similar 32-bit-portable helpers for non-atomic64_t.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
This conflicts with some pending work I have here:

  [PATCH 2/5] PM: runtime: Avoid racy clock checks for autosuspend-retry
  https://lore.kernel.org/all/20260929114714.2.Id0a3276d23d30e0b5fd4d6dca730be0f9d8fe018@changeid/

It shouldn't be much trouble for me to rework one of the two, pending
feedback on whether my approaches are acceptable.

 drivers/base/power/runtime.c | 4 +++-
 include/linux/pm.h           | 3 ++-
 include/linux/pm_runtime.h   | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index e70726b499e7..9eed1f79429d 100644
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
index 322e3b17f987..289fa72c0af7 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -242,7 +242,7 @@ static inline bool pm_runtime_has_no_callbacks(struct device *dev)
  */
 static inline void pm_runtime_mark_last_busy(struct device *dev)
 {
-	WRITE_ONCE(dev->power.last_busy, ktime_get_mono_fast_ns());
+	atomic64_set(&dev->power.last_busy, ktime_get_mono_fast_ns());
 }
 
 /**
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

