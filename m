Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795695217;
	b=MVfldNYcC9GqSdGquWQLqBgcVKIbN6kmu6XN6fFOd8Jt+wDABbc5qrKo7/HNKyhu1oJD
	 DiVCSeWx5YG9OG3qwxx2C6/KE1eMqthPRVIngbRhUdRlftQw7WEAneHO5n7bw4L8klkSD
	 O21atdTEVUuE7evXB+K4pdQ+8lEXdct7/NQOK1ijVTOr1x6duYYJfDGaaixnXGD3VViaX
	 4vlZoYX0QU3RJ8ObWzAeWpGtK2sIoOLOQkYqzFM0a/mzXN5agiZPqmoS343w9Oi+Wo++d
	 VsDK0C3RGowsJuOczwJZHmM77p4N8Ops7BQ3vOAKktLx/uV6PVR6RNQn5vBY0T7svwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795695217;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vEZkd73R9Nm/7G0BLxBa+UkEx9fu59+1ux1PHVb/i/0=;
	b=eoZ4q562cKV6o3DiIl/Ri4OoG4LSnc7/SrBJa1eCAzVoGpEzwFWJQJrZpw/VKyAb2pwE
	 Vj9yU1QO1BCv8q07Ap+up31dc9Uq6VtC961vQjJXc9UMwt2AOtslJ3Tp/F/9IQVrQXVii
	 jKqpWy3sksxMRZbL6mxj9ZHH4JGo7um/yZ9OesRlPZdLm6WIYfGX9VTjZZdGnxo6Rffph
	 8GH62mBn5sLp1ee+k7nzGjS4Km81CbD4NhFwhxQa1qTKH+tT2RTVYCu5QbURumX/lfiz5
	 wV2Vb0H70eKxK6J7fUw5VHq0w9lVdl2nPpAsllTqEe1CxF6m8Vs+lWzuchsypSbr9xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pJD+K5Qc;
	arc=none smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE35606A31C
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 12:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFE35606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pJD+K5Qc
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5c14f3dab0cso3915280e87.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 04:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795695215; x=1796300015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vEZkd73R9Nm/7G0BLxBa+UkEx9fu59+1ux1PHVb/i/0=;
        b=pJD+K5QcCPh1YWqCKLAxIsYRS5OOAgSCoUyL3ov8+EWugSEefurT7jZFBWd+R4DhdE
         NW4DiPbLgtFOqh64pdD6i0hz+MgQsHTr+O7YVbK0KOl4S5yD3Vcfflawh3i5+tECNKJq
         MMTxZH6VPfbgkrERCtevSTKOfmjjHwVp64tX8LvcYh7X1mjgdS2w9UQ/5I17JXFUY+Z+
         0cq9dE8rBZNNIjDGfUyuB+wBH50n1IBBM3S3A1Uo6vpXaXJMDT8mmUgLGa5KVEfkBjYF
         sbRSMWLPrBk2mn0moDZVsI8JtE6lJEetnLx0T9a0Plog9DA9o5MrMfyomheg0lhv3Ywc
         xs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795695215; x=1796300015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vEZkd73R9Nm/7G0BLxBa+UkEx9fu59+1ux1PHVb/i/0=;
        b=SYKqyiOvNFYcuCSlVnjwAJ5zE+57F9orG31uJL+p73YQj3dF2inu6/QabYjV6oicUq
         Cb5fLrCjI/5gWHZJfEZk8sx4uexbBEBQclAFULui37enw0mziDCEjy2ZC/5Rte5+n8BO
         p0l3UP7ctN+feZyUVdyJN415L4QOhhY5roJF1KQMKI+1yiwi42AguETvalQwl8ye5SeC
         76VMIjDBHELV98GL8dmAkYGEcotnd2lN6gtJlD3yz5or+/5uE8l6AwOg/bAaf4Cve2CB
         j6kasfCkeSUVGRciPPZfGqvtTjIo1H0Y3iOAFxfKZgZj1dgHFm0HKJDigmB6lPBZr4uv
         ppzg==
X-Gm-Message-State: APuU4Z87aVWOR07dcECBVud6tuF9BlvH49dqkHWATGEs74TP6uDJNtUC
	i6leRfszIAJ3bDNkpW6rEXwvnQtHS2oMZ/j/9xioOSNzoqhoqgnTE0nm
