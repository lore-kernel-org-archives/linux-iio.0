Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0BB2BD58A
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 22:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809806; cv=none; b=sebmxoTbiA3zMQ0hMNNMueau/Ogpc40o/+fUtbOWnIeXPVe/kUrv0HjH9c2EmK8Wbm3jvUMOQq7UcSE+pyQqYaJu0atg4IlE8ty50ayNg/IRscCiKw8yRkvhrfX/V+K65xeG40SD8VrJPPTTHFC1OSQQ9nmnMu9G9OGd3ExR8Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809806; c=relaxed/simple;
	bh=E3qixZHGrY++BieqglXg/1nf9294x61CkBcRvMH5kMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m2w8zm/cBqQHecnnw9JV3+aojjgRDV5X4d4E1krvHC2LDwNmuXRwjtHNZidT/HpdIkHoi9VPyBo5HzPFDqnrgXYUH9LoC/TiIGW6MZNVpmxriQ6EFF4iIolqCMznnn/4NN0TvD7rD38kyNUVT4Q6qeRaHvM5q8B8wvxKMTHREjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=iCV7v8z8; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="iCV7v8z8"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2d8ffdc31d0so394480eec.0
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 15:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776809803; x=1777414603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ErF/smf1RGwYYSd5uAXQ5ZFI8FNotVeWrqMpZjXu4e8=;
        b=iCV7v8z8MvqKw/2f2O7Xt8O/KfX9m2WH2ov/+i8NhBjQapJxVzW5S3YZkJCRZeZmKj
         OoN2jJalJZEK9ojZo4Ufts/K9A/qgEOKsH4JGwSz/U+CpspNJp9hL56xY1mjp0Ek/fCZ
         qXRtJeH7keP4IDskdMpxevcuzMtJYj6sGFW1TkMlaSSZ3ib3XRCuhzyVgLCLJAgOBnv+
         Z2MYexN7Uq52/sa2L8NwWJfjbXFq/NkvD7UjKrwhK7KhBCAy5zr5A0XAChbRa/2A4MVl
         VMllS7DBPD6XWoROamEvNB5GprrIt7h7yBAqsIT4O+ZnoUWQvsJn4sulJmLOywcu/6Iz
         YvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809803; x=1777414603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErF/smf1RGwYYSd5uAXQ5ZFI8FNotVeWrqMpZjXu4e8=;
        b=gNO3lmdLSaeogVPcdR6sMMm345jF5Ka26fb6qXa4SkSupaFkMosxOjNbDOmAFBS33h
         06Q/ua6dTHRHZEb4pwD63XcEUMSXN6vjgQRc0SLibVLtzIIswkKbgAmZwu4ZG2mmGABw
         c0yyWdRvtaBUEBdad6v4/63dXBm/ZSfa91iUVTyOYyzb0nlZ3C5/Ik8NJAikiihJTRhz
         m4LLdNuQ/D41IEiQWY7ZxV8SnmDzN7yTQDm641hGMJ/8hxsDuxU2UMA2mB9GEnTcxUzs
         iMDBhBIEflvmEbZPs8r/xjA+J+gTT4mwAIAnLhLGtcXguNTL9SxdBNdFyVskK0zuNrEv
         HzLw==
X-Forwarded-Encrypted: i=1; AFNElJ9Hqflv4pfZSz2cIxuWlsmrPIST+CNQlmuX0FqKjDAU20oP+hO2C8MP5ETpYVTCitTVbU+fvC8Z5bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiF4x2GIxjRaFQB5PVukpCirc3vODQOEIPeKczNPbj9PLuuNxE
	l+VUnBSIoM4LptJuj8BdsQ/skemKDhsrAQ5GmvVmRnK9r1hQ4wGPwE5yHV+CrBV5StY=
X-Gm-Gg: AeBDietZM0/28hCjufT4jRI/3AhPksfsWWQ8r0ncOhgCkLivyOkCkNmRb6Xq+++MPA5
	u2K4Qa3WcMUrJDhrh+L7pqT1lj66rnZmarkK6rkfV7qcck0k119vnZWUCIdp0tvzFYds5xJzu3g
	hiceGyL2ujmh2z6vpNKm4cHPBqIqI2CvyqeR8uBg3VwjQQBbdCwHpYvR8Tny4zRkEMsyUfjZeRv
	WIpizvm3mTbKFNDBpsyglAlRXj7lvSzTKJTSCGsUMoIPb92KDIrC3CBmcmaUsfa24pkkpBcyyVx
	dUS1+HlqWr6vupuYlzwB2ve+IX8M0c35fMZKydk0DRU1SMJQHYi7PUVUCosJUZn9WwxmOCS5nZH
	iBVZq0rp9ZITHRrpCN+BkdCNrJICIYbmecHeJ2IqBcuT6zuqYdDYJIpK1e/4mS4mdwovFasV011
	pHdyiXSe5jr31le475oIuoQKCSrZOW+wEkS+rE+6XXco5TYdifmd6zIJL6+4EFWSn/3TzxpX3R9
	WV3N1PORaS4
X-Received: by 2002:a05:7300:5728:b0:2c7:ea98:da0 with SMTP id 5a478bee46e88-2e478a31b67mr11061672eec.19.1776809802953;
        Tue, 21 Apr 2026 15:16:42 -0700 (PDT)
Received: from felipe-ThinkPad-E14-Gen-4.. (201-92-135-6.dsl.telesp.net.br. [201.92.135.6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cfef3sm19827980eec.24.2026.04.21.15.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:16:42 -0700 (PDT)
From: Felipe Ribeiro de Souza <felipers@ime.usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com,
	paul@crapouillou.net
Cc: Felipe Ribeiro de Souza <felipers@ime.usp.br>,
	linux-iio@vger.kernel.org,
	linux-mips@vger.kernel.org
Subject: [PATCH v3 0/2] use guard()() to handle synchronisation
Date: Tue, 21 Apr 2026 19:14:57 -0300
Message-ID: <20260421221629.70401-1-felipers@ime.usp.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor ingenic_adc_read_chan_info_raw() and replace mutex_lock()
and mutex_unlock() calls with guard()() in drivers/iio/adc/ingenic-adc.c

Felipe Ribeiro de Souza (2):
  iio: adc: ingenic-adc: refactor ingenic_adc_read_chan_info_raw()
  iio: adc: ingenic-adc: use guard()() to handle synchronisation

 drivers/iio/adc/ingenic-adc.c | 57 +++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 26 deletions(-)

-- 
2.43.0

