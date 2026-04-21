Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB25739DBCA
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 22:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776810149; cv=none; b=iNRPKMXr4NT+HLodV2n1GMiseJrVgpf0Bb9uDa0NUclOmnpEhNwKHCD2301+UH4/Qa1TyNTqBKxas1SEQ78oEZFuioy4gIp5hFi9qaVoLIVDtx44QSeW2b00aRDrKe3pbxqvOuuDBu3iU/dCBzrT6z61jnx33z1Cek6gg8IRGG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776810149; c=relaxed/simple;
	bh=rJxCoQD257w/f3HP0JhV8eSzzqjaRyhMGwSkj4Nu7sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CT4DNGCY7Z//1/NukVxZunTvC57ToZH5Pu7/WtdPqy78ohqvXcUVzNE9pod8e3q5uEWRYlWqD1H4Tp8grXHDyg9tf1ec/bpEYqjtOuhrfyEmtkAEaSiPpZy/F8N5vSu5MQ36jgugpmu0bs4h1MbBm9qeh1UUMHPNfeo8kCTQSmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=sxxbP4dv; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="sxxbP4dv"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c726f46baso5870101c88.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 15:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776810147; x=1777414947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6ol5Q19clYG5+4j4dvQJFpUByvikc8oX/s10Ta3MRMw=;
        b=sxxbP4dvaYkRHB9/gDyQizY+qyG9GkuXatts/wpsTfSPCvJdWrXPXgy4iA/G+YKpFt
         aIXXekFju64YeKbBZBSaZaHTi+3EWPc1eVfaEznTgnbob59lIjW7BKXH8/z5cZ/qWT0d
         dRfH01jxnVHSCiX0IVbfJac8zj7BFce1+64F3oF4/uHVl28+GUphS095V3E2Me1NITZ8
         w4FjHTxPD9Cq0ltlQXbaxLkyHxz4AtSfDwVAflV1c1A8XvBs59y/xwslsn8lgyAdeF5B
         EJsvhXRYJgidrpxBvmTwd7eCCKMM+PF35bjVmJGrnsBa5kIGfXv54gCoM0VA5DHEcGuR
         Ctzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776810147; x=1777414947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ol5Q19clYG5+4j4dvQJFpUByvikc8oX/s10Ta3MRMw=;
        b=Kb6PH9ckwzEXDxFZz8kNIgi2JOyd2CkxqtHJ14Tc1hS0ifVV9wHTFJF7txb7rKvcg7
         qItObT2UZklttaaoDer8Su9lSgCP3/FG4iR3iUPl8Ks76D5tArNTnPXG6zFEIEg+abKF
         mGxaSupupnoMSS7E/aE4ZmzBI5UdZeDxGrPOXKZblryJJL9iEtLYRGA5+JH+Gg99zVjc
         3Ag9j6lZRoG54PSerxdMMK8ed16i9EPrEbc2JTNG8Jm9nsWlGQ0y/SEXz0zHNG0/YUnN
         P2XOM7ZAwMShTMCSlEsTdUwmIBclWOIEsq/htcfh1PVV2mafZW9qZIAVu6+GzLmwpL41
         wFpg==
X-Forwarded-Encrypted: i=1; AFNElJ9AX7Kh9I/me+r3t2G45BZt4ExtJuHcDAm6pqOehSBVPpr1QXtdFQMbXlBNAnsxwIDRcPwDXnIXhKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT555GylBNyJEtxuXloVdwSPsBwA/3p4+errjhIN5BjsQQNIsp
	xM+dYcB2qIYHRDMIf8XlQh3YlLhWa7bdLx7PLG+B3Bd5xd1UAxy56DlDE7ajPQL3H0Y=
X-Gm-Gg: AeBDiesF/66paR+cGNY856DLNrrkOWEAgGU6qu9asAnO7NgBikOtByuxW3uYuMLA+x3
	UK/fehOlI9FBYdb7hdIweAWN3V7KMYmdXBEwsPI58rf3W+xZATFLEcSjCFYttk1XGP60G0Q6Okh
	BLQJD+/pPdbWByO/jdmUac6abVVk0ugEiZQSfLHxFkW1vemvq0QCBCBdGIoT7FGX4pOWJdjddpa
	VjZoCrfL2NJ8xIPJtgVa7nP4uQV81q6/+fxsBMS7UoO6efi4XKlUac/KOUQwEKXfqTXI69y2wg0
	PESK+im2EGk6x9J7u7BUwGzN7H4Y00CJFXSPOARghnLeA5joVoAv4yiwXaTgwF9zAJmzE1vELp4
	793tnFlklhevtQRzTGN722i2/DPCgyKDZapm0uEmZavU82fGPoWY4YomudqzzR9ELmM+9hZUzEW
	QSFgna+fOT1JEbmWqULaUeiEoDasaAkHR7w5Gy1g==
X-Received: by 2002:a05:7022:6191:b0:119:e56c:18ae with SMTP id a92af1059eb24-12c73f90c50mr9441603c88.22.1776810146912;
        Tue, 21 Apr 2026 15:22:26 -0700 (PDT)
Received: from natalia-pc ([187.116.73.68])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c831d5b29sm20129785c88.8.2026.04.21.15.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:22:26 -0700 (PDT)
From: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>
To: andy@kernel.org,
	bentiss@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jikos@kernel.org,
	nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com
Cc: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v2 0/7] Add helper method hid_sensor_adjust_channel_bit_mask()
Date: Tue, 21 Apr 2026 19:20:32 -0300
Message-ID: <20260421222210.16016-1-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series introduces a generic helper function to handle channel bit mask adjustments
for HID sensors. Currently, multiple drivers implement identical logic for this task

Natália Salvino André (7):
  iio: HID: Add helper method hid_sensor_adjust_channel_bit_mask()
  iio: accel: HID: Replace method accel_3d_adjust_channel_bit_mask()
  iio: gyro: HID: Replace method gyro_3d_adjust_channel_bit_mask()
  iio: light: HID: Replace method als_adjust_channel_bit_mask()
  iio: light: HID: Replace method prox_adjust_channel_bit_mask()
  iio: magnetometer: HID: Replace method
    magn_3d_adjust_channel_bit_mask()
  iio: pressure: HID: Replace method press_adjust_channel_bit_mask()

 drivers/iio/accel/hid-sensor-accel-3d.c         | 17 +++--------------
 .../common/hid-sensors/hid-sensor-attributes.c  | 12 ++++++++++++
 drivers/iio/gyro/hid-sensor-gyro-3d.c           | 17 +++--------------
 drivers/iio/light/hid-sensor-als.c              | 13 +------------
 drivers/iio/light/hid-sensor-prox.c             | 15 ++-------------
 drivers/iio/magnetometer/hid-sensor-magn-3d.c   | 17 +++--------------
 drivers/iio/pressure/hid-sensor-press.c         | 15 ++-------------
 include/linux/hid-sensor-hub.h                  |  3 +++
 8 files changed, 29 insertions(+), 80 deletions(-)

-- 
2.51.0

