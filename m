Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188AE365A17
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 19:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775849866; cv=none; b=Ya9Fl4WdpAQKEb0vDB9Ssh3ftNORPLfPkwLD4fv6z6F18Ht0ZGpFckVzlFcHr+z5v/iBP5kzvzXTjFav2oLWT/CDACedDNi03WvA9cAP3O/dZngozpqztqY6GziZwYwAyUrMSl3E6LQRJlHhP30kJWpZJRc1BO/NcDI1Yed3Okw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775849866; c=relaxed/simple;
	bh=S3lgvEBcAj1n1zYoDPurzykZ0cedeVsf9vodlAjga8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+tjsNzzH0+LaXnGKf4qzSrUNu5xBinxc2EloBf7bbVeAiC1B/3LVlzzb56IqOVxJaM+ePTrzexfAWeZKT2hFQRcMTD57mbp0xVPmZe3awd4TaOXMptgVmQyQ4iLUHrXV2GuEPyxsYtYPcZHk9PXZNyRwFHX11YCV2ofgsvOHWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReMIIQyy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReMIIQyy"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48374014a77so33647215e9.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 12:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775849863; x=1776454663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bC+NTB9QrnUqEiewv4maV3b9X6T0/r14MS4an8UAFs4=;
        b=ReMIIQyyBbrcc2gpvgKGS0V+9UrcBN8sJq8zpY4Fg+RMxZeMvFjz9oSExR0XPtPwKP
         KNGk0fqqEqUSGsqy7cbfhUVuhQR/Lee93phjnTsGJp8Go9dHO0kieAlkMPgMLIj0Q1fv
         THymiGNhaKcej7zpFADIh29hnbY+wuXVkuYg65XaPaiFIN6usAQjvU5h/tV7DNTyjyf3
         WnleytwNA2Re2dT2xSsKt+OC36/QYxCb3+lhyn17dosfMX7epsgha6/J4fNpySHjXPFT
         vWc5MffD+pmUxXufAAlaaHazvshkKjZIIb7g2PGUIH2txrRpUZHKe2AgqeVER9EjTKqB
         3cbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775849863; x=1776454663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bC+NTB9QrnUqEiewv4maV3b9X6T0/r14MS4an8UAFs4=;
        b=RTPw6/i01GZJuWy5PBoAVx97tx3EPxk4UhOYoe+bdzuFBJR2t4tdfSAdCijjBEZGYv
         syjBwjG/NTFFvDEJ1fFLkJ0Z1M7OIT0BrIr4IssylIl6jsdAnV6qfvs/4Gw52NzDngDq
         aTDeV1JFpm6cU6kZqs//pLLeNNjLp6fw2bbX1Gv0XzK9lz1E9kxPaeCTb3//0i2XXhPw
         rDZ/4QNtJtcNiYmiy9Z9WoetrnUyEa0yO8hDY1f91AfHBxRmE1oPQkoHstpDK14M1ppy
         3b2UsKFDYFEv1SYAyhXfaKqWqa2PFPrylYQDJgWT6DvqAxiRr0CKK+PTs50k35JiJQaV
         icwA==
X-Forwarded-Encrypted: i=1; AJvYcCUBDz2qHkYUDb6NaG8auxzN3ODazwDs+eDwfFcRhNSUTozdVDm5jyICq2t86TnmqVQDtaxzl0WYeVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpx2yiUUfVfArFSHgknDvpzEUGI927cRHXJSIW6XEjcTFfxPPz
	l+5inOsJu5rJPt1R9iDFOWLTTQO90EkdT2Qart1mFsPa8CCVdSTdOQT5
X-Gm-Gg: AeBDiesFqerIFTGWPWyrB7SwfXjRg6f0+K5/DbkySeBNq338RPCfXLBwSuAF+ZiG+DL
	XeaDCawx+LENYT/rht6Kn++4r0b9Fi8WYDrOLoJO/jgzlcyIJDWmj44LYxtuDeoyuRrx38ZwZ19
	IQjQVp2/7gP/wyo5qLnK2/LrdGzT4F4rmIKWgKnhGFP5s4kZERkRdMUaUresC6edI6WW+mL6z6x
	UfEExL9zFe3kvelswhnyuUXIckPgAyvQTm4puZFThUS2VnThT9uyM5PdmdJXtxF/CnBXTzdv+g6
	VRcrYTqVpnXo4hmIydW3aQrgfhjqzIIwSEoL/JGkTjU9vP8h9VxCLden/q4v1Oc5M/inJZgmq9P
	/bmhcxbcIiyXYCBVeYCj7+Pjfx7X1YkvXySQZDqYAFdFGNrQQX88BgmbZEZCYSbxHRYQ33Lg5Ru
	+XDZZjq0lC5fYpvpt2rlrsMPAcoYeDuApMBWm7O9Eh9GQqFin+6A4NU0rgBHlgKXFBehz+Uepnd
	/W1sTMmHcaYQIA/UbajVFY=
X-Received: by 2002:a05:6000:40de:b0:43c:ef4f:79dc with SMTP id ffacd0b85a97d-43d6427b8e2mr6800271f8f.8.1775849863493;
        Fri, 10 Apr 2026 12:37:43 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50044sm9690425f8f.25.2026.04.10.12.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 12:37:42 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH 1/7] iio: dac: ad3552r: Use devm_mutex_init()
Date: Fri, 10 Apr 2026 20:37:31 +0100
Message-ID: <20260410193737.35905-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410193737.35905-1-devnexen@gmail.com>
References: <20260410193737.35905-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_mutex_init() which is helpful with CONFIG_DEBUG_MUTEXES.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/iio/dac/ad3552r.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index 93c33bc3e1be..a2713b0c176e 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -629,7 +629,9 @@ static int ad3552r_probe(struct spi_device *spi)
 	if (!dac->model_data)
 		return -EINVAL;
 
-	mutex_init(&dac->lock);
+	err = devm_mutex_init(&spi->dev, &dac->lock);
+	if (err)
+		return err;
 
 	err = ad3552r_init(dac);
 	if (err)
-- 
2.53.0

