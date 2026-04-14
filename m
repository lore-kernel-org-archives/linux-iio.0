Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D6438B15B
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776206602; cv=none; b=Csve3V4ky03+bkYmvIJSW5OCmrNrKMZ2rwtjLSmETOgBzBlImC4hlzY/j0SojMTLZksMvKSQEnTFY585N72gg7ZY542HSYenE/Dc1aAH60Yb74kMgYabmmiBmk74IxZe7yOKuu+40Z+vYUhChhWJiwCBpUqZiaQHkNpj8mHFkRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776206602; c=relaxed/simple;
	bh=vNRA6J2+Nh5kk+8wVzqvkREK5Nenp0Br7khYY03UGDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fr/LKYtLAZ8wnV2I62L/ZEj1KKC2nB/K10WXQ7ZpZ9N3D/pEaR4kUyVg76MRoHYkqsrNDrWttTI+fIOBx0XGjSLUVQ7i1dBGGDJyDXnnZBxfm3rrGF22V1CCN1gbgygtVR6ZQ7PB0DXTTPXpIVb0PoXhRxuzETB9ycP+mpgOlas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=SjccCrv4; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="SjccCrv4"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso3850606eec.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 15:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776206599; x=1776811399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xVaqx2bA0uX9Kc1Awl/FAoEiMPC51tiJH6XAaQB8+g=;
        b=SjccCrv4PlnV3GHaggNSfArQxDA/2uwZjjrobAMxHFvYkVDwxFkdJ0hAwmEPWwopVA
         JG4o2w09JoEUAslelG1d8gYXwiUPAD1XpQDUh1B/ydCES8jmpnY0bBg3BITVeSdUAxob
         AxgR3rsMgIXEzncgDoLUEB8xvQjhOO3yFiUoZRsSL9JGA7W3+Zlne29LHpL6WuPokOy1
         tE2LWGdWN8zvP8iw/X3wR/jIDh/CwaOON7D0L1/tCsdQ/W1pm+dGyAaFPPi+QCmieMru
         6uLpUFMVDkUPfEV5H9cH9p2TvOJsSK+H9sJKhtd2ZUxKTFwdmjea18gMKspom0tZst1v
         bOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776206599; x=1776811399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8xVaqx2bA0uX9Kc1Awl/FAoEiMPC51tiJH6XAaQB8+g=;
        b=mnllKirRPG/vmjK2MI94d/TfTLGdctoSVzY9Y/mOQ23yVKWJCDi6tKpJZViSXD2w2f
         hvm67pb7n5qHN+qIUEmfCZe6LirUSsoAsrckLla0ioU8vDrSxpGMueYn48DCmfPYpxZX
         g2sjmCVgKMGmUCUdmaYN8ykUN9gdRitFpIwLoH+w8etyWjlUZfMJ//gInk1FcvVdzjVV
         6sGoLvobLt9GbLKQCudr5qCOkfa/V2OK9CHvJJhflBmBuq8jxEUuhdMfuDFHPMo1eH8g
         jCQ1sf7wSsxgnORTcM9/yry03Uc1Av3c2eJqDh/ioV4K+c3Ar9+D/v+I0H97UOUXpil/
         QaQw==
X-Forwarded-Encrypted: i=1; AFNElJ/06lSi95un2n73G9OWUlz5U/5L3d5V5Utxl+0JwUMwj5Jtq5AX6PXzbd8s3JraKye1KlNLt8Lf45g=@vger.kernel.org
X-Gm-Message-State: AOJu0YznXGRVabpBero+lenKx65AG2mCnPqJdwxk3xlz2jxAMe/Xp4Jp
	QrlFntGqgIacgUPsh5cfdMdgN18fBLJ1fXDZDFQKLmIJTEuH3AKNThbJDEnj77pbkWE=
X-Gm-Gg: AeBDietujRZAcVS6VvxFIkfZkrJI+8ej1CC1WVRTueflrerErVsNhF/25Kc9K/81FJo
	N52yvMCBOGeRh0KL3ztwEzz25NtC+93eANNzmLrh3yBSfoApN2JOx3gA1Rtdtetx2JiKa8Rl72+
	XIqdHpgTgBGAXHbz2WHGLb3Bp5TWUMcAEyfYgTcYe6hSbkJHoiMtC5UvyP5tZ9aOCOoKznU6xIm
	B6yVOA9RUHxA2t/FYSW+aTfsxx5b4xlD0lloUdLLy++Isi37CdyaoyW+XOuWXWz4ZeXhoOFwdwu
	22xLqxbVh9OAxV6xpu9f66fEzuIq5mHs8J3W623N49uwRcOTTKnwhnBAP34GtB28yL5qRq8+9mR
	qlb9G9YmhNjBZ3XuR15DtnUKmCl1Hg/XZTXisIv7XydJurdi15M1AQwQUtIvXIh0h7O+3lHaLvy
	jmtIlu80keCr0BhqJkQC1frlSFP47mne3sw3U4Rh9bcrvrTdhmyOnrzU28hAvZtFhQgyIFXm+gQ
	9Y4hTBOmzKVIj6jVzfVFEsf7uLB/YLM89KQKcjro3hIC1w7/g==
X-Received: by 2002:a05:7301:2a27:b0:2be:acac:af7f with SMTP id 5a478bee46e88-2d40e3e6960mr10640030eec.7.1776206598921;
        Tue, 14 Apr 2026 15:43:18 -0700 (PDT)
Received: from gui-host.Dlink ([177.33.104.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2dd32dc2827sm4650361eec.23.2026.04.14.15.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 15:43:18 -0700 (PDT)
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
	Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Subject: [PATCH v3 1/3] iio: adc: xilinx-ams: fix out-of-bounds channel lookup in event handling
Date: Tue, 14 Apr 2026 19:40:33 -0300
Message-ID: <20260414224245.8493-2-guilherme.bozi@usp.br>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260414224245.8493-1-guilherme.bozi@usp.br>
References: <20260414224245.8493-1-guilherme.bozi@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ams_event_to_channel() may return a pointer past the end of
dev->channels when no matching scan_index is found. This can lead
to invalid memory access in ams_handle_event().

Add a bounds check in ams_event_to_channel() and return NULL when
no channel is found. Also guard the caller to safely handle this
case.

Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
---
 drivers/iio/adc/xilinx-ams.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 124470c92529..6191cd1b29a5 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -871,6 +871,9 @@ static const struct iio_chan_spec *ams_event_to_channel(struct iio_dev *dev,
 		if (dev->channels[i].scan_index == scan_index)
 			break;
 
+	if (i == dev->num_channels)
+		return NULL;
+
 	return &dev->channels[i];
 }
 
@@ -1012,6 +1015,8 @@ static void ams_handle_event(struct iio_dev *indio_dev, u32 event)
 	const struct iio_chan_spec *chan;
 
 	chan = ams_event_to_channel(indio_dev, event);
+	if (!chan)
+		return;
 
 	if (chan->type == IIO_TEMP) {
 		/*
-- 
2.47.3

