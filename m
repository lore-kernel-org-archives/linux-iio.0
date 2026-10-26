Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013666;
	b=QeYvxEMENjDeNRJgbt6bSBJXZAU7ZLZDzqkwIdaJN5/YLuhXf5iDEEsqZlaAWtXZqBxE
	 tfIo0vuH9jlnsnzagOGssNw5j9lbk/0YQeb1Fs2rcquO/tRF18FwCAbNMF1eX3KSzk1uP
	 4qmtkQHaYHTClBInyX27PI+3s/bhL1EJsJgII3TZ/7FLOZDmu+IShuK+mYvCgZK/dRqqj
	 uMkBm0UnDLMJk7xmbFTqepB6kLq1OWdSNYSnenLwnit5jqCBHhvqreDqfCI7aGxC+QQ5w
	 jBcf6+9a1D96T2u84tfjM5u6qO5HSVNvlxnNMnGRaCk2GUEX+6g8fSsQfqV6Mu9mU3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S8X5Y9IyyBtIsxQOYjbqtgkv37Y5t4081jPR++5oDKU=;
	b=sHyHMke14A+cRQbEYINddUzjkItX40AzhOvpYyi1pRw2xhDtb+RsBzLt1+HuohrRPY0C
	 LgMoLW3J7ETffDuXjC+INV+pXyNOEPIm8YLk1ZUf8LvIpwPS2TAb6kwivfllXz/O+nOXv
	 QzjBgWa3AOmvFLYLrJ/OPq0sZ8zfHNsnsL3S9ylZs2x3g3vrrdN68dwEhKJmsA11X225Y
	 LtFFwk/Xfy7cK1AjrOAar2Ws7Y/6IN6Cib43Ju8bWHdWemG5UA4rHnM5j/1UhVXrW1kyy
	 N+aJFTmAPMclV/el8irHajxmfy4ZXUdi57gVLjMdZLIuSLf7DYFSFqb40amB9DCdTyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qn3OXI2T;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68FA606A31A
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 11:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A68FA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qn3OXI2T
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-157fe9d771bso3388225c88.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 04:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013665; x=1793618465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S8X5Y9IyyBtIsxQOYjbqtgkv37Y5t4081jPR++5oDKU=;
        b=qn3OXI2TkpgSCc2zQQsQYGigI9SKg13KpHmaQZbX91XloFETbD6AutaUOq8I9IMoI8
         ZAPwRKBkWuqO6ba7b/zuKAvIkOLOkJbeUAdGuzipkQGYeTFn489KbGV8WoPnc8a+5Z/X
         pd0PtZIRdTcjDOso0axbgE/8HFu4fp9TE0nTdzpXV74u784TVm+7UzglST3TEHHS9Bvu
         keTVUSnzipDca1Gjznbrl5WwZthyhJ6MyaRH2RxJniGID3bEZ2r0ldIv/GCKRwH9fZrO
         Le4dYHSVQ+osJ/XuTemzAxMeYVqG6B3a7pysiCmWsuel25vgJDdYXkJCBTVeMXTKWkH1
         EXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013665; x=1793618465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S8X5Y9IyyBtIsxQOYjbqtgkv37Y5t4081jPR++5oDKU=;
        b=w0SDD8iuEMHPnUI8PmlNcHTNCEtSk0tiMs9DCdkPSQCjOqqWkgwlJhJp2QFTYOf6oI
         OaUubV7HB6LO/0BSRgbumclgcFp1rCh57T8eMwODUsyzoYYjZJiSrkADJCz0FsJckZRv
         8sLNhL+BvQqCIHQ2fHOa8Z3PDxHrFTFIs3kj7lJEiGESZwZWk7lcC7IbQ5k0S7qLIMsL
         HAOd5CNHGMda1CCn81GcdhnfM8xE9QZe62cy/5LIK3Mv0DCaLKXDL9jiXx5da+HQFNmg
         uLD27+gTVLYZS1D12yZBkSWp+tYmL0nHSQTQ/LHvpbKYM+Syn6lYqgNBYZZTzHbeDVRM
         E+Ww==
