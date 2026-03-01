Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BFB32D7FB
	for <linux-iio@vger.kernel.org>; Sun,  1 Mar 2026 20:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772396732; cv=none; b=TMMu5A6jaa8WlyAg/17Vu/FpmzvbBMwDSNuQZRjObI+T3JUbgboZo+O5GBHtbOWrqCnK62MFnpWwQQ1dtgbFTjRHc42s7JkhP3ynhN39P1kK5oEbOBN39T48FQDa10blyhsFvyslwtfsJnW6uWxmt9kMxMgmUZsyz0cO2lkic1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772396732; c=relaxed/simple;
	bh=kJFC0cNDBL/nIBecpTcNbA8LBt6F3LAD5vRbaC5j9fE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YrUvVGp5W7dVCcOdC9cW7yEZzkWRwJuTkMCNw23/L7ZawORx2ZH/WrC9Idn0c1xb3l4saO6v+2sEd/FZDiKSG/HHzm3f/+IVSPfPJtJMD9B1aBtYfjlMx5YA2Dj3dFyTLz61B4HB6i2Egqv1X5HGbpH+wgAAQopbDq0ch/VDXH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1jbCnRdR; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1jbCnRdR"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d18d02af68so3221155a34.2
        for <linux-iio@vger.kernel.org>; Sun, 01 Mar 2026 12:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772396728; x=1773001528; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=84cq4ncpaJidWZG+Xvcm8UIrSUsDvIJYWnImA3oJA4E=;
        b=1jbCnRdRpvX64BzOxxC0dIDDMLvg0LklQGvC4aBWXx42XaZHkiQ40BMA+0aj+9WWyo
         RI+84YWQ4i6jFW03UYukhR1CuBdkMfC3Ng8svElKLzDG6dl/pOGzAgLF/2Qa4cOVAA0W
         RZyU+4ecmMIgB+NPhAPZXV7/4WGvjR+ptmWC5QQ51N2XFvdqDYdrUu2gaLkow2fK/wo+
         zUvZSXQ20bENP+ZFc35LLol2WB2mynZ1Q0569p8gcJ3fR+l7WWEJcguepM7tm6Swwh85
         keeoPv1wKh2ZQYo3nwW7x1F1pVir5bM7rrgxOEKv68xRayGWk7tew1vL9M9Q0xP7tY56
         TpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772396728; x=1773001528;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84cq4ncpaJidWZG+Xvcm8UIrSUsDvIJYWnImA3oJA4E=;
        b=L+hghbDnFWXDiKNVaRRw1P/PiVwnTzBzQxYQsL0mEqDxbtPmvd9JCx/47v0316LvwD
         8Kdd9nRZtuqhV+jJG1pCzziCKciondEtkWUi9gp6TKl02UT4XomzQXx7MQiDjqmxuRNs
         GBzMHr3nBCPtVYOihsX4TgCzZpZvj78L/ouhU7SehD6uWfjvh2wK1umrKyAsBWcIxxdu
         od1k1ykpGrTmHmr1Ps3zi1QnfJutOD+agastCLRo5tmiErlWxcWKdfkzit71MQATiY5I
         UXQ2YQT3vTbbZwTQ4odOHeEWsaTel7eZ20/l6jEJCS1n89X51cpJXxq+r87ugRUXy8hi
         03jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz8J+cg/9zhK0C2kxhLjygrrXdNrKml+xElRU88CNgi5YOAIr2aRg88BkGlbt5oofzGVrmaohKv1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4QRHZwHVSOoxAD4gWjDPdjkFfHddacWFzFJCu7DduHbSNPTGI
	mBZ865dJ6bJHszjl1mi/D9reb6bTc9nIzg4YJ8jIykvPtGlbkDPppyKWd7I25ecLT8eC4C22KWk
	gNski
