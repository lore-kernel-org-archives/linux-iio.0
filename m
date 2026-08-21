Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84FA495515
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321162; cv=none; b=G0USc7UCLZWEFQ1OxeJZNHwcipYgBMBV1UDKFgc1a3Mq5yKG1JeXNx+N+i4ZJVECyUNyap6vMqXCUpIKCfbwZQr+VYf71EnKNSa5ZRfpW/BrCZemfVUrrgMewk1w9q9J7sGazMzA2Fip8LBqKpUBUEJdDdkntPC7S9o8krgjmEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321162; c=relaxed/simple;
	bh=xILDZ72jxyZjQyjzCib3BAQvXdPbb4nq60xTHag8v1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTTGDT7OG4iEMmOLh3fGc2I5037WNjNoeoQ4/MwhWyhUlbDNXHZrEcDazDBY3rAbFhUwthl8u4FVhTzlEDTDw1KtDUucA+OIgWlZB94H594n+I6bUmrS1lHqzKvR3jSKm649PkFFciDuQhKrkJO1wLCzdPxbVcB0Wrf1gpiru5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmaxryG9; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmaxryG9"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47fecbbafdaso361141f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 07:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787321158; x=1787925958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2KWpd/hfgwq+s4+WzVsyz6lYrq4eStvmkgNPPTNL3hk=;
        b=HmaxryG95saLYPC8xqFjVZcbzy1528Y3QyjsObQlvnxlUXhf3zIk2ZFj+TwRaIqHcB
         +f8HJ57gAApzJkNl+nUORdSTJuDFT4EO+QxwcU0uVZUpDnhTxfb5v3vo2EYclFdmkpcq
         3UcwSaVqTL09ERZKwiqyfrorOka8Mk0rxdA6RJik4XhLRYxK7tbygyRsCoP3W7fNllag
         nbfBv3Z0z0BQB07LLd9eRjvDJKOCxY4F+PxHfJoevONtXC3cgceUArFCIuO3vfAHqity
         38ZkFZJVY5HbuEGEO2jTZp0yjwsCZyL5h/z+U9ukkyYhrJl/xc8UX+6tJx++PYOWftKd
         Sg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787321158; x=1787925958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2KWpd/hfgwq+s4+WzVsyz6lYrq4eStvmkgNPPTNL3hk=;
        b=Ha4FfjD2AzZx3lotv30B1/KlPiN+GGqmqUqbCKvQv8heII4r9VG8f4feshL0/+bcuV
         8bmUevtqzLn0gNNXrJq0Lxpf322kjPUp4UOUSz6pel0cl3GVKp4VaOIXcqXGzTKAcu4s
         bnpoquh+wGDe/JSM8dJ7AraYnkyni1kdPp7C8lmxfPQLTSxvFb0sBACKsKK7Xu+9DJFF
         ULs5JkUkgnbbkXiJLOiCrMGDsKNsIQU0pY12fcl9TpANxi0kds6Tj5fJGLVYYx3kjbRa
         eapvqFO+KKnNNkfOADDeFIrmXm3+O66N6wGJJ0PrXyraOwy7SVPjS5rf1sz3tTkszbkW
         +mxg==
X-Forwarded-Encrypted: i=1; AHgh+RpnhSGwVQgV3lYDK1qJ/g26kMoAa9MvpuNTYBnftRLRryd4iRX52vHI2mP6ywI41Evak65Cf7v/FK8=@vger.kernel.org
X-Gm-Message-State: AFuF++lokT8fDoFWtto4VJcwu3N8qY4sE9UzJs6H+L5LuZ4TsCiZt4HZ
	Q+Uru62erv6myqwxIb9FTh/N8u/RWR0IY3n0BjlOzKjHZ0D3znpAVT80
X-Gm-Gg: AR+sD11sJACPyTfZL1mKNkhhpnoasBApcRpEKqYQN8w4uF4IDOKvWb+sn/lx34de5/C
	l4Olv1e4M/sr0vuZxnrEc4V6bBHc7G0JqdeNvWE/CnGla3+98kzbJI47Sb2EUnc2vMC5by059Nm
	afTQr4pMoZz3cTQbz7zLhp3Noy/Lbneyn+oefEdthvCALga0zLyABN7MlkIbaWsWz5nYtB+teEm
	1KaovmNEYx7VT2OH+ByCYcPi24B8b5GBJTVJ9ki3v0XE3ubdPPAoUP6QVMeyqAWTkn5U8OhXMLP
	z8ZtyAmO1kiACQLyc9nS/GxeU34Sh7SrbJ2Zx4jFduDyZ2bnvuShDiKWXYCMwUgPiUO1Ta4Qt/0
	hX9yLkxI7f6wB/Ed4/qVwhhMJGI/hgEITzqezGlt6NJ0hQjegln1qDGzvJG+JX81DKWXU6/a9lY
	mruwfdUoFu/1J7TpYFfEcg3/uYxs1VVcRCggf5yJkedm5dbfNBNRc/Vgbr2/7532vCyHe+7CEAV
	4T9blJ3IQBrNxgTdmwUKojpaFp439RqAZA=
X-Received: by 2002:a05:6000:2584:b0:482:a909:53d3 with SMTP id ffacd0b85a97d-482c0b42303mr9294147f8f.2.1787321157774;
        Fri, 21 Aug 2026 07:05:57 -0700 (PDT)
Received: from MacBookPro ([2001:8a0:6c97:6700:9816:5963:8c6d:ec64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c3775sm15106964f8f.26.2026.08.21.07.05.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 07:05:56 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iio: gyro: adxrs290: use iio_push_to_buffers_with_ts()
Date: Fri, 21 Aug 2026 15:05:51 +0100
Message-ID: <20260821140553.80246-2-grondon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260821140553.80246-1-grondon@gmail.com>
References: <20260821140553.80246-1-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

Signed-off-by: Gabriel Rondon <grondon@gmail.com>
---
 drivers/iio/gyro/adxrs290.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index 563de2724396..b61cc81122a6 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -502,8 +502,8 @@ static irqreturn_t adxrs290_trigger_handler(int irq, void *p)
 		if (ret < 0)
 			break;
 
-		iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
-						   pf->timestamp);
+		iio_push_to_buffers_with_ts(indio_dev, &st->buffer,
+					    sizeof(st->buffer), pf->timestamp);
 	} while (0);
 
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.50.1 (Apple Git-155)

