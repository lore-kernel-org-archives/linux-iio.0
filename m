Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795866951;
	b=s3VjEE9W+N7+ztZRzKR/JRSzs2BlASGsQBjPgKnwChNEiTnmsSFxhGmlzsWOxQSicnzP
	 iId+q3aD0n+GQYz2y4gcMpYB2EuNVTJgXIj1V4WFUuWhcb7/BUvJkWSZUxDphfQ/2ZQEi
	 vxgoAbew/2ziH/c4IuxQdakT8+Un1+MsrWsS6cpvV1SlAW2QaW6nDTI+VOzwJ6ks0e7fo
	 ztoSG3wWMqT2oa2ga35LXV/LEVYNn32XFwIi76MZnYg+5kA+lFSj4dcLAvN5fgigTvhG5
	 /dOj0J9nvKqsF6MUIxOTGi8s+hg1R/MpYVKh8c3h9TX+lNZ4e5REkXl36vLGUdsHBOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795866951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Kj+W82NANvfKgUyKf6IsWAM4Mpg0yQ4fSrxz7u58oqs=;
	b=2devU/Yac8Mo8TwpngplHy8oojpCPWGLkf0xwNz7TPQCFSJrtKktBvKDtNaA8H0kQqh9
	 BLXrAEPIf9Vhoh542xv6+FlbGjt23xJVpLzn7lSEb3IDApHPFBQ6MJ4uHdbmEMPlgzdwm
	 /Z/mxGrawJ3LkEA1P+h5488EJjLf4SqbDHHeK13y7sysQCJVMUoKlJ9X2bX//wKxcDid8
	 TTzv2PxC2KseSNM6/xA0o0OS+A/2lPk072b3NIf/uZ9dB7k1u8sYzX0NnNUxXUJBwOSXC
	 /UaSc7bWcofYJGmBjNDUnEdGLOqDXDNCYlgiwUx27LD0MghPkKA0LZf1oOM+KUJ9NcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fIY++pzt;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD627606A31F
	for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 11:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD627606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fIY++pzt
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-38431138772so11759730eec.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 03:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795866950; x=1796471750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kj+W82NANvfKgUyKf6IsWAM4Mpg0yQ4fSrxz7u58oqs=;
        b=fIY++pztOrkz3mXgf9ib4t6dfFX8OBpQkX0lKw53kp5erKJDD623zwcOExT2Rh11uW
         nNDm9wk1w8jWWreUGfYMBa0VGMf4a8WTwRYeMK8D4z1o1GIEoPyRNh6tKxcWtNBahuMs
         vxw6viH2/G0RoT/6U4ziIm39DLbpfapcNBFUd2LciAwu7fFoz6knYewxd7EtXxxo5g97
         idD2+Cm/qJLXDoji2Kb5PosFXr7RaMCi+Hyy1OmoxARpe7i3Tj0cWs05N8K+0QiLe0A9
         0+KeT+YGy4QPN+paY/OTdgYkIU1SIZgG5TviGk52oeeYARA/ZvDw99r4uCMpKSHa1w/Y
         I6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795866950; x=1796471750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kj+W82NANvfKgUyKf6IsWAM4Mpg0yQ4fSrxz7u58oqs=;
        b=ITa6Im3kcwar+Y4jhhuo+zuQ7ffZ6XugWScUn6ZvLGBwDfHeFcMdZxakQ+fZqO7Paq
         c1/6SXuLPJxiuNmlFYA/9wMDyJhzYdM9dPNdS3pc1XmoyQfOyT/aWyZE5OasJLWBIO2M
         wwgiKFYGJ1axgUBBEAHsLm/AMifWD8ZGxA7Ad0/2cTORNA7od5dg+NWjIBqJXWcIeNOi
         vPNabmjNKezJauhlx5l6g+pztGi0U0HLV8oVY0BShTsHGI2ilFd+mgWlU/rXaUhHWkDX
         7m3ZygOKK+A8YGABi01Quh77/ByC5PxKAHbhlJf4Vwxt/lkSMCWBwmwb3lNjJge2oKmh
         xESw==
X-Forwarded-Encrypted: i=1; AL+hErG9X/y6o5UizGHjZ+hKUY85QbB5pvrOnSgVO6IqMaQt+AFVADIitVLbBi5oF1el0CWkmuYSxNW9iCs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9G6dU68VVJsuQimiWmh8NqDlTSYWRBz+XJxa2Edtpg5VP4J+l9
	K7CiJBTDMYxWpFS+IlnvOXHBgzeTnnFOLxvl0l5aeucjTVpv8spg5fWv
