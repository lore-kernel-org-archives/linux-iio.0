Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623193;
	b=eC+qerK9nPaiwf40pnzloKZk12FNI9TL9BICc+dgzHwiaCDBgQ7q6Vgi2cOPusy/xfq/
	 SmGNnKZO3vynHU/BdaaQCp7POYvWI2xUnC9Gl+Qg8XlqKyAOWIp4esaAqQVnaqRF77oeo
	 MryXFqV4JM3V/w/5Ygg5tbAywLLEwQ5PkrXzQICt9kO/7FUWk9vUXe+OIhvx8v0mS7A2s
	 oM1pIYxAJWibb6bvi5RoZM8/Hn7yusgbYJbkn0CKcUsoCAjy93oE7MROkaLWHYPNgqjLp
	 vT5Jp3VgxAYOQ57wPMRnrgnoJBrR8droT48f4OlOTHtgU0umpJN6yJJ2fkeKNEJVdxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9dBd0LsCLxCDmDC84llNmb0TWCl+Ku3zRuVheUNJrJY=;
	b=kiRY2VYJ+47gqEZAjDFK3DVnB/mXZfHFfN1bViMcxLfMpwDGHZMrLF9JEH+UfdSL0QbK
	 A8fRm6tzNWsltDTYVxXOzeCvaXXc07gWcTmxBdRbzPNvbpEo5FkMq+kishpVN5bCBY5Ik
	 0pDe8LA9GRxgcmb703mNHj9iHvU1i5ufiL0bg8gMhR4gyGPnU5mddA0c5tEWRI/2aoAtq
	 VwJWmIbk+TYmMPxFDO6vHNPKtCJixLkHutwnOEeXkccknUU2VRV3XZzyqdqgxhKE7QWnK
	 m1hgWb9lAVEM9sx6K7lUzppbaWi7bl8jRti+oREBPzhbrXdyE14QviB4ImHmgePqeeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a3oXmX6k;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04176606A31A
	for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 22:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04176606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a3oXmX6k
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3282db206d3so2904954eec.0
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 15:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792623192; x=1793227992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9dBd0LsCLxCDmDC84llNmb0TWCl+Ku3zRuVheUNJrJY=;
        b=a3oXmX6ki1f4RU80cDLqopO3xl0tZFydPl/dho8cigX3Rzlk47duV8ehC8eGRmV8lQ
         8t4a2veqBsfAk5SojxEnUNYBX7PcYxkUDDuclbwtc/OtEOJbHCIk1VeZsZDEAy9u0y/s
         gk40u1jK3981mrnBIK3mPYZ+W0MDAS+P2cWDj7B2Hd6q/8K2VBYrYBXUILzWpvxXHOcc
         Lui9pvIVXyd3IAfLiAQrvdjBuuOe1LcEis3ToJ6HtXQrB0LJ2YECp3yZQZXiZ4RswI+V
         J4Vq7fBPLW8fY7krnMjIlVsM+6uxDIpMcW9+OG2Fz6t0eYEc4aojM0cLQ1n5BIa5Ph1T
         WeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792623192; x=1793227992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9dBd0LsCLxCDmDC84llNmb0TWCl+Ku3zRuVheUNJrJY=;
        b=r7kJoWojUy9MWCU1YfgjgqDFDxVl/ALc/ukxmXa6bmJ8jUb2ue9UhlinMkGyMDQT4d
         JQnjZ+jZvLhGRQ6NhCeA0aeOrPMUJtvHwZh+ym8kZ8Du8vePE7N8bZDPOzdaXltyW1ge
         Fp9qBOdDEWu9K7aI3zW5zAeZ+A+s04TPzQbklgkh0BaMUpcjBuwie/jg7JQbqG/6E20X
         9sceRDW0Vd74SZ8eWKlAuDDXE9mH/74gFt0pqCmdT0Y2ttt5xOy89xTubEBL9LWTm3Qg
         aVFavrdx5rP55Wjh5k65e9l0vPPC1NC+T4cWhmEkgzhqJYUdNwLPcUSYOjwJ4tAbiKQ/
         EUPA==
X-Forwarded-Encrypted: i=1; AKwUvBxnVWdg+quYocoBi8t2eGV1Dm2rXoffSeuOH7mPF8gzsOASbtU9Djqw+rK9juN6SWEOgM9y4+61DXg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKbEx8QZDBWx33FMSHOx/VEFo76bsyXIvo84FT6KoSliAk2gAOb
	spSNCkxRjO5qe7Xn8XU4dpUd7tEPrvoS4sRzaTOsl7UuuhSJbWRHBVXN
