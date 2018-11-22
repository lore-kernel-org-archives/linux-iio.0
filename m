Return-Path: <SRS0=v2gn=OB=googlemail.com=martin.blumenstingl@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/1] meson-saradc: fix internal clock names
Date: Thu, 22 Nov 2018 23:01:10 +0100
Message-Id: <20181122220111.28808-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

This fixes the internal clock names which (prior to this change)
contained slashes. That breaks the debugfs structure for these clocks
in /sys/kernel/debug/clk.

The idea for this fix is shamelessly taken from commit b96e9eb62841c5
("pwm: meson: Fix mux clock names").

NOTE: This is meant to be applied on top of "iio: adc: meson-saradc:
check for devm_kasprintf failure" from [0]


[0] https://patchwork.kernel.org/patch/10693631/


Martin Blumenstingl (1):
  iio: adc: meson-saradc: fix internal clock names

 drivers/iio/adc/meson_saradc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.19.1
