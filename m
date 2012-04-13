Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:54087 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758130Ab2DMJY0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2012 05:24:26 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/4] IIO: Another set of buglets plus cleanups.
Date: Fri, 13 Apr 2012 10:24:17 +0100
Message-Id: <1334309061-21073-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Greg,

A fairly trivial set that no one has reported any problems with.

Only difference in here from version sent to list was an accidentally
included binary file pointed out by Maxime Ripard.

Thanks,

Jonathan

Jonathan Cameron (4):
  staging:iio:light:tsl2563 channel spec buglet / always reading same
    adc.
  staging:iio:Documentation: Fix a cut and paste error.
  staging:iio:iio_core.h make less dependent on other included headers
  staging:iio: chan_spec - take extend_name constant.

 drivers/staging/iio/Documentation/sysfs-bus-iio |    8 ++++----
 drivers/staging/iio/iio.h                       |    2 +-
 drivers/staging/iio/iio_core.h                  |    6 ++++++
 drivers/staging/iio/light/tsl2563.c             |    3 ++-
 4 files changed, 13 insertions(+), 6 deletions(-)

