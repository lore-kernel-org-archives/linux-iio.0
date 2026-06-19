Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC183C98B7
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884551; cv=none; b=WYNkik6P7brpcMFiXq21RQGzNREhpYMoaCMc6IBPn7kiguR0EqPY2Z/Tu7aWXTvky/gREqoK7OJirbFGOijcf53FbDFllMCRmS6X4qtqDjFFlFc3SQ4UK/HZWq1enqwnCgtvcyjEURXl+96q8NnGxiQWBUmWvtnJBGU5AO9UDfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884551; c=relaxed/simple;
	bh=zTuxP9n0Z4lR5wzI18Se22YKGhVtliH9wswUfnB9Pt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZiIIdOy+COmZnne+6IsdzprFR6YZLUKrfwTfUcw6CafVO08YIfDm57rz5KKuN0bxMXPqdkUbJ5riCNTAGH4nwHaO++72np127Uc71axObZu/INDYAFDkEbcvAgF4yJj/XM1K/BuppUAk1Mm/H0wre8clpxBZou1Ojgsg8CXl2S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=i5FH46dA; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="i5FH46dA"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ef779c1c2so1743252f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 08:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781884540; x=1782489340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E38KgysEUlpO0tvgqlXmMywYoQA4g5F5guU/qtHiKCI=;
        b=i5FH46dArp9sbaT0/RHm2HcQI3OuWzSHqVLGUxx3gzQamGdXH3MVQ77Doolu9jOGl3
         1yntywch4UqUk35MssoCUjMOUt153h53kMbyPiFYT80t1+o35pW/2wr3WXrqbLarKNDp
         /NTZp0s8vn6pCamH5N8p6RDTs0dbfIPNRlpgRzuIlnTz/ZWKljuV4tk4UiFLclUj3c5M
         ER6XCXt/040B0MNWPW7nzhaNgXHpdxFmOC1GAM3gDs7f0rCQbaH1IhCDd9kkUVWVxrHz
         t1Irzk2ALAlULitgmYk869iLG9/vkz6EFFGaK3goL0OR3pD5v7w7hgF8lNeZ16zPcnAK
         6XIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781884540; x=1782489340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E38KgysEUlpO0tvgqlXmMywYoQA4g5F5guU/qtHiKCI=;
        b=rk2S9b1+pnLyz7FaWhDsVygYflQehfN2VcnfaH6270VB7lmnUZwSPMTT96tzLIW1me
         uqRk83F3SFrJlq2NMcctDPRNYEnW9HEjcbSssnGwTodU4kTcMINbvhxXGBrrI/C2F7ul
         NzHFfFmgbaCitfIycMZbd1Hm+JwdYDbODromhXUlYI0P8LHF7el500tWTJN0cHXgkqrI
         H+RqDcxx2HhVYRolr1sPbGzbTRIq/ZGo/W458NmqLoWXmJSMsRUVB3EkVDa13iprpFnB
         alvVUrm+KnOIJikQZvIv8DPaE3cOa5/Wjrig9N52INn0B5OgD/Q1JVHYNwm4BKV4XPaq
         43yQ==
X-Forwarded-Encrypted: i=1; AFNElJ9RZAUzCeR8POctAam58Nz9ozh6ne817KtYLMUT78DjbjPJXt4G1aUlxnwYmgtvRaqWGnX8f+HFuYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA8YRtfxArkmubfyz0VPcfD/L2GQGSMDlc0NQ1TcXBYD33VuoB
	8s4HUXjjD8rspeAOChoOV5C3HYoBTm0l6SodqqTILHwO85vG5zq+XajJrl5O/NaPf5k=
