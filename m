Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585904;
	b=VYXSl3RRr0e6aMP54IWrvvJjoLhtvhC/9wobpX3qVqXvVZoDYhYrwtWlAKdGg5Pzk5bX
	 EaqvGtzrJ+WmQjvvqkeCYpg/3+bFsrMTqO6vk++fteAwVszq/JOhDtNPTr0g0oimya6v0
	 YjHehq2/g0+LlXTDH3LYIA49pPq+StdqR1advgI6fueNphe2MxHymHFjB50725Bre/gKM
	 8X81YptmgAq84zMdING02l45QAI1mVPrUq/FO9u8MyP/ifhAmWs7egKQ68EEMVTmdSX51
	 bzJl7VsnhPpwo2peMWuyIhTF46biRcl7L4L6NHrej21XoTPRn5CuCZRmT6ssFOfwbyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=+UifFPON+SyGnU8x0yf9mTT7ZmSVe1u+d9xf4h1Cr9Q=;
	b=hQ729dGbAt5fIljtIoCGzIsQbDGxdg+5MWGZKzw4juvTUb9aqA6tPwGuIzYC6phUwuhP
	 p2yMq4M1zByjTHetX7zeyD8dGfMKSvr1RUQvrySrtIDYlpKptZKYTzc564SaIQcYJLVRi
	 rbfbGvzGMmy25C6D/wdXzfMHY5DpaNvAzPp4igpy4qRNf6YFOcQCw1TwSaZzROsFpOTwi
	 K3cymNPjsQT01hpJ7hCKWagnjUFdkyaSuVzeki59zbC1OWsNsi0fG/BaRJaycvpt0tCIY
	 fVHpg4HZcznHje0kONYqaf4h6OZ+OPv107/c0X4Ose59NQPqctRMkZhhlmJVMePcXpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=SnY1vHvE;
	arc=none smtp.remote-ip=74.125.228.70
