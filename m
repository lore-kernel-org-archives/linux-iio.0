Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008859;
	b=rGkc1O+0Uxeq+YFEZ4wZC67VvQB2GCPwUCZKFjf8g6DusS0tkBoqlhcVorZtgP8UyxtH
	 lojLjgr57X6pE/dp40rsBQ0XVpEXk9ybHt7AbgY2yuknlUMHrqVMZ6L3t75INQ6izgfeb
	 MzH/S7WLNvgQetbcsrMCvr/bqrXH29T+cyqUOGCZDnnyKnpaJH5Bnwttr7uyH9oyQ6rXp
	 ZMPxMPLrxyHvSCKw4EUia65RevJtd1Ka75dRFvJ9Vqoj8kA4gnIi4bwFsBydV9QVzG44S
	 TFqdpPfPBvuxDTnuYnjEkThIqfF249E3qf4SEYtLYaWmMLtg11HWQz+1RQb03KUhpDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yUNue8RqNAG3xbvxKJkiWvhSC7sssvJxNpD4oMJGghY=;
	b=tQZKxbiOUmjbu/EsMFysM2DZTusHNta5npKK3nIFu9VBGZ+pLZsmvSqNGTkfQtEcAOQH
	 DD9zf2QRORP+ZRo9qe57IrSkbtBTxV6q+o3GKDKtjFkwe97LftvLPhDYw80Ypnz7OJJ6c
	 QatWb21zj3X6pLLlT6pqpjedH2twE22u5cKw4T+8m2hlpvDXdjTgRhk77/ia3VLneejC6
	 dVzKaVWBeFG76pAvOrgqzp4rJqlJ1YP6xlqOqe0uc1JyFNGgGgolJHF3UhA8g82iP5Ca4
	 vyPkrv1WCKsMx0UkjtCav0mdJPijMlH1W/Poj6iDzbisB4RV9N2YPyIDouy9Has1S9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="O/1e9Whu";
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE65606A320
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 10:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EE65606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O/1e9Whu
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-156cbe59524so1910157c88.1
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 03:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793008858; x=1793613658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yUNue8RqNAG3xbvxKJkiWvhSC7sssvJxNpD4oMJGghY=;
        b=O/1e9WhuRj5MV0MSVJ/fCJ+d2Csw/EvdUVILQtiqBCNrVw2OXmB71KQukWHsM+3SBc
         gVTl0OaIEBRElvVZbt22X9R2lExgCsH70Eepn4lJuXgVwHRPRMxr81DMRS9DysV+oiFQ
         Vku5nnGFOdI8I0Hk4vt22aMqA74ehwiShxq63/eKYphx3BPxJPP3kh0m4BUA4BT/t/ud
         Vf2Frefo06rVKqEPy8J25uzpAk0ECeDhnfAxcAmsZnO++g7K2MEgTKTwqAXl4rt7/qOM
         9C8htxP1+mOll8ttMad2MWAMLSts/UmjHkgNqW1bOTe27d+XGb/HjYS029Qh13dkGMLZ
         KAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793008858; x=1793613658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yUNue8RqNAG3xbvxKJkiWvhSC7sssvJxNpD4oMJGghY=;
        b=B25WOF+Rr7+alm6dmp1eHfOglGtryD1Nn3L+OU9X08MQN/zl3HcWiMymtE1Fj2Mhny
         C7mBukugUdOFuz5msfXDmximFfy+kMGFquMWDMpmR1J73U33h2vTGGQN38YeyzSpNP82
         bK8Efe2w36vL+Y863/0N/XcSPC7vYw0uBTeZZkKMiVD8eRjBwnXdWTAf1kkbep5HM+Wn
         IfXyIQn/sa96ZbENU/t/mZ4rKNTX+IeREnymM2AV1O+VMD5f+MCR+XNJT/kxWwcwxqnR
         S/kCVOdV89jYnvhO0fIzhvs8Z2d9HlHL3FTtaNaKhP58KLPjkuQ/GdljmPjYu7jBeJlh
         x5zg==
X-Forwarded-Encrypted: i=1; AKwUvBzBYWp+w3VXn3T8UUp3cQGJ4VlgEju6jIp+3gaPgmvh9bGjvY8ImtOGuXj8/pIspuSvbUlCA4tNVxA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHLlNw9cBGLXKklhSkTTpGz+QPZHpKwcFSO9DNmdxgZPOAupQz
	ubc6np95RwrTZ+t1rPT08fAi3qo7k247zXg9jI0kIJaiAU5dMIvFb7c/
X-Gm-Gg: AYBFou0oVJS0JjVcXNjKbZTEWtpsw4qHqG14S4z5vNkJwgxIaIDURhrev1KludJBT7g
	qAXavqzBuNPaMlyvyglYAxuvmBTtCcxQnMEMA/6RoQXrxLcwj/DHRcUfIxWJS3bTXzTNS6HbEz7
	dybk95ghg9JEKrtO8EUzvkUQqW7e1OPJHJTQABfg2Oj3kIzv/pk0Aaswms2FuiHEFpaiYHzPou+
	z0nZDksdu++UF9YhAucB1NaGl4IKY0S9tGLCjX8TGEowcfZyXFvaUo4aoG4DmATxyvGrNokCeTe
	1aX9UAtehxeRbWsS/upc7i07uLrx0nKb4pXRIG09/R7yxWgv3i3wiv+ECFrbs2jwr7Ec6Q4yqC3
	wQMnRwJ/pMD+pHL3us6ok5gK8f16yibswKFBrRA6vpFwaQryGL7y37LK9hHxI9MfLIa2f5g5ris
	JAFoTLNzdueyDjB0zbWMVrsLU9S3WpoqrJNYHqlqJWmSVUxP3K6njVZkYNHH7kaOll3a7N8ITbT
	7P1y8DX2bFuCwM50M5HPXL+b/YUiYmlmYlxe4apUXojW8hMFkDs+iVs+fgk8GLFFtiLQFDss4EP
	iEy39kaJ1FKqWGjOjvmH/wjD9m7nVAOa5e6q7E0arUFJlrv4QVbL4J2Fss3/fZyInyVO3ELF82b
	VqbgULgBcZ7w=
X-Received: by 2002:a05:701b:428a:20b0:192:fd91:c567 with SMTP id a92af1059eb24-19935906f80mr10155416c88.11.1793008858180;
        Mon, 26 Oct 2026 03:00:58 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2a5a515sm21224176c88.19.2026.10.26.03.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:00:55 -0700 (PDT)
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
Subject: [PATCH] iio: proximity: sx9310: report a hysteresis of 0 when it is disabled
Date: Mon, 26 Oct 2026 15:30:32 +0530
Message-ID: <20261026100041.16018-1-kapoorarnav43@gmail.com>
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
Compile-tested only (W=1); I don't have SX9310 hardware.

 drivers/iio/proximity/sx9310.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 79ba46d8a0aa..80b9714caf39 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -447,10 +447,9 @@ static int sx9310_read_hysteresis(struct sx_common_data *data,
 
 	regval = FIELD_GET(SX9310_REG_PROX_CTRL10_HYST_MASK, regval);
 	if (!regval)
-		regval = 5;
-
-	/* regval is at most 5 */
-	*val = pthresh >> (5 - regval);
+		*val = 0;
+	else
+		*val = pthresh >> (5 - regval);
 
 	return IIO_VAL_INT;
 }

base-commit: 2ef6f5c4ee56e90c237c5f7687f09e635f7d30a9
-- 
2.53.0
