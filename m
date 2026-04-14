Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789B938AC8E
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776206585; cv=none; b=NH853vUVFRQHrr8nTPjnb/1i71X4w5sp7PEBYze5/8z4zOGTWRtW4smGKIPl76rnDKpx7g6zLw7ekbUQqxizjm3R5wdk3AWe31mZ4oUazrWmthBYhySslg5Xm1UXLoM4k4X72H7BXoR7BUiXQc0UKwhLfQECI++naBsCtEvceH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776206585; c=relaxed/simple;
	bh=PJ0wXrCJwRZB6Cz8UmYg3CjBCouUvrNMwy2eugg6LQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y99/EgpjIsI+CdUNdiihR1Pu1oKhum4YrBbd4YGL3NpthevoDYjHZaGFIgmDhxOw5IbzUpIw0q/P4wqVzd8Fp32iKULKeRlchQgHI0a5RMnO7KCcA02wCMuVm7bBjyyHzO6XuKFhQTHu4YcuJklFSWJRU4jVrV9oe8KhP/cJFIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=jeANqBSD; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="jeANqBSD"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so5487795eec.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 15:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776206580; x=1776811380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rb3BLemqhdiX3ZwvRyrWGWGBqhlheXx+K5Ge+Z0UaZU=;
        b=jeANqBSDQEFnjLJ5UJM5/VjJI7XCBrBPawAivpnstIyoTAq5DTJhtSyzIwtOuW35ey
         VZEq4Bp5MTatUMeWyA4Jucf1LbY51AssnVNyg0Ztb83HbRCPpN/W65pcznQXJopxPJZ5
         fSt6iqmsxmNu67T34KVmPE0l9CovCRav7PRimVxrl25WkoyWHoAVBVUdLha0kPN/QNxd
         yga1DToWQxjUT6xYoJNiKmWJaq9txPwXywR0ROSkJKQEN8F9SurMf4s4yBnDhoaO1EqG
         LH0Gv55RXkZ851KnhqaS8L0uJl/U2VqrLsk9UblxkvLeZ1twJxfeNl7CzC6I6JdtYTMK
         4QhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776206580; x=1776811380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rb3BLemqhdiX3ZwvRyrWGWGBqhlheXx+K5Ge+Z0UaZU=;
        b=sBudkeQDcYqk0ryMyFwfhv4WvbqJoieISGDQ1gSB9sN5yxmx0T3ZwKj+aAzahiwaFK
         vxWK2WRGMmHK+gTifwsRtZqhqxn9oWRP3yvA/UardAdCfkQM09ZX932vDpOw6zZFGukT
         cXIhcHqGyFGbwLh7vT03yd++qrtR5na9f6ekpRVhTjDGvIs8FKi1znxctXalsCx91ZcZ
         +vdi3x2/bVvhu5qqd7w1ZkLqV8VxtUCXmPEflwa90pvXy1qXAk/Kx/Ejf8Adyju7unKk
         19mQoSBkmxF2MfmLehH9hBJeGGA+p5XvImAbInlpBaWq7ls9MA8PheSbkLzv7Fyde9tD
         tj5Q==
X-Forwarded-Encrypted: i=1; AFNElJ9Y02VJxSVE7GQf8Yky7EuwQnoWh3upfa8lyeKq2kngoFfUud/3xHSQRv8JDy1ofRETplFH5UL3nt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvPAHauReneaPGFlEgm+TFbnDMASkE+QbBMH1CVpyFHOvlASPP
	uvYcQEBuW7jxoIUInd9bXmUV4rcRsHcGpi/cmvQbmR0NekiLcWnt+Ga1LgRnRvQu8Mk=
X-Gm-Gg: AeBDiet8iz5tBa3wkwj7Q4q050EPhsqpPez1NO8cP2yUAVmR6NhnEkh7VauRgrwkotF
	hb9CTxbcnFfkyp/5X7vbn7Vr8/kk/bhP/EtCyUgYLhW4HSbP6vhQJnvIunqT75H0iVNJQhzm5Qu
	eeTVmcwd0uDfDmhQY06JHcbMe0BfIaU7YIr9b+xwLMftMasCjDZ8V58i0TONCT4wSi8SdaHDVtS
	J90JT+wnaJY/UAAjoLVuqligDieeYYa4RTTFyLSE7krmRlRpRoVwO6YQebJtXIxGXQHyJmy1L7A
	Uy7lGzCE+HfVtFs66oLn0kDDldhqog2rsXs6gzm2yF8Aza/TkjV7WF2L/dAw1D5KXxVaZNwmBDM
	GgA7z8UKYnO7VuHKlHStZSWg4moC9XPtluvvTO+qOUxwfDBGyS5yLMI+bqWW4YBgQpMfq4cbUVV
	AAERnTH8S0PpbiAO6bjvFAgdj/jGf25ZNZkAtmU2vOJElroY4OIvqhiB5Utinfxoh6gcYtakaU2
	JfGGqo/96SZbWLQdI3NuQjq97jIlHwxTxWzgGUnuci5Gx3/Zw==
X-Received: by 2002:a05:7301:1f05:b0:2da:1a81:588 with SMTP id 5a478bee46e88-2da1a906cbdmr5452024eec.14.1776206580488;
        Tue, 14 Apr 2026 15:43:00 -0700 (PDT)
Received: from gui-host.Dlink ([177.33.104.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2dd32dc2827sm4650361eec.23.2026.04.14.15.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 15:42:59 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: Salih Erim <salih.erim@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Subject: [PATCH v3 0/3] iio: adc: xilinx-ams: refactor alarm handling to table-driven design
Date: Tue, 14 Apr 2026 19:40:32 -0300
Message-ID: <20260414224245.8493-1-guilherme.bozi@usp.br>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses significant code duplication in alarm handling
logic across the Xilinx AMS IIO driver.

To address this, the series introduces a centralized table-driven
mapping (alarm_map) that replaces multiple switch statements spread
across the driver.

This improves:
- maintainability (single source of truth for mappings)
- readability (removes repeated switch logic)
- extensibility (new alarms require only table updates)

No functional changes are intended.

Series overview:
- Patch 1: fix out-of-bounds channel lookup 
- Patch 2: convert mutex handling to guard(mutex) 
- Patch 3: introduce table-driven alarm mapping

v1 -> v2:
- Fixed Fixes tag format
- Replaced AMS_ALARM_INVALID with AMS_ALARM_NONE
- Changed alarm_map base_offset type

v2 -> v3:
- Replace 'i >= num_channels' with 'i == num_channels'
- Add missing trailing comma in alarm_map array initializer

Guilherme Ivo Bozi (3):
  iio: adc: xilinx-ams: fix out-of-bounds channel lookup in event
    handling
  iio: adc: xilinx-ams: use guard(mutex) for automatic locking
  iio: adc: xilinx-ams: refactor alarm mapping to table-driven approach

 drivers/iio/adc/xilinx-ams.c | 190 +++++++++++++----------------------
 1 file changed, 71 insertions(+), 119 deletions(-)

-- 
2.47.3

