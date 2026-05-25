Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0913E63AF
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779706351; cv=none; b=WPcVef8+wYux5LvlVc4OnvszK/g/lWIP3nyCaoTokqWvKBw5++ypAhcTFlDLSIgD4FJtaBcMwTaFMa7AT2RYRFw1p5LHlX/xbSXBAeKwIm4iP2hkIj2R4FjeeO68avmTD9CdT5BLWAQtUq7SdWtj2xCM046CUvbaIfRC/MIyyx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779706351; c=relaxed/simple;
	bh=3FrcsQlVziUdeKI/N9eYaCs4RJmRsrcZLsIz3cZSFq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIUpKl/O133dd0brWGk/rlEtKpMNinHp43X55ZNJbZzwa5cRR3vffZ2DkiNXuT9twg6ivc5eEmkOHia0SgwjxY1AOsGM+S0fp+W+FccICuRpHlA61JcYXFa6BjlD6ARfQxWPH3LG7bUM4yoI5RoaxdqI+Mv+cyXE7egjLEbJtXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZtk8YJI; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZtk8YJI"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-366be8040a9so4021308a91.3
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 03:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779706348; x=1780311148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uk0PkavUtmrtR763X7Xl8KGOaAn01gQsV9JDZDG7T1A=;
        b=dZtk8YJIakMNipqUj/t5VM0UmqEioiPb7T2UipJtFDoWhi4qCo56fwFT2KsuV5PZjb
         k8aSFdt6dwFKw3IReX3g2yzvHufrQTQR+AWNiiqKvPX10vU0zGg+gJFpondnj+q7e2BK
         nM99xoOaui8jmirBTZOHXxna4aA8NIuWa75LUJ3iFuIW/2mu9D/BHE74ndl/bBcN4ajE
         OHVNerqehTF+KgMbTKtcPjOs0SgQKyRSTHFNoB+X9AdC8mOI4WzYVHcj1xrYzpQ8i/sI
         wGKEafYgnMumxyj3cBuAZu/ZxYi87OxevNP8atoijn5gEYP+PT8QAkzbNUccN9ZVVsn6
         H7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779706348; x=1780311148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uk0PkavUtmrtR763X7Xl8KGOaAn01gQsV9JDZDG7T1A=;
        b=ThO/egsy8VpkAKE8AFpmqNweyCbc47mP5brqFZ+XI3W/OHnCXAJbnbBzzD7NSBiPzT
         Oo6D1naqBvitE68olA2ZF6yBMWeYtNzgRwmDK49r/ZuId52EKKHIpiBytuCqG/d2T5Sv
         7loXV7gIicK9iBCEY62V7EgTfz/Aer7jrjbvLLBTx/NXMgw49Zazmk2tdAXGrHo9P8s9
         ghW4w9ywB1W6NWYSmK89S0oz5FrDvqYpoJyT/2B5wu821xV/kDuQMhq3DbWmkGwdxkdu
         j6GbHM3/RRttK3HOhIrtqLx6/4F/6+5rsmlZvhTOR2CB9oiwTtNWVFz95V3ITktKoB6Z
         kFxw==
X-Gm-Message-State: AOJu0YxWveXSiRkdUImohIgI3QlaeUeeixqNzURgysS1vmhlvpAOTQ3K
	3z5kCzerc3gElAKI4VTS0x1mNoiwt74xuzxxOg3z4zm95URviyJ+5iUetKF9xm9G
