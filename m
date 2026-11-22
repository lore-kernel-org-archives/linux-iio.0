Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795333631;
	b=HBazwk2ulBGeJGhX5m7g1aH+Y/6aNTbailUmBYE7jWtaqFBYboktbwaNu/PCCLXV3Ets
	 1YlMTSlbaV8LetZxxQg2RdWbL9pZzzOZ31FJ3ntMLs5aase5w0ddyX+OXMYkqQqvhqP/s
	 1QOHPR6LXiqgWu3JuQXFm02Bz4NmdkHEzBvwT1ZlGy9ZjtXADTyN6IunTyD7KByuSnxFl
	 vkV5OhnIuwiIXdbyDOV6XX6VhQHotuhQZQEvDmP/aL1GG7IQ4r/3rWeCtoQE7/OzYZPe8
	 f/RUf90Jm6JYTRYo46J9vCYhGqyUlcDxt2TioZIPQG507daDzJM6KHaKvSpIxOLWhRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795333631;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=H1Qd9Fv/BWffK66RMxaaCwY0cb70dS2E1+H4i8vWI9o=;
	b=FtLDcEVdGiJNRYOBQqmvPqzv/Cw/jQePtkfKo97kOAlUFnoNs3GHlYrZG3IWgH+3Sdad
	 vNrNlkQeTV6NxTRBnRty+33owq/JP9qDkZCMpbONq5/UF4TcdQtBv73ZyC15Bs6cv+/oo
	 w//d2jPhur61h0D4nrEdPDxYdlSqTEq2yppEBUTmVpuOVOA6knx/+JSkrBpk3gM/7HN2e
	 XpT3Ei1okUUGVMEdDfE5ncT/VonvfzwidJ0KJRjcYzhKraU8uXJQRS+wy2KifCeRj+cyr
	 s1TnDzHX+HlpPdKKGFV8uU9jeh7G3nyWugayB/hxcFfc0oXzWE1fQwohkixJra2Yjdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nnxGHbR8;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E209D606A32C
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 07:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E209D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nnxGHbR8
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3282db206d3so6850972eec.0
        for <linux-iio@vger.kernel.org>; Sat, 21 Nov 2026 23:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795333630; x=1795938430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H1Qd9Fv/BWffK66RMxaaCwY0cb70dS2E1+H4i8vWI9o=;
        b=nnxGHbR8/m0N0FCfBEOdn3JIClOJq/NAFkFIVvMjfprljv3AYfc3R84tiZPqMiIubb
         62f7g/9E40W2uvx+JwwVETxaAuC02I/dCEvFXc4qkhNpVKNRMpuZ073jBD7yf/ebIoLH
         4wmlrSTuR7nVt1GrMbRUfY0CLkWFDD+PzMRwFtpP6T3Uc8xLp7AKtaaYPXQJbIso/cVb
         DMAbCKhrA1RGqmhO20ZZBMfnNFsStxO9PvF3/UmOC4gT2wQ9FMkHfsCt43T8fCN/+OIv
         G8eUw0uVX2g6FD6OFRvybVOhibeTqY9GcXCnRZ3Xweq+I4FsfrImEQPDtpRdlJ4/K0f8
         fDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795333630; x=1795938430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H1Qd9Fv/BWffK66RMxaaCwY0cb70dS2E1+H4i8vWI9o=;
        b=Lpgu4A202nsET17vvz3c9529DI44xR1fdUFO7JrXJFe7YImC/0HqdM2RvsVsAmQdzY
         Lk6tmsv8WqRwB0KJWmpD6dppoTDgSM+ikui/Jz3VBX5hGoi0PB76oY1LC/kffD2QgxNg
         Rf8nlW1rL1Zk4BERbf9+ZAn49nErZA4D/klADraJX+qIPBNj1naAnjUlp3Nq3El36BIA
         z8zffgE9+rdR6gWDvRC5ZtHxRLlSqWqV4uGtQyYddfghkN8ODKJ6ztFdisNaRXzswrkg
         gnNeMfKK/BhvrRMbG1qc14F6Dy0C1MWg7/dtDVJbcvyfGmKIfI+FMdAfo4Jq4Xjr3tXe
         NyEQ==
X-Forwarded-Encrypted: i=1; AL+hErFj4DSVYgTT7s9bXIAJMU/3cAmp0jcvnT+ejW2rzEi3JzGtbcATUu93U/dXEwfZ8uGPmW0SDeweMRc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+Af9hezjFK5+KKIGJdamZv1sy7UIf11D6HkjMmVfe+d5I5eSx
	3rJP+8kp1hm3tk2c504QQRXh5VDRXv32jlmSfhIFeoV9hZqHno65rdCP
