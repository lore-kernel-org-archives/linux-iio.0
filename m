Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx-out-2.rwth-aachen.de ([134.130.5.187]:12457 "EHLO
        mx-out-2.rwth-aachen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S377076AbdEALUJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 May 2017 07:20:09 -0400
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marc Titinger <mtitinger@baylibre.com>,
        =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
Subject: [PATCH 0/2] iio: Trivial fixes for INA219, Documentation
Date: Mon, 1 May 2017 13:19:40 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-ID: <ecc3ce3c45fd42e588bc59f6076455da@rwthex-w2-b.rwth-ad.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following two patches fix some trivial issues, no functional
changes:

Stefan Brüns (2):
  iio: Documentation: Remove (partially) duplicate line
  iio: adc: Fix bad GENMASK use, typos, whitespace

 Documentation/ABI/testing/sysfs-bus-iio-meas-spec |  1 -
 drivers/iio/adc/ina2xx-adc.c                      | 12 ++++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.12.2

