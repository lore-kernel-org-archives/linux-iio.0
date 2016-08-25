Return-Path: <peda@axentia.se>
Subject: Re: [PATCH 2/2] iio: gyro: Add driver for the MPU-3050 gyroscope
To: Linus Walleij <linus.walleij@linaro.org>
References: <1471286287-25074-1-git-send-email-linus.walleij@linaro.org>
 <53008712-7c50-79db-07ab-3544902887e1@kernel.org>
 <285e7c3f-eedb-28ed-f651-926260d17a8a@axentia.se>
 <CACRpkdZeomin6_u=1hm-fJucMnQmAJXu01YaC0g1KdafWPD2kg@mail.gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Nick Vaccaro <nvaccaro@google.com>, Ge Gao
	<ggao@invensense.com>, Anna Si <asi@invensense.com>, Nathan Royer
	<nroyer@invensense.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"Crestez Dan Leonard" <leonard.crestez@intel.com>, Daniel Baluta
	<daniel.baluta@intel.com>, Gregor Boirie <gregor.boirie@parrot.com>, "Wolfram
 Sang" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <5903e282-aaf9-9c86-5df5-17b75d5b4018@axentia.se>
Date: Thu, 25 Aug 2016 22:32:36 +0200
MIME-Version: 1.0
In-Reply-To: <CACRpkdZeomin6_u=1hm-fJucMnQmAJXu01YaC0g1KdafWPD2kg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

On 2016-08-25 14:44, Linus Walleij wrote:
> On Tue, Aug 23, 2016 at 10:37 AM, Peter Rosin <peda@axentia.se> wrote:
> 
>> Specifically patch 3/8 is relevant
>>
>> [PATCH v2 3/8] dt-bindings: i2c: add support for 'i2c-gate' subnode
>> https://lkml.org/lkml/2016/8/15/270
> 
> Yup the gate is what I'm using.

You need to update the dt bindings to the new simpler form, and then
add the flag I2C_MUX_GATE to your i2c_mux_alloc call.

>> The above is not in next (yet). I don't know how this situation is
>> best handled?
> 
> I can put these patches into my development branch to get
> a working driver using the gate. But I'd prefer them be in -next
> when I pick them.
> 
> Then the rest is merge mechanics, dunno the best there,
> Jonathan can decide.

I waited a bit for someone to scream about v4.8-rc3 being a bad base
for some reason, but there was only silence. I have now pushed the
series, and it can be pulled by anyone interested.

Wolfram, please merge it into i2c/for-next

Linus/Jonathan, technically you don't need all patches and can skip
the last three, but it seems a bit over the top to be super anal
about that detail...

Cheers,
Peter


The following changes since commit fa8410b355251fd30341662a40ac6b22d3e38468:

  Linux 4.8-rc3 (2016-08-21 16:14:10 -0700)

are available in the git repository at:

  https://github.com/peda-r/i2c-mux.git i2c-mux-dt-3

for you to fetch changes up to 8a191a7ad4ca9022bb838387b20d3de6acc88b72:

  i2c: pca954x: add device tree binding (2016-08-25 22:11:04 +0200)

----------------------------------------------------------------
Peter Rosin (8):
      dt-bindings: i2c: add support for 'i2c-mux' subnode
      dt-bindings: i2c: add support for 'i2c-arb' subnode
      dt-bindings: i2c: add support for 'i2c-gate' subnode
      dt-bindings: i2c: add bindings for nxp,pca9541
      i2c: mux: add support for 'i2c-mux', 'i2c-arb' and 'i2c-gate' DT subnodes
      i2c: mux: inform the i2c mux core about how it is used
      i2c: pca9541: add device tree binding
      i2c: pca954x: add device tree binding

 .../bindings/i2c/i2c-arb-gpio-challenge.txt        |  8 +---
 Documentation/devicetree/bindings/i2c/i2c-arb.txt  | 35 ++++++++++++++++
 Documentation/devicetree/bindings/i2c/i2c-gate.txt | 41 +++++++++++++++++++
 Documentation/devicetree/bindings/i2c/i2c-mux.txt  | 23 ++++++++---
 .../devicetree/bindings/i2c/nxp,pca9541.txt        | 29 ++++++++++++++
 MAINTAINERS                                        |  2 +
 drivers/i2c/i2c-mux.c                              | 44 +++++++++++++++++----
 drivers/i2c/muxes/i2c-arb-gpio-challenge.c         |  2 +-
 drivers/i2c/muxes/i2c-mux-pca9541.c                | 11 +++++-
 drivers/i2c/muxes/i2c-mux-pca954x.c                | 46 ++++++++++++++++------
 include/linux/i2c-mux.h                            |  8 +++-
 11 files changed, 214 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-arb.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-gate.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/nxp,pca9541.txt
