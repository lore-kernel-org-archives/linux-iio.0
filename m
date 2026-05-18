Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3224390999
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127918; cv=none; b=DtrfJwVL1OqlQYA03xWXEOZ5LQ95AWpidUXpMZI1yzTmWN7JaB5NDaZt+n3eSQK8L+H515QDmfOCclrtuuJ0O6LnuqTsUgKaVJpYUfUvArLj1CyUntoksqKMjZ6Q0i3yTYBYFpo+lybwIMAhG+OmE5f/a2G7X8/11ibfOmfIHqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127918; c=relaxed/simple;
	bh=SepVrJQKUpcIhZ8WoaRQtzTiFs6CKGUS4vW6leHwx1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cPfaUjUz3Hi6u2aFPs5NYqHskk+eQ5r0ZewWTG5kIuVI+BpQozVK0sARamL+sATsG5bsKhSTze+BEnoQoK0dBY179wGuQvMHvJpoD/5uRznGbffDgYUazXIoarpH+rwFQ4eE35H0NfMZL/HBm8TUD8A0iMEb3LwSCKEoBBLc5s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkiY6wkw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkiY6wkw"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-44b7e8b65faso106891f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 11:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779127914; x=1779732714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4G1HoMCMk5IMHxjXmT3jOlWTien1K2K18WRiVB1Nyb4=;
        b=MkiY6wkwWbTKpTnaT2nOTh038G+TxLly3vkHOqcs0lCXCAz9EeROA3vFoW073zzDtj
         JsklyS50Ja9/uHb3zWj6DuiBQl5tq14NKFMQt05EvyrqLJrAbATxnupsVZ/nBPCP+Zgd
         ZaVIvhKpr0qaeTNAl4m8zSAdvxyLYdC88yklJXSYh/1xkrmlnJ3zUZc2sMf11Saao3kW
         9ozGAYzaH2h1TvbXbh/LBJ6wpTjQwAuqFWb7eczREe/OmvMJugo1H7X+4kIichRroTZc
         DHHX9QMHePjQGTZJSG/wx+8rKTLbPYbeHlcSLkSzvF2HZ7QOw41SQbWL4IgGsfeYLZdz
         +HOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779127914; x=1779732714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4G1HoMCMk5IMHxjXmT3jOlWTien1K2K18WRiVB1Nyb4=;
        b=SM4kL+4hritzkzrkOkZ+dvfgtHZOsk1qW3uPXyjyBSV4olD8F5hfj4maBW38mE5Kjw
         SkTywI5v74UNt8LouSjCc3J1u+wNUNdqH/HCqgjVVtPdR9AwzAn+4Ct/KiffI9J6+sL7
         Hpx/f4FhNaZ6E9j3RON0VuSpAkC0CW3F9nDnPAzfAgknUEb7KA7NYv1MAiOBZXG/faRt
         PvHyKvp9smCOy+xskJ3OjeHwX5qL4Eedh9vthFCnpFoDrkjtPp87xU9Avg89/rq6c+k1
         hJYUXBxG8vCmyYlDa4g//FxSbcdrPMQuY23XuFzBYAdOc7MZr1ka0dHm3xxF15AWQjaq
         rDOg==
X-Forwarded-Encrypted: i=1; AFNElJ8SxEexNOG/br/yGNyE+gCa/h7FaydIRExouXgZA5suWLo8XkgobQXMiJ59RpQGrXmm9ZNiPpv2JZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+iT+yLS5cLaA8nYdtz9h4kxnxTpgLmJYN3FzUHnTxAkYCPzwk
	Pkd2b3c2JzD4YAjjmJ59x7nhA38HjgtO/Ws5LAb5q82oAOmwSepGY3V3DLwWmqtpeAw=
X-Gm-Gg: Acq92OH/3AkVKP+47PjSivMk4OShTZoqNa/qOAzXzeb3Z5sIqBna1q2k/B0eqP9IJVO
	xDKEtNAMVuxBPWom4cxdZ/wSBWAX4ZvK2llnDuaQVBQJzv/VNJNGUylqwI3BOK001tbE7HjgwnZ
	YTIAgGp9t7+2+naZ9stbCK6R9VRNDcgkqZam/CaMSQwMbI+jOP3cpCca94sDsbwpvt42cJgCyku
	t6dTPMOJxfsoUKJUx4Uw7ZhnPNXAkI+rKICXQ3/uhjVQLzi3o4r+VmfWA1mTtqw7lGuRBP4x4V1
	GF1MHyDIH9S1lFMELYdSYcQPil6dtxY6Y1OwWQ+LyGJGrecRGkpSBx56xQZUenQIHdkrZraejn8
	E4jfiOlQ6hH1ukopEBCGnlpzXM9LMX6NWnDT+/PjqsqaY8pKhOVVpK7BRUQr+azKv8cDn6BiSad
	BjQtVVd2dIOHbPB33eC6YEotI7YVFl9MFfYQJcXkUrhFgl
X-Received: by 2002:a05:6000:4556:b0:44c:225b:7737 with SMTP id ffacd0b85a97d-45e5c353bc9mr7974567f8f.0.1779127914084;
        Mon, 18 May 2026 11:11:54 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768072sm38612642f8f.5.2026.05.18.11.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 11:11:53 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	daniel.lezcano@linaro.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH v2] iio: adc: nxp-sar-adc: harden buffer ISR against per-channel read failure
Date: Mon, 18 May 2026 23:11:38 +0500
Message-Id: <20260518181138.1504-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nxp_sar_adc_isr_buffer() bails on the first channel-read failure
without calling iio_trigger_notify_done(), so the trigger use_count
is left incremented and iio_trigger_poll_chained() drops subsequent
dispatches until the device is rebound.

Reaching this path means a state machine has gone wrong (driver bug
or the SAR ADC in an unexpected state) rather than a transient bus
issue, so this is hardening rather than a bug fix. If the underlying
condition persists the device is wedged and needs an unbind anyway.

Call iio_trigger_notify_done() on the error exit too, matching the
success path. The nxp_sar_adc_read_notify() duplication is intentional
and avoids a goto label for a two-line bail-out, as suggested by David.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
v2:
- Drop Fixes: and Cc: stable@; this is a state-machine hardening, not
  a user-visible bug fix (Jonathan)
- Reframe the commit message and explain why the failure is not a bus
  issue
- Inline the iio_trigger_notify_done() in the error exit instead of a
  goto label, accepting the small nxp_sar_adc_read_notify() duplication
  (David)

v1: https://lore.kernel.org/all/20260517162346.189-1-sozdayvek@gmail.com/

 drivers/iio/adc/nxp-sar-adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
index 9d9f2c76b..1fc839a15 100644
--- a/drivers/iio/adc/nxp-sar-adc.c
+++ b/drivers/iio/adc/nxp-sar-adc.c
@@ -341,6 +341,7 @@ static void nxp_sar_adc_isr_buffer(struct iio_dev *indio_dev)
 		ret = nxp_sar_adc_read_data(info, info->buffered_chan[i]);
 		if (ret < 0) {
 			nxp_sar_adc_read_notify(info);
+			iio_trigger_notify_done(indio_dev->trig);
 			return;
 		}
 
-- 
2.43.0

