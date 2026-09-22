Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D51440641
	for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 22:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790115004; cv=none; b=V7pqo7oUX+E/VKuDOeDCDRiUZIj1RaF2i3Q9dk9WHMgmn+Gldr3Fp24nv9BsoGNJX0zGsZXOeNyL+ezkL1asL0YOml9KpxKlNXOX+ut8OpAPN+SHfWk7naRbQj7JBOfvScoCBmZrX7mPj4z4i1SW8X/FqdGHt9p5yJMcKUwpfKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790115004; c=relaxed/simple;
	bh=ez6IjVz1RI/L1fCWYZYoXXXQ0XI9Qbd928iUK8xMI1Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IUKaSNZU2NWQIup0Lk97fIi68UpGSBbATLTY/ei4bEvLw+7oqFJX3h6KC5KwixRes9ojgLs6TOXst8Pd6Wk9vMl+6z+TzERErsOtssOVdRGSjPepvoBpJqtO1jMXLnMtVisl+6Oc4ze9dHaBQDB8qV+ZzzJHliNw9daaH+EzuuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L13afg3S; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L13afg3S"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so243632a91.3
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 15:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790114994; x=1790719794; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KStyCSuaz3JtzFB2fu+E5KRM99Ww/CsJLkB3+qyDWQQ=;
        b=L13afg3SJ8OAsLJU4yUbZ2cLRTNRhLsm4SF7IAlw5qEvtKqwJiL8Tx5MengxIA/wTK
         GjyqlaZ6bpVkTnTdoGVTLKsenaazIt+Y746Pk+Id0kEfYlz+LTPzVjgMyajLusIgc9uZ
         r6LB30kexihn4vyRir/7JL4RH2X8sA0OocD6cDYgy0GYYuzXDRvbEiacTYKfn87iXkzq
         nLouAVmJq/zdiAo95Njw41J2szM2kucQu23BhSIgbZ+M/BNaVIGc2SvSujgO4Ber+MM0
         tRZWjMNmmTHy2NvUMfo3q5GEGdydUCbGIAyFxu6ojdu3/oy8ZGtbP8O++SsWbCIIrWNG
         pC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790114994; x=1790719794;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KStyCSuaz3JtzFB2fu+E5KRM99Ww/CsJLkB3+qyDWQQ=;
        b=H4pN8wGaockVIsw7dbau3I1z+tB5GknmG9XsWYG8rwYrX0/SFU+uyfq0bZV+p8hbeJ
         lklzffKYNq5U3sW2p5qMknZweHyv6O35i8ewPhYfXlVnakvPQ5Eqyrru4BJcr+X7YGaL
         yZzF006c+VNun5YFk71UdK66pMw//GFasfC0yB3e1i85CiP4c3E5CuNnRep+SwufNk8y
         gDxlHZIlfc0d29fFrSABiCk39UgsUjZCXn5t72I2B8ndPGslW7jfHpN5FRPqFb24qPAM
         zy1rYQ3wikUpu3olLUrCooW7JIFsu7h1P6/1Mi8VCTufACcLsP+8KR5lpWU/uvS/dHrO
         JPVw==
X-Forwarded-Encrypted: i=1; AKwUvBxObpKC1eUWm5nkh26HXqwfhVP5tlKjs7COf/SwZj2lfbe0ACsz+sY4wrUwOATpdSIXq8CF5AxFpx4=@vger.kernel.org
X-Gm-Message-State: AFuF++mf4NT/t0IFqdlxyNv2EvbDNcOeaOh0NA4UjBCWBrL1QvuSJgWV
	78hs1e8D4uBpcLGqIkOyjVwz3KY215yonV2HU356nSgy7J6q81rBFxM1DZms73ezFbktdNbRWKI
	Q
X-Received: from pgbcn9.prod.google.com ([2002:a05:6a02:a89:b0:cbe:e432:1cc2])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d8e:b0:38e:fea2:df53
 with SMTP id 98e67ed59e1d1-3a07e5adc58mr635171a91.4.1790114994291; Tue, 22
 Sep 2026 15:09:54 -0700 (PDT)
Date: Tue, 22 Sep 2026 22:09:50 +0000
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922220950.2267270-1-morbo@google.com>
Subject: [PATCH] iio: adc: qcom-adc5-gen3: Annotate struct adc5_device_data
 with __counted_by_ptr
From: Bill Wendling <morbo@google.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, "=?UTF-8?q?Nuno=20S=C3=A1?=" <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"

Under compiler-supported bounds checking (via KASAN or UBSAN), pointer
fields inside structures can be annotated with the '__counted_by_ptr'
attribute to specify which field in the same structure holds the element
count. This enables the compiler to perform runtime bounds checking on
the pointer.

Annotate the "base" pointer field in "struct adc5_device_data" with the
"__counted_by_ptr" attribute pointing to "num_sdams". The number of
SDAMs is determined from the device property and assigned to "num_sdams"
which is then used to initialize "base" via "devm_kcalloc".

By ensuring "num_sdams" is set to the correct element count prior to
the "base" pointer allocation, and since the size of "base" is never
reallocated or changed, this annotation is safe and will not cause any
false-positive runtime bounds check panics or KASAN issues.

Cc: codemender-patching+linux@google.com
Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
 include/linux/iio/adc/qcom-adc5-gen3-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/adc/qcom-adc5-gen3-common.h b/include/linux/iio/adc/qcom-adc5-gen3-common.h
index 39cbfcbdb101..b3e2c2f50e8f 100644
--- a/include/linux/iio/adc/qcom-adc5-gen3-common.h
+++ b/include/linux/iio/adc/qcom-adc5-gen3-common.h
@@ -137,7 +137,7 @@ struct adc5_sdam_data {
  */
 struct adc5_device_data {
 	struct regmap *regmap;
-	struct adc5_sdam_data *base;
+	struct adc5_sdam_data *base __counted_by_ptr(num_sdams);
 	int num_sdams;
 };
 
-- 
2.55.0.1082.g2b9226bbc0-goog

