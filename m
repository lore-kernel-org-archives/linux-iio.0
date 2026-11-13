Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794547545;
	b=F153GXC/3aiSkXQPLHpiPnkjcX3/xFnmisd1VPd1IyUGVLhHze8dyVDBATdvFhXKf3j/
	 IxM9GsmxgQgGF1q3we129IE/TvbiPIYDMTYFxGz835SZ7S2Poe2hHN7iH4nuEavf7WHy5
	 BiI9TBQx8vflH/WNlAvoxIHRaNRVnUGDdvu9+t9WdbBHNzMbObNh3jwkfCpxE45fdjqLL
	 QKmCF1uau9biS0krPv/dHVJ2uo79JM5tgJKHxELEX8AOCk8ifPVA5vEXdQt325NOkrCOt
	 jVdvdwd/MHJprhUv7LOgDabHlYZWmCpirrkKgnSIo7nyNvMVgqOzOsTllUTTcE/LLzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=hc26nAXdEa9s0ljd85iZeQt/CoG3wZSNWTf75pTYhKo=;
	b=hNw60xRIatkgRCO9hyttsqWGqYnPsEp8IBR0jS8LKlqQIStq2eotlaHRDMOmXjCCqeE1
	 h8DZLBZ0xGE3PXNHjHlVsoZ+q6n2l0CKKL4mg3Wst1iDc4IUGH11viq+PrNVzD6+WQgg1
	 jCZmWQWY8doUPKOpErlg0JvZ1EWRQCyvqOzD6WzA5xx15B5SV+YgcOE/DWnLeWWrCTEiM
	 BCOkxulxGNp2ijrtwdrRJdWY5AHxgkbhzhjTZ5ud6jrFfZwGUy2PQQdOizXtnmBZmNUKR
	 0t/DMsrbCd9LfsIhaNkDFtKn3j1AYFyDuSX1mR97lzKjXnbuu/TWGbcTorh0HUvj1jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UGX37Xq1;
	arc=none smtp.remote-ip=209.85.217.42
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38A5606A895
	for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 05:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C38A5606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UGX37Xq1
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7d2dbc0a8d4so140547137.1
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2026 21:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794547544; x=1795152344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hc26nAXdEa9s0ljd85iZeQt/CoG3wZSNWTf75pTYhKo=;
        b=UGX37Xq1B5mND896ZmBiiD31YFttEBfrFng2/axVOm0A99AW1tB2HuU2+66VnwdebZ
         JJUWmInL3Uc9n7/1tFdsRdHT2DwM+sx79sLrlFqBBsWuWolkPlZICq14uIIGGm+mgkpQ
         R9sgILAPPmKhjweQQUCk7TajMrLDwPCkwYbzhzxzNaX0f+1pO0oaWmbniQKHCgX3cnx5
         pPXSTZG3FDw04nwO9VqusZGLDgOT6ASMmWE7NB1YFSGlYeIHW1eeFyATc3kcm5KoXA07
         Ap4/3X68liHTQCsn7g3VD51Fh4u80w+AgUwVfxPCMps1DQFjbRKeM0BI15mismYwyG8/
         Jlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794547544; x=1795152344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hc26nAXdEa9s0ljd85iZeQt/CoG3wZSNWTf75pTYhKo=;
        b=iOt8Z9IF4jLfzxnY/F0snFtPdPaPVycZyyrH88Ev2sAoJgDF5Cx+HKWhX0rhlYuy8i
         1BHALZ6CEfWo9NX4ec7nMnB/u9jOrapTtb9A4QPCbqivBpmSv3nCQCYUp0AlNfmd5Bwa
         fPVAlbfI6ipM/cQldHVHm4Ll6YyiYMhR6VgC45D8+qvb5GgppjCV06cjGO2dVBbTBzVT
         XX/3Iv14M9T338Fd5VDi4sbbXviSqFs4h9smgknFsHLDjM8emGPJwWFfIz2Xho5saffo
         uF0ik+Ae6gkxgfhQrzlIOy88F/iFxBtxF9Emx2J+abckEluOpCTIynQ6rdpPN3n5P3t9
         Qqdw==
X-Gm-Message-State: APuU4Z/WY/0eSYAd9ydcxS35gvKj51ngKmu6hbZ0ssUpYtcA6IBWGLDK
	y0uAcFg40LM9ZtVWRNjEowaip0OdKWsb0UTO9xIG7i+hFm4l0VgTM3JR