Received: from mail-ed2-f6.google.com (mail-ed2-f6.google.com [74.125.228.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CE560A6F7F
	for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 16:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12CE560A6F7F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=SnY1vHvE
Received: by mail-ed2-f6.google.com with SMTP id 4fb4d7f45d1cf-6a406d7afa8so586604a12.0
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 08:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794585901; x=1795190701; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+UifFPON+SyGnU8x0yf9mTT7ZmSVe1u+d9xf4h1Cr9Q=;
        b=SnY1vHvEfcW6Q4y8RsJAwDs/Y8ufORxk6twFczLisoiULOb0AZE24YPQgyboSKWPu7
         L8pEa+uH195Syj4b9pp4nt1crwVpBWQZSv3SiwZO/Fzf4BvoBnXolA72LASPCc0qy3X1
         onAMlxw42dat9fKRXcF233oKAjIsJVwwerjBZhQ7arj8yNzORIXgy4omOP6nUCBJsrKF
         vj0xEq6b3zXoqKuKPtgYoUXbhKNAj2u58whda6+AFCZ0zIT4JdcAMq8nMRyMa16JAVGR
         sLhZuEietmaTstOwStfsJJ+JeV/FdXGXoHcpaaHO3iRu91vcIk7BEZ8RVdX7kUNQB5wL
         Xk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585901; x=1795190701;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+UifFPON+SyGnU8x0yf9mTT7ZmSVe1u+d9xf4h1Cr9Q=;
        b=kWRBZcLzM9NqBUVXgJlbThNX9oYdztGOQyBa0jIfLPXWacaVKqhavXHmKDAy5f67O2
         79553HnEUdJF2qbwQBQft8khS2U8uHaT1gfDVQUYG8vnh34oqtE3hnG2WOOwiasSsow3
         AA0FK4/UJprggwC1QkM7DMPFclwfDBlmAFD0VW9hpsMmu0rt3FaHcED6IKOQ5fhePZQ8
         bS5rQmkAeKTUlpbPtwFzxtXAvKK6F0xqX6tYYQWNsTFfN+s2VXKlUaeNSnS6A/tq8SoK
         S6gio/4f8Pex+gU5gX0/GaStqxLOkL8pOuWJE5E5Bg2j5tU2eAYS94ZM9j70Ob84nRki
         Egqw==
X-Forwarded-Encrypted: i=1; AL+hErELOVubiDIYBbTxBosCxk1GJ9HGz5yooEyCINWKCSPBMt+ckgc/J9+HNGmRrdOZIWohaiVxjIWJNOQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+spGdThy4hVXfX7iajlshzF66S79vqgNUn0rEUevMspJmAjbtu
	0CDmgmheFoiR5FOfs6GqBfNN1u3TTfuJkFPMEHT7FOYRkM2n58LjK1vEDz7dGZpA5Qg=
X-Gm-Gg: AYBFou0unninNsHDGje6Fva0PFqxlgQvqPuMZa0YEKFh4cBEaCddKqCm/WjHAtfoddW
	h7ALZ+DtKiN4bv4dEFMq7YwsdKe6oD63PKqSfxrePkdpJe3bsqPjChxD27BIoteS734US8HPRtu
	cpURWCGXqslRUUHDpUjEI2zJ2h6IcxHwd7lkUaIKcL93RE7u0lFhEZUxh5+s9rCTzHXAQUEEqBm
	M7G4a3XbKVawDl+hdYqDCVAlDv7NfOwXld5gdMyICxtzdAUEGxHiDYwuwOC4QNCg8gIOa5qPgUM
	Jbyf/oKMxTVEPkddY9JoZuJUVl52wyXZ1l88l7oRWjvjdInqabDvGTpFdUwb+iLqE6pXIaALlDv
	9wiVE+Iq2DmRwacymaE8cR3WSkt3rz0zAuWjQyMLZXSQiJfPJertJoBabXEP2VGD84OnsUcfVku
	urVALaq8+6bnPiEqY2z0KpleAg3EL2oYk/XRhzBjimnl3FIa0hRSUhR9ot1ZdBazBStE38f9DSP
	+IK8IKMEy8eVYk2dQaNolLRHZ2JzwnMYDW8nDHIOYIG//NiiPwKJq3cQP2EvMKiz6njIhm36+eW
	qXpWGDu5xLP9Xeecr0gGxBYv6qJfzOiniM7dMuKalgMQaWqc2hWrx3C4kZv6XHD9FWeseQqW9qJ
	Q9zrSFIU=
X-Received: by 2002:a05:6402:2348:b0:6b7:b626:3047 with SMTP id 4fb4d7f45d1cf-6b7c0c6d5bemr2614461a12.22.1794585901476;
        Fri, 13 Nov 2026 08:05:01 -0800 (PST)
Received: from [172.16.240.104] (144-178-202-142.static.ef-service.nl. [144.178.202.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c264d99csm1123946a12.36.2026.11.13.08.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:05:01 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 13 Nov 2026 16:56:44 +0100
Subject: [PATCH v3 3/5] thermal/drivers/generic-adc: Allow probe without TZ
 registration
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-bat-temp-adc-v3-3-743979a8fd90@fairphone.com>
References: <20261113-bat-temp-adc-v3-0-743979a8fd90@fairphone.com>
In-Reply-To: <20261113-bat-temp-adc-v3-0-743979a8fd90@fairphone.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Val Packett <val@packett.cool>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794585895; l=1961;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=dKIR7SEd80N/+qwSyOrsBe2GJeTCbwmGB4u3yhxKz60=;
 b=W6M5dRaAMjUDhpYShHtsozwZdwnqCFAQirhB1YkYhJl2/l4HagKS8AChyehoYTB4jc4qoyEPI
 U4dOEZleS6PDzlU3Zg6O6xRR8Td/f3BeutmmgBZtMcd5Dsg3cJCzvp3
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

If the devicetree node is not referenced in a zone under /thermal-zones,
devm_thermal_of_zone_register() will fail with -ENODEV.

Since the driver is now also registering as an IIO device[0], allow the
probe to continue without the thermal zone.

We also can't use gadc_thermal_get_temp() anymore because we haven't
necessarily initialized tz_dev.

Link: https://git.kernel.org/torvalds/c/3762f5851ac5 [0]
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/thermal/thermal-generic-adc.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index c6a7a65aa6a6..40a34e97a515 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -86,14 +86,16 @@ static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
 				 int *val, int *val2, long mask)
 {
 	struct gadc_thermal_info *gtinfo = iio_priv(indio_dev);
+	int iio_val;
 	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
-		ret = gadc_thermal_get_temp(gtinfo->tz_dev, val);
-		if (ret)
+		ret = iio_read_channel_processed(gtinfo->channel, &iio_val);
+		if (ret < 0)
 			return ret;
 
+		*val = gadc_thermal_adc_to_temp(gtinfo, iio_val);
 		return IIO_VAL_INT;
 
 	default:
@@ -195,14 +197,14 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 						    &gadc_thermal_ops);
 	if (IS_ERR(gti->tz_dev)) {
 		ret = PTR_ERR(gti->tz_dev);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev,
-				"Thermal zone sensor register failed: %d\n",
-				ret);
-		return ret;
-	}
+		if (ret != -ENODEV)
+			return ret;
 
-	devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
+		dev_info(dev, "Thermal zone sensor register failed: %d\n",
+			 ret);
+	} else {
+		devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
+	}
 
 	return gadc_iio_register(&pdev->dev, gti);
 }

-- 
2.56.1

