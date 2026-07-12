Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4979B3B42C2
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783887913; cv=none; b=eaSW8DQT7gpWUyCYuSDFkSiaWO9+2k9YBnvGHJgLSE5xwocCMHjcoHmB3bSs+K9YgLNSnjQGo60XP+9rqCDVkk05aCGEO///Bv/1B4OLuWZ6a+wnBdxOZ1oK+OTeQSfSVjqpgZjkMED1saVKE6AhzcP11F73QjPlOVaXpoQEtg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783887913; c=relaxed/simple;
	bh=Ie4QE5BtziviDMAyslSY0sDbsQrtqCcEe/nHREKcIUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EqL1tDGx2MzYFsR553XOxf30teH5+m89Q+k7ASfy8jsjsAIvjS8tgLqX9PjXllABzrIpwJr+uf4jF4wYVt0CRgbJigJf5dPsYMo/W50ooI2rrA85IhwJf1dOi4WULoAz9Bo3R47ApRI/TNtWMtX/ESpHonXO8rK+PO7VzI9KwpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvqUcCBw; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvqUcCBw"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-384c94c9414so2272029a91.3
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 13:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783887912; x=1784492712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S0dLTgYy+mXCVxclK16Wz025jqN47A32NMw101nFP40=;
        b=jvqUcCBww8/rSFKWhw2zpe87tmyOX8QTX//EMGRjTg4vvwXgV9mIYQtoq4C8Bt8nH8
         AblKWfigBWwRyu2IEpS3jOFyak0eakWzrcHZmKaduM7b03lO2ed8Q+qjhO0x+1Yyhvs0
         Z39b5B/ek/ezUiX2T0hhZCuwZ5+IPWEtMTFWFUbRMMP8r8M2KeIxb5+2ODTau/vRXCKA
         uWRKqE8p74UiDjQBtMSxLq9j939bRhOxQleXFX70XOhZaQptfKnlE1UNeh9lsoqxFsCN
         1y+cSkGBzBs+LaDLlYcD/c40Qef4boH5hqLxGg/8WNv8FLjTZVQi/w+t3AblhqDsiJY8
         L8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783887912; x=1784492712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S0dLTgYy+mXCVxclK16Wz025jqN47A32NMw101nFP40=;
        b=ZYATS4b2z06XByz7hALniHtqnNwRmJpViMEeV8+qm3pGpUu9djubY3LHJJsdQQQ0RN
         +7WOJM8xUIlmmc1pUzSoeG5Ko4oVgyIiHJcduHJzuvVQt4KZhupmeBKuTf4lD/rOEMD+
         J3isUsMHMQxi8NmrUzTYlj3+6II4KiryabhqOuMrm7A85s3IWe9Pmoon1WlElCpt3kd3
         j5O7w+Fw0zDXD+Iui5ombHigwNmAspxRdjxlVG1NfYLgMref/jTcQHbd2Sbp7i6UCViR
         r+T/HcHFjLD9SQ5pRyJasmb6kXjC2VSjU5Hh5VG+s5cvLFgwpf2suS2eHuYRJ5nsJk6t
         aJIg==
X-Forwarded-Encrypted: i=1; AHgh+Rq5gfXxcD2O6zqlPp8hu978EQ7fI0yECdoSHWdNaH0dsqfz/SVeinlhFnXrtpmvVmVY4PFJfJnv1QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKxMHZIp+sl0jvMfmNF47vMQp9Zf+OCcV4Amuj2gRngPRxF3ZQ
	7Sl3xwsKmtgjkz9itntnK/vde1SoauRSKK1T/m93tuX5XbAl4UQGCDI=
X-Gm-Gg: AfdE7cn2nrWivLfE8VQMKeECOUyaaa3cyW0U8UoNK+dVt8X/vbVaGu/1osqWNyY6H+2
	hmvvckGNRMiT/EHBDd32xTbVhAqs0X2uIt2VnPklu100//+8xG6VgSfhXD+QVjSAIfOJDrCNMet
	iT6Vzu2YQWYbNRVNSJ1SGbk0PCdWOuwAFCmErucFSs4Hf0amgIgG4LibI6c1SQFMupUbaS3bF7z
	ylRzvUrlxUvblyNOIkQZDbpXeJ9lQK4OZTRGNTrQpYlZGh8DSjqspC2Wnfuo6NaCybk4IJPaUj6
	PsUR5QrGXQqHtvQrb7Y0eLuSHSB7cJl/5zeJi0gM4Z9mg5HGO3pNmHiDIJuQwLm9eM6qnssmZK1
	a0HhpE6/KCmdrkfSX8zEpJPRVwJnQMlOO4KPuXOjVUzRBSUINs/xtYUJjG2NY7/G4SgoPGWBpuX
	NMx85nFwq2K1Vn+tNiMbDwkjNz7O8LmJq+1xpWb+MwPPEWrqdcgoAC
X-Received: by 2002:a17:90b:3c4e:b0:385:d033:d9f1 with SMTP id 98e67ed59e1d1-38dc7777d37mr6876741a91.28.1783887911546;
        Sun, 12 Jul 2026 13:25:11 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm58833648eec.4.2026.07.12.13.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 13:25:11 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v1 3/4] iio: light: opt4001: Reject integration times with a non-zero seconds part
Date: Mon, 13 Jul 2026 01:54:50 +0530
Message-Id: <20260712202451.20822-4-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260712202451.20822-1-nikhilgtr@gmail.com>
References: <20260712202451.20822-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

opt4001_write_raw() only looks at val2 when setting the integration
time, so a write such as 1.000600 is silently accepted as 600 us.
Return -EINVAL if val is non-zero.

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/light/opt4001.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index bdb1eadbd450..31a5397926eb 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -288,6 +288,8 @@ static int opt4001_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
+		if (val)
+			return -EINVAL;
 		int_time = opt4001_als_time_to_index(val2);
 		if (int_time < 0)
 			return int_time;
-- 
2.39.5

