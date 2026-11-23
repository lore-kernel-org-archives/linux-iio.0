Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795406092;
	b=wUz8Qp4Os4WWBE9epNShTHi/vQZVaTZkz9v+bsKeV2XOrsV159nKGNAf4IjWQ6rVB+7k
	 dYiBQaq80PRB9U0YceCl36tLfXfTFkxVED91hf/fxJzuSEMDc2r7yQLSnLDbhAVs4YayX
	 bdpBUVxgRFzDsd3BhE4h4ZJKVgLOdsTes59ztqlaCw9972audxCy09aJ22O8Gb5+CRXmL
	 IdUNrK6QzNDCte7EdJRdPKVWsRcZukIhX1+bPwClGaX2UYcNIypbbVDYRWazxfpJ06dqG
	 F/XAyWdAml3jqxesYVnJ0/3T0xP8S8bpJ0EuSm/BrXD1pdOnT1qFTozIeio4f68LByA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795406092;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=tijZnio262QlVNY8/BenZDD+z9wUKdBtX60AbzY0cdo=;
	b=zJAO9pzDd0+BWbVDhWn79IESKsLl0QJf5Ws5rr+tDjK418pHtPQYPU5F7L4b4mJuQgkv
	 SsdIvEUiYlDWQNarPgWvxVpm/PFfZHfAoqkKMeYztl4GCzOiMLjJcNxEeyJFR0fAtvvzz
	 MZBIikiTY9FX8bXNodgfvUcStfH8HQ59qMjQoNi6zvf9ID1QS1Zmye7rthFQN//hauCax
	 rH4YfWIquRPmxzYaujYzJo4UDSz87lW4fJwPgxjEwoXTTSrmfMWSvJzSBZUixDA6HBIYu
	 i1pqqxxiGKmmZaBs7v6uTrNCdE2JvFNoLG4HxlpJcK4gBrt12i+77CqDg9E95Q6oAFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=n1i01Hdq;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFB3606A31A;
	Mon, 23 Nov 2026 03:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AFB3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=n1i01Hdq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ti
	jZnio262QlVNY8/BenZDD+z9wUKdBtX60AbzY0cdo=; b=n1i01HdqSmoA7yRdFr
	leZcYa6lUeE6ZbvxvczG1nne6diD/ZES1idrq2loVoFsPpLZjf5uOnFs1nJvKCTG
	Ol7gt/tUBMVSFbc5f7NmACK5kOXsLlUopcG1t94fJbW0BndRopsqA7oYiSgWFEMj
	LWE73pqaczhfEcwacrhcE00mY=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBX3UDhuANrzxO8Hg--.53023S2;
	Mon, 23 Nov 2026 11:54:11 +0800 (CST)
From: Wanhui Fu <fuwh1120@163.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	Wanhui Fu <fuwh1120@163.com>
Subject: [PATCH v2 0/3] iio: adc: twl6030-gpadc: convert probe/remove cleanup to devm
Date: Mon, 23 Nov 2026 11:53:28 +0800
Message-Id: <20261123035331.1871875-1-fuwh1120@163.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:PigvCgBX3UDhuANrzxO8Hg--.53023S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr45ZF1UXrW7Xw1kWFy8Krg_yoWDCwb_ua
	yFya4xWw1DGF9Ykr9rZw17XrWFya929rs8GF1rtFZYyFn7Xrs8Zr4DCF48Zr1qvr4xtw1U
	Wry5tr4fuF1IkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbBMKtUUUUU==
X-CM-SenderInfo: xixzxiqrsqqiywtou0bp/xtbC7gMCoWsDuOPr8gAA3k

This series converts twl6030-gpadc's probe error
handling and remove path to devm cleanup, and
deletes redundant dev_err() messages in probe.

- Patch 1 registers twl6030_gpadc_disable_irq()
  with devm_add_action_or_reset().
- Patch 2 converts iio_device_register() to
  devm_iio_device_register().
- Patch 3 deletes redundant dev_err() messages in probe.

Compile-tested only.

Changes in v2:
- Use devm_add_action_or_reset() instead of a
  goto error path. Thanks, Jonathan!
- Convert to devm_iio_device_register() and drop
  remove(). Thanks, Jonathan!
- Drop redundant dev_err() messages after twl_i2c_write_u8().
  Thanks, Andreas!

Wanhui Fu (3):
  iio: adc: twl6030-gpadc: use devm_add_action_or_reset() to disable IRQ
  iio: adc: twl6030-gpadc: switch to devm_iio_device_register()
  iio: adc: twl6030-gpadc: delete redundant dev_err() messages in probe

 drivers/iio/adc/twl6030-gpadc.c | 41 ++++++++++++---------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

-- 
2.25.1

