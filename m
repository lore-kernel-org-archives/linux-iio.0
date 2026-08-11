Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E0F3BB100
	for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 07:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786432069; cv=none; b=FoAxsiPP66xEn6pr26pf7Io0hPD6awtRdsX3pDUzLRK6oS008uoB+0lnBB3hySRzthVz5v5LXKYn0pTKJq0ii/sav8Jyy9rvadcxKh65Q1/61a5qZogSkpchwesF/WeZK/Lf3cQ7KaFl3LHqWpWAWKu1d2WKsCjFhMQj+kfGpGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786432069; c=relaxed/simple;
	bh=QlGCBKAt+BtoohjNaDUIksQVWzB+odMxSv39IPC0gkI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bPm7KjPLA+dPAFrO2pAH25f48VfH8D/ncwWfRC63tOm+bcJoMMLTgeLyEbrUNbvY1BUnscOsQwztcQXJX0hh71yCfyegoCCqUdVYwBuEj4mfOkcuKamhCsxWlBNv8re9cBtFSgaVve/K12SUyjjGO8F7VTSSqIYsRFqlU8zTZxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxcDOCqf; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxcDOCqf"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-ca957432c7fso2662498a12.1
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 00:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786432067; x=1787036867; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lU0XB4fL7Vjn7A3zQ+l0tF6E9/h6EhKeGNx9dXj48WE=;
        b=SxcDOCqf8FaRWLJaUJuduP1kCe7wJDEvFH5VzgiU9ruprhjTTy0DQ93Ui3ant4M3rp
         0pcFugSjhQuBOCDvLkfYbra/StbscLe/6k0ipq/8GYAOMo/FhpP/iWg3x2lZyVuPXItL
         aci/ohSWenGL+8JHmJdULVHlWeTt9K25pkAz/qBbJWa+eU8l61UXIEhao4fWYARY+ftC
         TELeGwe/2oCF+zxjGXeBVH6/pM8v47Uw1ereftxxDW4mADBMG0mq47RJnzkQbOQnVkbd
         5POn3cRpuLLZoPxx1s8PT4zpKhJc77NJx59QC72cXKHsa8yXWqfOq4zqUptXW6mmNnPS
         fF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786432067; x=1787036867;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lU0XB4fL7Vjn7A3zQ+l0tF6E9/h6EhKeGNx9dXj48WE=;
        b=AzzPQRDPjuDirfr6hilvkkxaf/F3x7xyeABLSK2vWi/6X/EsRapumqZU24pGUKDrPW
         q94FI2qFJ1qfevR4laGdJ2LEA7ZQk0LkRWSHXChWpkc4dJcf32jXls4Kn+g9RhaytKZn
         8JYAmMJBVjvYo/AQM9qejsIn83HCp+JkU1RZ39ydlLCOmdeLLgqdz2TtxOqn0AgiL4wA
         OWYeOKRQFKjiyr76kmtd3oOVVOlrAiF6ubHUn6qPl/y5IXKyn9zz0gqdMYc8XIYH7W/d
         JxWyhvgJZHsOqkhnGF9nxqbL1FuBWqeO7FDARR++ftNfHpuZhlxTvEYnLieogwuREd7c
         xiSQ==
X-Gm-Message-State: AOJu0Yzj58UuUbC9+MIDaltZ3iGkWmZaKULNUH/MB/Jn7kEoov2GeXjb
	c+JeMC7kuUG8AfGkCqwwEn4qfN8FxGHM6uQ/PmLSmqMwsDOFiY1esFrS
X-Gm-Gg: AR+sD134k10qYv130wj1Jk0fXYHGI6RM7vBbc80ONH4NgIdED5RBC8wnXixE8kvkuAY
	guYwLaEXHz5PnZ73X9fGIjwh2DB0+skkqbPaQdYmX4SuWdCRgR9zMbY1LSubloSL+L5Z6OAMO2A
	p2USCSQQRjIGB4XI2HplpJEoDrQBnX942YCvSwKC5plJuGjooWTG/UlN34TeBxVHT9ge/jMvd99
	OivkHnONv2KvrfN64K/3nm6dpQ4PZOFV3KJYjChLqgP117mdTP81hdBwG/k4AIZ5OzghS/UFDpJ
	JNU1NVfKWcrGEGVvFgCYqbtaS+gpPr+2H4CGOv+I94KDrsZMNYSUFUSeKt/0+nK4mU6W+yExQYB
	dXyOT6ZC1kt7Uk4muqp9NBztpTg3kmChrO9UdiC0KsHyc2XHsyNFJQFmqHispZtCFSUhwBrI3o7
	JPYCooJlCn5Qgi5HhpU/t30Ktz5QVCMXIubYOU+FzvHJjrB+YCvd6wrCmyicfDYDlgLIfQUUtwm
	Yzk9ZSL92xOwqaMDCfbLKJuNoFq
X-Received: by 2002:a05:6300:197:b0:3c3:791e:5e18 with SMTP id adf61e73a8af0-3cc2b7ace7amr2024151637.7.1786432066827;
        Tue, 11 Aug 2026 00:07:46 -0700 (PDT)
Received: from [192.168.20.42] (115-70-157-242.ip4.superloop.au. [115.70.157.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31c619d0209sm1765052eec.5.2026.08.11.00.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 00:07:46 -0700 (PDT)
From: Tsz Shan Chan <tsz.chan.dev@gmail.com>
X-Google-Original-From: Tsz Shan Chan <tchan@jacques.com.au>
Subject: [PATCH 0/2] iio: light: vcnl4000: shared IRQ support
Date: Tue, 11 Aug 2026 17:07:23 +1000
Message-Id: <20260811-vcnl4000-v1-0-50e7fb657692@jacques.com.au>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0MD3bLkvBwTAwMDXQOjVEPLNHODVHMDMyWg8oKi1LTMCrBR0bG1tQB
 yvILgWgAAAA==
X-Change-ID: 20260810-vcnl4000-02e19f70e706
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tsz Shan Chan <tchan@jacques.com.au>
X-Mailer: b4 0.14.3

This series container two small changes for the vcnl4000 driver.

Patch 1 makes the iio channel count match the channel array.

Patch 2 adds support for shared interrupt lines. The driver now requests
the IRQ as shared and the handler returns IRQ_NONE when the interrupt
status register shows no pending interrupt, so shared IRQ work
correctly. It also reads the irq parent trigger type from firmware,
falling back to IRQF_TRIGGER_FALLING when one is set to keep the current
behaviour.

Signed-off-by: Tsz Shan Chan <tchan@jacques.com.au>
---
Tsz Shan Chan (2):
      iio: light: vcnl4000: use correct channel array size
      iio: light: vcnl4000: add shared IRQ support

 drivers/iio/light/vcnl4000.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)
---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260810-vcnl4000-02e19f70e706

Best regards,
-- 
Tsz Shan Chan <tchan@jacques.com.au>

