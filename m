Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:48635 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983Ab1K0LjK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2011 06:39:10 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/3] Initial filtering (hardware) control for IIO.
Date: Sun, 27 Nov 2011 11:39:11 +0000
Message-Id: <1322393954-31525-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Greg,

Thanks for merging all those patches yesterday.

These have been sitting in my tree and on linux-iio for far too long.
I think all issues raised about the initial patch set were answered
and fear this is not of sufficient interest to anyone to get a second
review!

Anyhow fairly uncontroversial support for the low pass filters on
the ADI imu units.

Original message was:

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
 drivers/staging/iio/iio.h                       |    7 +
 drivers/staging/iio/imu/adis16400.h             |    2 +
 drivers/staging/iio/imu/adis16400_core.c        |  177 ++++++++++++++++++-----
 drivers/staging/iio/industrialio-core.c         |    2 +
 5 files changed, 161 insertions(+), 37 deletions(-)

-- 
1.7.7.3

