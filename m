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
Subject: [PATCH 0/7] Fix regulators and PM for AK8975 v3
Date: Wed, 29 Jun 2016 14:08:32 +0200
Message-Id: <1467202118-10386-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

This series finally has been rebased and tested on top of
Jonathan's development tree, also rebasing on top of Leonards
patch for AK8975 which was in there, and test-compiled the
result.

Linus Walleij (6):
  iio: magn: ak8975: fix regulator usage
  iio: magn: ak8975: add Vid regulator
  iio: magn: ak8975: refactor regulator handlers
  iio: magn: ak8975: allow a delay after enabling regulators
  iio: magn: ak8975: make sure to power down at remove()
  iio: magn: ak8975: deploy runtime and system PM

 drivers/iio/magnetometer/ak8975.c | 151 ++++++++++++++++++++++++++++++--------
 1 file changed, 120 insertions(+), 31 deletions(-)

-- 
2.4.11
