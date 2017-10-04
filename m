Return-Path: <SRS0=+naZ=BD=linux-m68k.org=geert@kernel.org>
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jonathan Cameron <jic23@kernel.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] iio: adc: rcar-gyroadc: Misc improvements
Date: Wed,  4 Oct 2017 14:08:23 +0200
Message-Id: <1507118906-8946-1-git-send-email-geert+renesas@glider.be>
List-ID: <linux-iio@vger.kernel.org>

	Hi Jonathan, Marek,

This patch series contains a few improvements for the driver for the
R-Car GyroADC block, which can be found on R-Car Gen2 (arm32) and Gen3
(arm64) SoCs.

Thanks!

Geert Uytterhoeven (3):
  iio: adc: rcar-gyroadc: Cast pointer to uintptr_t to fix warning on
    64-bit
  iio: adc: rcar-gyroadc: Enable compile-testing on non-ARM
  iio: adc: rcar-gyroadc: Use of_device_get_match_data() helper

 drivers/iio/adc/Kconfig        | 2 +-
 drivers/iio/adc/rcar-gyroadc.c | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