X-Gm-Gg: AZFdTZdxyvroeTp/HYdzHj1v1/CQx9F7vwRTHMhUiuhFR4XBfntmKJH0m3XloJxpLWH
	FOtSypXRStnVsS3+Mg/OvrbPUE9k2gxR/pQ/Onfy/uApBPhkrxluvWGSrbyR7kKtF+MbEBYt0S+
	0JperHR0FV60AwL4IRZ2um5B2MASjTcIARKzeovty0OyjKSvR6bmPRouTMqF+zlcHPwr51r3gMA
	qsVxLLMq4MhFUud/56tG5O8ocrlaXJpnpvRUCEEg9lre/I0IIpvdSSoEVEI5pmVMCkCgGDo5kgH
	0zClOzegn7chYtjgSGsDfLTPSVHeJ11Xf6SirYTqtAAR9seLLohQIdemKFRn96en9RdZlsKYR74
	pWhk+4iAAOMBpJ+NFPQViUrErXQeWrLXJaqxXxoqaoIBicJ8KJMvJAfx7VNBqU4zEWdZkTuJNS0
	92C1WInxCVz5G8K7UanPaAIba3RnIBNzfjHloho6Mpt5ui51QmfkUe+sUCq7nAthVpcK+xdfEJC
	bCUTAt6AGoks0TKDtv01NJtUgkDPD9+vvHO477ITxDBg9/512jTcEavVrca1Hg6b0Ua8w0vHjUX
	jPrNccI6QuVFxnJ7tT5LoRcFuniVJP2fde/YPWr/yGi3lbcBlYiPdSxYqC+OZwBB3o16qAGPAVu
	f9brNtgG78sKqLU+x8R+UK3BFXgydvcFNEfwyLJ1n1W1+FvLepU2gFHMP6xXJKqBDwOM/HedTG9
	JgbHMquD6YZolUCb53DqAWsS20wYc8mL182y6Ztto3SHoM/me7dKqCyExEgE85aWU=
X-Received: by 2002:a05:7300:ac82:b0:385:4b9:18f2 with SMTP id 5a478bee46e88-3857093f077mr40135576eec.21.1795866949795;
        Sat, 28 Nov 2026 03:55:49 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385f68bc0adsm76783178eec.13.2026.11.28.03.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 03:55:49 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v3 1/6] iio: proximity: sx_common: fix raw reads while the trigger is in use
Date: Sat, 28 Nov 2026 17:24:49 +0530
Message-ID: <20261128115534.558478-2-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261128115534.558478-1-kapoorarnav43@gmail.com>
References: <20261128115534.558478-1-kapoorarnav43@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sx_common_read_proximity() only reinitialises the completion after
waiting on it, so a complete() that arrives when no read is waiting is
consumed by the next read, which then returns old data without waiting
for a conversion that includes the channel it just enabled. This
happens in two ways:

- The device trigger has no validate_device(), so another IIO device
  can use it. While it does, set_trigger_state() keeps the CONVDONE
  interrupt enabled and the IRQ thread calls complete() for every
  conversion.
- A read interrupted by a signal reinitialises the completion and
  returns, but a CONVDONE interrupt already raised can still complete
  it once the mutex is dropped.

Also, when it is done, the read disables the CONVDONE interrupt
unconditionally, which stops the trigger for the other device.

Reinitialise the completion before enabling the interrupt, and leave
the interrupt enabled when the trigger is, as set_trigger_state()
already does for pending raw reads.

The interrupted-wait case was reported by the Sashiko AI reviewer on an
unrelated sx9324 patch.

Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx_common.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
index 4d4937395d9a..66d06435da05 100644
--- a/drivers/iio/proximity/sx_common.c
+++ b/drivers/iio/proximity/sx_common.c
@@ -167,6 +167,15 @@ static int sx_common_put_event_channel(struct sx_common_data *data, int channel)
 				     data->chan_event & ~BIT(channel));
 }
 
+/* The trigger needs the CONVDONE interrupt too, leave it on while in use. */
+static int sx_common_put_convdone_irq(struct sx_common_data *data)
+{
+	if (data->trigger_enabled)
+		return 0;
+
+	return sx_common_disable_irq(data, SX_COMMON_CONVDONE_IRQ);
+}
+
 /**
  * sx_common_read_proximity() - Read raw proximity value.
  * @data:	Internal data
@@ -188,18 +197,22 @@ int sx_common_read_proximity(struct sx_common_data *data,
 	if (ret)
 		goto out;
 
+	/*
+	 * Forget conversions that completed before this read, e.g. while the
+	 * trigger was in use, so that we wait for a fresh one.
+	 */
+	reinit_completion(&data->completion);
+
 	ret = sx_common_enable_irq(data, SX_COMMON_CONVDONE_IRQ);
 	if (ret)
 		goto out_put_channel;
 
 	mutex_unlock(&data->mutex);
 
-	if (data->client->irq) {
+	if (data->client->irq)
 		ret = wait_for_completion_interruptible(&data->completion);
-		reinit_completion(&data->completion);
-	} else {
+	else
 		ret = data->chip_info->ops.wait_for_sample(data);
-	}
 
 	mutex_lock(&data->mutex);
 
@@ -212,7 +225,7 @@ int sx_common_read_proximity(struct sx_common_data *data,
 
 	*val = sign_extend32(be16_to_cpu(rawval), chan->scan_type.realbits - 1);
 
-	ret = sx_common_disable_irq(data, SX_COMMON_CONVDONE_IRQ);
+	ret = sx_common_put_convdone_irq(data);
 	if (ret)
 		goto out_put_channel;
 
@@ -225,7 +238,7 @@ int sx_common_read_proximity(struct sx_common_data *data,
 	return IIO_VAL_INT;
 
 out_disable_irq:
-	sx_common_disable_irq(data, SX_COMMON_CONVDONE_IRQ);
+	sx_common_put_convdone_irq(data);
 out_put_channel:
 	sx_common_put_read_channel(data, chan->channel);
 out:
-- 
2.53.0

