Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFEF364927
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 11:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028716; cv=none; b=et+L7arBZM22O/U1RLq3mDUxkNxhwgdNN69G13whMkkklJRsWLStngEyhz8kZFmp6WagNOtNprtrQMVP5Eo/20OtYfUFKBlf8j4JEQ+UrBs5qkcvteFM5n7KukJuk3CG51erHbKRlBZrFR0uiHHabgsSYVBPnK2e4eHZ26ytab0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028716; c=relaxed/simple;
	bh=KPEtP/l2rpCPUPVRlPtwP57praEDezWS+qamOeiLmy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qxpsLc6d+kDYnicaEr0D3OzCkU3NuxQGX6SLjhSHFJq+ix9yHGAST5XttqQJYqy6F1FgJGC+vrZKw4Ekxf2Oqy3FbFYXWzz9cf6YLFcY/d9eQCoJAh/9ReFN/IIMGjGOomao/GWoACGuxNtL51ztMIdc/l/N221rLhdaDGOgnwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6GoyT10; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6GoyT10"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-383adaa461fso620808a91.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 04:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784028714; x=1784633514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jrKroNG+WUkTMMJq+n2qekfNMAfDT5ieJ4xOEkhDX/M=;
        b=f6GoyT10QqNY9kD0Umpap57LxORyLhUnpAaU7eMLcPyM9f0FMDVk6jznIumVchjUJ6
         DTjJw0MkDmnhPYYXrqAy76f/ADk0SuOm0k0Nxsxa7Y91iSXzjNla/KUgOvu8GdN1KqX9
         m5zcJtGhYCq+/zUGMdmEWawFYioUnRGxTCEdOJka6WxZ3ffg1FSB73hqcrdVltUng6vI
         0nhsbGqOm2SSksoUx+XkQWG1Qp30pdjIbeNCEAxup6mOMZ+Gx0yELCiZtrpc/jara8dv
         AQBiXGCUdkuSL7Ai/tT3W0QofHs535cMf1xUnpMFX+NGQQyvHJK694L978vowo3TryS2
         LMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784028714; x=1784633514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jrKroNG+WUkTMMJq+n2qekfNMAfDT5ieJ4xOEkhDX/M=;
        b=BB3BZGMaLGxJjXhPDY7Gxx02Jo3O2jjx3hzgrk3ROZUdarULg48vCanAaWCXJZ/zFi
         43ttpg6pNTX9SMqgy8WmNbv1KZycnBFiYyx6xaSh/HOvbWFQ1IIFj+OK4x0WEbKxUJCo
         SRLE+vCvGXseha/jP8D8IEuOHF0LB7wC2q4cj8CwGPDYmCRit0IO5V3Yl/uYqGbYiaRQ
         WdrUxcrs2h93wubrc6KGUgB6WnT4pxIp7PZMK9DKK+sga4MPc1mIxIwVQUvIHdkiHdKJ
         xAQnjbN9/cDEc/WUk7d7oR5r8oYD0/nz3XxvmYgeLuHDUOB4NRKj1BD3VJJOhW3wbhsu
         nCIQ==
X-Forwarded-Encrypted: i=1; AHgh+RpeLgvqnyxtqhnwD/ktvJhm/slVEzJXKZYVy6UYpTDdnGoidVP9MlqSiaFmf0VYTLJg/EK7pvconBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOhDb4LvzJPzuKuafdWF8MW9gtrkESVApSyIX48pTPD3WooVfv
	5MQcEuZcNYSJChrPfnnjlzu3iRUAHirFQBnW0qub07a7W1GVhe7Zd9A=
X-Gm-Gg: AfdE7cmbYH/KQV4LHM3v8wUSRvJErgqPBPbErTztNtW8T8qZUlvKq2bvkKvpXP/535e
	jFQg//aBAlmJbgZP78qmiQXFcdHqxDWq4f/vUrblUZutMOwoGQE3jHPmyoNhPN6o8H/IIEf5UlE
	1NZPqNxYgne8U/N2/H19BAISndwcxsH4MimRYFPMcAAznT2M8+0cFZ5e0Hrlb3AOkgtxDK2/Db1
	TUNUlSiJiuuzr5KqyFkLytZa7LC2mtvkjcVkMTvvYci0v4MzZbH1Pdc5uSoxP10aSxZ4+FSX6Rj
	as1CRmDAhGSEtyrncia6a9SQRui22BXe/zy91288rqsNoGKaf/HhrH1n/P8neSYkZ5LIpz3ubDT
	aFKmGlWcQUrGeimYaXuG18OmdU1OwV9Grj/AowV1O1D0NSsKLd28gBrVBF3vY2D4fFey2QqbkQQ
	8SBxgHT9sCaPkOzgwaXyk/0f0J39BgOLq+BZItt23JKRkvPxFkRgD9mgL4YXAW62A=
X-Received: by 2002:a17:90a:d886:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-38dc782c6b0mr11083125a91.1.1784028714130;
        Tue, 14 Jul 2026 04:31:54 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f72a6sm95357368eec.1.2026.07.14.04.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:31:53 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v3 3/4] iio: light: opt4001: Reject integration times with a non-zero seconds part
Date: Tue, 14 Jul 2026 17:01:33 +0530
Message-Id: <20260714113134.3445-4-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260714113134.3445-1-nikhilgtr@gmail.com>
References: <20260714113134.3445-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

opt4001_write_raw() only looks at val2 when setting the integration
time, so a write such as 1.000600 is silently accepted as 600 us.
Return -EINVAL if val is non-zero.

Fixes: 9a9608418292 ("iio: light: Add support for TI OPT4001 light sensor")
Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/light/opt4001.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index a0f174888384..bb4be6384e4c 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -269,6 +269,9 @@ static int opt4001_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
+		if (val)
+			return -EINVAL;
+
 		int_time = opt4001_als_time_to_index(val2);
 		if (int_time < 0)
 			return int_time;
-- 
2.39.5

