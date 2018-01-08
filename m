Return-Path: <SRS0=omKU=ED=redhat.com=lorenzo.bianconi@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v3 0/4] add regmap API support to hts221 iio driver
Date: Mon,  8 Jan 2018 23:12:27 +0100
Message-Id: <20180108221231.13283-1-lorenzo.bianconi@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

Changes since v2:
- rebase ontop of 'hts221: move common code in hts221_core'
- add a patch to the series in order to fix some sparse warnings in
  hts221_parse_{temp,rh}_caldata()

Changes since v1:
- add missing flag to read_flag_mask in hts221_spi_regmap_config
- drop hts221_write_with_mask() and always use regmap_update_bits()

Lorenzo Bianconi (4):
  iio: humidity: hts221: remove warnings in
    hts221_parse_{temp,rh}_caldata()
  iio: humidity: hts221: remove trailing whitespace from a comment
  iio: humidity: hts221: add regmap API support
  iio: humidity: hts221: remove unnecessary get_unaligned_le16()

 drivers/iio/humidity/Kconfig         |   2 +
 drivers/iio/humidity/hts221.h        |  21 +-----
 drivers/iio/humidity/hts221_buffer.c |  39 ++++++-----
 drivers/iio/humidity/hts221_core.c   | 132 ++++++++++++++---------------------
 drivers/iio/humidity/hts221_i2c.c    |  64 +++++------------
 drivers/iio/humidity/hts221_spi.c    |  81 +++++----------------
 6 files changed, 113 insertions(+), 226 deletions(-)

-- 
2.15.1
