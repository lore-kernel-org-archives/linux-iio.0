Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:50962 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933250Ab1JNPju (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Oct 2011 11:39:50 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: johnlm@apollo.lv, Device-drivers-devel@blackfin.uclinux.org,
	Michael.Hennerich@analog.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/3 V2] IIO: Filtering (previously RFC ...- how to handle).
Date: Fri, 14 Oct 2011 16:39:45 +0100
Message-Id: <1318606788-3936-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

Technically this has all been on list before, just now it is in a coherent
patch set.

Introduces low pass filter controls and description via 3db point.
JohnLM suggested a whole load more stuff that we might want to know
about filters.  Whilst I am in favour of adding these at somepoint
I think it should be as and when we have a user.  I believe the
naming here allows space for all the other things that have been
suggested.

Thanks.

v1->v2 Added documentation.



Jonathan Cameron (3):
  staging:iio: filter description - low pass 3db frequency.
  staging:iio:imu:adis16400 add control of data filtering.
  staging:iio:documentation: document filter_low_pass_3db_frequency.

 drivers/staging/iio/Documentation/sysfs-bus-iio |   10 ++
 drivers/staging/iio/iio.h                       |    2 +
 drivers/staging/iio/imu/adis16400.h             |    2 +
 drivers/staging/iio/imu/adis16400_core.c        |  177 ++++++++++++++++++-----
 drivers/staging/iio/industrialio-core.c         |    2 +
 5 files changed, 156 insertions(+), 37 deletions(-)

-- 
1.7.7

