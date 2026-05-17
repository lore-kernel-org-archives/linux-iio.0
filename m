Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB55930E82B
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779035047; cv=none; b=eS2pU6tnrdMaaBbRVIbWyjhVYuqM/vFml5RZAa/aHHST7VyvuRtE7k9LorI0UVKgHzBx4YAytZxHnSjXFuyV8MCOOqdfkf36k6OVRMx86MDrZB0itL5fYi2dy6b8iNoodGozt+9LNcSpiCeybpQx/Fz+iX29mCJ130AVpghOC7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779035047; c=relaxed/simple;
	bh=szJiY6EJbu4bYlsozrvbiskziHki0cBuDtsWP1MNp+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cg8aT30KV0ikKuKh3OPbt+JV79DOMv1+ipC+0KRm/iQXVQ4ohaku1AEcca+IPMz++ZEVhZvnYWAG/R8qz2HiJMFJwyDupOwvMGHHyjEl3n2MsAAXmg5oMlBiOtcdPN+hQ41FNw4mpBjAHXgO1sfi+bMdiPeRFuGeJZhEXUXqUlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZOgsJOw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZOgsJOw"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-449cdc12a8aso209184f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 09:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779035044; x=1779639844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4xQUzenjZFV6yOOyNJ+dSYEulDJrlac0Nc+paPih8Tk=;
        b=kZOgsJOwmXvQPSNYWHmCr34oTy9ILavNhr5IZDPv5N+W+3rxCys5y5p8EWMeS2uMPJ
         QkgKy8pAhpSkio3CmNAVaBDqX7E0k9GpIfstIvimgYenRB+Cxn+H5yPJ+G1hBdjuMTMP
         iwQLAO2W819MdvjbZIwoJ1CvVbh2HpZWWICXeXi/1rItMcaV1HPjymR3Dpuf1Zer1QpN
         9AIWDpsQDOrWLwKyL+rcwtsAgPSCBVDo7QY5F2bTeqpLr+0E+ODQV2qfttY5Xt5zPb0E
         jMlYUtaZD1/PvhzwaBXswowJyFDFf0PVNtooCoV5IGfyavvQ5SWI5AXPDvN0aZmTVQC4
         kxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779035044; x=1779639844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xQUzenjZFV6yOOyNJ+dSYEulDJrlac0Nc+paPih8Tk=;
        b=i7eMxo4Cqs3uRI6c8vb3OEkZCrtdQd6vq9C0KRbFWiT1u9zpvI6tgL2D0zozp8N0FO
         nsSbVdwmKo/gYigVMNZF9R8sDPHRrJzDg4kLU1Y4z/ZE/4t4pNt/5cmf8rxkUzBv0WCs
         jPG8haDwDK610UuzUxxcNZ3c81C3g1aPJ+nnN1GOM9t8j6CSvE5mpRfmjzi+HBhB//cr
         35g4VhWrj2cXkkhGzxDPavZquEb9QcYIQE79eyohyx9599cVOPmPcQh/G3X5mKcAeYhT
         vZtN7SalxzknZ9iLlHWv4MQ8GEf0rbztwC/7TJsH6aQFTU9zioJwqphJ90cHtF84O2sE
         iAmA==
X-Forwarded-Encrypted: i=1; AFNElJ+MDiyqR/hC/sDWlswXNxaJ4xEJY1AsKqRD/8Y7sXO/NLQBeOShXcfDgkcTNI3asDvE2ygcqsCwp80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+u3wPD3ua8BY2+IvvnzUcyGoNInqw9QnX4aUZZ7or+1fkR2Ee
	oSlizBOz+bk5W5q0MblHROU7rSjH3jIabdi5vjCl69fvInl/77wmk6T+
X-Gm-Gg: Acq92OFX/d18c/EVjKOwNlpY4d9bA10w/tzFsuephXRLgh8ObV4gDpwGbOiV5T0jsvJ
	do9e7lEGxkH5trDgXgY7HQqFtKykzVNuV0rgIHedK0vYWRG/SJoRHIbyg99zX/horVwHrI95ITS
	TPaE6Boc5NG+P+8ClnJVUkEWQo+CG/sg1GIZpbcIz4rKUp+pS4O24uot2XmcIrt1vDRnsugRtoa
	D1Nqe5V8TzF8pWldcIwbyvceY2prWP/Sl2/JjGLl9G6vanO63MbcmvKimjedxrQAfaoQprDc0/X
	V7ZUIu6zEx88SpgTgS1s5I68hUTb03UBEZr3MHxDm7fcv+41vxIETMiwnzZetKe1L/p9MJVRJSh
	Exn2+9IF07i+OvYmru/3isrS3ukrIn7hYRkaDqhFozRXjntt0lB2a4RnqroIpHagaV7rIBI/y8j
	EmLLZ8GrxuiaCD9B9Elml3o5Fi5yJd5e/ca+E19wZd1B3c
X-Received: by 2002:a05:6000:1ac7:b0:43e:a978:c25e with SMTP id ffacd0b85a97d-45e5c37d119mr8648504f8f.1.1779035043883;
        Sun, 17 May 2026 09:24:03 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19c2dsm31481840f8f.21.2026.05.17.09.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 09:24:03 -0700 (PDT)
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
Date: Sun, 17 May 2026 21:23:46 +0500
Message-Id: <20260517162346.189-1-sozdayvek@gmail.com>
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

