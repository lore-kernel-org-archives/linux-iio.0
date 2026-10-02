Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0B546E017
	for <linux-iio@vger.kernel.org>; Fri,  2 Oct 2026 23:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790982447; cv=none; b=EqEMf6Uw6d5OEqOoWSoYGufww4cOgLqHjiSVDGosD+XR3ofsyD62bviVWvtkcXo8gHyB4yGb0l1qoN3afpN9ya1dKPznXy3JWuFtAHPsgUYmPqesGx/uAO3FNrzCto6JC9kOraFPKogzaw8QQ8+z7bgxxqYwsXO98Tr00z0sAJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790982447; c=relaxed/simple;
	bh=0Ye5uRCpFYj10aSEKZ4sOZLoRrzXYNiOUhVoX1kC7Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQVu3gg5BbrDyTShNI7xOv+2TunoyCya5xS6neUI7uXhTYASQ/JqDTkR4+RmSKgybILmoookmPfWp2EFWXEc9n2j6s4BqntDwaTgEJKsunervs+0VYyS9rR6zFE6ZPNbtq5+nCDmsmnoDx/25/skeUV4aaZlWVuWYp97UG4RfuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mClFcRsK; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mClFcRsK"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-34bb8b31647so174451eec.0
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2026 16:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790982441; x=1791587241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Yhq5TvFbCkOnmQ0HyRqBja4cyWrB7IIoElNmyWi5U0=;
        b=mClFcRsKNyiTE/6xvZYFvQZa5uS8eNuLvzYRqYie7sBUycYyhEl3XSWpSDqaQUg5NZ
         TPjjVhCkD9yZ7QoMHqufTkqk9eDdyU4rsTxLT9/z8LnNHUz+Q642wqlSMcvUxEmFthyH
         6doEHrMqeynv70LU34kDxuJdfJ/ZO4uiNNONE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790982441; x=1791587241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Yhq5TvFbCkOnmQ0HyRqBja4cyWrB7IIoElNmyWi5U0=;
        b=Bn8gNEdmMq29pMV/bWkd8wh3JNKlvdgGxBSTY6rviYfgb39N9B82lAj1fuVlZp5Ykb
         f24LqMwxslO1NCsv1kHNJ1ZmaD7cECOiuncn4KpM/V1zkUXPEJckeMn9df2UxnM+nfmq
         5S0wmp8PSoM2fP0McqCvhLdJfcJ9skO9ogu3QbLD1Gss8OEjLQGLgLKdzNSaRY0z2ic2
         5ej6xkfiNsARLskrhB3mbWp8PeH+pYkyq+pVMfvgsCqkVgMksgbRoEpToZ3FuMfB0iFf
         JhQv2rmPK866fOgU+3fdpBlokVlJ6F1lePHSYpqhgq+sOMN5Zw0y3C0FWhVj+x8k/bcg
         yoTA==
X-Forwarded-Encrypted: i=1; AKwUvBw3M8fcLgTHFtEpAhm+LvWtdLyQBMkGxwRjJgubKlGcQsrwLlSwmpeIbOpyFtOgXLIC6VpjMEXboaI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPsy9NFFGPX677kAW8AX/kbkI2zRdoBeQOTocs3rwjjUDUmDLh
	RzyYmNd0Iw4zyjKIG7Iu4yAtfy0fEEp8nvzdBpcuz3GDtV2v2lfLC8nYLHDCilMGdw==
X-Gm-Gg: AYBFou3xw4M0xAFIGpj+zGzWUD3EVfUrrEo6Dg449Y0ZebSUAa7Fg46L/EkSBxV4uSD
	q3oHYuIdMn+2XW1hHIuEeq664bjM4HEfGGuglMpraZEJSM0mqZc+IiF6P7IX21CXViBIjpvGTcU
	zZhRp9OXY7c3DpbCf+UqsoC1rqYbogANi6GKE5CQPxtb1eFO87HEOvxEyAUy8AizOHPCTOFpEa7
	RdQVNJ2rwOso/x4IaObU7QS2QMuRERuAqluMawXkUbioZe/CFIbzsObbHM5gDamSyrZKYT1F5pq
	D0b9KyAG3MIkFkD4zzBIk1keItJMYU2mr3fYAiq1bmEfgey5TipJSNxD6Clu2mIr2JgBA++Au44
	2tKUeee8NVzKKFv1kNRAGAbJ/OaCELB85ZwXnIqTRBZiqhMLmr/Y4kTCwRpN/MswUglIK2YZfS2
	XlOXEs/2Sacy1VZA4biv75FzuAI7gy5k73VnRC0ZHZX3WJHFu9Y4vvYEW9+13tOCOREznrdLBVH
	wWfTwKdJigelXg1o1bH+kGIQT7oiCSvvimdKg==
X-Received: by 2002:a05:7301:5f18:b0:33e:d4ae:e10e with SMTP id 5a478bee46e88-35111552a86mr1003826eec.40.1790982441123;
        Fri, 02 Oct 2026 16:07:21 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:b0dc:e72e:e96b:3323])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-351143b577bsm702253eec.15.2026.10.02.16.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 16:07:20 -0700 (PDT)
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
Subject: [PATCH 1/5] PM: runtime: Only queue an idle check for RPM-linked suppliers (part 2)
Date: Fri,  2 Oct 2026 16:03:05 -0700
Message-ID: <20261002160309.1.If69ddc515c2e9fd4338441e87688b9d690d2ef36@changeid>
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

Commit be5755f023e7 ("PM: runtime: Only queue an idle check for
RPM-linked suppliers") was incomplete. There are two other cases where
we perform idle checks on non-DL_FLAG_PM_RUNTIME suppliers -- in
pm_runtime_set_suspended(), and in cases were we failed to resume
suppliers.

Fixes: 5244f5e2d801 ("PM: runtime: Defer suspending suppliers")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
Noticed while touching this function in subsequent work.

 drivers/base/power/runtime.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 655c0b8af095..e70726b499e7 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -343,6 +343,9 @@ static void __rpm_put_suppliers(struct device *dev, bool try_to_suspend)
 
 	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
 				device_links_read_lock_held()) {
+		if (!device_link_test(link, DL_FLAG_PM_RUNTIME))
+			continue;
+
 		pm_runtime_release_supplier(link);
 		if (try_to_suspend)
 			pm_request_idle(link->supplier);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