X-Gm-Gg: Acq92OGV2qw1V4Dy2xVlGLrUmLU9pbIdex+3c9ypenRwasWyaEvW4sCi9pDrmejrJzD
	eappS7YOwbVm8tbwvxPGxCdb7y19xEq78gqg8sSTwGYlbM+H2P3Q+ndGym5JCTht2PQp/3zgK/3
	4fybNf/plDO39VHjJ70Xetp+FHSVqx7nQICOAW5nBOmkVZYqwAz3p5RoBsCYaHndIdOPCCAUjLC
	NJOG/jiWF8FA3KMZ7svYEPZz5SSlM0YQFpBmdGWFEheh9tnd487iTBsw6k8BOhBk4ne3lile9N/
	mFQdWnUaAjAzTjF2VGJUedwNS3FslCn0QUFu6d2UjU4bywpoPasq5I+v/LVsKX+D/pm/anDFmBe
	ckD0lIy/cGjMLZDBV2v73t6TTditnt/ZbB+cWI2lfXG2376wuvsJUzbNwn2GOy/Mwm36v0YD5f1
	vUKq6936TzepnNAZ2PQhOFIZrTlRB1AKN91ujvOiWHF1zKexevTeSe2hD4M1a5nHlsrBykHfMsz
	908/3EvGu68h5S9NAnrt5aHyNk/mXCfV5GUgpZpXkhxpm6ujFne
X-Received: by 2002:a17:90b:558c:b0:369:932a:2b8b with SMTP id 98e67ed59e1d1-36a6778aedbmr14172064a91.11.1779706348076;
        Mon, 25 May 2026 03:52:28 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:2011:e829:fadd:33b:8fc3:b2c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a7265a001sm9302388a91.7.2026.05.25.03.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:52:27 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	ak@it-klinger.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Subject: [PATCH v10 10/11] iio: adc: hx711: pass iio_chan_spec to hx711_reset_read
Date: Mon, 25 May 2026 16:21:26 +0530
Message-ID: <20260525105127.180156-11-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525105127.180156-1-piyushpatle228@gmail.com>
References: <20260525105127.180156-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change hx711_reset_read() to accept the channel descriptor directly and
update its callers accordingly.

Split the existing HX711 channel-selection work into a small helper so a
later variant-specific change can add a matching helper without growing
hx711_reset_read() further.

No functional change.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/adc/hx711.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index e5d842853b71..fde95758b9a0 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -268,7 +268,23 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
 	return 0;
 }
 
-static int hx711_reset_read(struct hx711_data *hx711_data, int chan)
+static int hx711_set_hx711_channel(struct hx711_data *hx711_data,
+				   const struct iio_chan_spec *chan,
+				   int *trailing_pulses)
+{
+	int ret;
+
+	ret = hx711_set_gain_for_channel(hx711_data, chan->channel);
+	if (ret < 0)
+		return ret;
+
+	*trailing_pulses = hx711_get_gain_to_pulse(hx711_data->gain_set);
+
+	return 0;
+}
+
+static int hx711_reset_read(struct hx711_data *hx711_data,
+			    const struct iio_chan_spec *chan)
 {
 	int trailing_pulses;
 	int ret;
@@ -282,11 +298,10 @@ static int hx711_reset_read(struct hx711_data *hx711_data, int chan)
 		return -EIO;
 	}
 
-	ret = hx711_set_gain_for_channel(hx711_data, chan);
+	ret = hx711_set_hx711_channel(hx711_data, chan, &trailing_pulses);
 	if (ret < 0)
 		return ret;
 
-	trailing_pulses = hx711_get_gain_to_pulse(hx711_data->gain_set);
 	return hx711_read(hx711_data, trailing_pulses);
 }
 
@@ -300,7 +315,7 @@ static int hx711_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&hx711_data->lock);
 
-		*val = hx711_reset_read(hx711_data, chan->channel);
+		*val = hx711_reset_read(hx711_data, chan);
 
 		mutex_unlock(&hx711_data->lock);
 
@@ -390,8 +405,8 @@ static irqreturn_t hx711_trigger(int irq, void *p)
 	memset(&hx711_data->buffer, 0, sizeof(hx711_data->buffer));
 
 	iio_for_each_active_channel(indio_dev, i) {
-		hx711_data->buffer.channel[j] = hx711_reset_read(hx711_data,
-					indio_dev->channels[i].channel);
+		hx711_data->buffer.channel[j] =
+			hx711_reset_read(hx711_data, &indio_dev->channels[i]);
 		j++;
 	}
 
-- 
2.43.0

