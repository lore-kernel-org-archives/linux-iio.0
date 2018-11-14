Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36813 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbeKODsW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Nov 2018 22:48:22 -0500
Date: Wed, 14 Nov 2018 23:14:06 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] staging: iio: ad7816: Switch to the gpio descriptor
 interface
Message-ID: <cover.1542215638.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes in v4:
 - Add all parts to the dt bindings as they
   are functionally different.
Changes in v3:
 - Drop busy pin in case of AD7818.
 - Set RD/WR pin and CONVST pin as outputs.
 - Add device tree table.

Nishad Kamdar (4):
  staging: iio: ad7816: Switch to the gpio descriptor interface
  staging: iio: ad7816: Do not use busy_pin in case of AD7818
  staging: iio: ad7816: Set RD/WR pin and CONVST pin as outputs.
  staging: iio: ad7816: Add device tree table.

 drivers/staging/iio/adc/ad7816.c | 113 +++++++++++++++++--------------
 1 file changed, 62 insertions(+), 51 deletions(-)

-- 
2.17.1
