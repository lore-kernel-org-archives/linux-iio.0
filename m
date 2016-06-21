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
Subject: [PATCH 0/5] fix regulators and PM for AK8975
Date: Wed, 22 Jun 2016 00:18:13 +0200
Message-Id: <1466547498-15484-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

This fixes up the AK8975 so that it performs nicely on my APQ8060
Dragonboard which controls the power to it with a simple regulator
which actually goes off and on and cuts the power between uses
by using runtime PM's autosuspend feature.

Works like a charm for me, but would be nice to see more people try
it.

Linus Walleij (5):
  iio: magn: ak8975: fix regulator usage
  iio: magn: ak8975: add Vid regulator
  iio: magn: ak8975: refactor regulator handlers
  iio: magn: ak8975: allow a delay after enabling regulators
  iio: magn: ak8975: deploy runtime PM

 drivers/iio/magnetometer/ak8975.c | 133 +++++++++++++++++++++++++++++++-------
 1 file changed, 110 insertions(+), 23 deletions(-)

-- 
2.4.11
