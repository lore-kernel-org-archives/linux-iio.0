Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hosting.pavoucek.net ([46.28.107.168]:59479 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933050AbcI3N0m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Sep 2016 09:26:42 -0400
From: Tomas Novotny <tomas@novotny.cz>
To: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Yong Li <sdliyong@gmail.com>, linux-iio@vger.kernel.org
Subject: [PATCH 0/3] iio: dac: mcp4725: add vref selection and devicetree support
Date: Fri, 30 Sep 2016 15:19:45 +0200
Message-Id: <1475241588-18429-1-git-send-email-tomas@novotny.cz>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

here is a small series to add voltage reference selection and devicetree support
to mcp4725/6. This series was tested on mcp4726 with devicetree boot.

Tomas Novotny (3):
  iio: dac: mcp4725: support voltage reference selection
  Documentation: dt: iio: add mcp4725/6 dac device binding
  iio: dac: mcp4725: add devicetree support

 .../devicetree/bindings/iio/dac/mcp4725.txt        |  28 ++++++
 drivers/iio/dac/mcp4725.c                          | 108 ++++++++++++++++++---
 include/linux/iio/dac/mcp4725.h                    |   1 +
 3 files changed, 126 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/mcp4725.txt

-- 
2.1.4

