Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2520466B7B
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521524; cv=none; b=DKKb0vPbWdqpODDJkoXLfTQxOyvnd7BzZbpQPkjJhc8RvPUyOx1C51sKiK2HJqezqPv0PD9Dw5+E/UN5ZzAOLAmp9WrhKyCJLw+JmpV5wpTb/UFcelVl7cZr8CtXWrEJDZ2XwunRLD48W0b7R+/CWm4awThtJ21gHHqoARt0G6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521524; c=relaxed/simple;
	bh=5k+SnEgwLcoE/m9oWbMPiYN8XaRjygHFU88BagKW3cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmLkqP/iIqBB1fzxWwC8SdIyULTtfcWp15a25jGOEFjFhDijlsSc0+LsqM6mu2tWuMQejKhFknb/OSAfwTqik32Vmnotw1r9s62jALnXG4kWFfVIGogtGHeS8VwEj2QD+7VboENatBmit7CMV6UA+wucp2kAT0cFdxuDSwOKkLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gfu4YBdU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gfu4YBdU"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b7d3ecc10dso45703375ad.2
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 10:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778521521; x=1779126321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beKvBN1aF04rHKZBL8DcVQubUk4t9ZmlxiCzX/vBMwk=;
        b=Gfu4YBdUNYV0IYPX8YornMdAkct1IB9M3kDNcc4CFcurHnR7AOQQL4dFGft9kh0fO2
         Rx/Q30ziLvXjqm3vhftlpgtvXN707tuv8G1xT0hduWPVmjQ9xGD3639Sy1eOsGwhCO6a
         qoLsJyios/eFUxWCmqI1rXss5EINME8Ht7G9f56uHfzih5SQ9jPGG/K+BOF7X5kNZPBA
         ZpWandFN9jb1oizWSee6ZS70/dcVBUzBYQkQamTZrFk7hkmGJ14jkHgeN9yl+pCOs8uc
         DOd/0hrN9QTz4HiSxkBnmikZI3yARQwR26ITeYhw9ubIqCNTtl8hqLqmgAXUkGyd62+Z
         tsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778521521; x=1779126321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=beKvBN1aF04rHKZBL8DcVQubUk4t9ZmlxiCzX/vBMwk=;
        b=Q0A7rctwPhixS5edtEzgqeT85ej6fUgt8wEto/bD7tNypRGLehYiMwVtEsiu4OYi0H
         cjPsg2mwMxjS+bA3BE4maeHBGDQfhemiJla+CtJZhrpVZ1oGtcXvYusuK+bXhoFq/w3I
         Ca89UXpoLn8vZr20teY4O4iCV/Q9E06KjZBoyipcG4Z2RaYZ3B8NS3J97nkpoF5PSM2r
         TngzMvpX2IVcfQBm0QqTO+mRXpUxfsK/EeT0Tur2gvmUkmDMVBMpblpPPdXRP/5rtxVv
         LpxevhiuoDiA69ClOk5hdrEDN65yK9AMeD3hEVk1n8vKd5tbQOqfz6tfmvVdt4RcC0C0
         Gr7Q==
X-Forwarded-Encrypted: i=1; AFNElJ82QiVV/PX+zblJCWldyy2Hegv8kVKRkDua2w4UAQDC9hEcQETWfPo7n2D7IG52rhT7HzX9t1bxzB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjOkdu4UZ1CobnMgC0nIxEGZ2SPFVik9vpZki3c73ZfZZvHT9X
	03LkUPoGfExkXE/eCyoN9lyoDbuddZ4H1l7vGERPMaiJp3aB3Ic/4mbZ
X-Gm-Gg: Acq92OEc/6J9dxxSi+MrmZyDcmJhOld9/+y9+ZAFoAv1CGgc14sKvYyXZoI12MdMLLk
	6CleYQK0atuU7alEnCusQpRO1kTq+PFbV1zk3jZJ38r1Nie2/ggX2m5B3+TgdIv55u6WA7knyjM
	9FLe950LpVbC0QYgn8tzPVu9lPz0wr1+Ewn2WjSUJjkU+xULP5YVzZ5QHWkvNZ7+mIgFt4TckWf
	Q6+pAlUB54+6A76elTFCZKNKGR9KuzA43WLllfuoqylBIo4h8HQlBESyQvZKfehIROaOqL0jozp
	Qg/eCb8G2al2As1D2XH/e1RGQd8bI+26GcvsCQYTMcMhlamLVlLL73M8qzZ4p27FhdZ8AnhBeVO
	jTU93e7xvyEL4UnyfXPGc7kZIAclDJmzaxg4lBasC2XsKAsMogxpIcs3Zt76zgL4MdFz8aVWF8O
	1xoPNg9LPtRtNe6XwBGHXI+SdD4JKEZLp9Uil4vUwlNZDwVINZewj3ayQdgrd47soFhqiWtnkk0
	AInprTmJGfbOdOSzbpiI8Z6D0i6eysvltt6gUS2rDjka0gMmCS/5kLhCpds
X-Received: by 2002:a17:902:d2c9:b0:2b2:4d36:7aa with SMTP id d9443c01a7336-2bc7ac4ed26mr117712555ad.35.1778521520774;
        Mon, 11 May 2026 10:45:20 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e365a1sm106838425ad.44.2026.05.11.10.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:45:20 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: jic23@kernel.org
Cc: ak@it-klinger.de,
	andriy.shevchenko@linux.intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 v8 10/11] iio: adc: hx711: pass iio_chan_spec to hx711_reset_read
Date: Mon, 11 May 2026 23:13:35 +0530
Message-ID: <20260511174342.123820-11-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511174342.123820-1-piyushpatle228@gmail.com>
References: <20260511174342.123820-1-piyushpatle228@gmail.com>
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
index 0db2d2db9242..183568196d52 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -269,7 +269,23 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
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
@@ -283,11 +299,10 @@ static int hx711_reset_read(struct hx711_data *hx711_data, int chan)
 		return -EIO;
 	}
 
-	ret = hx711_set_gain_for_channel(hx711_data, chan);
+	ret = hx711_set_hx711_channel(hx711_data, chan, &trailing_pulses);
 	if (ret < 0)
 		return ret;
 
-	trailing_pulses = hx711_get_gain_to_pulse(hx711_data->gain_set);
 	return hx711_read(hx711_data, trailing_pulses);
 }
 
@@ -301,7 +316,7 @@ static int hx711_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&hx711_data->lock);
 
-		*val = hx711_reset_read(hx711_data, chan->channel);
+		*val = hx711_reset_read(hx711_data, chan);
 
 		mutex_unlock(&hx711_data->lock);
 
@@ -391,8 +406,8 @@ static irqreturn_t hx711_trigger(int irq, void *p)
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

