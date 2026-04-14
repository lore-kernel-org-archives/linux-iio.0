Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0943D5647
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 10:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162840; cv=none; b=fqqPdSvDTmJHAbrbwgWI3/VjA56mkRvAB9uffxvrjoA+P+PZPP+Uv/4/L5e9s14LmlKhiOzhFhpo4AhNXVdigcL1ej4MnXtT6Ksv98h5NFOuOnV8aeYCi8OSgA/AMDphIizIhI5+3PgWddQV/tXQ5iOLcX4s2hut52TPRMKK2Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162840; c=relaxed/simple;
	bh=u9sL6Y6S3EfWUhwuIvnIopSsXsMpMtu4N/UE0GJ2SP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeImKg9zz+t7/6bV1hplRR7OItXr75Z524EFQ4/Z501DEJpc+D33+hWB7P0b5x0+T48NkHfwGOjX5XkQvYvAcVQiNunysaMsSnuHjaiI8NYH1//EhqR1qslUQL2EWVgAotx3wevGlbxr8T5AJNNCrKIxerqR3l5KzQZOanwp+dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=VYLzd8AF; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="VYLzd8AF"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ba895adfeaso5524037eec.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 03:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776162831; x=1776767631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3My74YzchJ5b5u6cPS4kfn7rpF3jGLClMpdesSqRBE=;
        b=VYLzd8AF0nA+xtLNzW4+jaKvUF/Pc79ighr9JnjiuFhLQEZq7FYFOvOsuIoYLBEmAq
         5oU9lxaMh9rOrJdQnllcWE+akABWZMQdEBzMgr+JffGj/Ab1JZcY2t9NtTIMB+6w90iT
         OHSmtQSD4usCn2LsUhskzeMlfi6pZm2v+urwOnm7AmFwts1p3nF9CsyCZwsrT7ClzVEE
         Ysuv8uyYrc/DaZouhuBeMTl2qjubGgTabNY66qsFg9EvdqUrQu5OmIFW+EIdgGPgvdE2
         ImUlkjvxLcT3WkPUeHhn2ISglTiqWw80RdZlzQcjAHUIvJnMl6atdBAUOERv41/u2b5l
         jt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776162831; x=1776767631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C3My74YzchJ5b5u6cPS4kfn7rpF3jGLClMpdesSqRBE=;
        b=Mo1ANv4mviZKgnmSjUVHHQga9Yfw75daoJf3wvvFDP3iJK6GzZKysyJj7tPwQlaF13
         2BbsHCZGr6sDwTdBESeTjuhQk98FxxZY1fhTZ4iFT2oMAQcty+9tQIXdFdrjAQYB1sBF
         x5PEIAP55GItX9KDZp/17yGkP95PE4BBYeYuxfSlAFcadx6uxBLQOtH4eru5tsnXKAAX
         dQ3GHp4QVFQYddyrxYZutVXnTJO6v3WrPnY+ZotyjlCcBlYN37j3Wo7MyD6pKNFPD1pT
         mty71k4eFPs6Yk5rxdL0Z2CYsINNXTPFXZ0hrpSJBtWkWDSb4/EZ4zAahK7UR+YRmS3J
         1WKQ==
X-Forwarded-Encrypted: i=1; AFNElJ96YLwBN/C+bhFIWrvvm9KgJchGD0O7c3xpQ2oW92AFB2dbmlhbYLV50sFDn68Mzu9g1acfE1v93ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFQch9MNpUrXK0fUXXAgvXU7w8aOUEdnzeyOsPymFBHNdXMPX/
	ySt2vMnpGLtTrVly2PtPhpsagSO7SsagZkOUYCRlH4kKCxTYDTB/mETspvG/lBQwsBY=
X-Gm-Gg: AeBDieugAPQeOxDRK6/kcOioW6EQZfNAb3b38IasX0r5yxl5vyth/G0pzgBeyiOJ0wA
	rdHyJC1g+4bBvnRuQg9ZazezFPEjumnTL4lPylLUb428fOcZl2S4socLpe63921Ev7k3lFBqOMX
	DsqEiuLrnyfwJOZ3xO4efTaAzN2R2+Ot3miIZieSaCu77ieCZshDFZ0pF/Z8qESN/4SBOr6fH8n
	d2D3w4VRlXbdmEGoj73vEa6VFxlSitHLcSh5P/J969InpAEZcKtogzDJyWhOefWW8P3GshKS7Qo
	QDPCd/q6NEdAGc53a1fHdGor2L4NTSLix7rAfqE+nPAqujuosXIvJPNyRVtw4VVymINqs5bO9v4
	mWesoFmaztLakQJQunud1LmT/ByXvEqJN2hRSWGjKHb6o7CMWcsbb9eoGdltcZHJQj5kHkHuYm5
	CIvw836JyC9g3T/X7zxrp7OCsBdkimHevZQZXqRvcaHUey8yYdoKMsXHw3iK0tffYxbct8+FJRr
	8fQa05dlv9YhOn41AJPJYC8tKeOVyMZbcj1E80rp9lhrioyWm3jc6okI9ff
