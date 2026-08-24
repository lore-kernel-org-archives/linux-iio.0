Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB28E2571A0
	for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 05:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787548236; cv=none; b=RSUNQCGVdAR7SgG5kYMhSVLw/WWkW8tV3Bn88unGC8aWAsCH3GQNdwdkzw4xT0hU3BmmHLbeG+DsxRWoJYiPorwP0EPunrhAPqIEUJz5PBP/hGOumcEbNhYB8IMWn7vgTQXUA5d32JP0yGvmGY0+nez12aoskL3VPfCtZ/Fvf6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787548236; c=relaxed/simple;
	bh=Sl8hsTtzr30BYZs9Th5FE7uJDLO3mbuSpjTIcGSKiiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PSgy6IhyI5TnJ+6ssa3XDbAD0eP9Pgb+X0woRxuyQVzDDO1mpm9hfNj/61Gkv1gTMLs4tG9xhIadh/PLyqwnklZyBCf+X5Ds2PzOoNunh5/ulr7MhSXp+Oa66RDbIK/gVkNqH1YVwDar00es3B6FEugpwSHmnab6hX6G32G51gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mo3S8eww; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mo3S8eww"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso5009139a12.0
        for <linux-iio@vger.kernel.org>; Sun, 23 Aug 2026 22:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787548233; x=1788153033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a2mb2wp2mxRyAYJrylsfWvc15BoZBNUQjhivf2ccdLc=;
        b=Mo3S8eww78cyKU4MnLXwmFKqBG2Cx92J/YfGJAJ62B0vHa5CUUGUflj1s/sxJRFPpP
         wpGKPJvyBwakGFw3PX1p5ZHXZ4g+9uFV5ie0uet6v0vuAHH70LSvMF+9F3wyTmbTBkGO
         5tT2b9Ktfc7QxTEy33eeWRxsRQyHV2KCQmBY0JWnz4uio/lZrN/HfCr+/CbXi6FcHgre
         lk9uiTIPQNn5So8i3PnZDizQISRedSCeFEz0C26f0u5BbWDRQoX+0HNbHL6wD3VXcv6b
         8mtEjngr7Znb0f7XFH4Mw8X0VsjrJlttckdKSyI3HWxPYo7hj9xdDDTpAAGu38xHnS8E
         mm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787548233; x=1788153033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a2mb2wp2mxRyAYJrylsfWvc15BoZBNUQjhivf2ccdLc=;
        b=jsSgqQDKjNuaS7Dheb495oQkqHId4VFFpdx5c5TM+272lcxtQBQ6orTqLkktBSzMyJ
         yNbkSBQGHFe7Y43MAUIjoFVvYIIjo/YalZWxskQJV/emIezr7rvMprQLBVJw8eEDIPfP
         2ZPHX+Yi9/l7NSf7mvHC6urtexFqwFR/C34Uk5vL3GNk6Tx6SZO233cyc6nqlMcJNuCr
         jTfxmgTomIMjip6suomi66aMtVkzrczoSiE31zJKu2n34qj8IneArOHuGF+dTd3rn6jL
         FgWay0LURkq/i/+ySFIYNy8NtDIlESL5lfpx4NA+DMvLSF0A1nRoMXDxBApJpmF0SZSI
         Zp9w==
X-Forwarded-Encrypted: i=1; AHgh+RolGm8cfpJbRRDlLJwmE+MEhbJ4+8Ohm4BHpdIa+WkMj+XBt+WcjydobhEvuOPzZ8HP1DGuZNBFA3E=@vger.kernel.org
X-Gm-Message-State: AFuF++kaBWvbDVGEF0crHJqOTdIVA+bbfeiaKu336zCC9wyZAVnyndqM
	XwLiKnOPS95NZ5Taat+BYocgcxXbRjNUBwuFSbecx9EtOWQYZeenUgGI
X-Gm-Gg: AR+sD13tdTQ64F2JIbmiGXecRbCeNJ/qh9kwLCVarkJeTPBd8HgAjT+USZYCAO5PxsW
	PFkcAcdSSwOpkjkwXedo3PSuEptj5fvwOrBh/5xgqCgFP7+TdUGu9AEOdRsvlLf0e2Q+lbAy5/S
	JLWLPvMBF+ubf/JpreeR9dnBvfmp59m4jPfPVG2Pi95mu7fBfrMTrIeDDbMvCQZDHYRc3Yg0K01
	7BHNJCoU9uaXBhbYU3lvGcmbFfdTurQHBaw6dCr746z0uD1Pmv6ICzM9WAiUddGLll3c7opBOd4
	+JsAnSW3MehmznGS/T6zqOgWvMVAdIu/wUpWCA8/IYRMb3Buk8/8Pk5/m2KeKp4tlgeiBT2Pfhb
	n6bEuIRRjqHP4+e38jN+SCcoGTwlPsDJm6N+3vp35LJr+QjgWYIsBSM3wsMeAkUMP/3AI1K97jg
	pHt1YuO6M83/85ePh7ARSmNw+OZGGM89VWOWTLpTV06mLihP4Z8btKwmpv/uB4jnxZsk1l8ag3N
	w==
X-Received: by 2002:a17:906:f049:b0:c1c:4db0:8314 with SMTP id a640c23a62f3a-c246a60c26cmr2384011666b.13.1787548232725;
        Sun, 23 Aug 2026 22:10:32 -0700 (PDT)
Received: from localhost.localdomain ([196.235.128.6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606bd05sm1008487866b.2.2026.08.23.22.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 22:10:31 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v3] iio: adc: ad4030: fix invalid oversampling_ratio validation
Date: Mon, 24 Aug 2026 06:10:26 +0100
Message-ID: <20260824051026.11049-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ad4030_set_avg_frame_len() computes avg_log2 = ilog2(avg_val) before
validating avg_val. The existing check (avg_val < 0) allows avg_val == 0
to pass through, resulting in ilog2(0) being called with undefined/garbage
behavior.

Reject non-positive values (avg_val <= 0) before computing log2.

This issue was identified with assistance from Claude AI and manually
verified against the code.

Fixes: 949abd1ca5a4 ("iio: adc: ad4030: add averaging support")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes in v3:
   - Dropped the !is_power_of_2() check to preserve standard IIO attribute
   rounding behavior, per feedback from David Lechner and Jonathan Cameron.

Changes since v1:
   - Added note stating the issue was identified with assistance from
   Claude AI and verified manually.
   - Removed initialization of avg_log2 at declaration.

 drivers/iio/adc/ad4030.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 9c5f19321e3b..5a5e69dfb5d4 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -746,14 +746,16 @@ static int ad4030_set_chan_calibbias(struct iio_dev *indio_dev,
 static int ad4030_set_avg_frame_len(struct iio_dev *dev, int avg_val)
 {
 	struct ad4030_state *st = iio_priv(dev);
-	unsigned int avg_log2 = ilog2(avg_val);
+	unsigned int avg_log2;
 	unsigned int last_avg_idx = ARRAY_SIZE(ad4030_average_modes) - 1;
 	int freq_hz;
 	int ret;
 
-	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
+	if (avg_val <= 0 || avg_val > ad4030_average_modes[last_avg_idx])
 		return -EINVAL;
 
+	avg_log2 = ilog2(avg_val);
+
 	if (st->offload_trigger) {
 		/*
 		 * The sample averaging and sampling frequency configurations
-- 
2.43.0

