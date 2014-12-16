Return-Path: <arno@natisbad.org>
From: Arnaud Ebalard <arno@natisbad.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
    Alexandre Courbot <gnurou@gmail.com>,
    Andrew Lunn <andrew@lunn.ch>,
    Antony Pavlov <antonynpavlov@gmail.com>,
    Arnd Bergmann <arnd@arndb.de>,
    Darshana Padmadas <darshanapadmadas@gmail.com>,
    devel@driverdev.osuosl.org,
    devicetree@vger.kernel.org,
    Florian Vaussard <florian.vaussard@epfl.ch>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Hartmut Knaack <knaack.h@gmx.de>,
    Hayato Suzuki <hytszk@gmail.com>,
    Heiko Stuebner <heiko@sntech.de>,
    Ian Campbell <ijc+devicetree@hellion.org.uk>,
    Jason Cooper <jason@lakedaemon.net>,
    Jonathan Cameron <jic23@kernel.org>,
    Kumar Gala <galak@codeaurora.org>,
    Lars-Peter Clausen <lars@metafoo.de>,
    Liam Girdwood <lgirdwood@gmail.com>,
    linux-arm-kernel@lists.infradead.org,
    linux-i2c@vger.kernel.org,
    linux-iio@vger.kernel.org,
    linux-tegra@vger.kernel.org,
    Mark Brown <broonie@kernel.org>,
    Mark Rutland <mark.rutland@arm.com>,
    Michal Simek <michal.simek@xilinx.com>,
    Pawel Moll <pawel.moll@arm.com>,
    Peter Meerwald <pmeerw@pmeerw.net>,
    Rob Herring <robh+dt@kernel.org>,
    rtc-linux@googlegroups.com,
    Russell King <linux@arm.linux.org.uk>,
    Shawn Guo <shawn.guo@linaro.org>,
    =?utf-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
    Stephen Warren <swarren@wwwdotorg.org>,
    Thierry Reding <thierry.reding@gmail.com>,
    Wolfram Sang <wsa@the-dreams.de>,
    Andrew Morton <akpm@linux-foundation.org>,
    Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCHv2 0/8] from now on, use 'isil' as prefix for Intersil
Message-Id: <cover.1418763328.git.arno@natisbad.org>
Date: Tue, 16 Dec 2014 22:18:26 +0100
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>


As suggested by Jason on a v0, I made a specific series for that work,
which intend to remove all remaining 'isl' prefix for Intersil to only
have 'isil'. More details below.

When Intersil ISL12057 driver was introduced by commit 70e123373c05
("rtc: Add support for Intersil ISL12057 I2C RTC chip"), the vendor
prefix 'isl' was used instead of the expected 'isil' (Intersil
NASDAQ symbol) and documented in vendor-prefixes.txt.

