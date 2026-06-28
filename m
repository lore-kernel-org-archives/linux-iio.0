Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1353B0ACE
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782658723; cv=none; b=OV4GBgpqMqmoTZs5rJ68GJTizDP/4BFjactY5iP7a/x2rgWQjWGekNs7R6fz3Z7sTJ2kLyqutgbVbcKOWiRvor6ASAuF+c6F9YVTXTTBNXBzaF/GaZPMvmeJ0jDGBf5s+pqjqPFEcWUqQFTz9DsJDPhsayHJSE50uodZiRUMJbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782658723; c=relaxed/simple;
	bh=6KwVdXym8m9VmBu/yZDbGr4sR4go0nT/ImlSsY/m7K0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=otBlekj++izEDruHzbDxcMQ7eUlEkW2xPChFFVbWOtie8vwEhLZd/QHAYjCZqOpc1fuNXWvfoiyuazHr4MpwHPdEA4/BDbOPmGmRtfVu2JM/nxkkL9ryaWisuMNVHQgZzwhG1YFrCvaIsgdskxwqRgd1QEifR1E0EiWYFZD+sfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOiB8jv3; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOiB8jv3"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30bf8b2bd20so5217736eec.0
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 07:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782658716; x=1783263516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJM+v6mJ9RBfgqnA3JaL3CQXECHO5LJ7tpDsIB136Js=;
        b=IOiB8jv3r1VcSv9aA/I7bv3fdnU6zrpdOKYS5nSK8ztFvZTqplBG2PQT4hIggSwXTM
         b/XhzdCVOq73SVWjOld8m0jGjfvjRlBIV3rtFkjM9SJZmmDVGex+Z0/pj/h7YSIU7vWv
         ZOKSsETiit4QBYqC8orVtmXW9se1lAGT/VH91rcD+WIQ4nP8i8ICOHiGe22nC8jeTk7c
         +1gQNLFF16a2Mb+lEEvJtzbMY0NaUTOnhMSdUVjquLPzc6mLmCSHe/rMjRvo5A2fnUVA
         yF+tdnE9d8zBh27UuP1An1+irceahpxuzr8ddkPKOmeoZlleVGvf0qQBkwETYasdWNQV
         Yvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782658716; x=1783263516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EJM+v6mJ9RBfgqnA3JaL3CQXECHO5LJ7tpDsIB136Js=;
        b=A+1LHG5pAeAo70/lHLjsrHAViElv+t5E+FGMDZSP2HJnebE9Sp1MTTkLKJbbp4hipL
         xlk2ewlt0Xbx7ZAb7+a0W2mN44CYS7CGMIsUOlqB9cgEIkjlNW7+/7mlWTAgMLI+eb3T
         jLDQCC9o2G/UPYHSrJGCoiAYfm6M5CBj4FVwv1Zb5Hz2XHghgRqgk/KY2fFus8+LhDqs
         KsT7u2KA24B7DL7rWXq8fy2S5zjW5bWX0HspgPe8XeAouwKJADObLkNeSWBf9Mex3rCi
         /YFeeNzdLyA1nE/9LSi4psDAP5+/3Ho9jUu3e45SkJC+atNu2tEP2QgyY7xUrbcpS9yH
         XYZg==
X-Forwarded-Encrypted: i=1; AHgh+RpUdB3QnbD4avAvTQs4g/TUQlk4jrJap372PsPhiLFbSIZ4KyLakty+maJazAA+6dHqI/YIucPq6b8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6qMoV2Wr2IcKx5iyPxMzCQzYo8pBd9sTsIK2GMdJ5N0EjoU35
	53VWp+wwBEHVgAkgxQp6CRAX5gjxSiKZ4fvkG311UNSsaK/kv8PssEib
X-Gm-Gg: AfdE7clBw3bER8rKFz8VXbMu65XLJ192lV7PxmbjJey4tj0SaqTO5Ume61c10h/00x0
	nuXsKMRqVP4ifpTAo2mEjt8MiZ/OzOwUAFDL6RubRok3qFucwsJXXCdfI38ae8IrNJDVNkwfjji
	onbcs4XKeftqD/CMK/f02SaSCPqCk7jO4TIqahbDZmSugtE08PNz7NRuoI3CY7DV/ht48WapJfI
	XxBj3WYKYJasGrp6T/TvFL4sFcaHjvVLk3bqGf9pgUIhTzJCJmp6yPncM4Wga2Rx8dcwL1U9Uo/
	WnJL3UhDOAMgMVWiL2kV/u1HzNQDc1mC8WPuDe/g6Wc29h9KECXtcx4Emua2MrjTLz6KhQmlf+v
	8rkQClkYSMeovVzmGGOWrF7mmR9uqR0iCPl3ISkPBu1JrfmrZNC+kkN9R2zkIVY/3oHTpJGhiRA
	hIDUM958d5+09Kh9nkKjukTgpVxDXZGQc++nfvZswHewWARb34uo2yHJ7RK1PqKQFnXYDUYgrvZ
	atC
X-Received: by 2002:a05:7301:3f0f:b0:30e:c32a:ec84 with SMTP id 5a478bee46e88-30ec32aee3dmr1786836eec.30.1782658716032;
        Sun, 28 Jun 2026 07:58:36 -0700 (PDT)
Received: from moksh-Nitro-ANV15-51.. ([45.118.104.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c944999adsm31307072eec.24.2026.06.28.07.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 07:58:35 -0700 (PDT)
From: Moksh Panicker <mokshpanicker.7@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Moksh Panicker <mokshpanicker.7@gmail.com>
Subject: [PATCH v2 2/2] iio: adc: ad7779: Remove redundant dev_err_probe() after devm_request_irq()
Date: Sun, 28 Jun 2026 14:57:34 +0000
Message-Id: <20260628145734.77191-3-mokshpanicker.7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260628145734.77191-1-mokshpanicker.7@gmail.com>
References: <20260628145734.77191-1-mokshpanicker.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_request_irq() already prints an error message on failure via the
IRQ core, so wrapping its return value in dev_err_probe() results in a
duplicate error message. Return the error directly instead.

Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
---
 drivers/iio/adc/ad7779.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
index c1a99b4c1256..a5b8bfa99a74 100644
--- a/drivers/iio/adc/ad7779.c
+++ b/drivers/iio/adc/ad7779.c
@@ -842,8 +842,7 @@ static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev
 			       IRQF_NO_THREAD | IRQF_NO_AUTOEN, indio_dev->name,
 			       st->trig);
 	if (ret)
-		return dev_err_probe(dev, ret, "request IRQ %d failed\n",
-				     st->spi->irq);
+		return ret;
 
 	ret = devm_iio_trigger_register(dev, st->trig);
 	if (ret)
-- 
2.34.1