X-Gm-Gg: AZFdTZfNloFi3XgWsXEmXn/NgNMNFFcYeH1tY0DlK+KwaNc7R2Q5YrYxp6ajEjaPjc2
	9+HVsgdlIcx3dRupO0+FEN6GQTKKBo9fn4WUvpFdNpvvyshz/Be2O5HJWVVw8DHiZeoGS2TMEaa
	poVDdjHbw2CpMPsLWuAN9FblJEQw5bwees4kp9jzXFRhDJ2kLHMixlXhwN1l2Rg3vw8NhFMM1zz
	VdLMYZ1IdgDElusgiWEjFHcuZG96SVNBx7+Hd4bQfjx9cxP0fqWr5wOE0xSE7hVELvts9qlxLBh
	qrX3ANTk0XEgdZk4ViP/i8a51IfvrFMAPrA7qhIG5MXewWSuAtKSZ2J5gPdRC/WPqGN294LyMlu
	Ow8RSnDb0HGsNyVz/Fnk/ZdnReQRW180m/O11jDNGG0151BYKQzYUP/YzxFowvznITMT09IbIPD
	TSH2QqxptYBrmMkdXRK0TYzwGMB11T6J1/hOgFT62uR2NljhK2gioPWvsVRQyIA/OliZJ8APYto
	5XaMZn6c3ZCcKRk4AmWOar3ioRIougFF9ZX41zASfXNndaSwX5WzAVbqUQ/1bFUsZ7rRNH1SGmp
	qFIVY1sJsA7uryMX2eelgx24Cu50gTxKPKZHwVz0QePT8EnQ2241AocV87cxE/2Or4grwEBgDr/
	xDWJj0tXXUDN6O2Y1qOwW9IVvTfMp6HHtME8G
X-Received: by 2002:a05:6512:3e1a:b0:5c1:6071:76f3 with SMTP id 2adb3069b0e04-5c1bc87315amr6411616e87.34.1795695214907;
        Thu, 26 Nov 2026 04:13:34 -0800 (PST)
Received: from yantra.. (nekmmqtmzjx8yvukhae-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:68b4:f70:61d8:6e86])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae8044e8e0sm56541791fa.5.2026.11.26.04.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 04:13:34 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	u.kleine-koenig@baylibre.com,
	crofts@kernel.org
Subject: [PATCH v2 0/7] iio: pressure: dps310: cleanups
Date: Thu, 26 Nov 2026 14:13:23 +0200
Message-ID: <20261126121331.10438-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The cleanups promised in the FIFO series cover letter [1], plus the
rest of Andy's list from his review of the ACPI fix.

Patches 1, 3, 4 and 7 build to the same object code. Patch 2 gives the
same coefficients as the old parsing, checked on random input. Patch 5
changes the wait after a reset from 15 to 55 ms to 20 ms. Tested on a
DPS310 on a BeagleBone Black.

Based on iio testing.

v2:
- 1: sort high to low, fewer lines move and it is the datasheet order
  (Andy)
- 2: "No functional change intended." (Andy)
- 5: wrap the poll call on logical boundaries, msleep(20) after a
  reset (Andy)
- 7: drop bits.h and errno.h (Andy), drop mod_devicetable.h (Uwe,
  Joshua)
- Reviewed-by from Andy on 2, 4 and 6

v1: https://lore.kernel.org/linux-iio/20261123220649.36887-1-zoone.rupert@gmail.com/
[1] https://lore.kernel.org/linux-iio/20260921183132.233136-1-zoone.rupert@gmail.com/

Cc: u.kleine-koenig@baylibre.com
Cc: crofts@kernel.org

Rupesh Majhi (7):
  iio: pressure: dps310: sort register field defines high to low
  iio: pressure: dps310: read the coefficients with get_unaligned_be*()
  iio: pressure: dps310: use min() instead of min_t()
  iio: pressure: dps310: use KILO for the Pa to kPa conversion
  iio: pressure: dps310: use time unit macros for sleeps and timeouts
  iio: pressure: dps310: drop the unused i2c_set_clientdata()
  iio: pressure: dps310: include what the driver uses

 drivers/iio/pressure/dps310.c | 86 +++++++++++++++--------------------
 1 file changed, 37 insertions(+), 49 deletions(-)


base-commit: f2cbef9101b9fc979a324bb1242b8b802a2484b6
-- 
2.43.0

