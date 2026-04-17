Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32DC29D268
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776466851; cv=none; b=cTnWlEyRFBUZnvVWuWsKKdyyNbSWIqpNfUIEIWwxDqOeNpsNbS9d5mcQoEbq7Rq9cIIV4vS04OgUo4fmQHEjlN3Xe38826aQyWv95Khh2iv0ulpceCFbKb6qLxIZ+TAGhWM+PEpYUfF/yzrhrPnGrkD92A5eRmaKd8sXL/Va/zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776466851; c=relaxed/simple;
	bh=tnH/tm354C2LHKU1HohnWm2cykJvmp+fjPzvH4K81Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FT0wOJPaDvaaoIiI9UaPqZl/B0XMB9DvzGY+UdCPQaxWk+gMXRfytuDXCVygFl8rujRwdkn1Xy/e/MI+xDGiwj4Vnf8Nk2dzfRsBI+qIji+IsUgb5AF6XS9xyTZG8tu5nnMNz965x385MzeE07CW112+o5Iboo4onBPAzb6jgFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Q5osMVK0; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Q5osMVK0"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso1219448eec.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 16:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776466848; x=1777071648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SaOUMlV4k+LOLbYB+ezceMJb46TNU8NlhAFEDoc0KOk=;
        b=Q5osMVK0q0lfzpYjPcCF/oIxpX9traB2iOmJwoUAAsjlRl9PMS1o0q+uhdoMmL8zjL
         NS8S4LXdpHzaUZfF4auEYaupSEJwzfBTooLG12VH7vfgFdKVQTamrlocTOhdmxasloUq
         /us9v77PfQBBgfvc0DjFzgW02Igmzkk99cvDrH5sfZYLlpxRDT8cqnamNy6BdOjhrQYt
         BwlMRxnuUSQgpl1fxuLAlLGb81GColIjWiVY1Y8AMeFSxWzxq/zo9tJWQJusjN8U58ZC
         ZjhII/M1f+7SbuNO45AFXCcpYqBxT44tBgTDw6KD/PNWOc32u8KvZ9AF4DUqj1jQcQRp
         4Vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776466848; x=1777071648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaOUMlV4k+LOLbYB+ezceMJb46TNU8NlhAFEDoc0KOk=;
        b=dm+xCDOwAkcZfQZ6eAtN15jTWRUslBzIFQd4Q1Y7i+2gvKvunfllsnN3VA9kpoaeYU
         a1IgU+0sud8azV7tGpxEFIC4q3XCyPFp/MLCGWv73gKVgQSj92/A2Cv379y5Z0JnLaAU
         RqMVuRkT5XQkjC1/LMYkcbZDUY/Fgb0lQd1dO+qVNmwRn5CyDmapUGoG/glNmojoG19/
         lBNpVuMj7oirKrq/xiV4bk6GHnAiy/E40+AEXYAN77/Vt0pgSA2HmCF1lTKZVE/jWL/1
         WG5p0t/u7vs9kxGu4KfruOGiS44HLQsal79Qrd5a3MCb0qLSwf4MBBTu0yzWFG6zX5YR
         5o7A==
X-Forwarded-Encrypted: i=1; AFNElJ8tY5/EMjWo54ucIF1wizTMk4fPb8QDjv8UGQE1HVL6O4ayoTEPoywOzfENKi/S5M94eHoVCim1oI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmu8KrnmmJ9qx5HPmdhBk1xnKMdQmp6j5Mz6z6AShJgpYxTwf9
	VoV2DtaeVXjWp1byDiv2lXb8TKRmnrwioWLK5ugJ7hoDvAYQof1sTdhsUCouelw2uTw=
X-Gm-Gg: AeBDievgiIa2lSIh8mUlvMMaJ4CT+8urogtNg60YCGAvtOoYdvzYIUEWMV01yTaRS9y
	VQRug0mj6Kr1qWucm5B9wD90vst9iRayxAvRjCPlQvlHxGblcTXUzBmnMNEzp9/XSB72hgVgESr
	47tVa5YAlllI+VZcHL73VPhY+2uuDCq4Xy31MbtgSk8IkKVeUB00tvncZ4iznTcRbfVuRa+VYIO
	/oWiT1+ujE3uyE3xCbx2U0D3yy0pHhhU5nmFrsxHhX1Jff2vqukl6JldtADnsIYe+OkJ2wCboeQ
	XfghCVv25U8JEd5Jp3QdHe5dNyV8oE+K7zIKFFUtSKgSb6b7hBfwkR1x44vN13xPcoS+P6hTuR7
	kCjSRgtDHPmW48dkULLY64Hm2GlZe8P1u+km90r79vbtfHcdpDtDXwmlRXq34XuVlnnRduTTHcH
	8RKTjKynoAzXHsK9xdfGUiH2GyaZV7xDf3i0Htmw==
X-Received: by 2002:a05:7300:d70d:b0:2d3:f3fc:bb6b with SMTP id 5a478bee46e88-2e4646cca96mr2836393eec.1.1776466847775;
        Fri, 17 Apr 2026 16:00:47 -0700 (PDT)
Received: from natalia-pc ([187.116.73.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce440sm4117637eec.14.2026.04.17.16.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 16:00:47 -0700 (PDT)
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
Subject: [PATCH 0/7] iio: HID: Add helper method hid_sensor_adjust_channel_bit_mask()
Date: Fri, 17 Apr 2026 19:58:43 -0300
Message-ID: <20260417225959.16688-1-natalia.andre@ime.usp.br>
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

 drivers/iio/accel/hid-sensor-accel-3d.c             | 13 +------------
 .../iio/common/hid-sensors/hid-sensor-attributes.c  | 11 +++++++++++
 drivers/iio/gyro/hid-sensor-gyro-3d.c               | 13 +------------
 drivers/iio/light/hid-sensor-als.c                  | 13 +------------
 drivers/iio/light/hid-sensor-prox.c                 | 13 +------------
 drivers/iio/magnetometer/hid-sensor-magn-3d.c       | 13 +------------
 drivers/iio/pressure/hid-sensor-press.c             | 13 +------------
 include/linux/hid-sensor-hub.h                      |  3 +++
 8 files changed, 20 insertions(+), 72 deletions(-)

-- 
2.51.0

