Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9AD49E5E2;
	Fri, 25 Sep 2026 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341144; cv=none; b=uXOObPp11S/ki8kD0OP9/Pjmli/jcA/jDt4auV9NicEBI/Y/r/jLNDzlVJhGK6jhFQWE5qN1mvSwPra0sI5CjFuY8D0XE3edzLS1CLJfZnc/HSH+GRZPor0oQz+jPDClTKsXVnczNPwfM31jwOqQ/npTXOLGPBp2kBmTDZmQjiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341144; c=relaxed/simple;
	bh=4AxdFT0WzmSbeLuiFxP/HrQa4E6cMrns/k3nnEBxLVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RF0i8MQf+2+JGbnAs07q8z6z99W1dpOuFxUJRIojnYCWg0SqWK6H/a5NwC/tE8cd35V+eYCF5fE8ibKVnnMebg6mVwoLC2vTbrvquC73kE62UnBLVFscgDA/h96FE16BELSVSiZ9Vdqapu3+k8NlN01WbLGpR6alFw0XLpFoBkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=E2il2/mF; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="E2il2/mF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Yq
	m0myE8nRYdyf7NdK4DeAIbw3YyMn5drzZbBpux0oI=; b=E2il2/mFmKcnTRboyX
	0ByZDa+gUIXzp1ftOtOhylRu4ANl4U0gmYTRx26O/4ZGqrIMQTBtbMDs/1cGJ8O5
	+6IkYt2C5mHw5odnuTyDjTpwzK9Bfl//mLT3F0xkTjz26x44Px/2OAvWydV1sRN3
	aMOSmJ1BVh2TgAZGg4ra5Ha98=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3f3zUb7ZqOLTlAg--.28269S2;
	Fri, 25 Sep 2026 20:57:58 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ramona Bolboaca <ramona.bolboaca@analog.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Kurt Borja <kuurtb@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	David Jander <david@protonic.nl>,
	Danilo Krummrich <dakr@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	linux-iio@vger.kernel.org,
	linux@analog.com,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 0/9] iio: adc: reject SPI devices without match data
Date: Fri, 25 Sep 2026 20:57:38 +0800
Message-Id: <20260925125754.2162337-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f3zUb7ZqOLTlAg--.28269S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1rXF1kXw18Wry5tF47Arb_yoW8ArWrpr
	WqkrZ0krya9Fn0ya1kG3429a45JFsYkrWYgF18t3Z5urZ5AryUXF18ta4xt3Z7AFWrt3sF
	qry7Gr18W3WvkF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziF4EXUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8BZZk2q2b9YmyQAA3m

SPI driver_override can bind a device to a driver without a matching
firmware entry or SPI device ID. In that case,
spi_get_device_match_data() returns NULL.

These nine ADC probe paths assume that the returned chip information is
present and later dereference it. Reject devices without match data before
the pointer is used, following the handling added to the AD5686 bus
frontends by commit 572a00852635 ("iio: dac: ad5686: missing NULL check on
match data").

The ADC128S052 and ADS7950 probes also dereference spi_get_device_id() to
obtain the IIO device name. Use the always available SPI modalias instead,
so the override path does not depend on a matching SPI ID.

Each patch fixes one driver and can be applied independently.

Jiale Yao (9):
  iio: adc: ad7192: reject devices without match data
  iio: adc: ad7606: reject devices without match data
  iio: adc: ad7768-1: reject devices without match data
  iio: adc: max11205: reject devices without match data
  iio: adc: mcp3911: reject devices without match data
  iio: adc: ti-adc128s052: validate SPI match data
  iio: adc: ti-ads1018: reject devices without match data
  iio: adc: ti-ads131m02: reject devices without match data
  iio: adc: ti-ads7950: validate SPI match data

 drivers/iio/adc/ad7192.c        | 3 +++
 drivers/iio/adc/ad7606_spi.c    | 6 +++++-
 drivers/iio/adc/ad7768-1.c      | 3 +++
 drivers/iio/adc/max11205.c      | 2 ++
 drivers/iio/adc/mcp3911.c       | 2 ++
 drivers/iio/adc/ti-adc128s052.c | 8 +++++---
 drivers/iio/adc/ti-ads1018.c    | 3 +++
 drivers/iio/adc/ti-ads131m02.c  | 2 ++
 drivers/iio/adc/ti-ads7950.c    | 4 +++-
 9 files changed, 28 insertions(+), 5 deletions(-)

base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.34.1

