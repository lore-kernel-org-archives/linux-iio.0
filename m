Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE2237B3F2
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773504406; cv=none; b=VQUuj1GCCepo5HVvpvGuk3Nq5FQGGa+NemzyPPq9RpSVcDmOyAeRpyI6ajF4HCRsCQ4UUqYig2ItW9pY6TO+Bu+MA5tavuGEt8obhQy+aesXQqEaV7e8LjUhNGZsP7NEOt00YvhlxlHDHpmavJQn9fUra9CIy0Yw7LZ/rQYLBNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773504406; c=relaxed/simple;
	bh=ewacY4CtjcZ9Q6nfX9avDl3jskAs7cDNt4STGuQgQMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T2mPBqwENAp7fRNFXstOs+qnsfr5eqYxostJmTOi3gupDF90mU7Pl9UhQnAFr8KhuuaeVFCCnXgW7XSyUzStExbANRvo3r/YKuGeUEs36LEPWLA4xTVhxfxjCM/AgLpDkuzftD9qBocLh653fDTxtcHW5zSvppTK9uDQMJc5STo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KP/o+utc; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KP/o+utc"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b93698bb57aso604577566b.0
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 09:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773504403; x=1774109203; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nfmCl3VC8crQVQSKGIh/XriSOgp+m5SIVFUaVS68dLI=;
        b=KP/o+utcjt6WLnHR6tr6bexxj/BDDH2mWoVlJ1IQV+l+L6tSjhuWB/lme+Tnge6u4J
         GrmxuxHUEMDicLUvoEjx3ZAdookgS8XG9tTWhz17aABinRn5/AkCCXC0M0MMB+J+uXhX
         nY/9lgVjVEohSX7XrO/JPkgQIL3XvPtph1n++ixBWiKy93xayByMH6EwObGCyzs9CYjP
         EyYR3gbyue5G+dySBtxgUrfFWVsMCKFN+ktgYL+GHudFMyDqnwIFfksxiAQchX4QaOba
         IImUPm0cXiRWXRjblu/y8tNMWTyzslcLqbKD9hOEtmUIZTklXCm2ignbSPfpZ15968/d
         ibSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773504403; x=1774109203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nfmCl3VC8crQVQSKGIh/XriSOgp+m5SIVFUaVS68dLI=;
        b=ciWOFGhON0x9VdD+yS9/wkNTcJLQ0z+kzR9bOirkWdb60QD1YXx1sbxWs7WettWYYt
         uHs8xCVU2TOVXYrGAn1Rl74KNyse6dRmyWVWSzc2exVbAjoGbRGuiT5YqkiIctC/1vXF
         8j5r52w4uyrPBq1kyEvCHd659MRANAZCFd06R3BOLB4sHluAN82ebnT38Tig4Et+mOld
         GzR3wJRnoGKGxdda9XP4eqNfSF0VBNCFLGQjmFMGXVskhaHcVJzDq7XzseCSMHWVSQ+z
         N0HjJpZqW2cnOB41C4g/ScyNrK/5E61tb39VHhNA20Iw1OG+qY6hp5zTFdsw1q11DHFm
         nZ+A==
X-Gm-Message-State: AOJu0YzDZERAhCqSWfQEpbTVaILM4jLbhf7gbRN38Z6U0TAUPb7DOhu2
	pE/TmemCrZQX3gZBeeFjH7/py4Q/iZYaT7V2OdrjFLsBqSC2NMf0bpAp
X-Gm-Gg: ATEYQzwAEXPJZ9Nl+rCU2t1kOoZ59eQtAWybeyDBOhR8AMNW1fmJbA5eoUFwQIvOmpx
	9+OVMUceOL4LpfZmCEMAM3d0tBGXmDnM/KjqU2Gx/KzE0kuUJxbqFP/XzvpZo2FcENhLIyXTRRf
	w9KOEDB5zRmVb10Sj7FebH8MsnDegRwhB9oTafFqEkL2QSNMApNTviQqkG/tbwKjdEZ84f6FDXo
	JKMXKl82Jr0jnnoFaVwVj9Sc6WPdi+DMq8EVFRDm+htFfoUFHYX7NJGToVnqZJ+pFR/Twhek0b+
	wNKwBK6mS9dM8ZLtdfj3up77B3VOwqDsrZIqf/X30yjVII36ePAm/ZimkX4ghyI+3cfIkNIhM6y
	vYaKGoGIaJyngPNFL9alQODujaSPLLR0h6EJDOJfg3mDtNExaJTfXXix/oRlyHjpsykI7o7bo4Z
	7Ni2gln7ZgmSJIHNGj0ly00ahc8A==
X-Received: by 2002:a17:907:e8d:b0:b94:231f:26ca with SMTP id a640c23a62f3a-b973ffd3b49mr587744166b.20.1773504402922;
        Sat, 14 Mar 2026 09:06:42 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b978b8625d3sm151722366b.52.2026.03.14.09.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 09:06:42 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Sat, 14 Mar 2026 18:06:34 +0200
Subject: [PATCH v3 5/6] iio: light: vcnl4000: remove error messages for
 trigger and irq
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-vcnl4000-regulators-v3-5-3c4a48d30676@gmail.com>
References: <20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com>
In-Reply-To: <20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

The error code is available in the log after return. Remove duplicate
error messages to reduce noise in dmesg.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index e501db7249d7..c8bb1826b916 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -2041,11 +2041,8 @@ static int vcnl4000_probe(struct i2c_client *client)
 						      NULL,
 						      data->chip_spec->trig_buffer_func,
 						      data->chip_spec->buffer_setup_ops);
-		if (ret < 0) {
-			dev_err(&client->dev,
-				"unable to setup iio triggered buffer\n");
+		if (ret < 0)
 			return ret;
-		}
 	}
 
 	if (client->irq && data->chip_spec->irq_thread) {
@@ -2055,10 +2052,8 @@ static int vcnl4000_probe(struct i2c_client *client)
 						IRQF_ONESHOT,
 						"vcnl4000_irq",
 						indio_dev);
-		if (ret < 0) {
-			dev_err(&client->dev, "irq request failed\n");
+		if (ret < 0)
 			return ret;
-		}
 
 		ret = vcnl4010_probe_trigger(indio_dev);
 		if (ret < 0)

-- 
2.53.0

