Return-Path: <SRS0=lHPj=JT=it-klinger.de=ak@kernel.org>
Date: Tue, 3 Jul 2018 14:48:50 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	robh+dt@kernel.org, mark.rutland@arm.com, mchehab@kernel.org,
	davem@davemloft.net, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, linus.walleij@linaro.org,
	rdunlap@infradead.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] iio: hx711: add data-ready-delay
Message-ID: <20180703124850.GA17965@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This patch adds an additional property in the device tree for adjusting the
delay between a rising edge on PD_SCK until data is ready on DOUT.

This is necessary because of parasitic capacities on different systems.

In the last patch there is a fix of dtc warning if someone is using the
given example

Changes against v2:
- added suggestion of Jonathan to add vendor prefix in device tree setting


Andreas Klinger (3):
  iio: hx711: add data-ready-delay-ns property in DT
  iio: hx711: add delay until DOUT is ready
  iio: hx711: warning in dt binding example doc

 .../devicetree/bindings/iio/adc/avia-hx711.txt     |  9 ++++++++-
 drivers/iio/adc/hx711.c                            | 23 ++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

-- 
2.1.4
