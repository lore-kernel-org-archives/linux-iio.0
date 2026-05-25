Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD29258EE9
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 01:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673191; cv=none; b=K27+Mf0X+KF7LVyv/Gxevgt5c9moe/ltog1w4vvxY2a2YitnP4m1wVL0aFJTHdTJzvb5UKcyM5e6t20av30sdkca9kkhbBPK63f5wYLE0XMZX4tbwHOt5K7EDmNZKmUnNLdv13K31Dq1ekgXuDX7HQ2x9LeMdIO5uuDDANVnPp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673191; c=relaxed/simple;
	bh=T4Bf5vbSPVSOe3vw9rQJwnz9U9F9C23dWoMfCegfy7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OXx8rdgE5Z6txwvC7jejN7/AB91VqNfYkwJ9djGzNCzBGANOp7iBPjdx8G/XO+cCtRZ4LXLBRo0mGQI3IzntPJnb25QKTNfOY9EHvaREpp77NgH25bXtCctxZauFMxkMm6VcLi+lc0gU+8SAyZF+CIgaJseOwrUi0H0Y69ZCRNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=biqRBoP9; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="biqRBoP9"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e61f8d3cbfso766301a34.0
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 18:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779673188; x=1780277988; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYbs/MKBJVpipjYP+IfAmb04OO4GAu3z1Fjn8q1WnZM=;
        b=biqRBoP902ebCWFiRv0JnDmx06s5cSz8vno95guNnuBvpzq1IIZ3zWAlFy7OKb9bSE
         PFdEPNBJm/03SVJTkmYFaVInzBANy0LZBYefQKbvXUISyOiBz3r4eot+pYzGcyt8hNli
         K/CUqB7sA4Q4jG5mbKfFAuGBpL2M4HpCDpv7nNXbEO3BeocjqixUh/KXLHWNqXmqU3JW
         CHNzjTJ515eQksw8lUHRfjsIvq1sKk4Qv6mbsSQ8c60/SFLTIiZPU3z09hmMkpILXpxS
         se23K79I77fHPV8tVTcARYoVQkeCCZgng6vwLVU4kginxqS+3P+RIwl9vguQ8OnITYdI
         fQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779673188; x=1780277988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SYbs/MKBJVpipjYP+IfAmb04OO4GAu3z1Fjn8q1WnZM=;
        b=cfVGCBBXR52Dz8L+VT7PecfFDBBpCNpoYGikPz9ODiOYMf6R5tq0W5JqhTRv0TXs3F
         iuvyDfLiw0eAOPCi4s+7eO6oNFLVoV4aKjXe0OaH0sDUzia7qe/DPTUAFtIbJ2H7RrDV
         52lcfczHT/A/TlpO5JEikQKuQaK9E2FIMMzmJ86DhZZYVMQNu7eeirMJqNtiRoNRhyVJ
         hTX96CYOANZWgAFNMoN8RD7nu0Bva+D5q8uHNNV5yhoUM8/bqYqZVzPzBpdo0nEzX6op
         YMaGg4p9EWnP+GzEHruBTeVIcQqdye8hrLtVIE9OVbIWtGcKd+6vtajPplATX0tf0xrQ
         DqTQ==
X-Gm-Message-State: AOJu0Yx7Q/+7sXxazfWSWrld4tEx4qdRaDfnh4mrXioyyOLZebY82RQv
	faCJOmuM8k8QFGY+Sr527PBmuYRizeqv08eMk+rrFkkl8LExmt6Vo2XUH+dXSt6dZHM=
X-Gm-Gg: Acq92OFi1tgMbVmk15Vg7dX8BbHdM5b5aGXxJDo8KSZXNzqTvyYXaAx2qWSwZS1dOIH
	wX7oKiki5/E8mJkuPFc2d5pN9HqrS5158wEsw7IDqJZsxklH4TfoJtXQjfUnOqbV+GRcNKkqoBU
	g8IVCP6Y/51LWxUO5MjR7gH7LOl7+Q5i3C00s/77v9MBbAwoawxDrBP0c2GX3iUDXhXX7dnikDX
	tJ3h/KUXR8yCqfIm82tP5DbUMnzyuJkMGhZhyyY0JzDD2Z3o0u6aCeBnhEEJWgsXzX4cPjZcJm0
	GzBXLw+UBCDGBQ8jVFr9ucKyJykqEfWImMbNKdB1hmG+b9egpdYVLGuvoc+YuDB7SrPKUzoXUGp
	J8NjNKYFehSTqFCoTJ5aKc2axF1GkSIz22yFTkTC4OZvigHm58Xi5GzA4AJSVZUTYE915NutsTf
	GyxWVSZWquSjs7n4y4fwCU6/13Tjbn
