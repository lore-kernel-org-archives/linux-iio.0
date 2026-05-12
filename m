Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC07872621
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 01:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778549007; cv=none; b=pLKyHOgr3X3AIdg9c19TvPWlcLliAc48kSaTXT6oHUxzGWCe3Pouc2R62lA+gIqS8TDqg8NaeKVSt/25LL0lrEIT6V1anmYUCOWfPNi/QAOjxiVrzxA75uT5y/DR4YAn1mBLnl5nnC61wOMR/ECGTDXkshAf+50ABoy7LjEQbSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778549007; c=relaxed/simple;
	bh=OVbT7GrjO4bw54kW6wWdnEsBmgKNZjPUqoLO1KwrOgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OkMK7CQonAEXxNGxFEqEEHO5kEsS1GtZDRgg0yXC6XOg5i1B2G4Fc/cbeXDwJQu1skPtLrFyeHMc5CT9EAh6daQgmo00fXu5kPPjUf5sxpTHoCTsCQpJyHjLJBw4ZVUGmFFNJgmMHW8NZwMcS0Dp2XLpdldr+nFTFuPq04KbyQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=eXfew3S5; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="eXfew3S5"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2f68f3b075fso6445010eec.0
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 18:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778549003; x=1779153803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bWaS1RB5JDYayjocwxCsK8mCDmJHUShMMBNotDmrnWA=;
        b=eXfew3S5BQ3LZrSOxBKdmrBqwLaxgKODfVruqdWB+jobv2hEaGgwaU89DNouwpDobb
         cmGdbpbD7oZ6VK9h8sIbqa238vlkHhJhjKKzn49dkg786P9E6fCp1KcHu+w6Oz6BlFkE
         BdCHooY1Fqc2MVfYgd90VlCsnZ/uRPhlqmVT3YjeSMNAgKFh45gqRRP3m26Ffgf0DkRI
         YlzYSky6V+sWAmeEjY9kXaiwV2wu8X7WYFsXdayZor4NgkYY+RZzBeHZaJvypUKVnIWk
         ml2zOuNUfBBYrE0iijEQFEj3LvguFSO5wpokvU5zarOlqYk70v5tpMeu9d537Fw2ctLB
         Ui6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778549003; x=1779153803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWaS1RB5JDYayjocwxCsK8mCDmJHUShMMBNotDmrnWA=;
        b=rUy0qG1pT0uliA6ZJ5KkD/TMp9D+Ct0K/Hgw9NTsZRe3Oz66r/SB+HeoqSlqFREQWX
         XKNeEG3ZiCVzF/1cA9qu7e8ggzSsWgxzZ1IZBMmfbVGaBcvdmDQSc0KR7p0MSCLFor0w
         n7LNgAON9+w0/J88Yjus1I36N+AOi6AfDyP/MO3p1L7Hu2Jz9OMcT1xNgdMc6n+3Yniu
         NN8jOFyr60WC4LMpegXNFtQhlZ1Ifpg3N3JHXMnpm7+adT1EKirZtZeiAVlV29mWWBUU
         9q7KNyf4s4YSYctUqzU+WPv3NE9uuO6e2u7C05pRGydm/qrpc0dXGVNyOMS1vN4tQaOq
         i2/A==
X-Forwarded-Encrypted: i=1; AFNElJ/l099Zvxe+vQqL/PPZLpqfL1exeNHzHY+xcQ/qY2YtsVrOG097subQCdlLyZGBjaTTIdQ44yjwmvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywJ9kuyfEtP2W0Ll++xwTp3AiDoLq8wvYHMltg+XZYkJcb940r
	64iQOQmlhZ+Tij1cMH4Efk6EKHeenvrrOxuHfK+jPFXB1x2E3MqINi46/UDYEb59thQ=
X-Gm-Gg: Acq92OHM8iaSzorhYvSKTPoFPUPUyBlmAmvoEH/U2Hab9JosLF0LG4yjzjXaFjsVifP
	E/3Yrba9guRRysC6+DkOkX6cke7DqntjTrgZzSKXsja+gLcJKxF0dnpP/UW3lOTPpVBa1yDvVYX
	NuGaZuYhaFf0RBX1uWeZuEAFg10xLqT+VzJUtWE383SIADXcynpELTDO7FBmxskVBZyM6i8NLbz
	XxJ8JJTUQ/H0Ra8NZdGBMW/J/ZMoSIdPkInCLHJG9MUSL4/AIVFW393CYXDhMivTrofaLdckCn3
	9cYyCQYmtNucPNYOsmctoVoblbYxbztIe6GQtZ0UABtnuQQekc5pMxQzwuyqodq65/4MYioVgCx
	P4AuD8ZB4kV0gAbha6hTGTy4/IYDXfwYOCZwfOQhen2uZITB38TbvnXoB3L+7V5A36EN9BVNw2q
	rkp2MYmCDjGnk3t/YlhUDVq6f46j3c8Q==
X-Received: by 2002:a05:7300:bc0c:b0:2c5:ed1b:ca9 with SMTP id 5a478bee46e88-2f85bb72d01mr8468512eec.1.1778549003223;
        Mon, 11 May 2026 18:23:23 -0700 (PDT)
Received: from natalia-pc ([191.205.196.185])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847506fsm19484481eec.18.2026.05.11.18.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:23:22 -0700 (PDT)
From: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jikos@kernel.org,
	nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com
Cc: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v3 0/6] iio: hid-sensor: standardize scan_type initialization
Date: Mon, 11 May 2026 22:16:16 -0300
Message-ID: <20260512012302.20883-1-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series refactors the HID sensor drivers to standardize the
initialization of the iio_chan_spec scan_type structure.
Direct initialization using compound literals was used.

This change improves code readability and ensures that all fields
of the scan_type structure are properly zero-initialized.
Additionally, for the hid-sensor-accel-3d driver, the channel
initialization loop was refactored to iterate directly over the
scan indices, eliminating redundant logic.

Natália Salvino André (6):
  iio: accel: HID: hid-sensor-accel-3d: Refactor channel initialization
  iio: gyro: HID: hid-sensor-gyro-3d: Refactor channel initialization
  iio: light: HID: hid-sensor-als: Refactor channel initialization
  iio: light: HID: hid-sensor-prox: Refactor channel initialization
  iio: magnetometer: HID: hid-sensor-magn-3d: Refactor channel
    initialization
  iio: pressure: HID: hid-sensor-press: Refactor channel initialization

 drivers/iio/accel/hid-sensor-accel-3d.c       | 27 +++++++------------
 drivers/iio/gyro/hid-sensor-gyro-3d.c         | 24 +++++++----------
 drivers/iio/light/hid-sensor-als.c            | 18 +++++--------
 drivers/iio/light/hid-sensor-prox.c           | 19 +++++--------
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 20 +++++---------
 drivers/iio/pressure/hid-sensor-press.c       | 19 +++++--------
 6 files changed, 42 insertions(+), 85 deletions(-)

-- 
2.51.0

