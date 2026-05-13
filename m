Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC1A1519B4
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 00:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778632514; cv=none; b=s9mmRmqtwgesMNLE8pNQCcyFh8N8RZI6Nb0rxncDTyzWIKbm88+Lc2U90tYQCfAAGZF7if+CA8dA/e45a/tIY15RUw8SwWDjGYjmxemzOAWTD9gQUSFchnlhbiVtpHnaH2cGJEHrU1lgQbScRNxnxvtFZuXfo7MkkHOH98wJcM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778632514; c=relaxed/simple;
	bh=VchqkeW3z9oXqLmMUKiDkbcIvetYWnrmw5hffU3NtVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UYRHNCQXKGUHtuH+3Yg93UV6zZKUjYTL+4zYtKth1LqdvPQmBMdqNBhkN3aWXnFT1QVJNnEKcdo6N3T9Sy1jd602St6INTZLOMTphsfk5wBvhZPHn9XRLr7cwo/N2wGydXzTfpzEuFCqmZiGmXGkA7sAG6no/5uXsdFADZKr8bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=lNXPCagS; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="lNXPCagS"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ee990e8597so10555699eec.1
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 17:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778632510; x=1779237310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2HdlAWdjeMiye6hUd5QaqiRVp5gEIQPNXzXyC/HWY7w=;
        b=lNXPCagSxEg+4zlL86c3IXklIymPiaIXxZrDLgjqdXtbiTSHSq1/1KgE1vVDFLd5d7
         5dvgcJ/KDSSexPLMGVjW+whKUqlo5xl21CzXDQ2Vme37+xo0mfqSOW1BLY2ZWp2OlTaA
         JZgkc92XRYh1IHKoe+7N8koPX2pw6DJyc0rzDlBeO02x7bwznlDv9h5M2FXQ36hNBLlI
         Q+hlJ3jcci2Uv57utlcKrapD7ouo7GpA78BCSfFwPveNxuPR3ovNpCAeuxs+StMLXXem
         f1oGZwhR3GDvSnY6VcKyWlpxxm0MwtbKOEQL9SkwuJ6ZatE8H6OUHCeLcxRHz6tlfgqb
         zw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778632510; x=1779237310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HdlAWdjeMiye6hUd5QaqiRVp5gEIQPNXzXyC/HWY7w=;
        b=qIQhhsAHErc7eq1F1dKDHhh8nJ9PWahK35B965Bnl1O+Nh/IUqPeJUyS27RSxJ0U1Q
         QoEjqLaRe82ooKV5LfDTNa63QCZOS/m+BXepwtAcpstta42M6IAZnrV1/TRK2N5aBaLg
         4iTjMug8dscOB074F6NsZzcGBNBcrZ30zpTe6gwqiZ7gYxcJWbGmGVEwKQNDACxhdRMX
         cWLx0MZJuZrorkSzUOXW/h2MiI9tffDjyFTjRyiCd+5FNSYtpvgJc5sjIo09dcQSmA6M
         bW6pp900Qyrerjk3YuCmMGUYl28f1m5kz85oufRjAHfWIHCzLMsfpMwEySWrAkKBpkRc
         218Q==
X-Forwarded-Encrypted: i=1; AFNElJ9hvbQ2Ii1YXLCfcwiMHCLA4D6SNoh3f3y+g/UftqkrFwuB4EyJ7QRP7NU+WFmOmBhRe0TlykCSds4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsl9zJQr6nujF9ce35AuSvbd3bWDMKqWgSf8e3Y3DNwLmvDHH0
	GTMnO+vuxMWHTqxqlqiLb+F0vEvqNISE6EkWzrgFz1YUZYrRdABZssEhXgw2O+MNKIxSvJO5UPk
	J2LxXG2A=
X-Gm-Gg: Acq92OHacFhpQmceKww4JAc+Mc8ewzIrGjA1RsD9iPEdaRFAHPGxj1Asq7K3EPcVoEb
	3Ur3+TjfDWUNHaGbWZnMH6og06DUupiEyJzubYXhV/c5NDdgxBdCkcT1OjljsDd9JJKmV8YdAvQ
	hShfuNCcl/tWjvFSrmU1lbbrZskPGwXm+x7zTDTYuZMoNd6cLRvYeJhTN4w3m3HPIy+79D3Ruh+
	/NcjGWCQAabAa+lUynNjRvsojGQ8ip0jvj8nA3/+8s9rhj7lK5nYTK7S1VO7MwKheHHpxnULNMd
	hP+avUYEvmfngJ9SN4nXcDRM9aI0BLP7lwDDBlVhhIYDjR+pMtBqwZOBFAAuBl4SfSqu5eSCBuM
	LcPRfAYvY6u+PPQ+N2u7g4AwgwKG0CgM4L5fvhNe9PUoX0z21UBKeocgAlndrN2SDeFMf0NGV5j
	m0cQSezq/EUIi3jG4CQktTw47HwRxH1dRehIdxflWOMpiBC5ufNFi0JH+cygLu6v6+GBpQdNymp
	rBMGYSUCaRwCJiAdvROyu2NPZ3ktnw6yyylGg8nWU4XCLP9
X-Received: by 2002:a05:7300:b586:b0:2f1:3aa8:f2c with SMTP id 5a478bee46e88-30116e980c9mr798294eec.4.1778632510419;
        Tue, 12 May 2026 17:35:10 -0700 (PDT)
Received: from gui-host.Dlink ([177.140.77.53])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f91004b6a2sm18471381eec.0.2026.05.12.17.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 17:35:09 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: anand.ashok.dumbre@xilinx.com,
	andy@kernel.org,
	conall.ogriofa@amd.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	manish.narani@xilinx.com,
	michal.simek@amd.com,
	nuno.sa@analog.com,
	salih.erim@amd.com
Cc: Guilherme Ivo Bozi <guilherme.bozi@usp.br>,
	Jonathan.Cameron@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v4 0/3] iio: adc: xilinx-ams: refactor alarm handling to table-driven design
Date: Tue, 12 May 2026 21:31:49 -0300
Message-ID: <20260513003503.339418-1-guilherme.bozi@usp.br>
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

v3 -> v4:
- Removed unnecessary 'event < 0' check for type e32

Guilherme Ivo Bozi (3):
  iio: adc: xilinx-ams: fix out-of-bounds channel lookup in event
    handling
  iio: adc: xilinx-ams: use guard(mutex) for automatic locking
  iio: adc: xilinx-ams: refactor alarm mapping to table-driven approach

 drivers/iio/adc/xilinx-ams.c | 190 +++++++++++++----------------------
 1 file changed, 71 insertions(+), 119 deletions(-)

-- 
2.47.3

