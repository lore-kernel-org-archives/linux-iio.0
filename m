Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25086326D51
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779035488; cv=none; b=qE6L5GObmIov+icfJJJCqDODKXjCXwrEnZJcqy40hJhfzMVOUAUKwpOXqm9HFZrRBszq4Z+bv90j1M0xfLEMayhsM7bfqqyqzR/s8t4bHk82iq+BB+TWY7PGB8wobgjm2T/DhLemBMAun2Bop8QWGB8IgjFV6qrzIEp9znssewI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779035488; c=relaxed/simple;
	bh=szJiY6EJbu4bYlsozrvbiskziHki0cBuDtsWP1MNp+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h8PQ5SJpqi4pYyEwaWf1wCSgZkQCbvnEjgjqY6uzc5qNglbHJTeaGHLgP5coIUiW5sjHRpJCBMxiWRZ8ZRjkG57X46B8dmSJE4gLc2y0h9nlv0/IXkIJTdmIAF4KNhVA28iAEjV6A7IUzCGeW7lt7P2uhUn787nttqcG4SrOqko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaQFLwol; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaQFLwol"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a8f97f6bso3231965e9.2
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 09:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779035485; x=1779640285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4xQUzenjZFV6yOOyNJ+dSYEulDJrlac0Nc+paPih8Tk=;
        b=TaQFLwolWi+EiI2hOJHA6sDEce2GXoV5lhaEvRMh4msYQoliiMjxtG7R3u+0wwmc4b
         hQQdNNWAR5xrt9lbN3bGrCswcQeUG0rI1fEc3ilRPQrn4hDKfchazez4JGuo1aHbPOaA
         WXRPR7Ea8xTvijbfjT7Y9TL8pW4uPaQ2R2lQVF+t3iVban0Cm2foxC/f3kTOEJuNWGDP
         TT+MrAVag3ggrA39O8pzLl4SbVKlwyorbiB/lNRp5KeLIE5rM0OrC8lJFs3zFG8kuxhy
         ac+NBbZEgPhOiQAGuknpDoIRjGn1fkpvdgNkZFsnJgsqh2NmFhqt+FYAGvGcaYG5D01p
         085w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779035485; x=1779640285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xQUzenjZFV6yOOyNJ+dSYEulDJrlac0Nc+paPih8Tk=;
        b=Od9gAUlifyKKNH1KA6JU+9E/fD5VUXRzwdKiIbrbplirVLQ+BXKAks1tTmnqV13zlF
         qnfLmVrbq8FEqJJAXjlt3yGaes6kkkjfvkUx8RMnx78UozoyzpPeXQcUxJvES3Jxca7P
         ZThe3MUHqm4SjGgnQUZtbw17juQ5cZ5o6M9v/IBXHZ8ETPhtXdOIp/BjxL/k1dsj/oGz
         naqKIR4n7A0rWILXxg/hXkZzeVsD/LavNPyVKkPTuKvyCx2zrQss15emZHM2sURQFT9I
         4y+vf9LBq49082wzzFeLpZfJU86BbUhheCEn76eQgIH2oEH/MVQaL8JH1/07O9uGNF42
         mWkQ==
X-Forwarded-Encrypted: i=1; AFNElJ88sVfd7lKH63bPvZjfH1uWBaLEqqpYakPq9l3+WCH0purCypKlW63w+Ut6Mq6tQNEtaFW0QSeUrjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaMVcTtRM0n8aaKfXGjzuNt5UK42nPbsl4Tzanxb07V+O62MIp
	61xEAFNOQD8ND5kKf4BlIqmDMT9yTAJG1tlwC932BOf5ieyt5hB+TFmw
X-Gm-Gg: Acq92OHBgMl6bXK6jMm7iiTTh8ax0wwSC6j1e45W2hpqCRXgoiAGLnW0gIyky3FFH0w
	joEk4ucYoi+Hp8KC8HQtppiBA5BW6aBV68+fDJ3aYr4sCRVxePS+kAj/nngEfmlT/ucMR8w7GUx
	dvS4C3AJgSW0kVV1LQkmPh5uXbYWIsEWK8xGmCx+fD2hX7Gp4e7nL/wKBKQvVsBeS8DobuEwK9z
	pga1erGPm/GNuzaFrrnxnQLm7wQvC9+RZeAbDkLtaumIUUvc0oUVPHy9eUu2ioZyL4xnfqD+U+T
	MyrXNYoWXASIMDrEA7cflg7W/dOJlFve4q02WAaa8ZRUE7eJ93xch9DUKE6u86tL9u3kqUF0knC
	MvOk4pnFCMCTtroDyPaNSOz4BlJ+tmfIP0NB9/b61iOb+fdKeI8nSwNNCEcJ/aMBeZBO3z+nQxV
	BE+7HKlfqpZ3jj4f7awpe/Gm4WPYT/vIBuxzZ15Q0el6lm
X-Received: by 2002:a05:600c:4692:b0:48f:d410:6072 with SMTP id 5b1f17b1804b1-48fe6302a9fmr95205945e9.6.1779035485464;
        Sun, 17 May 2026 09:31:25 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6449sm30401983f8f.37.2026.05.17.09.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 09:31:24 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: daniel.lezcano@linaro.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] iio: adc: nxp-sar-adc: notify trigger on channel read error in buffer ISR
Date: Sun, 17 May 2026 21:31:11 +0500
Message-Id: <20260517163111.469-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nxp_sar_adc_isr_buffer() bails on the first channel-read failure
without calling iio_trigger_notify_done(), so a single I/O error
leaves the trigger's use_count stuck and the buffer flow wedged
until rebind.

Route the error exit through a 'done:' label that always calls
iio_trigger_notify_done().

Fixes: 4434072a893e ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
Cc: stable@vger.kernel.org
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/adc/nxp-sar-adc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
index 9d9f2c76b..ed004812c 100644
--- a/drivers/iio/adc/nxp-sar-adc.c
+++ b/drivers/iio/adc/nxp-sar-adc.c
@@ -341,7 +341,7 @@ static void nxp_sar_adc_isr_buffer(struct iio_dev *indio_dev)
 		ret = nxp_sar_adc_read_data(info, info->buffered_chan[i]);
 		if (ret < 0) {
 			nxp_sar_adc_read_notify(info);
-			return;
+			goto done;
 		}
 
 		info->buffer[i] = ret;
@@ -352,6 +352,7 @@ static void nxp_sar_adc_isr_buffer(struct iio_dev *indio_dev)
 	iio_push_to_buffers_with_ts(indio_dev, info->buffer, sizeof(info->buffer),
 				    iio_get_time_ns(indio_dev));
 
+done:
 	iio_trigger_notify_done(indio_dev->trig);
 }
 
-- 
2.43.0

