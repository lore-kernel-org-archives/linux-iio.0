Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C510442EEBC
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181097; cv=none; b=l7Y9zaHCTcZAjGkzyko1WkBFdRXfFAxqJpIthFUuViODh6e2cq+6T5wKgWkpr/JgJVQLDeCWy6fBobbnrGf9lx0x+vCqZIMWN18do0FYTjjOE2ZU/hy5a0RTm0r/JHRZ8joibc5IabkM3jT2Qm1dug+5wpFbyVARPy+6tccgA3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181097; c=relaxed/simple;
	bh=j0mREre/V4zhpIUlfvuyfdH9TcuG3RwfhnEOeE8IXp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVCodlz/CZCSYYKcBsbd/32AcYz1maDZcwU70D+hjZ5B9cKIxmjyzHJAabetHyBcAHmmEXCR6nHwsCNkVxTa8jDIVUhnyUR7Ah7QWv0dtocV+UsmzfvIeWE18Bl07iamk86NM6wxBs8yJoJVsrh2Lv+x48OnAsgH/iKSb912l/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWnii2CF; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWnii2CF"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-393da8f389bso10354991fa.1
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 12:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778181094; x=1778785894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0/fayNN8YS7EuF5ye+JymuCUV3TDyEltikHs2mZ5J0=;
        b=kWnii2CFdY+HzHXoGzsIgOJ6NENPxTDYIg3YCDlbEfv/gHCmKf8/4OGC5/cAjGG8wQ
         Mrd1A4digcuacM0kVfmvTjllWowwXLHOo0RdxTI4N0ksDvfHFBK+/JrzPypJp6JZXpn+
         u9eEppYuHh4WTVuxSY6Thc43x963LaWaoTRqyKdiurkhyvo+nQyKJmMDHUzJPNrCkEyF
         LF4SSQKZCAhzIluuYtyHZQ1t2sXXghNslh0jeY1Eiyk/mO+O5bL/6HHoADlAOjsUGzm3
         NUWJuJmvWa1OTrAcIT4Et8l/bXntRM4xNlLottf56eTKIjMudDKXnZ9Tc+6fXJ90qaXz
         UOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778181094; x=1778785894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M0/fayNN8YS7EuF5ye+JymuCUV3TDyEltikHs2mZ5J0=;
        b=nVI9whbjnGF1gQncDQTYcxK0UCqBl/mNXmz0kPyEV5jdpIarMAgBB5zCFlTDJfV6kG
         Zw/hcDXLvBMrcip5vVzq34GlPU0PV1mTy6VwCWobxEYg7qkTzhv6oTbko0RkKgGT+qh+
         /UnjNeyV7S4i9f7QJNeqpRMbYX5UZhlrN+veZ4dhCEOP+BbGt1bd9WJnHLZnKvNQHCZk
         W2RP+r480KT+p847TySL5n5xSedFHHCoJAzMe93/wpFLJRdLEaHz35I4+epMr3WymvT+
         FpXJ+5xt630j0AiMDai6fKnTgOWbHWcvB5QjExDixl0XunSoNyG5lOoa45pGTMlsXARP
         opbQ==
X-Gm-Message-State: AOJu0YxPIz75Qniv3ugr25m8tq2aARP/BKT5IboaDLBCRJ+ZGbqyMhEf
	+9o5OVNiAL5WEt3rUNDfUGQQsfTLcyKqtDoG/Q4Pg53GvYwf7setgqpy
X-Gm-Gg: AeBDietaHOGFLzMFzPcD24qT+BEiMWph55/t+kx2/9E/A2VZ6Cs4wMY9HWgj7BzCa2i
	7kiA5+OTciC7JmwfUl9Tg+cpfs9KaC9kZTgsVtar43yKdgPd/jnRSooV3zQgKnWELPyrednOpgp
	VtnikUwEIlqRI8sI7vcTDwO9RDSnOsTj/JLUxlFbATZ1lpGOwDbzkcyYJhIPE0jwLeMuM3c/eYI
	PK4ZuwgtgnYn5KaGvR+U16V4ZkECi6OajUwsyRVB40wQE+VELd06iDn9dbugLbcEwmF+be2fLIB
	yZ07g77+upZWyelv7XJoeknjXJ+iQEyMqG/jnEU3p+ollk5xM4pLcwuepHFM9qy4hpPx+yFIhpk
	lbGrMGdgTnbvacd3NsDCgCN+l/MWAGvWiwGch15LZX83UqBo3/FVI/F1W7solXZ0FjO2i1RoXiY
	JMrQcnBiRcKt5aNcuY0B2eG8njZW9WTE7n+Rd999YV9rOMk/giOA3qkqyU3LF5vzqV9lNAvR333
	6s=
X-Received: by 2002:a05:651c:4187:b0:393:d6dd:e8a1 with SMTP id 38308e7fff4ca-393d6ddee4cmr17245721fa.2.1778181093803;
        Thu, 07 May 2026 12:11:33 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393ef1b2b91sm1612271fa.1.2026.05.07.12.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 12:11:33 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: jic23@kernel.org,
	mike.looijmans@topic.nl
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v3 2/3] iio: adc: ti-ads1298: Fix timeout comment and value
Date: Thu,  7 May 2026 22:11:27 +0300
Message-ID: <20260507191129.25924-2-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260507191129.25924-1-shofiqtest@gmail.com>
References: <20260507191129.25924-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the lowest supported data rate of 250Hz, one conversion period is
4ms, not 40ms. Fix the comment to correctly reflect the timing and
reduce the timeout from 50ms to 5ms, which is still more than enough
margin.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/iio/adc/ti-ads1298.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index cf5f954206..8957e873e1 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -210,7 +210,7 @@ static int ads1298_read_one(struct ads1298_private *priv, int chan_index)
 		return ret;
 	}

-	/* Cannot take longer than 40ms (250Hz) */
-	ret = wait_for_completion_timeout(&priv->completion, msecs_to_jiffies(50));
+	/* Cannot take longer than 4ms at the lowest rate (250Hz) */
+	ret = wait_for_completion_timeout(&priv->completion, msecs_to_jiffies(5));
 	if (!ret)
 		return -ETIMEDOUT;
--
2.54.0.windows.1

