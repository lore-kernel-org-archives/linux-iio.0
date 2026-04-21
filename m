Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD423B61B
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 03:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776742396; cv=none; b=kzLmB5abQtav5DGmXurnKPz+PNZX9DWyw7lh09x/c+w+6t7eKuBkyLHzGSqbL5dYDb8Thl/PFmd7RwUXLpL1OK0klRbiMaCiFvoh1GRJuAcFAav8CRCqX9bYxVezA9bwDGV/85sAKPkVTUHDNRxQyQAodZ1AC73oMKHyBKynkvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776742396; c=relaxed/simple;
	bh=1PTkyIaAAhRUiI9VHZak1VEUjNpclUAJjZnev3rantA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WATyIACDbn/JTnaZPNG0vvi2wyzRKOxXwjVEJQT2nxuUhwRYjxXF9T/ckgUebF0YQiuqNy83w7znVQZtHh5YLepJ5+6StFMaGJe+Xa8X6vVGGKqMJeHUR1++0mxFo/huaUqe3+fva2jxvL6Vt4+iE4bNK20pTnKBXaEGz06jRiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDDJ1V+N; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDDJ1V+N"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c76b9efc299so1441788a12.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 20:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776742394; x=1777347194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YXjNUP8S3hQkr13wiZtxStftqpT7wj7L6Sswm/jLgaQ=;
        b=PDDJ1V+NCnQ30iutbgJmjG1CbSm6yW8/v+2Equ9TdfBWhJHuZh5ScN2DreaQ/xg+Ro
         WQBe2+UIZAbcUYefDlKItxIMhcKqV5NpYoC6KORciCnay3+PuDGgZ6BaI8RV4aPGFuoL
         CDGrFmn3/i45lsiL9FryebN7S5iJKlhdIgXMJi0kKvkuF6Gy4wfCRFfwL2TLfQATL6dW
         kygdH6v9szRlSyq+vMFOS6eeQxUNkTkKlJKo6qLlEYlEMXwaUdWgxafNAIlYPeTLGJC0
         W4YPk5Tpfd/819xnrsAw3G5QX2vv4tG/E1UWq35yLa7dj5i/jNT+jZPJwbv/7TCq3mvt
         IgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776742394; x=1777347194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXjNUP8S3hQkr13wiZtxStftqpT7wj7L6Sswm/jLgaQ=;
        b=BZDwMlkYZDjE7iufygL18U/JHcZAkp4ARLkrIp2j+4Y68lHOXc3SynkfDv9ABF1231
         5NUoLSqW/5c8JKyIyvLCrS3ejcaOWIabb7LstGio2+h1JeVA3YJaCkr/FforlR3x3EZN
         wYrhBgbViI8rKZBV/mZ82XonrGJQHXAKKgHfOk51/Oa+GZAAmO66Dg+Xspu0oTSVQmv7
         rEcz0648BkIa8WwDP/PAES2Cf7b+mWNhWd1jTkYR31tbHNGuv9szEv8+Hqg38LHJEwRt
         Y+J91sEJZ/dqxUWcaf4FGZHXc99206xhPmeiPqk2fP8egzCv8zPoIp+C6PuUJp4LjYd/
         N8sQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5QqpMbUdm1mZwIxaAzCPIYURSdD+sKFisiXrZ3l/sERdXv+PxV5o2+/MAeXBKuFGaKMBIA+nD3ug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4FqtlOYLGphKlqQse2tLZ0L6PfZoz+2gevTrjq+WRFm6YWAgJ
	m3eIRyhQpjgJOkplX71YIEyD/WtmnIri9i9KjHnjJhnQ28lmJWMOCBzc
X-Gm-Gg: AeBDiev0Cq2dquIuaULI+cKW2+oYzpQTQVHbjT2/RKd+mdGyVnR2YbvqhunEroza7Em
	5ZQCQTppauUhiOKtt5LNfEPNbCxuByi9bjDk6MJkkWJtab/st82lZMZqm+oIX+stPvGowm1aB+E
	damCOEUMoGnxVuENjkhVVBMASHzk6Td3V4aAVepr5oNBUvdpc1AXq1qDRmjPKr/0GrUQt45c+7T
	/V6rWmYK8zsDwcpuzj+nlxdtoV9aOpoOnTq+Dw9tFZaTLM+55IRFs4oQUN/+qxpIcKT6pt/pNxt
	cYMIZMfGCHZxuy7gHk2XO5d1bT6xP2xXEW5YiZrrAfHCJoP28un/0UqoH/36+HebrR46Pv1W1TP
	4LSHStJj0cEHTHHMBmGYWDGbSe9PnrU6GkwSVKBoWPZZHqGQaAOMGd37DSwNYdmIh6tyqZtoHBp
	hnZ5amstLtx3ji7R0GuPl+CZsr0Z3VHexdhnAUworYzcXSEmV+XYN1qAM4Nm6RPmoMQXe8uz7Ik
	JSpm0e+S8fD43tSk3mt8hCPOEnbcvgwJ7cRwRQWXFD8LGhIWdqjoHlmSdf6AVL+ocH6muA1ug7Y
	c/7RTIE=
X-Received: by 2002:a05:6a20:3c89:b0:3a2:d976:2210 with SMTP id adf61e73a8af0-3a2d97637dbmr4564179637.8.1776742393644;
        Mon, 20 Apr 2026 20:33:13 -0700 (PDT)
Received: from PhantomX4 ([2402:3a80:51:767:3618:c13a:2d9b:d51a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797703df68sm9262933a12.27.2026.04.20.20.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 20:33:13 -0700 (PDT)
From: Sudharshan <sudharsanam346@gmail.com>
To: greg@kroah.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sudharshan <sudharsanam346@gmail.com>
Subject: [PATCH 1/2] staging: iio: adc: ad7816: fix coding style issues
Date: Tue, 21 Apr 2026 09:02:51 +0530
Message-ID: <20260421033251.15663-1-sudharsanam346@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix mixed indentation in spi_driver struct and add missing
newline at end of file.

Signed-off-by: Sudharshan <sudharsanam346@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 172acf135f3b..021b2ca0df9b 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -443,7 +443,6 @@ static struct spi_driver ad7816_driver = {
 	.id_table = ad7816_id,
 };
 module_spi_driver(ad7816_driver);
-
 MODULE_AUTHOR("Sonic Zhang <sonic.zhang@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7816/7/8 digital temperature sensor driver");
 MODULE_LICENSE("GPL v2");
-- 
2.53.0

