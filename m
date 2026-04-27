Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91EE1D5170
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777321226; cv=none; b=DB5k/Y8mmZLz+lV9Vm1EeyOMy2s96D7dV0nDHjgDEj17KBl//Qrnv2w3JgjCs7TizoD7Ek6r/xu+GvB25In3lI7Djt9P1yQvZGHI4792nz8/1Y/RJ7r6xAIEH4lUa9neovrYJ2HBGveClIvkcKWGGfvaZTOJ5yfqpwJ7gc5vGvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777321226; c=relaxed/simple;
	bh=glSbWnFmBwJx0IQqrzrcxPaAYcWfdeQRRx9TcoERQyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KQZQLgq14bzI0OgLsEOUTrbfL88FiXpf6j72kbU62wbg4Y4zEZ/i/KyWOUsT7g2eIhugCGZ9EvhXDJGwntuJ+LgyDNlE+hWmClosbXtoxuLOj7guuMrQzuJiXG/M8BjPNGyiKmvuq+VIjQ/3O5WIx6XUtU2EqUTHnFBJtEJ0Ki4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRGFeWzs; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRGFeWzs"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso88263465e9.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777321223; x=1777926023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gpgZylQ6F9oZ5g4Pqc6xBbXX6HVh4RUIO3Cnteq8M4k=;
        b=TRGFeWzsUEZvQlHG/hL0kiS7QYPZ0MKNRTS/0Fr3kFif3cAPysbzr4yEcRPJAnjnSY
         CZNVi/kEfBBtGR1y8qwiv4CMhHSv0AxoGurhnv+3VVilyMeEiCjx8+UjQCpAFz7XYLme
         tq1Bpvk8uc0v50lkxSopMNViXBuDNInCqRRG4/T+RwgFSCmx04ZmavpOWlMilNPf8Sgs
         siuWhvMl8RQyHLX5B61s96DWf8fyPFZSnzEwaUusWWtF118Gm7KR4nJp54ovvSn5S9+m
         /IEIMnJyKQmunwEK9sWhuNTXqo8hRmreEXs7w30ixM5F9cCyItDve4/zrE2KSgPam6AB
         Xeiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777321223; x=1777926023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpgZylQ6F9oZ5g4Pqc6xBbXX6HVh4RUIO3Cnteq8M4k=;
        b=Wqv0/l5Q89G2GXM+4i/QhC+/WuWtXDSeE3UbgKuEyg2Zn2DpWKPQDX7aE1WIV3cmSz
         2VBA0aWGvESVa90gllY+qpXuO2SsPZV2B9B6Vz+gw+iSX8PVvGrlG5dSA3imVfqdRkqs
         eIXPOdmJ295VV6xRISrRl+vioNq2l/OpCs0AgkGk9FAcaRHywLHac+t0qDMEmLY95duN
         IWLI1NWPSL11oVtQPYdUJXWSarMGkE7C3MNsHkuhILGZ7YeuAfdLdZkXIE6ZUvYR9GgQ
         /uaz/LJyhGqf8RsBE+IIsE/q76+5Lzdl+GgAtZjR2ySyvVYOhON7HnzG74L6UX20nvem
         eI6w==
X-Gm-Message-State: AOJu0Yxq/ebXV0KJA3oJfddEE845R8DNl9ERwIDTlUC145C6NmcbCQk8
	Fw5oijJjaEpf9YkoUH8qcMIaGDTiNW7Mjw1UJRN0NjKscLTa9Pwp123A
X-Gm-Gg: AeBDies+Bj64znXE9JpbbYtlsLOpLPs4yNmGlJq1peLoTFU0s4aHLA2ejx9MQMNiR5o
	ZiRpLv8oOXcRhtQlRBWVwSWarBklnHTnGiLqDviPQJZvOKEr+5fxY+s5RBQvYEw98h86AgEaB5Y
	+MgVAq6b4gbp90zXd5vlqUA6PxbAuC50Zg7JU2pgMcqgIU5OWokNGzZ0VQSe2o09ky2HRQLFIP+
	0eK8AJB6dyUnQpV7mI9E/spBfveqUDWr09bgO3twN9KSCxwRCTcYRLO4QJDivsWOsZNWwRyEiau
	cgNxi1/LOREoaK6uZxnXVEa4+mswd1+FyLzKx1NX2Afcu1ySFCsDwSzSpjYuPetsIoY4+OKKBwf
	oMvSJx1G9ekfOcKNE2qbMSOei3kMxV1yCbPR0Lv4gih/wzQF9yCg7weNlSTGOk+AZwnXfpi+Iuo
	xjqwrkW1YHmQ8Hmv8XpXd4LFp2LB5Wi5DaiOvr4+KuLmFU3Acc7Xz6aIT0Uyl9ILNAc77WmjQ=
X-Received: by 2002:a05:600c:34c7:b0:489:e696:8362 with SMTP id 5b1f17b1804b1-48a77af18ccmr2829015e9.13.1777321223093;
        Mon, 27 Apr 2026 13:20:23 -0700 (PDT)
Received: from Lenovo-Ideapad-Slim-5i.localdomain ([92.53.30.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a774939dfsm4977045e9.1.2026.04.27.13.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 13:20:22 -0700 (PDT)
From: =?UTF-8?q?Rahman=20Mahmutovi=C4=87?= <mahmutovicrahman5@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rahman=20Mahmutovi=C4=87?= <mahmutovicrahman5@gmail.com>
Subject: [PATCH] iio: temperature: maxim_thermocouple: Fix indentation in of_match table
Date: Mon, 27 Apr 2026 22:20:16 +0200
Message-ID: <20260427202016.1635-1-mahmutovicrahman5@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace leading spaces with tabs in the of_device_id table
entries to comply with kernel coding style.

Signed-off-by: Rahman Mahmutović <mahmutovicrahman5@gmail.com>
---
 drivers/iio/temperature/maxim_thermocouple.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index cae8e84821d7..7f80fa018ab4 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -271,8 +271,8 @@ static const struct spi_device_id maxim_thermocouple_id[] = {
 MODULE_DEVICE_TABLE(spi, maxim_thermocouple_id);
 
 static const struct of_device_id maxim_thermocouple_of_match[] = {
-        { .compatible = "maxim,max6675" },
-        { .compatible = "maxim,max31855" },
+	{ .compatible = "maxim,max6675" },
+	{ .compatible = "maxim,max31855" },
 	{ .compatible = "maxim,max31855k" },
 	{ .compatible = "maxim,max31855j" },
 	{ .compatible = "maxim,max31855n" },
@@ -280,7 +280,7 @@ static const struct of_device_id maxim_thermocouple_of_match[] = {
 	{ .compatible = "maxim,max31855t" },
 	{ .compatible = "maxim,max31855e" },
 	{ .compatible = "maxim,max31855r" },
-        { },
+	{ },
 };
 MODULE_DEVICE_TABLE(of, maxim_thermocouple_of_match);
 
-- 
2.43.0

