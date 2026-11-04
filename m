Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814989;
	b=ZD/1HMQnt82OnSjvDToYiDGnd+h+Hki5i2Y9aFPXQtxuNWzXMYFfRdQ+ihw3MCAtz9gz
	 MO6VH00Qcnn7FvI5HM4qZoCauF7SigmHnVuK9p2ekCAgxu+9/JksU8NVkatKYzgm5SJb0
	 xWpiB9p0g+yNAKxr7OfAkaNdGpsJjFGTdJPzc4Kr1CNmCzTnpW3Hf02Q+8HeVKMLCT17e
	 lHQ/m8gAxjK62V5z5nqrJzI2IOxQA1v83cWitGiv/irr6FcsjsnUw7XTIXMGujvP+kLy/
	 PnkM7xx7nGcOKnLXNZtOO1h1rfQUX+3MyGudwYpzAiY+NtLzAQXcGbG0LPiEHqKlnrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rzXpUJyGcK8Q9EiSJqd8qoWJyxkZrBy9n/iPsMdJd00=;
	b=ziS83guRiWzypOnWgaQ51LtWoILSLpwa80nQlp/wy2zCXZrDk/SfSftAXZ+wjolSrBBh
	 SyugvdpzYsc4mZlfgsE03GPb/VGH1wvNQrF3tFkG4wZtnjX9HWuGc/nTUjdIRZ5aEWFBk
	 uLRemWfqotd3cLqDT6OKbjSlJgeEInsOFIAW2+NAK0XUW1ubAmMAKjs0Xm1yQF5w+7W9b
	 t9UEpPLoxNMT4qLLy0pvIizDb9soeGO9X7LBj6THp9irTiB5FJniKpoaVTaxyMyBfWHvv
	 ZR7ejG/I4o5cTXesrW0IjIvbRFKvjWXk5PoHTK9OgNgxsdLkOzlnHcpR61t6huienrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vjGZDyA3;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9751A606D828
	for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2026 17:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9751A606D828
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vjGZDyA3
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-14fc585291cso985978c88.1
        for <linux-iio@vger.kernel.org>; Wed, 04 Nov 2026 09:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793814983; x=1794419783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rzXpUJyGcK8Q9EiSJqd8qoWJyxkZrBy9n/iPsMdJd00=;
        b=vjGZDyA3DUG6/AdGvuNo8PVYADmy06ub0XzuQlVvcB9QPSklGlTmlfIJlI8CXKaxuH
         Nxf+wfW5TN93qvFbCGbGWB1mhJWg3sSKVAZxWUDip82m32IgFFFvY9zJerG9Ah4GFKz8
         jSpHp/q3ap3wYdLbs9B7Stp4ZHGtXD+XPqQgM2Zj2Zm2o3Mr0widotN7c2x4xVFs/F/z
         0JnvyA6zrUBjrNQG9RKsEhfrvpSZVkcFRyD5ZosyYdBup4cF+FuxL5Ux0hAT2RVtbOue
         oAWIwkdgvSujlQ0ArLmQYemkukbBo9wkpqsMPcb4+l6RKHOvKgdkmXwdc9b4CQqUoD86
         ApuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793814983; x=1794419783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rzXpUJyGcK8Q9EiSJqd8qoWJyxkZrBy9n/iPsMdJd00=;
        b=12XnvaSEdISth3C5+KZsHf0sXU3H4UW4ypwDFmwcJBJ5Ot/tP4o0YcubcBVPT4+uFQ
         wygWNGoiNwiQAvnj3bHBkicVocrJHQY2pAGsgSjUJ6ZEBGLqg7FZvvidUrBmh+CIK4zT
         1lf30FauK+SvTLO0RyYeITOKjrzCTYuPB8nYsGQHVCVxmPJjkyxqX0Saxya6yP/a1vRs
         6wsgTSEhDHoOlT3ETvAHcdNl2YutbKhzP07WWqYSdkk/t0cx8oFLpmqT1HUwDslbJF7d
         fzKURfR/9g4ytPVOYkGqAFwjLB7ZDMsBBGq1eGghE6y7DLf2TJp3KmcPlZgQA/SGG4+w
         QXWQ==
X-Forwarded-Encrypted: i=1; AKwUvBzIW8ZvD/0EsE6pbIA5WJEKnC1mxxKlI6hp/5DbPZ+hw9KEersxnM0bbumKs2pUwXqFMB0jrWK0pmY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9OAeQJoGni0WaqTloavbjWL958LPSefdBU10X0Zw5+/x7NCS8F
	0XeABNJ3u6X3SvABvCrV3xm5lGevR7Pr16DVlWLBeoh6pnvUNUIKmz2g