X-Gm-Gg: AZFdTZd/ONXOcU+3Yfls395Xo/aHReQSAyWvH+RCq9HN3Pf3+BD7MQ6oxoQRsn0rwNn
	nhbfJTYDxAay4t04VzohemKsoTyqhOrqqMuS/ZD2x3h0NQ6fWbvxEj5lVisCbJ7b6YDt1yxPHYY
	hgtuINa4Hhn6fLoWYpb/1xGqVouHFjlj3Q6B4ETSyu1h8vMefTiPuThufr9tSeTxiqO+rtp/ZS3
	q0d2zPyx3Oen3Mms9z/bp1fUPzLrffnZdlZ+f3M6PazGHRDC5yGKHL19ve+kamx3Xhw8QbwThcm
	eMgkcCpgRFy2cOmJEMP2f1Ik8Peyd9VMU/VYOAQOxAFXoCpHarfRNgcC+p4KO2rLikDFCKG5qr0
	00XVIkjO57yo2fA1fBwjNAMKeqHWMCWhaA+b7qdyk8jADOwkj0/K5LCpEPWGVwRmgv17+Pvd52W
	tc0crUaIWuS4u+5xFfh1vOvXCwFusjmRbgcgoOAtfQvSaYqnl9Q26TIi9INONn6a1IpxaGJ1iZq
	/iCB6KXXQ3qhcK2iwdtWYrd6fVZF0FedWXRew/BXBdZ8+6IU5c7FVBp1AiaNUAKEzhdsxTBvvSs
	X+K1BvFszTSuJjqFb+EObOx+LuFDhLM9RVxJmbY40QH153d0put43mfzOMCFmDatcIsqy0tBl0F
	vJ0yIxY3+JaTqqVUgT9Hnm/9wIT7Jr7BSaWnLuvm9APyKVE65N78D9MHqOHz02zUBQEWIc/SUQq
	UlL/CLM2Q5CBMPYYdMoSsSOKoI5JL4L2gcF/W851PUOg==
X-Received: by 2002:a05:693c:87d3:20b0:382:8358:9e03 with SMTP id 5a478bee46e88-3856ef457c4mr9427456eec.17.1795333629927;
        Sat, 21 Nov 2026 23:47:09 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385667decc2sm24898071eec.9.2026.11.21.23.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 23:47:09 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2 2/6] iio: proximity: sx9324: fix proximity threshold writes
Date: Sun, 22 Nov 2026 13:16:42 +0530
Message-ID: <20261122074649.239441-3-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122074649.239441-1-kapoorarnav43@gmail.com>
References: <20261122074649.239441-1-kapoorarnav43@gmail.com>
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

sx9324_read_thresh() reports a PROX_THRESH register value r as r for
r <= 1 and as r * r / 2 otherwise, and the division rounds down for
odd r. sx9324_write_thresh() inverts that with int_sqrt(2 * val), which
is one register value too low when 2 * val == r * r - 1, so writing
back the threshold read from an odd register value lowers it by one:
setting the threshold to the value it already has changes it, for 127
of the 256 register values (3, 5, 7, ...).

Use int_sqrt(2 * val + 1), which gives the largest register value whose
threshold does not exceed val: for r > 1, in integer arithmetic,
r * r / 2 <= val is the same as r * r <= 2 * val + 1. The result only
differs from int_sqrt(2 * val) on those edges. Checked for every val
from 0 to 65535.

Also reject negative values. They are converted to unsigned int, and
2 * val wraps at 32 bits on both 32-bit and 64-bit architectures, so
e.g. INT_MIN is written as 0 and values just above INT_MIN as small
thresholds instead of being rejected.

Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9324.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 93f9577bbda7..57fe78089167 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -613,12 +613,17 @@ static int sx9324_read_event_val(struct iio_dev *indio_dev,
 static int sx9324_write_thresh(struct sx_common_data *data,
 			       const struct iio_chan_spec *chan, int _val)
 {
-	unsigned int reg, val = _val;
+	unsigned int reg, val;
+
+	if (_val < 0)
+		return -EINVAL;
 
 	reg = SX9324_REG_PROX_CTRL6 + chan->channel / 2;
+	val = _val;
 
-	if (val >= 1)
-		val = int_sqrt(2 * val);
+	/* Inverse of read_thresh(), so that writing back a read value is a no-op */
+	if (val > 1)
+		val = int_sqrt(2 * val + 1);
 
 	if (val > 0xff)
 		return -EINVAL;
-- 
2.53.0

