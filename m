Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39640 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbeKIRNg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Nov 2018 12:13:36 -0500
Date: Fri, 9 Nov 2018 13:04:09 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] staging: iio: ad7816: Switch to the gpio descriptor
 interface
Message-ID: <cover.1541733949.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes in v4:
 - Drop busy pin in case of AD7818.
 - Set RD/WR pin and CONVST pin as outputs.
 - Add device tree table.

Nishad Kamdar (4):
  staging: iio: ad7816: Switch to the gpio descriptor interface
  staging: iio: ad7816: Do not use busy_pin in case of AD7818
  staging: iio: ad7816: Set RD/WR pin and CONVST pin as outputs.
  staging: iio: ad7816: Add device tree table.

 drivers/staging/iio/adc/ad7816.c | 111 +++++++++++++++++--------------
 1 file changed, 60 insertions(+), 51 deletions(-)

-- 
2.17.1
