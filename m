Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:54018 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750902AbdJSUGg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Oct 2017 16:06:36 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH 00/13] staging: iio: tsl2x7x: staging cleanups
Date: Thu, 19 Oct 2017 16:06:19 -0400
Message-Id: <20171019200632.25820-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Here are some cleanup patches to work towards eventually moving this
driver out of staging. The most interesting changes are converting
in_intensity0_thresh_period and in_proximity0_thresh_period to be
created by the IIO core instead of directly by the driver. The rest of
the changes are trivial code cleanups to improve code readability
that will be required for a staging graduation:

- Convert in_proximity0_calibscale_available to IIO_CONST_ATTR
- Remove unused structures
- Sort #includes
- Remove unnecessary parentheses
- Code alignment cleanups

Brian Masney (13):
  staging: iio: tsl2x7x: migrate *_thresh_period sysfs attributes to
    iio_event_spec
  staging: iio: tsl2x7x: remove unused tsl2x7x_parse_result structure
  staging: iio: tsl2x7x: sort #includes
  staging: iio: tsl2x7x: remove unnecessary struct iio_dev definition
  staging: iio: tsl2x7x: changed #defines to be aligned on the same
    column
  staging: iio: tsl2x7x: convert in_proximity0_calibscale_available to
    use IIO_CONST_ATTR
  staging: iio: tsl2x7x: remove unnecessary parentheses
  staging: iio: tsl2x7x: correct alignment of parenthesis
  staging: iio: tsl2x7x: correct alignment of parenthesis
  staging: iio: tsl2x7x: rename power defines to improve code
    readability
  staging: iio: tsl2x7x: fix alignment of break statements
  staging: iio: tsl2x7x: put function definitions on a single line
  staging: iio: tsl2x7x: add goto for TSL2X7X_LUX_CALC_OVER_FLOW

 drivers/staging/iio/light/tsl2x7x.c | 447 ++++++++++++++----------------------
 drivers/staging/iio/light/tsl2x7x.h |   2 -
 2 files changed, 170 insertions(+), 279 deletions(-)

-- 
2.13.6

