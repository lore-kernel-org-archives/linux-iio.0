Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C1D3783DE
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 21:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782680593; cv=none; b=mSPeNfKzzNFLeLTFMbqaTb4QduxmPD8Gwr6vx2kanu95OBbqpyRdNFe+MV1NJ7QEfNNXa3sSfBhjFHrGlkUUGSsrDBAcW1WIUKzY9/1HTbDWklRxztThJEAmz1zlBs9YHDOgPVSs/sAgqzo7b1yVHw5sgfvXOBS6WIdVXBQBOYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782680593; c=relaxed/simple;
	bh=espG1giy09QMAmnoJM4JhpCcS2lwzv+JRCSXuD5yl58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4Nsy6qhvtGjWmIN/EP2iPz8NNw1YJXnE5gNaN3Jp8TEVgs/scIGJY8+xfJumWRiRd4Tmgq1OrleuH8RHElN54CoRFJ+RhXK6wTl8AxLHlXK32Bn91jH13SGnln3u2Jc4/VdMRaxUjKj8iTsx3nN1Key49lyD6+h9LG91IY7WYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pPTKqht8; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPTKqht8"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-693c69b97e7so5170988a12.2
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 14:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782680577; x=1783285377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xqlk8DHxm4SFQTQHY9V2Fn+LxNR3BBgzQZu7nC7+rPo=;
        b=pPTKqht86R/4/Y6d3DV/btvo+DDGT0JKcFbW/HF+nvSycsI5Zhgs0EVVif3u2XqS9u
         swg4Kh1IvG9xnlkCs0WlwBACSuZqdKHCNFpdRWvI3Mh4dOJcfpRwi39NpzTaYU4PbHJe
         eitkxOXSFifzBtKJ6ogN3E9ocgCnVMcCKzd3KnUAyjHOEskyGlkRUxkQojv8D4c7lWEb
         5TSH5jdmawl3dwXwhItw6PU6j5lObM2AjiXExmnZaHmxdqWAuKyuuXTswq/FScpXLuQ7
         Y5LmOxsPciq0117xIbhvfv7ss6YBmnkNB+X+2E2aDns1K90DTxzap24YJR1Lv3hBXX1a
         JJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782680577; x=1783285377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xqlk8DHxm4SFQTQHY9V2Fn+LxNR3BBgzQZu7nC7+rPo=;
        b=VUNVRUe4VYUTxLRQ+s5B9eI4tovUHOsEyxt9z7Su3lRgle9b+iDEf8zChVTEUmPoDH
         qymuLbm0rAOpz2N6NfulQdd5l2lupJVR4dgPp/ak4NHYkN2pDG9NgjbfSjLZ8IWozuOq
         BdzMvpiTK7vo9nEn8O4jdlZ05zfFjxbaRkGviLw3jt2vtwvagzewZYWrJJoKHKkqqk2U
         j5f+g6NFulCUWu+HnS8jpuaALJGm1447uUi2XYSVqN2pGrP2ANmkU5cY8lzL5W08axye
         qtQolKbbKTy33zQZXQ0IVgF81vsj7UXs5Cf6NzHjJh12KpE7A+uzty98/91PSB3+7nJB
         gBsg==
X-Forwarded-Encrypted: i=1; AHgh+RoABKbNNnYVIg32knzxh/4X/jsCvOCPBbTmZ4r10blQkRGtQ6qUroCf1tdoXWXEPYfJQwjQaILBY7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOQf+e+jbfJokvX3wkX2oJf9JqSfwiWVdmOyILrP9JB+Lvyh4B
	WgGTVDekeE/TiBdzwyM0cpdbZ763LSi8s//Bh7nUUBf4LJftAuBwxNn8
X-Gm-Gg: AfdE7cmy98ebq4rWg2UJqP8KC6MxHKSx2KdQv+UmsCVQ/i4267mx2YkNYds1dTkgE8N
	Gd7Hc+6zbr1MKAuKfbmn4hpjg4J048OX+YuG17VrM0BRemI9b4lhi7+ynD5V1WStwpgD9hPceML
	SYLx2sLIR1r770+QcpopUQsDnSYO1ytjekUBpptq4yIK18ssNBuysbOzZSQzKdOulqivCLson1k
	ou9/mR9PVhg1H36fgd24vKcBcoes15LhQ3qYRhMpTqB3KcMdvCZotDH8DBALv1kN2br7R7FXXNq
	+WfiEP+3x+G48s+MLLok7UULelv2dRDl6DJfm6l6sc0ihtmhee+efmcD+oG/s9Bif7R+6nKJwCC
	0QGF2Ukms/g11ty+YR9Wf2mxK9ys8KnSs425nZ1q9XO4j7QVzIND06oSaTYERBiqpViYvpg==
X-Received: by 2002:a05:6402:3591:b0:698:4831:f9aa with SMTP id 4fb4d7f45d1cf-6984831fc61mr1956097a12.12.1782680576881;
        Sun, 28 Jun 2026 14:02:56 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69848e5ebc0sm2205656a12.3.2026.06.28.14.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 14:02:56 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: wbg@kernel.org
Cc: krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	o.rempel@pengutronix.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wadim Mueller <wafgo01@gmail.com>,
	kernel@pengutronix.de
Subject: [PATCH v6 3/3] MAINTAINERS: add entry for GPIO counter driver
Date: Sun, 28 Jun 2026 23:02:41 +0200
Message-ID: <20260628210241.119825-4-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260628210241.119825-1-wafgo01@gmail.com>
References: <20260628210241.119825-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cover the gpio-counter driver and its device-tree binding.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 06a8c7457..14f1a4e9f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10984,6 +10984,13 @@ S:	Supported
 F:	Documentation/admin-guide/gpio/gpio-aggregator.rst
 F:	drivers/gpio/gpio-aggregator.c
 
+GPIO COUNTER DRIVER
+M:	Wadim Mueller <wafgo01@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/counter/gpio-counter.yaml
+F:	drivers/counter/gpio-counter.c
+
 GPIO IR Transmitter
 M:	Sean Young <sean@mess.org>
 L:	linux-media@vger.kernel.org
-- 
2.52.0

