Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4123A453D
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776810179; cv=none; b=Q2geBYXS631XOxkzusCrM245m/gVaNZQ2gdcL9pX6Ojr5vE0wgIoVDHbqd1CojdlZRE7j2d5lPM/y2131FuN58kcDTgaHAEFnIaC+wENE4mxhqqeQ+d60fw1/6OVZw8ebKEtQwjrTEUykO4kP5bg+lvxBdn2SCWwFY7TKQrCAjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776810179; c=relaxed/simple;
	bh=zoDXe/amBCbF67yguHQAyDyiMJmjso9zdJd07aRn2Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ClBAMjiafAWWJdSyjO0Qw8t5F499nl3KXALZ5wulQRgINX8yGGGCzCTCD5bZBix9wF1p1LNsNpssVvxMmi3PsO/4MwXpktHFrG9rsKKzN6qnf+0APHOF9r/RD/zvaLlweuT9phR3cVQDbpyVk9nAYwbFYkkTyP92alqleXoi4B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=t2z9n6hb; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="t2z9n6hb"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c45281a06so6436291c88.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 15:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776810176; x=1777414976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9lbi8e6VwOVyX64bxJDCkDYKiTEVA9LxEP2x8IkxrA=;
        b=t2z9n6hbeeXf5vMWRaIwX1nFLJzpgbwGmS1/TxofiOGJGWKQCXM9NdCn4lGd6m2AWS
         6mURXrDZuDJmxXlEXLq6VC+XTT59ILelIjMQODhkfAUll23UETzUYcc7wRAEg4hy4SeO
         ZjbQwX+0R73oh7glIogh1c9jaOMKUR1MZpgUwb+902JwDV/N9+Q/Ok5um+HbxSAWv714
         g7bQVv3INANKMPrUCftSxfzq0cwo0eqhmF3fzRrCYbaGlDazoUt+LRYtctybIpuzLZHz
         ocoJF4SbiBwI1vGtedQTt2dbXWXKC63vjFDaofPGSDLpqBRTcabgmeMW16biMzUS3e0w
         Z/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776810176; x=1777414976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w9lbi8e6VwOVyX64bxJDCkDYKiTEVA9LxEP2x8IkxrA=;
        b=InZZS8HLpPpv5SgClF8heH9zSY9Oiw9ld13kioxQ4OUbhsn1dldPc4N/buNHF2woZa
         d/WhswU0NTuUD9DNw7QU3EY6DLVAhliYZphhYmWbdTvBlx9/+4RrR3ipijXKSFaz7Ac4
         xG2hUlgDwyJksOTl9uY8COr91WLXHhUtc7U6q9lGM0KGlMU39twbpHTnxpNyRD7MUT5b
         uYNjmTnS77dY46//kfIT09aAp9wpw053y7zgXRiwVtbY/R3KIOKIAa9wKCmEdi5PZhps
         Xzpcfw8c+J9jBRJRFzkreAAIt5hnGadoSNfoS1GswzSGM+RB2grbVMkG6LBGFuVMq1NT
         XvBw==
X-Forwarded-Encrypted: i=1; AFNElJ9aBsne/vEYemPplXrWl2aNguW7wDqNRkzB8eNJmQr2pEs0ee+F1CCZhVusQpVy7Ennfg3jxHaNhRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIIprGIsD1La3wGjctY4rrYYwgHk6o+dtkjgpsK8zrl8aljc4I
	pL1jfDbyjvR3iNhcIlIGOvs0MPkNIpf+QPD+Alb+aS0uMOGdjF7BsboQdO5pNtemCiw=
X-Gm-Gg: AeBDiesJ8m0iFGTc7EsACcfjVTvuQYDOeN5IqhQNTedNJqZ2IhIKFZJnxmGU6JX1vKN
	TeZ2czo8q7474lfvebV8UI4mAJLdn4a6HmFgPvObArS5yQNYN8LquR/gIWGTXSZYuQofAN5zk+n
	/kFeeAgdc2gCp8iTBoBqb+MFbN/j3KKwk+KIJU565jOWpOIToWDJToJj3BBSV5JtuBc+UdRtJXb
	MW3rCoJVaUyzH6hUuuRcW18lEcQUka9ig0XXMfRx2HJKTVYs/hqimOtmEBKnUwNBuGrhkUxmzYY
	XdUsWTcC9cQXTvNJ+sgOaho36ns9meqJOR2zuHDmsF5pxdWAAeZ9B5dimq2fryKdKWzNn7H/WmZ
	lJ8jrJMu8QUOJ0YmaGpKkhryZwM2kY/l/ApX2BWc7r6ENrx8/fu1l2Tlp3v5zP6bW2mFlry6c2X
	EOCmCq8pAfPxQRIggvKrvBK7w5HmCQZ8cZkHcDmg==
X-Received: by 2002:a05:7022:1282:b0:11b:e21e:5653 with SMTP id a92af1059eb24-12c73f995b5mr9246680c88.19.1776810176494;
        Tue, 21 Apr 2026 15:22:56 -0700 (PDT)
Received: from natalia-pc ([187.116.73.68])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c831d5b29sm20129785c88.8.2026.04.21.15.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:22:56 -0700 (PDT)
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
Subject: [PATCH v2 5/7] iio: light: HID: Replace method prox_adjust_channel_bit_mask()
Date: Tue, 21 Apr 2026 19:20:37 -0300
Message-ID: <20260421222210.16016-6-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260421222210.16016-1-natalia.andre@ime.usp.br>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace method prox_adjust_channel_bit_mask()
with helper method hid_sensor_adjust_channel_bit_mask().

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/light/hid-sensor-prox.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index efa904a70d0e..edf76af76dfd 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -67,17 +67,6 @@ static const struct iio_chan_spec prox_channels[] = {
 	PROX_CHANNEL(false, 0),
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void prox_adjust_channel_bit_mask(struct iio_chan_spec *channels,
-					int channel, int size)
-{
-	channels[channel].scan_type.sign = 's';
-	/* Real storage bits will change based on the report desc. */
-	channels[channel].scan_type.realbits = size * 8;
-	/* Maximum size of a sample to capture is u32 */
-	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
-}
-
 /* Channel read_raw handler */
 static int prox_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -250,8 +239,8 @@ static int prox_parse_report(struct platform_device *pdev,
 		st->scan_mask[0] |= BIT(index);
 		channels[index] = prox_channels[i];
 		channels[index].scan_index = index;
-		prox_adjust_channel_bit_mask(channels, index,
-					     st->prox_attr[index].size);
+		hid_sensor_adjust_channel_bit_mask(channels, index,
+			st->prox_attr[index].size);
 		dev_dbg(&pdev->dev, "prox %x:%x\n", st->prox_attr[index].index,
 			st->prox_attr[index].report_id);
 		st->scale_precision[index] =
-- 
2.51.0

