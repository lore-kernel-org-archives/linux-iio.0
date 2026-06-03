Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8487B480330
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512604; cv=none; b=OVFWSCEczq6cQLYSXOgBzkgWEEHhdq6YrFzv0PtnqNzx7qhP/A/fqd++bZaibkuwM1wIyptH3TrTjafequpJ3LqRLzWa8NBmVw/b/Mruhlr161Hu0ncVAbmGMmCFda5C5QOJWA0n/qUxNy/24kh031L1B2KDAMhjcwMTmrVcUsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512604; c=relaxed/simple;
	bh=3FrcsQlVziUdeKI/N9eYaCs4RJmRsrcZLsIz3cZSFq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqQFIywJAloywKUxrnAvsKtCRc7l+erECqAK8CPvvAMdRg/Af3GWrgTgTifbo3w97UFmIZWtUlfZIt6QY0FvtxnTHVkqF/8vpjRcVkhqXwJIu8ono9+Kq344MBifgqeDvRt3Nf4DW6Nur1W4Z8RMgQvMyLW5ie23uEpDptQ64kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAtM4dH+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAtM4dH+"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf20f6be6bso36034105ad.3
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 11:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780512603; x=1781117403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uk0PkavUtmrtR763X7Xl8KGOaAn01gQsV9JDZDG7T1A=;
        b=cAtM4dH+jUXGOCPp8gH4t2OYkCT6gxfYFDuquYsvqFzbRonXuYyiGLx35PxuRsfo9e
         HCdfQBS4iLF0IsNsViisHqeiM8QyCpHDqWeJ8lBu29tUF9a7ttel3uHF2YfhKb3l9Wq4
         QJMjGR11dnyUGyRdceWLQu8rWn/rk80x+mWXDjLjpJqKKOrwvJPlFmuD9eULMiXHsvV6
         wABNdebnVnE2pV0fhOkjGsoj0+nSARU1Jn16PEzsYxIVtzGNSt7bZd87YIWiDLWLNMkl
         XArZ+Tf9snr+ahJtxOlYq8iHTzIyqHc1McxnKFIG6Lwg0l7QiRXQ++t/CYnD3DS3r97J
         1Pig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780512603; x=1781117403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uk0PkavUtmrtR763X7Xl8KGOaAn01gQsV9JDZDG7T1A=;
        b=Oe+rHkAN7NeIb3v5aCfaWcZyxLgb6+76J0cCz99Mo30dA7xoZ7SB46ekzUDl4WuOEi
         cUQcGHdKFOD6BM+cjf1u0X81R+5Tuhmy46ekGtSUmguluGRUHU7nub7fA1azwHeraM1A
         XzLfmn0nL6sr0ML7XEXdpxDkAd10ljGaUAlggXa4OmDGm8En09g76JxfLKFAq0cvMeXm
         PSfKGQFsEt/mbupTE9AQE4y4ndYODyp/YtxBiMoVmsaLxS2Pn7R84T9uB70R/3ZJWUiM
         sxpzh9r6O3zQLhYK0oCza+wpoXerviD8j8AEmsHQMvYrLjUWcy6K4F5tVz17BOmc5nky
         adEA==
X-Gm-Message-State: AOJu0YyBk7RrGu5OyBL/7sEKpWWZnHckb/5lUxLqi1x749350Lnm/yhl
	zhMMwUV1PKI36zN94MjmQneKhuqPVtut5lkJ9kDoR3b2V+Em7OE346lcQD5Ebg==
X-Gm-Gg: Acq92OGAYRYzhjicTDYkk3sDmeB8BmsAnspLh7JxUP9i1aLACUw1mCdxdN0NTPL5Pd+
	HdVgxY1yyA9YP7dByoZM2xpHuCvAk90EVPhTUhE5O223qv6HZfaHHzN12e7Fycq+qq+GrA3CYPD
	FlQGQFxxYGBjU65LYIO0feTTLHmh9LDjHE2BT8iWoJPuD5evhpKCcgXAWDmEbldFd/4Z0b/qe5u
	rXsad/xYIQ1mTwsBDwYn72/a0Lb2CWPq4DcVeE0WqqSSyoATrYwluhTxtfyxfsjnmM/7GKIFCLW
	m551awAtHnWdwqZ2BPcDDa7vQRrBzIaQf2hdCQo678Yf8yP5oOPaYHwlvG+OhzETfNjPnWAFQj4
	0ZpTAegVucasDbkC2vyz9ctNO9dCksFeO6cQv3IRHgqOMdRk1R0/XR4NT5Itn9KvnItL0oqtQrd
	m9QaOnjCjozEe1cyrD6W5WLpnbz1pxZ61Lng+A6WjkK+BzMRY7hbPwJIMXQMyH5stSkvX82epq9
	JBL9HbE4K2Y+u2LGH0881sBAFNNwmmVpF4sjA7apiZmFgly2FriVA==
X-Received: by 2002:a17:902:cccd:b0:2c0:a746:7aff with SMTP id d9443c01a7336-2c1644ab4dcmr44586685ad.24.1780512602733;
        Wed, 03 Jun 2026 11:50:02 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2409:40c1:4015:6e6f:ee79:7998:9a6f:65e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d59csm32139675ad.4.2026.06.03.11.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:50:02 -0700 (PDT)
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
Subject: [PATCH v11 10/11] iio: adc: hx711: pass iio_chan_spec to hx711_reset_read
Date: Thu,  4 Jun 2026 00:18:58 +0530
Message-ID: <20260603184859.89693-11-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603184859.89693-1-piyushpatle228@gmail.com>
References: <20260603184859.89693-1-piyushpatle228@gmail.com>
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