X-Gm-Gg: AYBFou00uqUpwEG1c9iTVvzs2qkGsHq/bMwU90Lespl8L0cto7TMXt0oQcLoZ7+6ZGA
	wUp7iisuQHmSGelLoEg1owWMARfK5NgyOLSHYo1Wlq/fsFLidYD/549yA1QiXMsE/i/aFRc7RvW
	j6Fjk09HIMNp1TIpFGoaC5glUjzpqo7fb/QMq8wyAa/guY3XB59PaVW5psUijQvaX21caGH1zsl
	unzaVeXQgrO4EIBBK8nRp2G4eDKvi832LCHkdS7VmnheLmNDd7sKreXusThmZTG6x1cb2ZEOHWh
	MAgh5ck46boiDgnFcWm2ug5y3BosQapwPVDAjumDQQj/AY7SKKSkIAlP+i904WGOH6v6XYPYjNz
	1oT12hRXj76uIYgzHRmkZWSYeUI1v0N8xOt/gODH68sWgC7AGeAaHkPXepTGCDit3En+vRygJ00
	urywx7/aP47oQtK5mFLBo8+DcbYZXtDA97NTcWH0IMe1mEdU/52SuwhdLzDVovs6VXBLKA1MDoP
	rCZCvX6+nbqm+NaZhffW2XZRtd5IOwKoo/FIzZfYYTMr11ctpcWvP8tqb1Q8J9KJ/0QEUMdOSOK
	Jvp3XfdSIPF9zTeUWg==
X-Received: by 2002:a05:6102:84d3:b0:7a7:19aa:f0d8 with SMTP id ada2fe7eead31-7d64db55f53mr255794137.37.1794547543655;
        Thu, 12 Nov 2026 21:25:43 -0800 (PST)
Received: from [192.168.0.8] ([2a09:bac5:565c:aa::11:1e5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c8425d142sm880439241.5.2026.11.12.21.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:25:42 -0800 (PST)
From: =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
Date: Thu, 12 Nov 2026 23:25:33 -0600
Subject: [PATCH 2/2] iio: gts-helper: fix duplicate NOTE section in struct
 iio_itime_sel_mul
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261112-iio-kernel-doc-v1-2-e382fc9a47c2@gmail.com>
References: <20261112-iio-kernel-doc-v1-0-e382fc9a47c2@gmail.com>
In-Reply-To: <20261112-iio-kernel-doc-v1-0-e382fc9a47c2@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794547535; l=1234;
 i=aleszlucero@gmail.com; s=20261104; h=from:subject:message-id;
 bh=REpyrtxy5vZO221Dtg+htmXzpUSwT6gPJO/n9pSAGjE=;
 b=GSO9P+m5JPtXXPWKWzRwPML3VIgPHLZ/x48mpri8vGZ8iGFZIDjVe8WQAqsQJOo7KmiomGElR
 JPKBHs2dHlhAQrg0atZ/mLz4oFXW/+dRaCGKsSZhrFf3OIa2UY0CITt
X-Developer-Key: i=aleszlucero@gmail.com; a=ed25519;
 pk=zRzEBMID7l1FXqr2CjfnlIn++3m3N05FuNYb5zPA3cw=

Replace the repeated 'NOTE:' prefixes in struct iio_itime_sel_mul
kernel-doc comments with plain sentences to avoid the duplicate section
name warning.

Verified with ./scripts/kernel-doc, checkpatch.pl --strict, and a W=1
build of drivers/iio/industrialio-gts-helper.o.

Signed-off-by: Oscar Alejandro Sánchez Lucero <aleszlucero@gmail.com>
---
 include/linux/iio/iio-gts-helper.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/iio/iio-gts-helper.h b/include/linux/iio/iio-gts-helper.h
index 0c4b2e9fbe1e..3f07a46ddff2 100644
--- a/include/linux/iio/iio-gts-helper.h
+++ b/include/linux/iio/iio-gts-helper.h
@@ -47,9 +47,9 @@ struct iio_gain_sel_pair {
  * @time_us:	Integration time in microseconds. Time values must be positive,
  *		negative values are reserved for error handling.
  * @sel:	Selector (usually register value) used to indicate this time
- *		NOTE: Only selectors >= 0 supported.
+ *		Note that only selectors >= 0 are supported.
  * @mul:	Multiplication to the values caused by this time.
- *		NOTE: Only multipliers > 0 supported.
+ *		Note that only multipliers > 0 are supported.
  */
 struct iio_itime_sel_mul {
 	int time_us;

-- 
2.56.0

