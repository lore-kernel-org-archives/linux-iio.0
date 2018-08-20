Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr10126.outbound.protection.outlook.com ([40.107.1.126]:10240
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbeHTNSH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Aug 2018 09:18:07 -0400
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH 0/5] License cleanup of "my" IIO files
Date: Mon, 20 Aug 2018 12:01:09 +0200
Message-Id: <20180820100114.22966-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi!

I found a couple of discrepancies in the license annotations in
some of the files I have added to the drivers/iio/ directory.

This cleans up the trivialities that I found. While at it, convert
the remaining IIO files that are "mine" to SPDX license identifiers.

Cheers,
Peter

Peter Rosin (5):
  iio: potentiometer: mcp4018: use the correct MODULE_LICENSE
  iio: potentiometer: mcp4531: switch to SPDX license identifier
  iio: envelope-detector: switch to SPDX license identifier
  iio: dpot-dac: switch to SPDX license identifier
  iio: multiplexer: switch to SPDX license identifier

 drivers/iio/adc/envelope-detector.c | 5 +----
 drivers/iio/dac/dpot-dac.c          | 5 +----
 drivers/iio/multiplexer/iio-mux.c   | 5 +----
 drivers/iio/potentiometer/mcp4018.c | 2 +-
 drivers/iio/potentiometer/mcp4531.c | 7 ++-----
 5 files changed, 6 insertions(+), 18 deletions(-)

-- 
2.11.0
