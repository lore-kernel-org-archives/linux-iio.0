Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B4C41D204
	for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2026 19:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191495; cv=none; b=d0dPvwZW7ugtc5tiGJxwtorBkq6jaIa7QKQcHsnN+wyqMBqwepWCHG4NZi6dviOdglcRQAdRO5JWavAUGlq++6SS+dKVrlZRwTcWyJpx722Mor2ynaiSMppx8pSFufZ00uk5ifvTq0OxV7NmFMb4IeunLehCmfk2MI42UWMoaLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191495; c=relaxed/simple;
	bh=9c9OuAocaCCgtCpHxNZG42iIBMJ13yG9pQl/dWI+rDk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gWqDqknbxrz1xVJCFLN7BLN/Q53vBoiJv2ayXPYkTHBi7t8sb6eKqSv7nYZ6pekGSQ/cjEOI3VA/eFH6rTX0HsEkBF9samDpzXxe9to+D9RGvtVf3MYyp4/fgyuPh8PI0nRUm6K736z9s4NKFOSFr6HtMgtEcCxcdterX7aWTIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qRMfJTg2; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qRMfJTg2"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-87d9541c117so65040b3a.0
        for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2026 12:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790191493; x=1790796293; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+WX8GeFlTKInVKU4q2TclqJUuJDXCWold0qvMqcWSxY=;
        b=qRMfJTg23fyUgmU7jxY7+RjTO4gWojpWqgx03hsLc8qf/Ia2nz1jyOG9AYm/HKAscN
         F8BbUx0G+xNHA13Wk/qLZ6j3t31kCMw+yBQ1BhME7Uds56HV3OXwe01tqFMKye2c7G0D
         +8g3dcRnlwdDg5OY3L+T6BLRs5AwHfHErIMfU8tDl8ghXN4NWHCoSkprZ+MovvxwKHuC
         v+64e5lEvcgtL/rd2f04tC9tY5NqdEwEzBcPTb+YDFvYeeZCUlEVdjWi4g6Rq/5dirK7
         VRjpjWYDMNAzRhYvkX9Aimu4fCViJh13JV2r8I/uQR4qkfuCzMjpNcRSqdLAqy+wlgKH
         jckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790191493; x=1790796293;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+WX8GeFlTKInVKU4q2TclqJUuJDXCWold0qvMqcWSxY=;
        b=0CifkmU2JhsoYUIpapQfPRFGvdTAQk2HPT+0EpuryMkDcl2dIJFwKsDHYOQ+VUDhYb
         y9GLE2vyPg3W7OfAoeWQEXw5avfMkBPBr0twJWbP4Mb6SXxOCrf3ivYAbulUTI1cu3BV
         HA5AYvNHQrHOS3w9nK1TXMF2gUgmIuk49GB59SeWZG8QbSoaRW9xaRvDBMaNeExGnXdo
         s25dm/o1T+MZzo2+z4ZMeSir8yf9FecvyI7FkWnjABgC8uNU2wFSYLq53IyROj+SahIO
         Pp8dRsWHdS2036+NuyfKMobarzKQYV2NMahrXipLHATQT1soQRFCyTgrpQ1pPcZdNecz
         14pQ==
X-Forwarded-Encrypted: i=1; AKwUvBybG0yee6vyMLUsgEKIsPucbqdejUOoicDAn7MU726p5OU7bMyEUsmxjARQE8CkuY6Od1r/FaLxJq4=@vger.kernel.org
X-Gm-Message-State: AFuF++kyOMHLq1uKsYAb1RzmE5mWl2Wv3U9ox6gqbmB1ZvEVTBf2aQVB
	gWJn+qfNw+f9jBRYa+GRGBnPYQtbN658HBm8Nh9ZKuSuIeapP5Ey6ZaPgl8EURiV14blKGrzgPW
	B
X-Received: from pfbdl8.prod.google.com ([2002:a05:6a00:4908:b0:87d:d8c6:60e8])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ab03:b0:869:6440:74ba
 with SMTP id d2e1a72fcca58-87e9e3936f5mr83242b3a.18.1790191493219; Wed, 23
 Sep 2026 12:24:53 -0700 (PDT)
Date: Wed, 23 Sep 2026 19:24:50 +0000
In-Reply-To: <20260923041630.2553973-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923041630.2553973-1-morbo@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923192450.3008671-1-morbo@google.com>
Subject: [PATCH v2] iio: gts-helper: add __counted_by_ptr to struct iio_gts
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
Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
v2: Remove reordering of assignments. It's not necessary as an assignment of
    the pointer isn't an access that's checked by KASAN.
---
 include/linux/iio/iio-gts-helper.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

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
2.56.0.rc1.310.g51773c2048-goog

