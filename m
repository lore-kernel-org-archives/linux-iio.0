Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8331E3DDAE2
	for <linux-iio@vger.kernel.org>; Sat,  5 Sep 2026 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601086; cv=none; b=YtIzsYAjYfyksCSCzN9K+77fHW2VgKg4LwJijvWP199oSbXFmrgzREyJfMpD/5IS4fmaWWv9Dwx5L/lAfzVR0bHwkoxTsOHu5YM3D+dwH1Mr4v/xW+c8lLszhrlWzQWM8cVk0Ne0rBXeNKN2S1XUCusapUyhsEkM7D57bEJKvWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601086; c=relaxed/simple;
	bh=vUdNV9wDoEuZJ8Vepu5sM2pMfaScmqCwYv/P2v1M6tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1QcfaZ/ZmSJMBwVBGPxen6O1FkfLBqEwY6nhQ/doR1wHMAuUlQ7iO3IU1gtPnthGAMYOh6LgrQa5ryXpcQAvLftyJqIlEI+HLCV4I1h5+70iHPGqkNIh+OLC47X8Fn+ohyUx9oYxufV1GOZbB83RzQqYJ+j4ndB7Tx2WCOeYdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyYOzbws; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyYOzbws"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3965d3d9ab8so1325022a91.3
        for <linux-iio@vger.kernel.org>; Sat, 05 Sep 2026 02:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601081; x=1789205881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8D/ScigX6w0Ntks8tt1Z8HJ/HOkWf3QCL1/JDcSPE1w=;
        b=UyYOzbwsGSCaUmxfD5zxhg9iyyKaMmoJ9mfMd2TwhtmnPurq/IifM9OVZRkS08d5gp
         X0pAc+c8mS2X35TW+bcEFlMQ7NOhqJVMzMotzvSrvMuJJY0oiredyG0Rt52Sb2SoWNM4
         3d9j0JEnUaGby+ebPsV9sC4mNX2066ftwhWpRIjxYehQsQ0EiUwoIA5WMCg+6Azf0vhm
         jIWpRk9Oe6Og/aZCpVAgqWKT/LDXhfEd836ngZgPYeeBpiO24rpOI+Er8ck1FanZqal7
         sMe+jTDtJLSSblA95ySWPR5PRPwG4wXi4n0dyZX0P5BW628JHv4DsjoHAiLfNW8plXI3
         RZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601081; x=1789205881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8D/ScigX6w0Ntks8tt1Z8HJ/HOkWf3QCL1/JDcSPE1w=;
        b=GQ+He9xH4BS4D12k5q+G6a/8yNuIWAIUJKOc7SNKbWHsnSXYm/bEfdmzjH8icSIhUR
         OWR5vT0mjC4/DqZJ7FhIk/Wz/pcywy2H9zjielKU97KYhxgm5XxF+4VxcLkyUOT1BKUz
         ONQwo5uRAAx0LkTL46Pnt6P6x6Ikc8XG3S7VAFlllq/gVoMJlns86kPG9icwnCh9Pg4/
         /i21mFAlUxFa4f5Fe5NbsTN9+zfElnOAT1KEUcXv1VAAYx9M93vvcU4pPQMMjacNXpDU
         +HQ5Xj/NNyDUF0Q19kC3QvEbF9v3kazG98uEziDMrGDnpO41VV22ngWKpLamjHAzGkRr
         AEbQ==
X-Forwarded-Encrypted: i=1; AKwUvBynnJ6M5GOLL/guEq4BYrcIj74znkm9yIR8C5s8GZcNPhZWwxVE+Re0YCi3NKmc7epyQcmKenoh3Wc=@vger.kernel.org
X-Gm-Message-State: AFuF++nLFV9K7LkxQgoMJpQHQg4e256MnfIG0PMDQs29A2f4mhCpVdBY
	F+0AM8+b8lFP4MS7MWB4Ci4u+p0Wu3nD2ZIa4TbxmiPb9YHSl40zMyub
X-Gm-Gg: AYBFou399d4WyQ3IxKMzpwJzVygoBFbzILFRzIOQ89MWZ/DjAw6fsyejZcyaPD3x7Mj
	16ivzK3AjLFm/Ag6c1YdbE73PtXwaVaWzg8wGFp71TbTT7o3AC1X+fL/V3R9U+il3udbiSTAejD
	5hDwYBle8W+SSnJ5yadZfkauh3KtrFLnNYX+9mENq43jb0TFktzMmXlWL1pCJQj01yC7htXnkg/
	TgsbTk93eItSC+JkJBtaMjRRNHQUAja/6DhVbZB7POrAeJ2CsLoxX4ZcPRLnIb04996oxjNXXfr
	Iy/lG2SkjpJeBv3nAwQ0mJTBSG4Aly4zFU+DFnwgPJ03V56gOuCT8nZTkH7No2ECie+1IqFR/QO
	gM1/eURKWLpKqVnploi1SV3nZLHh6e2rtthfL821KIEMppMnVCZBKY8+qbUEzh359HzL3QX0bfu
	WITuFmMokW8cZCIv4j2YLPB7n50QeH8+HtIaUjxFCzeURWOLl2VkPxyIhPMQ==
X-Received: by 2002:a17:90b:3b8d:b0:398:b426:ca4b with SMTP id 98e67ed59e1d1-39b2624f10amr16533121a91.22.1788601080936;
        Sat, 05 Sep 2026 02:38:00 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:5b5:60e7:9f67:1689])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08d086adsm15763353a91.15.2026.09.05.02.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 02:38:00 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v3 5/6] iio: adc: bcm_iproc_adc: use devm-managed mutex initialization
Date: Sat,  5 Sep 2026 15:06:30 +0530
Message-ID: <20260905093631.48667-6-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905093631.48667-1-mdshahid03@gmail.com>
References: <20260905093631.48667-1-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Use devm_mutex_init() to tie the mutex lifetime to the device and
improve debugging when CONFIG_DEBUG_MUTEXES is enabled.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 24fb41751e93..f4676607682b 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -526,7 +526,9 @@ static int iproc_adc_probe(struct platform_device *pdev)
 	adc_priv = iio_priv(indio_dev);
 	platform_set_drvdata(pdev, indio_dev);
 
-	mutex_init(&adc_priv->mutex);
+	ret = devm_mutex_init(dev, &adc_priv->mutex);
+	if (ret)
+		return ret;
 
 	init_completion(&adc_priv->completion);
 
-- 
2.43.0

