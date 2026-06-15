Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ED038B12E
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 20:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553924; cv=none; b=a6I3U/5waqEccUEcalb3XTesKey7OqF2m9RziAyD/mUmj91I8BviKQITHE5uCAgBt3tT4kKp9q3y8VnXkvCMqp1KU/NEdl4dLk/46xo397k5l7bnQuUji3mbfuWvFjMZZKkEaGwiJr7ujIMZanK+U8ndCpZf0cIqlyH6f7b2qbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553924; c=relaxed/simple;
	bh=a85PProtyjQ4avnJZsoBgV1FhvR3FB70mjoqBIQ24LY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cqV4CxQYYGuC3nraqgEPdMMedW2sBT+Dyr10yxwkH7QdXAo+KycqPRxU3/DC4w/5BD/edQP0ChizNlZI9+ocmg+luKz37nGGUN6HncJ5T46iizeGZxFc8Afs2oN75Iglccf8IINGRQqjwKA661R3qYp8jAj2Dgi6sguqnTGTsSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPRbWjWK; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPRbWjWK"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45eeea039ebso2130720f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 13:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781553922; x=1782158722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rv0p7X0/jWUPJUbyoh6NGJMDKaMFRF8cm9Cwsa9Pfbg=;
        b=VPRbWjWKPQOe0+hPSMvc0Lc4u6+fWvfIJ4xcqieNA0FQraqexb5646MD2L2nkpaGgr
         VNwX+MbZ/1z4aRiSmURnF7SXN+dFy5MNAdJd9yaBKz4aAzaSyvHQ+cVRq63HrO5MrARx
         RLUKY+a3pnNHYvGcnJQF/40d0b0B++nfx2VMEy9T0T0KWEkvgff0zTBtsbkGWxeKpGCk
         GvhwuGOblj5cr2Cjkk+u3+IJOlZciow6ZG3aoyj9aRF6vXrdxvtYwz/WuQTcQ1tWu1si
         qOITrGEMrYmNkp3bVzGnVetTvRWD2B6MtpKoytp1xJIlahiSowFxT8jUmC91enoFZA9a
         1XTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781553922; x=1782158722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rv0p7X0/jWUPJUbyoh6NGJMDKaMFRF8cm9Cwsa9Pfbg=;
        b=rN24Gk0F+nKKyIMzHXHoesMkKf/732V4Us/CT44r7letzeZR+Fdqo1Af6nTBp18XS3
         e28N07i5LLCgrQSSlJctQNXEPVbzoeLVX+ciNpYBzgUvtaZF0dhXIgUbEgMperifvDbn
         6TJSZea7Oik/WVh5l82Uo7VpbD7fewxO0W8JwEijtrwqtjs1W1PE87IKUTTFi7wGKTOK
         8lVYiYMDXNht7nbJU6czTxkY3L1Kv1IcyrWNM+ytphZQL+KBn3qB/hYRUcetpVheQc+L
         BoAAWeff1DGBAaZjLHo+p/nIwLk3Blpm2HeEhUrwmzT8k6Fe8m9/42AczSb810w48gvq
         vQTw==
X-Forwarded-Encrypted: i=1; AFNElJ9LDHWPxx/WtNeeuFrQ7SMvB45a8nlqYaIaH6LW9YmYZ5dnQYsIERctC/h/fA2Tlq1ETJOTbLVoeo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTb0Cp0dUU7ix2RhNtHTjYDJVedoN9rPJHMpkYdJaVNS8UUWKA
	XQbKnjfDlyOeEH5jItT9FV2t/F1hxoBGI0UI3EvmyUcGdUDLH1CSVwrB
X-Gm-Gg: Acq92OEXLFZq34NRwkwjlU/4c9pyxB5iDmImWHY9qDxg4Gmt8PQTL42A3LToNRCdZWq
	+7oXW7fxX8M3VBFSPpQkglAxc5sxyIvmA4QtW1WQO6DXFGhl4r13Hg/m16NSJIcQbi08iBfPI82
	lkC/9Qk+o+AoAIqHF2vlp97lY6v9hVrgA0/mmjJz7GHl9JO5a9gkNwVriAgL5YZClSbfC0/XFof
	mW/NowXEdHAjoigaejF4PgBmc5XgwJ/onTTDVv50zO5MG4CBJ6PSn4pzRlo4Y2ZK8hhIYDTfMTz
	mZjr/5+4bG4P3dmKoLBR2hfld9nc+plnldl6ZP6G1bdN8VmSDP0jSOqxowQzUFDYmU0o9cBnjAS
	65lL3ysAwkJAUNyXcowTaC0Yj8WyjgkCaQ9wesinfzfy1K3iMXvGUVQFB4qNJNzuSukmNUWgDX9
	ByrK0AId+ocSfHbSi/DaRwRCy8ew8Zo2p1BhHS7RTNhOSVSQbtgbrO2SHJkxffNtEQl7GRt6hDp
	IeRyQ==
X-Received: by 2002:a05:6000:40c9:b0:441:1e1e:a050 with SMTP id ffacd0b85a97d-46074b82692mr17937559f8f.16.1781553921738;
        Mon, 15 Jun 2026 13:05:21 -0700 (PDT)
Received: from arch.lan ([91.230.98.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2e592csm40267547f8f.36.2026.06.15.13.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 13:05:20 -0700 (PDT)
From: Tomasz Duszynski <tduszyns@gmail.com>
To: m32285159@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 0/2] iio: chemical: sps30, scd30
Date: Mon, 15 Jun 2026 22:04:57 +0200
Message-ID: <20260615200459.8272-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series replaces old email addresses with a current on to
make sure changes show up in my mailbox.

Tomasz Duszynski (2):
  iio: chemical: sps30: update email
  iio: chemical: scd30: update email

 MAINTAINERS                         | 1 +
 drivers/iio/chemical/scd30_core.c   | 4 ++--
 drivers/iio/chemical/scd30_i2c.c    | 4 ++--
 drivers/iio/chemical/scd30_serial.c | 4 ++--
 drivers/iio/chemical/sps30_i2c.c    | 4 ++--
 drivers/iio/chemical/sps30_serial.c | 4 ++--
 6 files changed, 11 insertions(+), 10 deletions(-)

--
2.54.0

