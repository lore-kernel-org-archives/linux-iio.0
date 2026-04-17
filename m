Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610021F4C8E
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 23:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467131; cv=none; b=nmFjo+3Pyh2f6QbWPcR3rsKZ73uStY9rXx83Elrkq4mZ0g53PN6OFasXgnQnghA3suurzQpPe2ib5zwmRaxmFYA2dzaL1lSddFSsvdNbSd4y/ETFQV1AnZ3Rnvkxovs+D/mmYdnACJsNzKdPk1CqceyAAG5NZgAczTYbI06B1xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467131; c=relaxed/simple;
	bh=iX5givvJohunuo90nWnSO3CuZJtWwNASYluWMY99CkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6CrYbN+BFHoGhj2EzPN0oho3dpe5WFsxd7BewBcp2A6BDXxFSpS3MZBaFCJpdg4ISdmZQbiaj+rkNwNAfqMq+GbxO8Ir/E3GG4CrvDrHZW+IPbj7XFuEuTbmUj1MATbiI1BrRaWXldrVmhW9mThBRxylgX3ljoYf5foD5OHskM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=iDmbcZgo; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="iDmbcZgo"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2d891442388so630084eec.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 16:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776467129; x=1777071929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9INa+gUw35p+Kh0eF5J3VjsuQ4XMQZZUDflfybyYx4=;
        b=iDmbcZgo23PosfWrko2F9gc4c93zTwOaXERQlgd+iCB4odBj0cwAmtYim4ihxta2jq
         jyGIFhAcJDaQ7eVTWpwvEtb8NPBAmkMi/xzw+6/loJvJS1BwFYJuT5yAQ4eZTaC4NYcr
         j+Br1N3lhkLVUC1YZ3NjIznX/WP2BvQOZkYedLMatubYHmwLw06vVOJKetFvuNYtiu19
         rOntK3GLaDv9tztiL5DriBa3EpG1oNI5JuxHAmAhaIItn/pAR9JsZ1F13KiQ+1RfxOxn
         0xDeyI0AQ/jMXkYWM05ThDRslE/XEfV9nqYfbmPjwH/8yHxYl5aAOio2Zezrx0YYW9Cf
         zkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776467129; x=1777071929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u9INa+gUw35p+Kh0eF5J3VjsuQ4XMQZZUDflfybyYx4=;
        b=QdjRkP+Z+FwEimWaR/5PhqxbML5qRMLokf0lQQ9OCOMkKoUAXsbFdi5HxV34F2s62x
         8ABNeY4bQQCRj3eenGYUcQGT/Myh/4scEkpLVR09kpB/IyzwokrDujJ/UJyvr1IBiCE1
         soGjUQZPjZPLAI9pzWKUIrSY+XOkwdDQeOwEaHrwD3yq+S5M/AiXrYbbwNC145CAJDCj
         +veC2RAoz+9bNPUHjfuaeXta3BSEmS4fNHryemvmclAXdcgBDr/DqsAqAaNrznkzsdjv
         u6OytYB8iGJDRZnhDl2NgGSE6EBIgvWKGNfTH9iUsY0Ui/fqXaEF4jJr5NdO7t602/Xl
         3uYg==
X-Forwarded-Encrypted: i=1; AFNElJ+3ZQQaJY18hUpgnyTEnDQ0IpEB9u1k1mDnnG/aSNq+LOo1dwqC26H84fSBK4NgUmRFR7OTpEohWWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV1XIdiTt1KI0EHkaC/bEX6sIUfI3VqscxxtTXNF9IarANF/Fc
	4u810cqP2j8LLJYzTbBbEWoUeitss+dAE+UMRNfCkiHr7tD2gHjys0KjGEVMVctYQFs=
X-Gm-Gg: AeBDievoNPO6HnoMrgVJPC1eJ6iESrAB4VYC0jK//9wgI5nZsJ103wxt2FjVWU4ZrJS
	YWpqcSmoQKBztmkIrsePj2viqTSjS/2cGZkHcw7oyPY828GpE4EzUh7J7A73jtv8X+7E3D/qjK3
	tRG2J5OzY5kSDQIK6aK0fv0UNIX4sc8jTdlqvIe20HICBBVDJDs5DVpPzlTsinvy2HJ7MiuLzyZ
	Rniyk4TBJB36R3YutKtNG362aK2nZqjKN+OFz3VJEo6RZFYvfJRs3Iie/8c+EYvjSLsxUnaPBzB
	VbMsh3/9klZSAlQ9VMvo5BV88uBLnFz76hG4DPW5Lw9FPxm80LP7xIEAFi5Ec4ZFPS7cLzP35W1
	Hedt5rMOo1+dxMUImHB4aDPA78NlVNJbKXp/3znrrAyX86dp560AInbOZYGrL69xJq3CZercSaR
	TSa0kUF70PrXmh+hJjYX865fkLFnARdUgzDc8u/A==
X-Received: by 2002:a05:7301:4185:b0:2c5:60d0:701e with SMTP id 5a478bee46e88-2e464ea8930mr2481465eec.3.1776467129410;
        Fri, 17 Apr 2026 16:05:29 -0700 (PDT)
Received: from natalia-pc ([187.116.73.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce440sm4117637eec.14.2026.04.17.16.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 16:05:29 -0700 (PDT)
From: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>
To: andy@kernel.org,
	bentiss@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jikos@kernel.org,
	nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com
Cc: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH 3/7] iio: gyro: HID: Replace method gyro_3d_adjust_channel_bit_mask()
Date: Fri, 17 Apr 2026 19:58:46 -0300
Message-ID: <20260417225959.16688-4-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417225959.16688-1-natalia.andre@ime.usp.br>
References: <20260417225959.16688-1-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace method gyro_3d_adjust_channel_bit_mask()
with helper method hid_sensor_adjust_channel_bit_mask().

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index c340cc899a7c..15704e05ad32 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -82,17 +82,6 @@ static const struct iio_chan_spec gyro_3d_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void gyro_3d_adjust_channel_bit_mask(struct iio_chan_spec *channels,
-						int channel, int size)
-{
-	channels[channel].scan_type.sign = 's';
-	/* Real storage bits will change based on the report desc. */
-	channels[channel].scan_type.realbits = size * 8;
-	/* Maximum size of a sample to capture is u32 */
-	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
-}
-
 /* Channel read_raw handler */
 static int gyro_3d_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -258,7 +247,7 @@ static int gyro_3d_parse_report(struct platform_device *pdev,
 				&st->gyro[CHANNEL_SCAN_INDEX_X + i]);
 		if (ret < 0)
 			break;
-		gyro_3d_adjust_channel_bit_mask(channels,
+		hid_sensor_adjust_channel_bit_mask(channels,
 				CHANNEL_SCAN_INDEX_X + i,
 				st->gyro[CHANNEL_SCAN_INDEX_X + i].size);
 	}
-- 
2.51.0