X-Gm-Gg: AfdE7clFz56O9rWzyOyvVfz2P1pT0YBQvbsaVB3pu03K4Bi7S9+V1TJQ6KTPicEATxV
	a6F4hvJ3uzrhY8NopkCthKSjV/DkOyKEL9RXtRwDPH7cFl2x6aOAlldGH6GvH+RG9tIEu7XxSig
	t8XJmHUEnp7vrOMZGE+wtj67p4eFJIY5D0hme0MSEZxC7dHVcdYLWqA5nublSkKXjPXvdx7UJYP
	VU7wUtjSSvlXLmqUTN/d87RKtJC/LCVhn2MgR4PjrAFkId7Z2XfkuObG+fOWYjLLkfNuNtNhxrz
	qrDVSOzBwCEb+zddh5WvTCMWWEUCB3LhNUt4uouHAIfZcCSTWSQLZSqVSF6FD4LT6DwFGS7NOXX
	l8zAcg3bMoGWuYFXcPeXgmiwhWUJECfwtahYFjvYFBB22XnlpBEj0SMR1JttEsYq75AAIj5xeac
	qFQHZ+TE0efdph4Sfhlgjnhc1AGnZc//IsVG5mxjKc4axOWNqLYhFKN0+2r2/oqaQPw6RDq0Dhg
	v4=
X-Received: by 2002:a5d:6206:0:b0:460:71e6:e11 with SMTP id ffacd0b85a97d-46508bef711mr6121458f8f.24.1781884540258;
        Fri, 19 Jun 2026 08:55:40 -0700 (PDT)
Received: from localhost (p200300f65f47db04359fc0e70763236f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:359f:c0e7:763:236f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-466667881b4sm2481f8f.24.2026.06.19.08.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 08:55:39 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 13/13] staging: iio: Initialize spi_device_id arrays using member names
Date: Fri, 19 Jun 2026 17:54:41 +0200
Message-ID:  <cac7a68e6a6adb1b58207640ab045e59eec86f53.1781883685.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
References: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2158; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=zTuxP9n0Z4lR5wzI18Se22YKGhVtliH9wswUfnB9Pt8=; b=owGbwMvMwMXY3/A7olbonx/jabUkhizTtLAEzs2nHzUIupk020Y9+ZllefxCX+HVwJ1JMkvDV Ra3uxd0MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjCROh0Ohum/kjeyidQw+ssa Mxhd153N2d3mxHL/bMSabyenWOlN+9Ey8eTTL0y6jC1l75bYvA5bl7S19Em5yZEjVUeXbxZeWRq 0O0ch7mpExD7xh/0yJ1P+lx05Gq5w0OnDtbYO/ht+yRH3jzXPMbvzYJ3Vg1OBYR1/mE+2S6etac 0X2ieU8TlU+vr0es0S71lTnbIXrPwgr8L97JRKuU6xzeKza5472vGYXZDgCCx8uEayTMWgR7/p9 WWNr+39ytu5dhnOPbv1bEhbScQ6g/wvc1yCTwlMzIi51fmF4VVhkWjo6cY7zHGu9/ITfoZ4cDFW C9jVT3z0INJvS0Fe3FsD9odtv7VYjX8sOTmt2+dSwbI8AA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

The mentioned robustness is relevant for a planned change to struct
spi_device_id that replaces .driver_data by an anonymous union.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/staging/iio/adc/ad7816.c       | 6 +++---
 drivers/staging/iio/frequency/ad9834.c | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 0e32a2295990..30644d2d7c54 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -426,9 +426,9 @@ static const struct of_device_id ad7816_of_match[] = {
 MODULE_DEVICE_TABLE(of, ad7816_of_match);
 
 static const struct spi_device_id ad7816_id[] = {
-	{ "ad7816", ID_AD7816 },
-	{ "ad7817", ID_AD7817 },
-	{ "ad7818", ID_AD7818 },
+	{ .name = "ad7816", .driver_data = ID_AD7816 },
+	{ .name = "ad7817", .driver_data = ID_AD7817 },
+	{ .name = "ad7818", .driver_data = ID_AD7818 },
 	{ }
 };
 
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 4359b358e0e5..f95c5365cd03 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -465,10 +465,10 @@ static int ad9834_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad9834_id[] = {
-	{"ad9833", ID_AD9833},
-	{"ad9834", ID_AD9834},
-	{"ad9837", ID_AD9837},
-	{"ad9838", ID_AD9838},
+	{ .name = "ad9833", .driver_data = ID_AD9833 },
+	{ .name = "ad9834", .driver_data = ID_AD9834 },
+	{ .name = "ad9837", .driver_data = ID_AD9837 },
+	{ .name = "ad9838", .driver_data = ID_AD9838 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad9834_id);
-- 
2.47.3