X-Gm-Gg: ATEYQzzsYIAnk49tcIfXz+NPwCagWlCT0trvB953cOe+mgOPiEjZNyf6bmhoVXNBDJf
	mInNGBd2/H99rvvuZEiyF4T1H9xCGaeTBK0wWcXcRLSIMdTXXkJvCKatfQ3SOwSWkoij6MftKJV
	VCJPD61ptdMrjWC35NrzMqHgwxL7YsgNb0RnMht4t0qKKjjLBqhgwLEYDiZfykJsmYXK2hnWomA
	YVNbvBkFP5gIuiAFrJJvlPUUBib72EVmQr5z9aezEPjxkxdD1EyXUC08WbG7KIMUPd4gJ/F5nix
	dLAzK6EMuLQYaQ6ifvU6naC8pBmhUvIGjEe+yWmqlC7DXYdo3KK9IHKAOYMbnPniMvgObdqME7H
	dMxzYC4Rvy0Qb9lCofxZ2AL3KZN9wQiRVboWGRm3iC2rMV1nKbFgcLISBNkheuWDOuMxGDPGyvT
	S8l+/hyKWaiseLcpPQ2X7giV5b6Rgn
X-Received: by 2002:a05:6870:a790:b0:408:694d:ff34 with SMTP id 586e51a60fabf-41626d8710emr5266434fac.9.1772396728264;
        Sun, 01 Mar 2026 12:25:28 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:8b9c:d657:204d:5a5f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d277316sm10063025fac.17.2026.03.01.12.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 12:25:27 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/4] iio: buffer: fix timestamp alignment (in rare case)
Date: Sun, 01 Mar 2026 14:24:49 -0600
Message-Id: <20260301-iio-fix-timestamp-alignment-v1-0-1a54980bfb90@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqEMBAF0atIr23QoJLxKuKi1VY/mChJGAbEu
 09w+aCom6IGaKS+uCnoFxGnz6jLguZd/KaMJZtMZbrKGMvAySt+nOA0JnEXy4HNO/WJ7UcWrWV
 tWjtRPlxBc/reh/F5/jjh3UZtAAAA
X-Change-ID: 20260228-iio-fix-timestamp-alignment-89ade1af458b
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Lars_M=C3=B6llendorf?= <lars.moellendorf@plating.de>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Lixu Zhang <lixu.zhang@intel.com>, linux-input@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=kJFC0cNDBL/nIBecpTcNbA8LBt6F3LAD5vRbaC5j9fE=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBppKCVVTRiJtV1HMlXpKIvTGlJtaSFTEtc/KYzl
 3Aw0ifuqmOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaSglQAKCRDCzCAB/wGP
 wMYrCACGuJnSRq3Pdj9RvQtuOklY26BWQ0PS3L0TpDu5SuPOeqYrLcc1Yq6BFTDfIix46Zf8MkT
 o1g2UOH7rrLNIeeMN3KSoRSr2IWxHIR4TVeD+HIhSLOwl4muOuPnWOiYDVJ+sEwy49+G99HGZq4
 9CIHUGfHvK2by/EWX1ZKgQ2MBvl6wQ8r3NclVoYYfGAhcw7tYKttpHSlNWz0+DcbyJahowdeUvZ
 5rPw4jtDWgzMfSqqfKie7DtJA75QLGGid80aFncT1vDuwmplri1fRT+C3zXdfH72Mpg+9ZhBuMG
 T+IDT1q6mq4VAjieB9gD4GhSfGauaNy+gcOq9ItCZQnWLQh8
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

In [1], it was pointed out that the iio_push_to_buffers_with_timestamp()
function is not putting the timestamp at the correct offset in the scan
buffer in rare cases where the largest scan element size is larger than
sizeof(int64_t).

[1]: https://lore.kernel.org/linux-iio/20260215162351.79f40b32@jic23-huawei/

This only affected one driver, namely hid-sensor-rotation since it is
the only driver that meets the condition. To fix things up, first we
fix the hid-sensor-rotation driver in a way that preserves compatibility
with the broken timestamp alignment. Then we are free to fix the core
IIO code without affecting any users.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (4):
      iio: orientation: hid-sensor-rotation: add timestamp hack to not break userspace
      iio: buffer: check return value of iio_compute_scan_bytes()
      iio: buffer: cache largest scan element size
      iio: buffer: fix timestamp alignment when quaternion in scan

 drivers/iio/industrialio-buffer.c             | 44 ++++++++++++++++++++-------
 drivers/iio/orientation/hid-sensor-rotation.c | 20 ++++++++++--
 include/linux/iio/buffer.h                    | 12 ++++++--
 include/linux/iio/iio.h                       |  3 ++
 4 files changed, 63 insertions(+), 16 deletions(-)
---
base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
change-id: 20260228-iio-fix-timestamp-alignment-89ade1af458b

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

