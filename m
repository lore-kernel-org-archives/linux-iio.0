Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105411;
	b=rz+SyJl5qzrOw6cndGodnBjuqhy1bXbXLFPw0CThYXBn4uUIwR9L0oU0dEtYolWMUfrR
	 Ex+rxjH6WajRTFkLRdfkV8I0cuDLo3LN3LUTv5VuWxJ7qobRmfU6BqfgF4pfmo3ElPucp
	 DeP3xW32ClKGS2wDdEQu8E4qBMdqpkuLcMFZB9LxFqK1vZ1u9k/WpL6WaCMLCPOTmAsf3
	 rNmwvzH+jhV4rv2SVj5VXutdsS7Th1a5mapuAw/b0SibZyoI6F/i/0nP2qm7ZHmZH0RS2
	 riVjputbPw6xTqjYzisuSnydD9JxNnZuMLrOmzz6TbPtDTa/fu1RSpoxEg9SP+qBpQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IAwqAAQD7kxOT9F2GvcLkLjakYWT0+JOrQ0Pn5dLBYQ=;
	b=bXGHhid0g6w8sogC259ryE1UgeKbYF2PS4yo4VC7V9Rir7Qwb6I2Uq/hVmJCDtJCpAkH
	 LaYTN0MKDX0JEJib+Ep4MXRHO1uJS0Go31Y25wGYq7ES1qWizYfVZ3adpxvcOZ6YSoW7n
	 p/allSMtl4SgiTRxLLi/0kV4InZEvdN0/qsGrCz02d4uwlWoiT9wVGMfci6GkZHZ5NSlq
	 k0VhYkdYfb2LffM06iiv/D2/P/EUuOIjWMPEmrmZA3QnU3ier537Jvhe1NWGvJDlxhZY+
	 QzQGe0aESdw4a/BB0F4+ZmYzlOPhWSf/UQGYFOoKT2wB92IhJhQJihAAnXLWuZRE/Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NmiDqgRR;
	arc=none smtp.remote-ip=209.85.167.43
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C47606A325
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 12:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9C47606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NmiDqgRR
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5be4fea434bso741714e87.1
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 05:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793105409; x=1793710209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IAwqAAQD7kxOT9F2GvcLkLjakYWT0+JOrQ0Pn5dLBYQ=;
        b=NmiDqgRRJrFmXSJIKbbdXABegTUZk0NZ6W3SMFeoK7ytpy859DpB0vLWWk62uy72mQ
         pjYh+EU5z+sZA1kfFMIrTvZhDlUciNH3ahDSHrCo6HP1QcGwD6O+YDtOovcxlTxHqNN4
         Ro+kBLbCWOtGF5rFurIW613Nu+0wZhXdZpEu442W4iwLLHs/hjUAR/earDMFAp3/UouE
         41zRkzSDusb840peCdvCfwDmpHcWRpVlOVJPVf0UHDD7HbGQ/6fUlMHtlC8qwacbXgFF
         LUleBgy9LOCvi8N+niD94TAuYGbhJFyMFzMhA/B3mQKjxu4KWIgniq9qJBQ1zRgW3akj
         IUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793105409; x=1793710209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IAwqAAQD7kxOT9F2GvcLkLjakYWT0+JOrQ0Pn5dLBYQ=;
        b=WV+Kw8DU1kb5pUXfFCVoJK4oHt8aZyTYcZ1MZUHZJMgRvotEjcD7K3Misy3owW0SQk
         NYwgMTv3oc3qfZI9ztQCE06/SC0RwOSrTrW5pYr38p1s1SlyOYwwZ4ELIvIUqgdvGPs9
         ClvMC4yizP3Zi1tSkPhgsXdvbewH8JY+x2rmUsxd+5KhVcvKXa/muiYFxKJFA9/+1CcD
         LBl4+j0VQ33L40O5eg6SNrfuezCOt1xpuUTE/GrOZuAP+qyPpmLEpc2aLBhSWOMK9x8/
         D5D24cbBpNNrP8Nv3x0TGxPKHuXj6cktxTf2dYWI+AM4m2SA4iHOvSS7wIQAHdvNlrtc
         zAbA==
