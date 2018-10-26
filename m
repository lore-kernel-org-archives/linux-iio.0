Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35689 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJZWAY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Oct 2018 18:00:24 -0400
Date: Fri, 26 Oct 2018 18:53:12 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
To: Slawomir Stepien <sst@poczta.fm>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] staging: iio: ad2s1210: Switch to the gpio descriptor
 interface.
Message-ID: <cover.1540489369.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the gpiod interface instead of the deprecated old non-descriptor

Changes in v5:
 - Add device tree support.
 - Add device tree table for matching vendor ID.
 - Add Support for retrieving platform data from device tree.
Changes in v4:
 - Add spaces after { and before } in gpios[]
   initialization.
 - Check the correct pointer for error.
 - Align the dev_err msg to existing format in the code.
Changes in v3:
 - Use a pointer to pointer for gpio_desc in
   struct ad2s1210_gpio as it will be used to
   modify a pointer.
 - Use dot notation to initialize the structure.
 - Use a pointer variable to avoid writing gpios[i].
Changes in v2:
 - Use the spi_device struct embedded in st instead
   of passing it as an argument to ad2s1210_setup_gpios().
 - Use an array of structs to reduce redundant code in
   in ad2s1210_setup_gpios().
 - Remove ad2s1210_free_gpios() as devm API is being used.
-
Nishad Kamdar (2):
  staging: iio: ad2s1210: Switch to the gpio descriptor interface
  staging: iio: ad2s1210: Add device tree support.

 drivers/staging/iio/resolver/ad2s1210.c | 129 ++++++++++++++++--------
 drivers/staging/iio/resolver/ad2s1210.h |   3 -
 2 files changed, 89 insertions(+), 43 deletions(-)

-- 
2.17.1
