Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:33233 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618Ab1I3KJj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Sep 2011 06:09:39 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Device-drivers-devel@blackfin.uclinux.org,
	manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [RFC PATCH 0/2] IIO: Filtering - how to handle.
Date: Fri, 30 Sep 2011 11:17:57 +0100
Message-Id: <1317377879-9264-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

One big area we have pretty much glossed over so far is devices with
controllable hardware filters.  This RFC proposes one option for
how to handle this. For low pass filters at least, the 3db point
seems the obvious choice as it allows us to gloss over exactly
what type of filter it is whilst still capturing it's basic
property of what it lets through.

What do people think?

Jonathan

Jonathan Cameron (2):
  staging:iio: filter description - low pass 3db frequency.
  staging:iio:imu:adis16400 add control of data filtering.

 drivers/staging/iio/iio.h                |    2 +
 drivers/staging/iio/imu/adis16400.h      |    2 +
 drivers/staging/iio/imu/adis16400_core.c |  177 +++++++++++++++++++++++------
 drivers/staging/iio/industrialio-core.c  |    2 +
 4 files changed, 146 insertions(+), 37 deletions(-)

-- 
1.7.3.4