X-Gm-Gg: AYBFou2LoO7YTxhV8JlcXEKeNlhVfUPeW5kBAHI3NoVbfXvuOu7LSv4lbxpAlRTz6OX
	4GxsUlgV1bEnaz6XQgleofez1leSSLYc1W7vzjRy5jKwk6qEvzAtyXqyDOB9w3lhd9vdKIxU3iP
	hzpQu4iWDXKKoDe6eacvIL+7gLHTdSkXlxDBm/75T9SOE97nSSY63hm+iee1Ocdufk5wPk4FYKA
	6GcP7sfgP876cnzKCpRTd4iXtpGEeZtmY34++Akf0LIzmkijpACPdSYVbO7eqHamZPzpx4SKUdE
	j/hgTCKde8xAQdCYtYzZcjjA4/hQJrV8ScB/ovgZdccaN6iD3VI9l5umVCMJotvYZYCRWX4fsMu
	mM7Oh9kL2PdyUiemuFZ1oop7xjntaNmleSj6XuwSLRyikuSJlzSEkWwsYX2D2AOPXUPJ3lWm8OM
	23kTZ4uOj00+EdbVbp1+Zd3aeNHFITPUlNJFiwNy8L1zEoArDVd9ezyG7ukGTfnDMnsTzTOO0GR
	qxY95tqOiiMryAB/i3SM296Exr4gYFbU1aXQCNk/N5Pu+i9G+kFTb9aHtxJgQFvhyN4MtfvIRJF
	dv8iUIqiDqqZK8sXAkk742Wn1ZNIIq2U2hUqzmPexYctMbZVWNyHWhXhNRsCvKYJsJFex2RwjpH
	uSwwiiGC8df3AURWTgd1iyCj8diUdsj/P5xLMdLEUts4yE5J6DjBo2/QMyvG+cFKLyb3EJvyBCZ
	Pq5sXuXXfz7zPbHDu7oddBmHUCd4nsfO4tdCcUigwMgw==
X-Received: by 2002:a05:7022:92b:b0:144:fb42:52 with SMTP id a92af1059eb24-1ac5de4e892mr29959665c88.28.1793814982418;
        Wed, 04 Nov 2026 09:56:22 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.212])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245ac2f44sm10135773c88.0.2026.11.04.09.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:56:16 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH] iio: proximity: sx9360: use an int array for the sampling frequency range
Date: Wed,  4 Nov 2026 23:26:04 +0530
Message-ID: <20261104175608.205872-1-kapoorarnav43@gmail.com>
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

sx9360_samp_freq_interval[] is an array of struct { int val; int val2; }
that read_avail() hands to the IIO core by casting it to int *. That
relies on the struct having no padding. Declare it as an array of
int[2], like other IIO drivers do for their available ranges, so the
layout is plain and the cast no longer drops const.

No functional change.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
This is the int array conversion Andy suggested while reviewing the
sampling frequency fix. It goes on top of that fix, commit d252425c1533
("iio: proximity: sx9360: fix sampling frequency write and available
range") in fixes-togreg, so it can wait until that reaches togreg.

Compile-tested only (W=1); I don't have SX9360 hardware.

 drivers/iio/proximity/sx9360.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 2a9b37df8f62..def69a060c0b 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -181,10 +181,7 @@ static const struct iio_chan_spec sx9360_channels[] = {
  * The interval is not linear, but given there is 2047 possible value,
  * Returns the fake increment of (Max-Min)/2047
  */
-static const struct {
-	int val;
-	int val2;
-} sx9360_samp_freq_interval[] = {
+static const int sx9360_samp_freq_interval[][2] = {
 	{ 0, 238535 },  /* 4MHz / (8192 * 2047) */
 	{ 0, 238419 },
 	{ 488, 281250 },  /* 4MHz / 8192 */
@@ -376,7 +373,7 @@ static int sx9360_read_avail(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*type = IIO_VAL_INT_PLUS_MICRO;
 		*length = ARRAY_SIZE(sx9360_samp_freq_interval) * 2;
-		*vals = (int *)sx9360_samp_freq_interval;
+		*vals = (const int *)sx9360_samp_freq_interval;
 		return IIO_AVAIL_RANGE;
 	default:
 		return -EINVAL;

base-commit: 340d44bdf9db0f095f99845b5ad8628781d79b6f
-- 
2.53.0