X-Forwarded-Encrypted: i=1; AKwUvByJnMLu/6s/s4cRPU4NFsa74Cg/3mUe8nsBXP61nyrFTqZR0R57Cpqcn3K/rQsSIqnFw0faeYdPeIU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjwViuscsz6LLDx1sOrMdMVSZbXdKT/CLnObinvRplGADtuNwc
	DkXdDUCH+Pu9N7YAzCfafdHpgzkkNX/EbaIzwNWmoNNDqj14CIzhirmI
X-Gm-Gg: AYBFou092v+RzVV7Vlx5Az9E0rOJddCWInK5uA1EvIxyKnIInxzgGF7DCv/BqHU0a/5
	K8162L1eUNutpE09ws8EUWorrosaYDI0s0K+uyYFQueWxLcYDy/BapgQq7tc+wjpLp1h+BaBEUy
	ySoeYayzF7JX2hO2fy3w1cPVWvckz6Q8GiyTkBSwX4EKLsGB2+dRJaknBljuG6LPugdkIO211lx
	RMlX82j88/kyQbIs5UthnMOUnFwvihwymhLjWZjNE2piEW7GGiQLqAOAFXaFC30J7MC7LQrMWBZ
	3wUQwcvqei3zvmlQeVWZupKZtvN2NxlVCvJrEIKpH6Ljo5BQguHOqlEOYq6fUZtrYyQfuixeYcG
	Y7PvXsXL7Qf/6k85f+peLv5w3mAD75B9vqTEjAmGAMm0+YF9aXu13yo9y1cp7kdk8gnGsYv6zaS
	IhvaVmBwLDdNUFnsUOi2pDSxY6JBac6Fjrl8oGh9aXfUyEKxGNjb8Frr2bL4kWvUnEuNIl3GNu8
	0g0a4WP6x4hE38F8WsprrHmKNLgW5kiWnoT1Kq+7I4fLv/tRL65eiH5ryeOXSFW9pxl1m7AuYC4
	Dq6bYCXtUKwWlr1oazAX/T1FvFYZ7aJ/hhppgtVZESvZhAUJtNUmxc+UuPmk2BLRlxZG17VFdsv
	nyDe3liW/5w==
X-Received: by 2002:a05:6512:3981:b0:5b8:f430:b617 with SMTP id 2adb3069b0e04-5bfc618c82bmr832927e87.45.1793105408719;
        Tue, 27 Oct 2026 05:50:08 -0700 (PDT)
Received: from yantra.. (nekmmqtcmoboczbkdcs-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:55c8:a52b:6ba2:979c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7e7cb24sm2052803e87.25.2026.10.27.05.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:50:08 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	David Lechner <dlechner@baylibre.com>,
	Guenter Roeck <groeck@chromium.org>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Jinseob Kim <kimjinseob88@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Remi Buisson <remi.buisson@tdk.com>
Cc: chrome-platform@lists.linux.dev,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v4 6/9] iio: buffer-dma: annotate the queue lock helpers
Date: Tue, 27 Oct 2026 14:49:51 +0200
Message-ID: <20261027124954.110697-7-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027124954.110697-1-zoone.rupert@gmail.com>
References: <20261027124954.110697-1-zoone.rupert@gmail.com>
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

iio_dma_buffer_lock_queue() and iio_dma_buffer_unlock_queue() take and
release the queue lock for the core. Annotate them with that lock so
context analysis checks them.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
Cc: Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>

 drivers/iio/buffer/industrialio-buffer-dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index 1daac23087a7..b42b70e9b06d 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -763,6 +763,7 @@ struct device *iio_dma_buffer_get_dma_dev(struct iio_buffer *buffer)
 EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_get_dma_dev, "IIO_DMA_BUFFER");
 
 void iio_dma_buffer_lock_queue(struct iio_buffer *buffer)
+	__acquires(&iio_buffer_to_queue(buffer)->lock)
 {
 	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
 
@@ -771,6 +772,7 @@ void iio_dma_buffer_lock_queue(struct iio_buffer *buffer)
 EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_lock_queue, "IIO_DMA_BUFFER");
 
 void iio_dma_buffer_unlock_queue(struct iio_buffer *buffer)
+	__releases(&iio_buffer_to_queue(buffer)->lock)
 {
 	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
 
-- 
2.43.0