Recently, a patch from Philip Zabel (7a6540ca856a, "ARM: mvebu:
Change vendor prefix for Intersil Corporation to isil") fixed that
prefix in ReadyNAS devices .dts files (AFAICT, the only users of
the driver).

Then, commits 7c75c1d5e72b ("dt-bindings: Document deprecated device
vendor name to fix related warning") and b2ea3f82e798 (dt-bindings:
Document correct and deprecated vendor-prefix with device isl29028)
decided to go the other way and deprecate isil in vendor-prefixes.txt
and in isl29028.c staging driver.

While trying and merge a fix I wrote for ISL12057 drivers to finish
Philip's work, it conflicted with the two recently introduced commits,
and revealed the issue: at the moment, there are various compatible
strings in drivers and .dts files for Intersil products which use
either isl or isil:

$ grep -R "isil," .
./Documentation/devicetree/bindings/i2c/trivial-devices.txt:isil,isl29028           (deprecated, use isl)
./drivers/staging/iio/light/isl29028.c:   { .compatible = "isil,isl29028", },/* deprecated, don't use */
./drivers/staging/iio/light/isl29018.c:   { .compatible = "isil,isl29018", },
./drivers/staging/iio/light/isl29018.c:   { .compatible = "isil,isl29023", },
./drivers/staging/iio/light/isl29018.c:   { .compatible = "isil,isl29035", },
./arch/powerpc/boot/dts/p1022rdk.dts:        compatible = "isil,zl6100";
./arch/powerpc/boot/dts/p1022rdk.dts:        compatible = "isil,zl6100";
./arch/powerpc/boot/dts/p1022rdk.dts:        compatible = "isil,zl6100";
./arch/powerpc/boot/dts/p1022rdk.dts:        compatible = "isil,zl6100";
./arch/arm/boot/dts/exynos5800-peach-pi.dts: compatible = "isil,isl29018";
./arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi: compatible = "isil,isl1208";
./arch/arm/boot/dts/tegra20-ventana.dts:     compatible = "isil,isl29018";
./arch/arm/boot/dts/tegra20-seaboard.dts:    compatible = "isil,isl29018";
./arch/arm/boot/dts/armada-xp-netgear-rn2120.dts: compatible = "isil,isl12057";
./arch/arm/boot/dts/armada-370-netgear-rn104.dts: compatible = "isil,isl12057";
./arch/arm/boot/dts/exynos5420-peach-pit.dts:     compatible = "isil,isl29018";
./arch/arm/boot/dts/armada-370-netgear-rn102.dts: compatible = "isil,isl12057";

$ grep -R "isl," .
./Documentation/devicetree/bindings/regulator/isl9305.txt:- compatible: "isl,isl9305" or "isl,isl9305h"
./Documentation/devicetree/bindings/regulator/isl9305.txt:              compatible = "isl,isl9305";
./Documentation/devicetree/bindings/i2c/trivial-devices.txt:isl,isl12057      Intersil ISL12057 I2C RTC Chip
./Documentation/devicetree/bindings/i2c/trivial-devices.txt:isl,isl29028      Intersil ISL29028 Ambient Light ....
./drivers/regulator/isl9305.c:          { .compatible = "isl,isl9305" },
./drivers/regulator/isl9305.c:          { .compatible = "isl,isl9305h" },
./drivers/staging/iio/light/isl29028.c: { .compatible = "isl,isl29028", },
./drivers/rtc/rtc-isl12057.c:           { .compatible = "isl,isl12057" },
./drivers/rtc/rtc-isl12022.c:           { .compatible = "isl,isl12022" },
./arch/arm/boot/dts/tegra30-cardhu.dtsi:   compatible = "isl,isl29028";
./arch/arm/boot/dts/zynq-parallella.dts:   compatible = "isl,isl9305";

AFAICT, it seems it makes sense to *definitively* settle for isil as the
vendor prefix for Intersil, as Philip did in 7a6540ca856a: it's the NASDAQ
symbol and this choice requires less changes than opting for isl.

So, this series changes compatible strings in .dts files to use isil where
isl was found before, and modify drivers w/ compatible strings using isl
to add one using isil. In those cases, a comment is made that the old
compatible string is kept for backward compatibility (w/ out-fo-tree users
of those drivers). Additionally, it leaves only isil as prefix in
vendor-prefixes.txt. Those changes should prevent any new inclusion of
isl compatible strings for Intersil devices due to copy-and-paste.

Changes since v1:
  - split previous patch fixing trivial-devices.txt and
    vendor-prefixes.txt in two different patches, as suggested by Uwe
  - fixed a space/tab issue spotted by Uwe

Arnaud Ebalard (8):
  dt-bindings: use isil prefix for Intersil in vendor-prefixes.txt
  dt-bindings: use isil prefix for Intersil in I2C trivial-devices.txt
  rtc: isl12022: deprecate use of isl in compatible string for isil
  rtc: isl12057: deprecate use of isl in compatible string for isil
  staging: iio: isl29028: deprecate use of isl in compatible string for isil
  regulator: isl9305: deprecate use of isl in compatible string for isil
  arm: dts: zynq: update isl9305 compatible string to use isil vendor prefix
  arm: dts: tegra: update isl29028 compatible string to use isil vendor prefix

 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 5 ++---
 Documentation/devicetree/bindings/regulator/isl9305.txt   | 4 ++--
 Documentation/devicetree/bindings/vendor-prefixes.txt     | 3 +--
 arch/arm/boot/dts/tegra30-cardhu.dtsi                     | 2 +-
 arch/arm/boot/dts/zynq-parallella.dts                     | 2 +-
 drivers/regulator/isl9305.c                               | 6 ++++--
 drivers/rtc/rtc-isl12022.c                                | 3 ++-
 drivers/rtc/rtc-isl12057.c                                | 3 ++-
 drivers/staging/iio/light/isl29028.c                      | 4 ++--
 9 files changed, 17 insertions(+), 15 deletions(-)

-- 
2.1.1