X-Received: by 2002:a05:6830:3707:b0:7dc:cb67:cb57 with SMTP id 46e09a7af769-7e5fee981d4mr7582287a34.16.1779673187667;
        Sun, 24 May 2026 18:39:47 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:713b:3006:84c3:c1bb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6060b2dffsm6250206a34.0.2026.05.24.18.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 18:39:46 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 24 May 2026 20:38:34 -0500
Subject: [PATCH v2 2/9] iio: common: scmi_sensors: simplify timestamp
 channel definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-iio-timestamp-cleanup-v2-2-c37c9408b7f7@baylibre.com>
References: <20260524-iio-timestamp-cleanup-v2-0-c37c9408b7f7@baylibre.com>
In-Reply-To: <20260524-iio-timestamp-cleanup-v2-0-c37c9408b7f7@baylibre.com>
To: Jyoti Bhayana <jbhayana@google.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, chrome-platform@lists.linux.dev, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1869; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=T4Bf5vbSPVSOe3vw9rQJwnz9U9F9C23dWoMfCegfy7I=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqE6gq5kb7gqNIvRa1NfJv7HOorfQZ3sqHYlddI
 Jml3lPpMcCJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCahOoKgAKCRDCzCAB/wGP
 wNzjB/99KlgYJikZIqEx1VRYZkMM2mAJQ0if0DHyVfTAhaCsz+wJI+IQPEslFn5JAl9jhLjhmzi
 PYD3VGA6lBMGRcJSUCgM1OWVM7B7QltkL95q39cLNNpYOAVmZQx7i1YAgGsDZgyHGNZi7Ui9FbH
 7SDCW7Xyd6pJ/tgTruIR+eKKLvhkVd3GaEcUc3513TBTtXTIh5IJCAzBqKfNlH4YcvKZ7F8FYlz
 YbLeyrMG6PzwvU49sYkKLGrsU7+sg+hUQx5IcdbiTf9BDcAPq7thGaVSVGtoAdpTKnP7Q/l9ohs
 O9uFitSD/dtrvSvYhnJy7skna6h2/a4L6D9etMkFCdEGvdUM
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_CHAN_SOFT_TIMESTAMP() to define the timestamp channel instead of
manually filling in the struct iio_chan_spec fields. This makes the code
less verbose and mistake-prone.

In fact, there was an error here as the sign should be 's' instead of
'u' which is now changed to 's' by using IIO_CHAN_SOFT_TIMESTAMP().

If we find that this breaks userspace, we will have to revert this
change, but seems unlikely since the timestamp channel is well-known to
be a signed 64-bit integer globally.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 5136ad9ada04..442b40ef27cf 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -419,17 +419,6 @@ static const struct iio_chan_spec_ext_info scmi_iio_ext_info[] = {
 	{ }
 };
 
-static void scmi_iio_set_timestamp_channel(struct iio_chan_spec *iio_chan,
-					   int scan_index)
-{
-	iio_chan->type = IIO_TIMESTAMP;
-	iio_chan->channel = -1;
-	iio_chan->scan_index = scan_index;
-	iio_chan->scan_type.sign = 'u';
-	iio_chan->scan_type.realbits = 64;
-	iio_chan->scan_type.storagebits = 64;
-}
-
 static void scmi_iio_set_data_channel(struct iio_chan_spec *iio_chan,
 				      enum iio_chan_type type,
 				      enum iio_modifier mod, int scan_index)
@@ -629,7 +618,7 @@ scmi_alloc_iiodev(struct scmi_device *sdev,
 					 "Error in registering sensor update notifier for sensor %s\n",
 					 sensor->sensor_info->name);
 
-	scmi_iio_set_timestamp_channel(&iio_channels[i], i);
+	iio_channels[i] = IIO_CHAN_SOFT_TIMESTAMP(i);
 	iiodev->channels = iio_channels;
 	return iiodev;
 }

-- 
2.43.0

