Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B44130CD95
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778442811; cv=none; b=gRaXDaVcku9/FXK5do4pWiQZ4KiXo2caNOJNR7wmiR+KsjXqrBhHglJP+YZXFlmvcw9Oh2fFkOuqWmCmr2URFuFAbg+A+3hcl0h7MCHjwCCwkD4DUs16D2KuIbn8RtRveCtZhiiMjbrz78E5T/H/Y1ItEFcMe64jNaemvTbgF5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778442811; c=relaxed/simple;
	bh=CcWVM+e3vOzvxPMHiHam/ZARcRos3URB+mD1NEni2ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aa6uXVbfkCQzH98yrxw3tTpdmC/GMDFaaqfoynlYim6D3Sa+4fHdcUa70ue2hn6lhnn9sMivquqGq4DU0BC8wIROqf15SBDDHOBeY9vvk31+PX8FKXa3sj4iMo38/8j2tnevIO07yEiSc4Ns8rg7Hn6aijoPWyqE0jgsge4rKqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWqoo2SX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWqoo2SX"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ba6485d219so22654925ad.3
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 12:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778442809; x=1779047609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zq8vqJkGxKnQ4HZxEPkyCpyl+unJgqOC2VHF9A/dltQ=;
        b=HWqoo2SXrcAwcLVoxkIgD+j0x4+3ROIqH7KRFVsslQx8rO4CmowrJYmRpaV2ODWmLw
         SJyIw13RhPVLhLrOSvbVsMHxgGzu9ilpHjYJV4yo9penjVe0FLqWUbUaIalhf5oLb4j2
         MdBxcrO/J6ia1yW1jzsQW253bCEEAAsQLnHtLNSOtkhY+fuDD1sJtWAyqhZD2dQ7apFx
         UbCs8gHCSHYr6cRALxpu0wqS/Lj5tV6m+14GTWKTp5a+083oM1bHV8LcnUCCoYqZZaER
         4yAwjskLVGzrMfM3csY5YhAyiI14MEPGwqlXliXObC9sunOOAcqoJVel7uwh2WALGCwC
         j4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778442809; x=1779047609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zq8vqJkGxKnQ4HZxEPkyCpyl+unJgqOC2VHF9A/dltQ=;
        b=dSNqTi11u+V/2rM2BtIOWj4JLlaTLywhqwnVeZ3823dp+OVJ1KggNANBnIWmW8LbOr
         4nByc2Eo21gM97k87llZrDpEDmpQUene0MFINef8pCG4Lu1U7a074wiG7wBnJeoKXck5
         Aivk+wK6fHCDxhZab4WqzJrYGCMy5y3m86+sSAgZDYEzesos4JsM/a3nTG7qt7iqZ9wF
         fkGvhxUUIrvTgiwad9en3nvwDLX0cncBwFZ1uSfdlJd7OzmmL+TI4R1ztPHfhFc9Vl2B
         bDjJW2HL5hR0CnKJTYb8ZJmOrn17Ew3yuRLqLqPqNWBXTG6EK8544CD6mhGhTMOiR9WQ
         5HvQ==
X-Forwarded-Encrypted: i=1; AFNElJ/n+IQSed03s0vyt5Cs20D+QVK5vSXeB3OS+fLtN5HY2KvgzYdZ6rqkkGI9mTetYlGtBaFGzkmH2QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK7PReR9ltLkwyLOqJIB867M2yw15mBbSjz16BM2ZmE4aaK1+R
	+plklho8F1/q+IEBIeWR+3yJ+iIamphKRRvZ+z1ycs1K0KFAPUfY6T3c
X-Gm-Gg: Acq92OELTNgebM6dR3z+EQwVhoKY3zBm6HXkuIqeo5tzHX9Oq59zJO0GoF7jaSfw5ZT
	5BhZAiz+jJjjGsLkD01/Angp0C9pnTlRJZ80HsiXrYkfk0mTBPiqwbkRzZ75VhMuoxmm1oDGT0X
	J4BtAeJYgZemS2GpnMW9wTRVTUZC+BxlAYCb5Mt0RMOeC9fFB1pKSXVUksphi+CDBR7Rv6tsJlu
	bMhXbO8PKlIGaUEDpsNAf0ZC8tXF0f1DdiNq2WfPDjSjYi5Uni/r59C6HhkRTA1rUDxA3AEvu6R
	9QISgD9o6uh/vkxrTemYV1Kaqp7ClY3W0Rdu2Z0VlxsF4V5XuBJOSwQfULXDB9oeZg5i0l4WQnQ
	/Tm3UQsUIBtbOlotKAxnnAgbtuZj21wE9smZ+aw6t8zk0DHI8r86Mr2P+w6uh5QBfIzKyexHhh5
	7aK6gdpgkDRWZUvamnkee6UYAlWnL2+4hYQVJWjc/vG1+w7OCpfbo3kjyQoNXGHm2m390jxRqXm
	bpnCyLiWEw3gt4ROj21Io+lobuoudGy9zpSzTcQFboFiYwpRHUJ+PDbBURwUut1qK6FIbY=
X-Received: by 2002:a17:903:3bd0:b0:2b7:beb5:3002 with SMTP id d9443c01a7336-2ba7908142dmr230533385ad.12.1778442809329;
        Sun, 10 May 2026 12:53:29 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e358b2sm77065095ad.54.2026.05.10.12.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 12:53:28 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: ak@it-klinger.de,
	jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 10/11] iio: adc: hx711: pass iio_chan_spec to hx711_reset_read
Date: Mon, 11 May 2026 01:19:32 +0530
Message-ID: <20260510194947.31997-11-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260510194947.31997-1-piyushpatle228@gmail.com>
References: <20260510194947.31997-1-piyushpatle228@gmail.com>
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
index 9f17cbc6c2e5..860f8ef5a7cf 100644
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

