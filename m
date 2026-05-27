Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF8143DA21
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900248; cv=none; b=k2IMVrwNt/nd4qROqHbCUrEHt2jiJcJfiMCAct/BJd+vjkSRDOgs0J4QJHULlTZJK8P0oJ7kP/7bBuUOok/S+rVYCGNiCxXAHLJ8Tqtpvdia4ij9Djua/PFz9x/JMnx1VnyJo090Od3YLcSXcemxaW4BMs8st+86Yv2WzMPssiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900248; c=relaxed/simple;
	bh=4Tqn/sNiW9FgKMQ9gfczU/qnWAXc3GR+L0EvrAQl8vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3BrPddsU38iDiCrSUkhOPjXiZM5wOrds8yWmpFPCCcbSwn9AcMTPV1+a9p+GNc3uvDY4L7QNysQc5pQQWzEHnRINu2L0OQIr8zvY5/aYSZXchcXcFEpkzuZr/bRk+tilPvMXZftXOu5uwR6JOBRxMkgv+cJyxUsxTx8IJTLZTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtIulyWA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtIulyWA"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4903d5c67bfso34250515e9.1
        for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 09:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779900245; x=1780505045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgDW+AwxdA9JCOT4P6klCmPb9/PGB94Oq0rtd2pQcYA=;
        b=JtIulyWA33Zor5eeQLmT66BIlJFm7VtqU046zan+My2GbQsE7ZuFIxP/Fj2VRGYEH/
         TO7onKzgLdRJTS+WhaZuzo2z0uRgRTuMeglPP6abS2lctv67M2k6AvJUfW5MJw3O4Jng
         uxd0knMNxGpFnkMNRRMZwDxqd2f5gW9btOP8UlA7pohvqsCkNnUc1cN7kn/pbq/N8wqP
         49aNqwzABgEPmYk6UUKiBaJajKGRkzc7vvbL6yMpWaeQ1LvBis5bMkSO/Zh8De06M0Ue
         8oAWZOVo/g0o80RKrHcwncEIokCWJ41HSNZa+zX41yT17jwzHoVODUf8HNe7Fmpol61m
         7tKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779900245; x=1780505045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hgDW+AwxdA9JCOT4P6klCmPb9/PGB94Oq0rtd2pQcYA=;
        b=N/STBsPhgiRetoi1bNxGq2GiGQWLMgFd8cPJG6zxObxAqbBnBINvIk/AccLXAC63uG
         I5vu9DnPzlXuORFLJJxwNp32SIIAn+Ve/a+grNn+JdTZZaB8d7PrNGRPrPdCy3/M2LQH
         nLdww+9ZmBvEX6NByO9mNCzctXhqgJDNn5YtUWq+VD0fPBhkCh8Nb9kO+Y9aDU5ye1yj
         DVSUObyqW7oMxCgkKUAUgmQKjcm5gUbem/ZFmwrVT9vC+eFw87YF6AeqwAWhj1ju5/vC
         JRZxB5cwgoJNY7wgEx1A7Dyr04o2s1DevATslDsBRJQISL8h9hF49AObsZ+ibdrn7BVv
         1eNg==
X-Gm-Message-State: AOJu0Yw64MgqYzwE5AmBQbMcTzGCL9wuch9Mcvz5lqy20yiT824QYvq8
	jvndMizAexXb7vXT+DzjLw8NGwlw4Dotywnt5+ijsIaBVVtichM57pRgfCfDrh0z
X-Gm-Gg: Acq92OHW0L5jV9p9A2H1D2swplqXFW5MHidlV+HI0+Gu2TjBGLk35nlGS8gEpazsGUH
	aruQPB+iIcCT6krymN9f54KWyoXPwXvG/s4IuuwQjOfiz2GMcIyZ6W3PeSdTm4Tg87hoTEfv5Kd
	AwaZ0v45CcjiuAcPuQVzYyA56hDxbmx17O+x09hndp2NxHJ7xdUVUACqvdCCltyYxYezY/RZ4fF
	tuJBsUXEOnl27bco4VWOeoeBA0YNBAv6llpGbFu3QkaMqOZSuYa1x8Gkf2kf4ca/jbNEK//6R4x
	bMhKCZvTMP3yGhu2KJ9cL1XefVkAyo4NJn5ACobo3c1CUQiXgiB8uA4XP8sn9mcccVUa9mYq7Su
	7MiIAIApKb6qXnCs692NFsTPQH9YfQ/pAylwanyukGqg4zgcrSNszDVp8CsvHj7CWZG7nrGLFBU
	uX3tRP9U2XaasJ58MA97cCi6qVS1QbkIrOtduNB2pQ4VLNxQizaSB++Xgb
X-Received: by 2002:a05:600d:840c:20b0:490:41b6:4d87 with SMTP id 5b1f17b1804b1-4904248b0b8mr299876125e9.4.1779900245429;
        Wed, 27 May 2026 09:44:05 -0700 (PDT)
Received: from MSI-LINUX.kielce.vectranet.pl ([2a02:2a40:27ec:2900:f829:aa3:9ba8:c8c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454c5eb0sm436435435e9.2.2026.05.27.09.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 09:44:05 -0700 (PDT)
From: Jakub Szczudlo <jakubszczudlo40@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>
Subject: [PATCH 4/4] update adc MakeFile with ads1110
Date: Wed, 27 May 2026 18:43:12 +0200
Message-ID: <20260527164312.355729-4-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260527164312.355729-1-jakubszczudlo40@gmail.com>
References: <20260527164312.355729-1-jakubszczudlo40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
---
 drivers/iio/adc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 097357d146ba..688feae92727 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -151,6 +151,7 @@ obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
 obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
 obj-$(CONFIG_TI_ADS1018) += ti-ads1018.o
 obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
+obj-$(CONFIG_TI_ADS1110) += ti-ads1110.o
 obj-$(CONFIG_TI_ADS1119) += ti-ads1119.o
 obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
 obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
-- 
2.47.3

