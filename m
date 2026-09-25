Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489952E03E4;
	Fri, 25 Sep 2026 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342299; cv=none; b=HjmZ2ntbyeM7lkmB+GEWjfx3IgZd/f7Je5q/gkQpSakoROSAqqjKNonAynmQaKeNDRPNF4BDLZhYIuEyTIHpskTi78Zuo3LH+Z9j64K9pQYYlN/Tb6iENH8czLsKfmyC7pdSxtOw9VSMFmw77bU5Mz/mWJLGXhqYGxVXOKoMLLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342299; c=relaxed/simple;
	bh=fXw1XFTYpoIA44mnFG03BeQj5rr+UWOhlpOmSxYb0LU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q0QPgDuWn4dLhMR9/aT+p9mPBim405n7nEh7JogbMxyJc9pwMK90zUizXtV3G2b7xDdCWjuasWOjL0IEDMX0yipdmHsAQime1kl+TtsMpBa/tnA7Ft3lF1CAv+cNL20anB85jRusT1SsZJmrigpoZjj/Nx0ggtGVMaxTf9TpDAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=C06Xiv20; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="C06Xiv20"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=CT
	DPZT871AVQpArpk16gfTXtCUkE5IK6MbL1Vv3qNnE=; b=C06Xiv2021QQH5+I+6
	kB+gFZ5rNkPjxoORbXCOATD+P0lg0wadr2+JIA2L+wJlX7vINfOCEePVaibSHEpG
	0213z9AZ+3KKK4kagx6hXf8wwWe9oOmNI9Mm77d+pqoxwTISHUIaZNpHsQWoIgUz
	KIwc3mtnaZDZMsOAS6X0j3Sus=
Received: from pc.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgC3fy9zdLZq8jiZBA--.52716S2;
	Fri, 25 Sep 2026 21:17:40 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rodrigo Alencar <rodrigo.alencar@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Anshul Dalal <anshulusr@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Herve Codina <herve.codina@bootlin.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Shi Hao <i.shihao.999@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 0/7] iio: validate SPI match data before use
Date: Fri, 25 Sep 2026 21:17:29 +0800
Message-Id: <20260925131738.2200612-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgC3fy9zdLZq8jiZBA--.52716S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw18WF1xJw4xXrykXr1kZrb_yoWDuFg_Wr
	1qvrn7XFyIkw1UKw4IqFnavryjkFWxWr1kArs2yrWS9rZrZr15Ar4qvr4kAwsrZFyqqFn8
	X3WUKw4Fy3s3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKF4EDUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8BWCvGq2dHWC7gAA3q

SPI driver_override can bind a device without a matching entry in the
driver's ID tables.  spi_get_device_match_data() then returns NULL.

These seven IIO drivers use that result without checking it, causing a
NULL pointer dereference during probe.  Add the missing checks before
the match data is used.

Jiale Yao (7):
  iio: amplifiers: ad8366: reject devices without match data
  iio: dac: ad5755: validate SPI match data
  iio: dac: mcp4821: reject devices without match data
  iio: frequency: adf4377: reject devices without match data
  iio: imu: adis16400: validate SPI match data
  iio: potentiometer: x9250: reject devices without match data
  iio: pressure: bmp280: validate SPI match data

 drivers/iio/amplifiers/ad8366.c   | 2 ++
 drivers/iio/dac/ad5755.c          | 3 +++
 drivers/iio/dac/mcp4821.c         | 7 +++++--
 drivers/iio/frequency/adf4377.c   | 3 +++
 drivers/iio/imu/adis16400.c       | 3 +++
 drivers/iio/potentiometer/x9250.c | 7 ++++++-
 drivers/iio/pressure/bmp280-spi.c | 2 ++
 7 files changed, 24 insertions(+), 3 deletions(-)

-- 
2.34.1