X-Received: by 2002:a05:7300:e828:b0:2ca:7eb4:3e0f with SMTP id 5a478bee46e88-2d586699913mr8843833eec.5.1776162831581;
        Tue, 14 Apr 2026 03:33:51 -0700 (PDT)
Received: from gui-host.Dlink ([177.33.104.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d90ae89e49sm8735499eec.31.2026.04.14.03.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:33:50 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: Salih Erim <salih.erim@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guilherme Ivo Bozi <guilherme.bozi@usp.br>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v2 2/3] iio: adc: xilinx-ams: use guard(mutex) for automatic locking
Date: Tue, 14 Apr 2026 07:29:18 -0300
Message-ID: <20260414103316.18455-3-guilherme.bozi@usp.br>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260414103316.18455-1-guilherme.bozi@usp.br>
References: <20260414093018.7153-1-guilherme.bozi@usp.br>
 <20260414103316.18455-1-guilherme.bozi@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open-coded mutex_lock()/mutex_unlock() pairs with
guard(mutex) to simplify locking and ensure proper unlock on
all control flow paths.

This removes explicit unlock handling, reduces boilerplate,
and avoids potential mistakes in error paths while keeping
the behavior unchanged.

Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/adc/xilinx-ams.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index f364e69a5a0d..1d84310b61a9 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -720,22 +720,20 @@ static int ams_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&ams->lock);
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&ams->lock);
 		if (chan->scan_index >= AMS_CTRL_SEQ_BASE) {
 			ret = ams_read_vcc_reg(ams, chan->address, val);
 			if (ret)
-				goto unlock_mutex;
+				return ret;
 			ams_enable_channel_sequence(indio_dev);
 		} else if (chan->scan_index >= AMS_PS_SEQ_MAX)
 			*val = readl(ams->pl_base + chan->address);
 		else
 			*val = readl(ams->ps_base + chan->address);
 
-		ret = IIO_VAL_INT;
-unlock_mutex:
-		mutex_unlock(&ams->lock);
-		return ret;
+		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
@@ -939,7 +937,7 @@ static int ams_write_event_config(struct iio_dev *indio_dev,
 
 	alarm = ams_get_alarm_mask(chan->scan_index);
 
-	mutex_lock(&ams->lock);
+	guard(mutex)(&ams->lock);
 
 	if (state)
 		ams->alarm_mask |= alarm;
@@ -948,8 +946,6 @@ static int ams_write_event_config(struct iio_dev *indio_dev,
 
 	ams_update_alarm(ams, ams->alarm_mask);
 
-	mutex_unlock(&ams->lock);
-
 	return 0;
 }
 
@@ -962,15 +958,13 @@ static int ams_read_event_value(struct iio_dev *indio_dev,
 	struct ams *ams = iio_priv(indio_dev);
 	unsigned int offset = ams_get_alarm_offset(chan->scan_index, dir);
 
-	mutex_lock(&ams->lock);
+	guard(mutex)(&ams->lock);
 
 	if (chan->scan_index >= AMS_PS_SEQ_MAX)
 		*val = readl(ams->pl_base + offset);
 	else
 		*val = readl(ams->ps_base + offset);
 
-	mutex_unlock(&ams->lock);
-
 	return IIO_VAL_INT;
 }
 
@@ -983,7 +977,7 @@ static int ams_write_event_value(struct iio_dev *indio_dev,
 	struct ams *ams = iio_priv(indio_dev);
 	unsigned int offset;
 
-	mutex_lock(&ams->lock);
+	guard(mutex)(&ams->lock);
 
 	/* Set temperature channel threshold to direct threshold */
 	if (chan->type == IIO_TEMP) {
@@ -1005,8 +999,6 @@ static int ams_write_event_value(struct iio_dev *indio_dev,
 	else
 		writel(val, ams->ps_base + offset);
 
-	mutex_unlock(&ams->lock);
-
 	return 0;
 }
 
-- 
2.47.3

