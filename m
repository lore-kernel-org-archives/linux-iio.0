Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Richard Leitner <dev@g0hl1n.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/6 v2] Fix regulators and PM for AK8975
Date: Fri, 24 Jun 2016 11:11:50 +0200
Message-Id: <1466759516-20586-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

This is the v2 of the patch series for AK8975 after some comments
and build robot complaints fixed up.

- Split off a separate patch to power down chip at remove()

- Move some patch hunks around.

- Updated runtime PM commit message

Works solidly for me.

Linus Walleij (6):
  iio: magn: ak8975: fix regulator usage
  iio: magn: ak8975: add Vid regulator
  iio: magn: ak8975: refactor regulator handlers
  iio: magn: ak8975: allow a delay after enabling regulators
  iio: magn: ak8975: make sure to power down at remove()
  iio: magn: ak8975: deploy runtime PM

 drivers/iio/magnetometer/ak8975.c | 130 +++++++++++++++++++++++++++++---------
 1 file changed, 99 insertions(+), 31 deletions(-)

-- 
2.4.11
