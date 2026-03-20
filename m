Received: from mail.imp.bg.ac.rs (mail.imp.bg.ac.rs [147.91.50.100])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6352C279DC8;
	Fri, 20 Mar 2026 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.91.50.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019443; cv=none; b=LkypToxdLtxmf8DUBMIJ/uAWOO5A8Ig88dnbzYXQ6Sugk+Tivk78e2V+dQQ6945xsJYOv76SmiPrOFFRAASTMAMbXo9y+IeoJ/L6AX/lkT9R3Xjiu8ahRDH9gsCgM+z5tH8EEk3koZTIeXIEToujGvW4Tl9yroMSYGT4Yo4uLgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019443; c=relaxed/simple;
	bh=60yW4ufoxAKBkE1Tl1c+/2e3pPIuHxJYDApr1O1X6+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyxN3dje0Q81Q7YbBXDOPZa+UPd8EwjZ4UhJNHSoV3skbv93pwIaCiy/n7xFuskJPBmVg9q/H7TH6d0gR6wYBSnfTnin+mG7xaPE3wqZjsLSHAOgpqVo2v5XuDzU6/bT/IaGXrxOojxB3SM15YLwI4hzfLHlNwAtik5xXbLT39o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pupin.rs; spf=pass smtp.mailfrom=pupin.rs; dkim=pass (1024-bit key) header.d=pupin.rs header.i=@pupin.rs header.b=s3/ertac; arc=none smtp.client-ip=147.91.50.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pupin.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pupin.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pupin.rs header.i=@pupin.rs header.b="s3/ertac"
Received: from localhost (localhost [127.0.0.1])
	by mail.imp.bg.ac.rs (Postfix) with ESMTP id B2840140C2723;
	Fri, 20 Mar 2026 16:10:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pupin.rs; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=dkim20260301; t=1774019432; bh=60yW4ufoxAK
	BkE1Tl1c+/2e3pPIuHxJYDApr1O1X6+k=; b=s3/ertacjTHDM66JrwkFSvWUNbN
	RantDsdXy2a3l/YgKdmGG6vjDb3PJv+qvNlx/ywJH21MeXMcNrwsVz9ZVbdY/sFu
	HnONQIO6eskofpb4XOLzbUzlBZd1hqbzuR52KgI+6kG60QWWC4DhxA/tgKEKeWbQ
	ejbAH1VF3cCzIcKU=
X-Virus-Scanned: amavis at imp.bg.ac.rs
Received: from mail.imp.bg.ac.rs ([127.0.0.1])
 by localhost (mail.imp.bg.ac.rs [127.0.0.1]) (amavis, port 10024) with LMTP
 id LRCd2W7nCBu9; Fri, 20 Mar 2026 16:10:32 +0100 (CET)
X-Comment: SPF check N/A for local connections - client-ip=147.91.52.78; helo=phyvm-virtualbox; envelope-from=david.marinovic@pupin.rs; receiver=jic23@kernel.org 
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.imp.bg.ac.rs 834CD140C272C
Received: from phyvm-VirtualBox (unknown [147.91.52.78])
	by mail.imp.bg.ac.rs (Postfix) with ESMTPS id 834CD140C272C;
	Fri, 20 Mar 2026 16:10:10 +0100 (CET)
From: =?UTF-8?q?David=20Marinovi=C4=87?= <david.marinovic@pupin.rs>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Marinovic <david.marinovic@pupin.rs>
Subject: [PATCH v3 0/3] iio: dac: ltc2632: add support for LTC2654 DAC family
Date: Fri, 20 Mar 2026 16:09:45 +0100
Message-ID: <20260320150957.105571-1-david.marinovic@pupin.rs>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260318135736.91564-1-david.marinovic@pupin.rs>
References: <20260318135736.91564-1-david.marinovic@pupin.rs>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Marinovic <david.marinovic@pupin.rs>

Greetings!

This is v3 of the LTC2654 DAC support patch series.

The LTC2654 is a quad-channel, 16-/12-bit DAC with internal
reference voltage and SPI interface, sharing the same 24-bit
SPI protocol as the LTC2632/2634/2636 family.

The LTC2654L-16 variant was tested on a Phytec phyCORE-STM32MP1
board with the DAC connected via SPI1. The driver probes successfully
and all 4 channels are accessible via IIO sysfs.

Changes in v3:
- Patch 1 unchanged
- DT bindings use fallback compatibles for LTC2654-L12 and
  LTC2654-H12, which are register-compatible with LTC2634-L12
  and LTC2634-H12
- LTC2654-L16 and LTC2654-H16 keep separate compatible strings
  as no existing compatible supports 16-bit resolution
- 12-bit variants reuse existing LTC2634 chip_info structures,
  so only two new chip_info structures are added for 16-bit variants


David Marinovic (3):
  iio: dac: ltc2632: drop enum and use individual chip_info objects
  dt-bindings: iio: dac: ltc2632: add LTC2654 compatible strings
  iio: dac: ltc2632: add support for LTC2654 DAC family

 .../bindings/iio/dac/lltc,ltc2632.yaml        |  12 +-
 drivers/iio/dac/ltc2632.c                     | 367 +++++++++---------
 2 files changed, 188 insertions(+), 191 deletions(-)

-- 
2.50.1