X-Gm-Gg: AYBFou3AjT7A+l4ZhqQxIBD5pQ8BSrDfTOnFxRSKeJBx3FXTeQbO2WvSXL/AaFBpyGl
	k9NbJLxTnUq/NqHtkiJ207ZL0kofcYg5kOP8SkyN5MWJAnInZOwCMuch/7jp8hcVEronGhECXcK
	KfKuWjTxOKV1L7M1Mm23wQAmfiwau86zrkAGbh1LIBO0NcBpH3VovSv/QbDSEbzRk9CH8ZEVXt+
	w5BGP09Acn61CPwCSBxHScZ/600ojgPRTjZc/ebH2EnYm1XQqgIWpuFjwOnGmkB7l9za2b7kRHi
	VEtD56Nji6oFS0LyVOcUH+vavkPJQKqBpf8V97Kddyk0BV2Fl/Y6odimXBBn1+RX+Qlyd2ObWxr
	Qoxw3+Gtzqp7XulCuk9SH05AgExPR1bWrL16gS3RiAmJg3YL4TuhFHrwSq7RKJQdiiLE4WeysXP
	dHzvWYAtyl8s1cmrBwdfuwfitp16u9boacCYdiTUcwmCQfCKUso1lVCko2q9s3ifyTOY3PHeMfP
	cGIzPod6elNX7nIcwE0YqN3bDWd+7MA1xzg6EBMFqV+hytO0vR6pvMXyScYEjZH5PbF68Jp/4UQ
	lzD7FDCyM6rHjPiCgEW3wW4GaFxeHTDS2eavaY6zcNSAA5SLwE6mXKr54scdaGkipI/55WbBb+q
	1eya12mbD14tcExSCrcg+iC27hfOATDl3
X-Received: by 2002:a05:7301:6d0b:b0:360:ca2f:ce38 with SMTP id 5a478bee46e88-3674c93bdf3mr5050567eec.12.1792623191663;
        Wed, 21 Oct 2026 15:53:11 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cc8c6dsm11688901eec.12.2026.10.21.15.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 15:53:11 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: core: fix signed integer overflow in
Date: Thu, 22 Oct 2026 04:22:48 +0530
Message-ID: <20261021225306.623361-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
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

__iio_str_to_fixpoint() accumulates the integer part of the parsed number
into an int. Feeding it a string with more digits than an int can hold
overflows that variable, which is undefined behaviour. The same happens
when the parsed value is INT_MIN and the sign is applied afterwards.

The parser is reachable from userspace via the writable IIO channel
attributes, for example the "sampling_frequency" or "in_voltage_scale"
ones, and via the exported iio_str_to_fixpoint() helper used by a
number of IIO drivers. A user writing a long enough string therefore
triggers a signed integer overflow.

Accumulate the integer and the fractional part in a s64 and reject
values that do not fit into an int with -ERANGE. The limit for the
integer part depends on the sign as the sign is applied only after the
whole string has been parsed.

Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/industrialio-core.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index d73f2541375f..40f4375163c3 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1008,7 +1008,8 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
 static int __iio_str_to_fixpoint(const char *str, int fract_mult,
 				 int *integer, int *fract, bool scale_db)
 {
-	int i = 0, f = 0;
+	s64 i = 0, f = 0;
+	s64 limit;
 	bool integer_part = true, negative = false;
 
 	if (fract_mult == 0) {
@@ -1024,12 +1025,21 @@ static int __iio_str_to_fixpoint(const char *str, int fract_mult,
 		str++;
 	}
 
+	/*
+	 * The integer part is accumulated as a magnitude and the sign is only
+	 * applied once the whole string has been parsed. Hence the limit
+	 * depends on the sign.
+	 */
+	limit = negative ? (s64)INT_MAX + 1 : INT_MAX;
+
 	while (*str) {
 		if ('0' <= *str && *str <= '9') {
 			if (integer_part) {
-				i = i * 10 + *str - '0';
+				i = i * 10 + (*str - '0');
+				if (i > limit)
+					return -ERANGE;
 			} else {
-				f += fract_mult * (*str - '0');
+				f += (s64)fract_mult * (*str - '0');
 				fract_mult /= 10;
 			}
 		} else if (*str == '\n') {
@@ -1059,8 +1069,11 @@ static int __iio_str_to_fixpoint(const char *str, int fract_mult,
 			f = -f;
 	}
 
-	*integer = i;
-	*fract = f;
+	if (f < INT_MIN || f > INT_MAX)
+		return -ERANGE;
+
+	*integer = (int)i;
+	*fract = (int)f;
 
 	return 0;
 }

