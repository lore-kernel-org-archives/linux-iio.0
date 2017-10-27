Return-Path: <SRS0=wbiz=B2=pmeerw.net=pmeerw@kernel.org>
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v2 00/13] iio: health: Add MAX30105 support to max30102 driver
Date: Fri, 27 Oct 2017 21:45:30 +0200
Message-Id: <1509133543-4597-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

This patch series reworks the max30102 driver to add support for the MAX30105
part (which add a third LED)

v2:
* send correct patches, sorry for the mess
* fix Matt Ranostay's email address


patches 1 to 3 are bugfix

patches 4 to 6 add minor features and cleanup

patch 8 allows to read the temperature without currently measuring other channels

patches 9 to 11 prepare for adding another LED, more flexibility

patch 12 adds support for the MAX30105 part

patch 13 updates devicetree documentation for the MAX30105 part

Peter Meerwald-Stadler (13):
  iio: health: max30102: Temperature should be in milli Celsius
  iio: health: max30102: Fix missing newline in dev_err
  iio: health: max30102: Remove inconsistent full stop in error message
  iio: health: max30102: Fix mode config values
  iio: health: max30102: Check retval of powermode function
  iio: health: max30102: Add check for part ID
  iio: health: max30102: Introduce intensity channel macro
  iio: health: max30102: Add power enable parameter to get_temp function
  iio: health: max30102: Introduce indices for LED channels
  iio: health: max30102: Move mode setting to buffer_postenable
  iio: health: max30102: Prepare for copying varying number of
    measurements
  iio: health: max30102: Add MAX30105 support
  dt-bindings: iio: health: Add MAX30105 support to max30102.txt

 .../devicetree/bindings/iio/health/max30102.txt    |   8 +-
 drivers/iio/health/max30102.c                      | 310 ++++++++++++++++-----
 2 files changed, 241 insertions(+), 77 deletions(-)

-- 
2.7.4
