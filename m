Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0BE2459EA
	for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2026 04:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790136996; cv=none; b=rFTX/qIg6Oub+vb80YTCaSbDmwMQpq8GEpnhi/GKt0b3lGl0UaPcjrafWRv/ASV71pyA9cWBxE3CpizQyq4X9VA4ZA6Aj+40dLVQDcQ3rSfZvoJkYUNfJ8BKiln1VoO11bl7kQGxF2QjC7Tw/nux0iKTda8dWIORsEyQuGUODCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790136996; c=relaxed/simple;
	bh=o9TjtdtobdV+VLOIrdmXJXPe/MKpL/k/ixnkhSd03v0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZHIh687CQ5Yj82MKqLUa3ehLxmMaBO+22xHB5wEKW/hM3E7RbaOghi+oHQu2/tqPPJfCS94p4uxAjiguprKcegzmx/smxaOrJ6Gu6tXG6WLZwyLC0qS2w1r4iaShHmsZUdSWX0DLkJQ+4cWAGGmiqUsr1N3UX46KB8kzBgoMdA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jCBRj5rb; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCBRj5rb"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d02df2bf09so3801615ad.0
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 21:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790136993; x=1790741793; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j5AH0uJIIH7nASAS7DePtuAYEH3M3ABuxwhVoAFGJaU=;
        b=jCBRj5rbTKzjtDVrMAGdF+Pqllbx1OOibfgppoWsGCM4qTCh1FuKbyJ68sEzYScb2P
         xsfoOvPJosXhuFYoAs7pwI9t9dvJiJaz9SHTAownJaSZohcSWRvM7FiMSux1fT+eUQ+y
         0KbHNNaM8s+ArdAEtmQP4/q4AGWkxCdMw9jJF0JQ5lz5XUZQi2BHrYVUmCUeIJzsDAlS
         TK5nBM1tD18wqY+yQozNzednKE6m6aLtBrO7KdwjlL74o06KHr/0x+9sgK6uIDOA1pDS
         Hfgesl79bZGMxDLzLcD/Yxz509pRA7La4PYujf6aY63m3XCjTdDDKTqT/bTUQuWeV0Nu
         c4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790136993; x=1790741793;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j5AH0uJIIH7nASAS7DePtuAYEH3M3ABuxwhVoAFGJaU=;
        b=NrL1dRhmxS2kO/pkhlK070rhgEjMGnaG+M58TKTZv5GP/6fn06b5+f+Dg1EaLhmLve
         s7ILh6W032zhVLdDOjnQ3lw3kzQEkKCcdYDzBf9NzDoWUm6cgnHhI++g4MPO3tcRMFaQ
         D+FBu+zrFFcPC5RVQWlO2ZVJpjWb7TQ8rBa173HLVr1gGfbfv6g3zrq4MMOFqL9QtAcc
         KesxdF0c8VR/X8HZrD8d6fcXQdSJTpXAn7rmykB/lYcD4xGQd8MO7fOhQW7MjSNkYGOE
         DT9BrO6Goa7ti3NJFNy2D7GVrgIicqtMYbTDNoT75pLKnu6l837sA2Rb4PimltV+mcKc
         Gavw==
X-Forwarded-Encrypted: i=1; AKwUvBxBgZ+TL1SotJTvxS6YFgJzyqiloFa7mv6+hdJNdnropa/04mbrV17viaiISN9CdHZJNrumuLA5XDc=@vger.kernel.org
X-Gm-Message-State: AFuF++ngljRC/TlxofHRfXwLxoyyUbAjd9mcZeHTTZ9xpKp3tqSpJGyH
	F0zgBfJO68o6+gQiFYcK+MgzzFGXrvjG/altX5Y3UstB4/m+m/r7gIqlsvtrwsXVFrTfWthh0aM
	x
X-Received: from pltt17.prod.google.com ([2002:a17:902:d151:b0:2df:4d8a:26b7])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d592:b0:2dd:c0ff:e728
 with SMTP id d9443c01a7336-2df69de4665mr11061425ad.58.1790136992984; Tue, 22
 Sep 2026 21:16:32 -0700 (PDT)
Date: Wed, 23 Sep 2026 04:16:30 +0000
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923041630.2553973-1-morbo@google.com>
Subject: [PATCH] iio: gts-helper: add __counted_by_ptr to struct iio_gts
From: Bill Wendling <morbo@google.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, "=?UTF-8?q?Nuno=20S=C3=A1?=" <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"

The compiler attribute __counted_by_ptr can be used by KASAN and UBSAN
to detect out-of-bounds accesses to pointer fields in structs where a
corresponding element count field is available.

In "struct iio_gts", there are multiple pointer fields associated with
an element count. This patch annotates these pointer fields with
"__counted_by_ptr" to improve runtime safety:

- 'hwgain_table': counted by 'num_hwgain'
- 'itime_table': counted by 'num_itime'
- 'per_time_avail_scale_tables': counted by 'num_itime'
- 'avail_all_scales_table': counted by 'num_avail_all_scales'
- 'avail_time_tables': counted by 'num_avail_time_tables'

To ensure that the count is set correctly before any pointer is
accessed or assigned, we update "iio_init_iio_gts()" to set the counts
prior to assigning the pointers.

Cc: codemender-patching+linux@google.com
Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
 drivers/iio/industrialio-gts-helper.c |  4 ++--
 include/linux/iio/iio-gts-helper.h    | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
index 4f52dc373abf..4de6324fd923 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -652,10 +652,10 @@ static int iio_init_iio_gts(int max_scale_int, int max_scale_nano,
 	if (ret)
 		return ret;
 
-	gts->hwgain_table = gain_tbl;
 	gts->num_hwgain = num_gain;
-	gts->itime_table = tim_tbl;
+	gts->hwgain_table = gain_tbl;
 	gts->num_itime = num_times;
+	gts->itime_table = tim_tbl;
 
 	return iio_gts_sanity_check(gts);
 }
diff --git a/include/linux/iio/iio-gts-helper.h b/include/linux/iio/iio-gts-helper.h
index 66f830ab9b49..7e7d3396ff1a 100644
--- a/include/linux/iio/iio-gts-helper.h
+++ b/include/linux/iio/iio-gts-helper.h
@@ -58,14 +58,14 @@ struct iio_itime_sel_mul {
 
 struct iio_gts {
 	u64 max_scale;
-	const struct iio_gain_sel_pair *hwgain_table;
+	const struct iio_gain_sel_pair *hwgain_table __counted_by_ptr(num_hwgain);
 	int num_hwgain;
-	const struct iio_itime_sel_mul *itime_table;
+	const struct iio_itime_sel_mul *itime_table __counted_by_ptr(num_itime);
 	int num_itime;
-	int **per_time_avail_scale_tables;
-	int *avail_all_scales_table;
+	int **per_time_avail_scale_tables __counted_by_ptr(num_itime);
+	int *avail_all_scales_table __counted_by_ptr(num_avail_all_scales);
 	int num_avail_all_scales;
-	int *avail_time_tables;
+	int *avail_time_tables __counted_by_ptr(num_avail_time_tables);
 	int num_avail_time_tables;
 };
 
-- 
2.55.0.1082.g2b9226bbc0-goog

