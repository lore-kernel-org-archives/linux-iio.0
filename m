Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDFE481AA8
	for <linux-iio@vger.kernel.org>; Fri,  6 Mar 2026 21:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831564; cv=none; b=dVVefN5NORl7YbIV6zwgYXyIPOcUwgcEOM4WeS1fS8G9gS4PPhKN4HKWkzrSKkmhB5Krk3ClK/onPs/B72JKo3q/JpPEI621ku/AMF1x14u7kEUVYQTAeji0MRrNLw+N1cvY/xMcw9O+O3GcYsogVPPOrGYQVgJ3JFqHCs0m+4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831564; c=relaxed/simple;
	bh=C6YxLRngsnV6iVKVeI76PVQxODdf/D5qHVanu0aFThE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tL/dZwdeaD3PZfXi7xzXZZiAI8YxsgL+5Jl2S0E+y0m07TEGqpCeVFLZtt34w72wDEoUa+sjXDS3mYTpHuD9+EIByxuo8rqL74PaR55/V/odwY3+SykgkulwRnEhZk8WcgWvASoreBFJYnM7a3vH9tWAlt35Oz00Vprpcqb7P8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XatrYVj0; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XatrYVj0"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c73a12af63cso403384a12.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Mar 2026 13:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772831562; x=1773436362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NJ+6pAZ1XxHlfzt3tWmdu99ccs1g8MJT8rkgb8wMQA=;
        b=XatrYVj0Udsr0fP/ZoKGkYkIiJWNnN3q3pLHSBWcb5FSrl99Of9d+eN/OEpBjJ61Wz
         zPhmsXudQpRPDjDWn8Eje/NPieJd1g73kYo6s2DCphE38S7mMKJVSHuZ4e03xfbjX+7O
         5hIl9eL1xmg3HM77n1nSvTHRRVXMXmFuyBPOSms+bvQh3GGBvSwdXEiiEQ2IhAYGprVU
         hPic/2CLrwTKH62WLO1HnjpBqI8vSDpoW4k5D4JM0SVBeQxBeUaXc/jZBO8ncjeJDLLE
         UmBnwALYhUaiVoGzhYLg0azF/Q8lsntq1Nf1OMTHFwzrv5J5znL80qhDRG/RUbuMuR1J
         rj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772831562; x=1773436362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/NJ+6pAZ1XxHlfzt3tWmdu99ccs1g8MJT8rkgb8wMQA=;
        b=Voeojp4f7XxUtA3x48mDnQRQyWFOUeUDEc2K0ShytNEzbaKkJ4ozJrWBCEsy0F0Cnw
         PxS5A4/b4fRy6bFCuJjkfzp8mnAa/mDeC5tHfaWZsaf6RSe+XIbJMQoUrKwe428bxmQi
         LxvjJPUogOueCGxGvOs/AFbRpc4Ec6yl8RjePZgp8H71PU7MmIqR2lPvt6JH5TVsBhm+
         4NkCVsnH0q9D3tV/Kf6BTu+WMYgdlL60yIY2InJN/GMeJM/AW8go+dTLBnWpkyDRQY88
         rTVltNr4C+shkv5hogIvSLfikk/YlD8hFuBKYtYp/rggnWVs5F0AUUdiL/D/URzy0WgJ
         U1aA==
X-Gm-Message-State: AOJu0YxhSeT3MjfJg/z8CNGYuJQfKp2dWayBfsZYCrlrYWKvEvwx5BRr
	WBpb73Z8MbeQ1o7WC4uWtKD7SgaOkUflSOcHhWhTiW1RdV946f3ZkKGI
X-Gm-Gg: ATEYQzwdspHFTVLpjubrYSv4h3t6Zyt2+YOXxG1+ZF9NSgXSmyXg0c07UAHzPI94X4D
	PUdH1R7Z4laPHrAgxyuhy+7tvHqESL2HND/GDGS71sQEZJJkYVBCc9JMxeYxFtHK/m+M/y5X8+s
	qGm1waiSwRvCzZo2SLA5bwx0GF4MBmEaO9pJ53W1sdKvxhmfjdcTA3TUGY+zfM98NtnOExyWSLN
	XZs9o4bZDM4UlW9rlnXM8W1gWVeXUFIzRR7+sidgmXzn9jBiuFFgIxudMlaabLoHW92xJf4h4Xg
	4AQ7E74cBECUxC2nAdLci4nkSPgXEC7Y3w1yAi5ScT4I8s67kDXEY56nDmKj7MwsfS29eh4Nov8
	ey3an/NjRVJFkVfWTIjstB3b3+kA7ys2rKS5ftsplujJ+SgT7q1fUcKGYcndScl/zz1IRnzS4zV
	fLpFDnbyy4tHFcB4qJ1/8uZNejU//qI2ZkE1hwHjR3Szy74XWBN5wszfy5LZ5m3mYi6VJwhUDxj
	hh5GVyeSIKwm1oQcP7w6U7vhQp/r4pFYWw=
X-Received: by 2002:a05:6a21:e545:b0:2fa:26fb:4a7b with SMTP id adf61e73a8af0-398590b6ca2mr3220460637.57.1772831562337;
        Fri, 06 Mar 2026 13:12:42 -0800 (PST)
Received: from fedora ([103.215.156.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e170c87sm2661331a12.18.2026.03.06.13.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 13:12:40 -0800 (PST)
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
To: lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	puranjay@kernel.org,
	dlechner@baylibre.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Subject: [PATCH v2 0/3] iio: accel: convert to guard(mutex)
Date: Sat,  7 Mar 2026 02:41:49 +0530
Message-ID: <20260306211152.65109-1-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <d587dd07-ce23-49f1-9a38-ea741e4ef14c@baylibre.com>
References: <d587dd07-ce23-49f1-9a38-ea741e4ef14c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts manual mutex_lock/mutex_unlock pairs to
guard(mutex) in three ADXL accelerometer drivers. Each conversion
also simplifies error handling by removing goto labels and
returning directly.

v2: Split into one patch per driver as requested by David Lechner.
    Ensured each conversion also simplifies code flow.

Rajveer Chaudhari (3):
  iio: accel: adxl313: convert to guard(mutex)
  iio: accel: adxl355: convert to guard(mutex)
  iio: accel: adxl372: convert to guard(mutex)

 drivers/iio/accel/adxl313_core.c |  7 +++----
 drivers/iio/accel/adxl355_core.c | 27 ++++++++-------------------
 drivers/iio/accel/adxl372.c      |  8 +++-----
 3 files changed, 14 insertions(+), 28 deletions(-)

-- 
2.53.0

