Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36889 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753944AbcLKWWt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Dec 2016 17:22:49 -0500
Received: by mail-wm0-f52.google.com with SMTP id t79so41542225wmt.0
        for <linux-iio@vger.kernel.org>; Sun, 11 Dec 2016 14:22:49 -0800 (PST)
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Patrick Titiano <ptitiano@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-gpio@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/2] iio: GPIO power switch support
Date: Sun, 11 Dec 2016 23:21:43 +0100
Message-Id: <1481494905-18037-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series is aimed at improving the support for baylibre-acme[1]
power measurement capes. 

We would like to add support for power-cycling of devices measured
using TI INA226 ADCs. An example use case would be measuring the power
consumption of a development board during boot and power-cycling it
remotely using a GPIO power switch.

The first patch proposes to add a new DT binding for describing simple
power switches.

The second adds a simple IIO driver exposing a single attribute.

The motivation for using the IIO framework is the fact that we already
use it for reading the data from the ADC and that power-cycling the
measured devices is an integral part of our use case. Users would find
it convenient to be able to use libiio as the single interface.

[1] http://baylibre.com/acme/

Bartosz Golaszewski (2):
  devicetree: power: add bindings for GPIO-driven power switches
  iio: misc: add support for GPIO power switches

 .../bindings/power/gpio-power-switch.txt           |  25 ++++
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/misc/Kconfig                           |  17 +++
 drivers/iio/misc/Makefile                          |   6 +
 drivers/iio/misc/gpio-power-switch.c               | 127 +++++++++++++++++++++
 6 files changed, 177 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/gpio-power-switch.txt
 create mode 100644 drivers/iio/misc/Kconfig
 create mode 100644 drivers/iio/misc/Makefile
 create mode 100644 drivers/iio/misc/gpio-power-switch.c

-- 
2.9.3

