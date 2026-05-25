Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8A83CDBA9
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 07:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779693353; cv=none; b=MoU8aocmkl3t/11WbN+WEOt6Gn+OxkIxp3EmBcfaT+gq16EGpdz7vU+CPbzDcbYgJdKz1+e1CAaTDAkC10A0WXF9RA4K3q5/7RI08aOONS2eKtpi8aD4YHuYqEALnoggyWNtOBlmd8zKELmw//+Fmvoiq35Y16zmJjqe9/THHv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779693353; c=relaxed/simple;
	bh=YegoUY1WOra81ZJDMWmsFQL7QyD8XZV45AdFQTMRDlw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mqZQLGAolAUjNXFYL10UVrc7vkK9nIpokjFjILXOYMbBF8l2O/oMKNxCZ1AZmsVpbSSH681YLoJ5tuHOMCVOLy2VvcVV9oteFx8oScTwnBGE2J3WNEYUmEF3iB533EvbuFrRl+jbWy76QBNXH1OQIRuNI+feAXUC9/DMswM/J9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ex1VZgbD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex1VZgbD"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891b0786beso62473405e9.1
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 00:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779693349; x=1780298149; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d4IiAvs5dhCMh+Wco8JSSp9GyVxeLnxNjl/psVDXbZs=;
        b=Ex1VZgbDTEpykX8792C59n1z7SZQFvBpT4H+tYeCj4UhRZC/2ML97TrQhp+TSN5TYu
         PklbH6O4NSlkt5ag8+cUvRjkqYySotXsqFXpMj2aIt1xzr+IjUrZA5xay1FATTLQXXhK
         +S+1nGXR/NqOUrJD5aUwIYJivWUZgBWBYWFeZ1CM84xPSpCYODqKRa81oZmwHPuhkAbk
         QKAv9yNERr7WhygBOCJktGbO3JK8lxXSTnPCHbDhcI/uzN1TFnZWDpuoou1NGn3JLUKE
         Amrxz8NaDRH4vcMEtbJA5o3tjgUA5MGLMjalVuajsDpsK747lhxMtbX1nGJx92t1KaOE
         HCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779693349; x=1780298149;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4IiAvs5dhCMh+Wco8JSSp9GyVxeLnxNjl/psVDXbZs=;
        b=KqVbf8yWzgCVnyfYrG1hZRWMKINf7S+nac7QcKuSL1wrvyNNIkPAA9QycJeBihdeKJ
         7QsjsoJxsnIDAq1bx5pRiSFYKKheGJkHsGCcYaYSeQk9hUZb5s/bILjNoQ1iOJ1oc16I
         VOqjMeunQ/mhJCWJDjk1GbSaLz1YTQkCiHVeTslD3Jp40McQF5lWw+EQwhAvmaUSuu16
         UFpHYOtw1i79BwxlrUAYYqZpbb4FlteY4fcDlJD6uWcwoMTB4gOSvXiPpE6dLd5v15o9
         G1BPbrRhPYUs21+ihAUGQdOJJ8oqmkMV8lfVPhJUdFivCyqgIrSYAVFvPwN3mQANqww4
         GxPw==
X-Forwarded-Encrypted: i=1; AFNElJ8RKoCpGM3coTdQ6HSL5UFZL2BCNPmlNQjovotZjigtlXpwBnYcKr2ibK+4weFV/TpjtBYDGk5myC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1a5MyCND1DRzvHfo1PiEcAaHpwwmQhdEuBCPzi047UmJAqaWq
	WBicW5PZBOHaVKuxJnTD775l9pX2+DjlGKRAX6G61MhhxWCW/dhelVoy
X-Gm-Gg: Acq92OGoa+2No4qOp7zj2GQGoMa8OvzyDtZ52ZODCQ4muyi3tO5vFYZIx8uonqk93bK
	GBHZzHJW96KD43fdhBWspeo7URBycC+cmcIgtfZQ3wHm/7tqHdklvgJhNOYiH5JgQ1UVEOypRAW
	kqvQ2+ZVSGSE9Hi/rHEMz2U+0pmRWN1PN+3S7pHeEppO+rkMoTGZwLvTyYh7Uy6DvP6DGKFGPnm
	h7npJUS8q9+HqU+JpIirkIGvOOjmQxi5w7aOdd9nvDZewGbkdpxPIj6pkWr3cOL6EHiOnEBpGwe
	obuqnAAwl+vvnz/hvjEAzUqzqisEpyITNl5bC09DLQHwRAnlC58OolqI8cy1D4qF7gF+H6Ci6rb
	jdFtSAD9yhNJVNbkYkWPYppVvB2UYnn1JUlKxahX3ZAewF5KHXP78Oke6Q21nhK6nhlOq20ltOF
	gGgyOCU8I4wfL13oSYBJtW0J8sKVDRSS9nRQ==
X-Received: by 2002:a05:600c:a106:b0:48a:9562:7a30 with SMTP id 5b1f17b1804b1-490426dcb09mr144718745e9.24.1779693349423;
        Mon, 25 May 2026 00:15:49 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0b82sm243462295e9.9.2026.05.25.00.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 00:15:48 -0700 (PDT)
Date: Mon, 25 May 2026 10:15:46 +0300
From: Dan Carpenter <error27@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: dac: ad3552r-hs: fix uninitialized data ni
 ad3552r_hs_write_data_source()
Message-ID: <ahP3IjYJ87bNc1De@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If the *ppos value is non-zero then the simple_write_to_buffer() function
won't initialized the start of the buf[] buffer.  Non-zero values for
*ppos won't work here generally, so just test for them and return -EINVAL
at the start of the function.

Fixes: b1c5d68ea66e ("iio: dac: ad3552r-hs: add support for internal ramp")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/iio/dac/ad3552r-hs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index a9578afa7015..6bc64f53bce9 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -549,7 +549,7 @@ static ssize_t ad3552r_hs_write_data_source(struct file *f,
 
 	guard(mutex)(&st->lock);
 
-	if (count >= sizeof(buf))
+	if (*ppos != 0 || count >= sizeof(buf))
 		return -ENOSPC;
 
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
-- 
2.53.0

