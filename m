Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B6F3E025E
	for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781268402; cv=none; b=k4OZp0sPSoQFVJuP7UETUfWnPka7EdLClz6ErtbcCmTZ2sDso2rSdo6mvgyYJhBkFA04bJFZJ6kdHWDwq60t7qi+J+8aouXOr/fcRMpx/VOAcMFVBXgQLaKm0Qh2eST3wciLB4jGkSXnHNgtoTbSq4RKLujGSQrYEqveBCzS26I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781268402; c=relaxed/simple;
	bh=F7odNu1ja7J6Tec4NNUJr33ZpZFClpcehgSpY+hF7n4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wxo9MlfAmHjs5SkN/+jKAXw7QU7qE2wCfY5x19dcDhKRDw43V3PAioNRaAy8P1r9qvT+dfJAv8JPcgoSVDmsKQUt3K+Fku7jUi5kDq4gdEI2zGDQQwIxzmWNAtW2K6hsXYWthhlcFEu2vjID8Gg2qaZ8zkac0/J2O0ENa69213c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0b944f6edso9553105ad.2
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 05:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781268400; x=1781873200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tjjr9qakYO64wRYHrlYQ+ZeiGSePqUXQbj+wVa5ikCU=;
        b=BZOqx2shpOsiokgsHD10bAD4Cv9HMMh+2uiTLlBnPSkFcMh16wjzeNbzPyGbBPJ9bC
         XNLmqD2owdWWSBesmtYn+zyquTYGYBfFWY33jqKrAxtXOK2QTcrUVU3zBGbydH7mkOk5
         IRM7vLQuqHQJoqRRxGP63RKmDYiovsLVMqrQ9EO2twMOzTFUkTLJKLl/v8i1SVbDuW4T
         YJIreku1tCPWT5669e0PWjNho0zdS6pi2Eh0Z6jyHdp4hbopKZqMSzKPSwRVuC5KX0db
         y9nQIdGYLi7apXt0lE0WQoupgi2t4qqQ4cv7Dp77Y9897mD8JZ71z7P52/HaEUfV47fZ
         5/LQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Fzzh8WNhfukNd085hiov7wfG7n5OMsrdS1KIlIJQkIslOMw9hHO4Jz/X70JZfVSl1tmkTNzf5i24=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfUtL1m65M0X6Yzo9UFsW4iJ6ZhVrxjVG0mSP/e0bO6uSMHSZ+
	UUCzi1KP7uuWW5MEI7gMwTV6yzeTsdCjbdbTNKKNNn44/nBf+HGRG4AI
X-Gm-Gg: Acq92OGtdlePrI/AgW/MVzVBAXorSjonEbf07LRBFgPcy5y7UoCl10sNndqli77CVD+
	7cJ06JqtCi4Tz6cISdDRy/mF5AXg30RkqrIrLp6jykIaxJxZNcpeU1AY9DeZujT1ynubDfK1AdW
	sb3CVNRrhmpcuyT/lFRS0zI/st3LrNZ87eq4WC47iPKaIxH2aV2HelPbRyg8EQCPJjCK4bULiWQ
	3/CCGyrMwcUdOBGwhrrpmmldfRruduFIXBvbV7AGZtLx3Eeu9dTnV+mDDany9lOq2xgz5I/IpjI
	pKMiSwQGmYljVkZwCJFngNu3diMbO96+lZPG+MJXLA/Xew4D2r+ZGAameKxH9ks3YXhGsXuwjfa
	+o6WMMNCanvNK6c3ymBlSAjdzBcv0rTGLUkyZcw1iIj+YY9W65a04kt7S6XDBvs1RJQhJsUwqoX
	+duHcF4WXGfWZID54M36SQVdW6fCkpU9hm1ZXD+DOJUuhZv+Cq/CWoDfYo0CICserBiT5OMyg4C
	vIaoOE6psZz2QrLQlYriU258HuTdoRcy5XeC0VD5fQnrFQKGBUtisMbOFHj/R022jg2CYWYcPBT
	jSbezca9r+0e7ooa
X-Received: by 2002:a17:903:384c:b0:2bf:379b:53d2 with SMTP id d9443c01a7336-2c410601d53mr32046305ad.15.1781268400144;
        Fri, 12 Jun 2026 05:46:40 -0700 (PDT)
Received: from fedora ([42.0.4.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb5411sm21115625ad.32.2026.06.12.05.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 05:46:39 -0700 (PDT)
From: Siratul Islam <email@sirat.me>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siratul Islam <email@sirat.me>
Subject: [PATCH 0/3] iio: magnetometer: add driver for QST QMC5883L Sensor
Date: Fri, 12 Jun 2026 18:45:24 +0600
Message-ID: <20260612124557.13750-1-email@sirat.me>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces the QST QMC5883L 3-Axis Magnetic Sensor
driver. It is a simple device with minimal magnetometer functionalities.
Commonly used as (software incompatible) replacement for the
Honeywell HMC5883L sensor.

This driver implements the basic functionalities of the QMC5883L sensor,
and intentionally leaves out some features like DRDY interrupt pin support
and power management for simplicity, both of which will be addressed
in future patches.

There was an attempt to introduce this device about an year ago but
the author seems to have abandoned the patch series. Since the device
is simple enough, I decided to start from scratch.

Note: I also noticed a patch for the QMC5883P variant. Despite similar
naming, the sensors are different including different register maps,
so these devices are not compatible with each other.


Siratul Islam (3):
  dt-bindings: add entry for qstcorp
  dt-bindings: iio: magnetometer: add QST QMC5883L Sensor
  iio: magnetometer: add driver for QST QMC5883L Sensor

 .../iio/magnetometer/qstcorp,qmc5883l.yaml    |  48 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/iio/magnetometer/Kconfig              |  11 +
 drivers/iio/magnetometer/Makefile             |   2 +
 drivers/iio/magnetometer/qmc5883l.c           | 512 ++++++++++++++++++
 6 files changed, 582 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc5883l.yaml
 create mode 100644 drivers/iio/magnetometer/qmc5883l.c

--
2.54.0