X-Forwarded-Encrypted: i=1; AKwUvBzefRWnEPszxOiWpFmBUgBBimtBYoFa2EmB17+17YhX+G9/WvVgYS70yO402j1NU8NMynpRP3+cuCY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdz2Q6zJzxEYfzsYKfAKV1W+7+U+8b4fnqKnq0sNTpwsIV7VEL
	pERugAbkwZydzphhD+OWgmnbw+CJfhB3QjtGA6fTbR5J5FWs5i4b48/j
X-Gm-Gg: AYBFou1ztd1IP5i+zG1Ih7U569qGCVhcRqQ39n3BNpwoGRuRN0E8z0FNZEqUbP19RXc
	M1iEY+TRIxD7YlARzlv1/Zt82A5pmny5W1r/HS3Y2PwAja/Xi779x43oYykvMgzRnxMvMZ0xd4B
	D0DV+8t7pnXt1+fOyXzRUdEJolOaKAnjtIvGjououByjJ+9aA4FnsS5rL5nhIAhLBvz68ENtod6
	9R7g8JikpBwbZ26A9cSAyhKSiYSFazDwa5hATqUXxAqUfgkW17fMLE5nprvRFIOVkymldOcWh89
	Yfr5vQJ5rP+n28aBmTb6aoQOYvrh5oNc1X6CmOIt5rZ+lBFRwSA74rsIjuRMSA3/Mg1s3P5tr9g
	vR7PsFg3XqBJ0PbgQN7jqzgNI+55GXFX54MHJTQCVtw4wvTR/q414EjKRnzHPCHizlChqnETrUu
	4/PjaqLfuKVMCmqCyafph7uDQw+s69rwDqhVfntM+OY2lq7pta0YIWYKZFvoctFV0KMTywLHNvp
	U8+lMmyIMt2XtxMyBb7/7+vASs7GhFTEqX4lW83uUgH1WTfCK3iDvJBvTJQfDCsK4zJk2x4Lf2N
	wVWl9JdX42o4Cze18bEk2SHY0PRVo5ORUdwlkBq4bcfZIvOCbk3upZAurXyhKYjsSnAnkZkbD+W
	nGehfFMnlV4Y=
X-Received: by 2002:a05:701b:428a:20b0:192:fd91:c567 with SMTP id a92af1059eb24-19935906f80mr10413928c88.11.1793013664628;
        Mon, 26 Oct 2026 04:21:04 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a1bfaf25sm24469130c88.14.2026.10.26.04.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:21:02 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2] iio: proximity: sx9310: report a hysteresis of 0 when it is disabled
Date: Mon, 26 Oct 2026 16:50:49 +0530
Message-ID: <20261026112054.59895-1-kapoorarnav43@gmail.com>
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

sx9310_read_hysteresis() turns a PROXHYST value of 0 (no hysteresis)
into a shift of 0 and reports the full threshold, which writing back
then usually fails with -EINVAL. Report 0, as sx9324 and sx9360 do.

Fixes: 08f0411c48f2 ("iio: sx9310: Support setting hysteresis values")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
Changes in v2:
- Invert the conditional (Andy)

v1: https://lore.kernel.org/all/20261026100041.16018-1-kapoorarnav43@gmail.com/

Compile-tested only (W=1); I don't have SX9310 hardware.

 drivers/iio/proximity/sx9310.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 79ba46d8a0aa..dc1b1c3f4776 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -446,11 +446,10 @@ static int sx9310_read_hysteresis(struct sx_common_data *data,
 		return ret;
 
 	regval = FIELD_GET(SX9310_REG_PROX_CTRL10_HYST_MASK, regval);
-	if (!regval)
-		regval = 5;
-
-	/* regval is at most 5 */
-	*val = pthresh >> (5 - regval);
+	if (regval)
+		*val = pthresh >> (5 - regval);
+	else
+		*val = 0;
 
 	return IIO_VAL_INT;
 }

base-commit: 2ef6f5c4ee56e90c237c5f7687f09e635f7d30a9
-- 
2.53.0

