Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:50408 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560Ab1K0Lp5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2011 06:45:57 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/2] Fixes ot the generic_buffer example
Date: Sun, 27 Nov 2011 11:46:03 +0000
Message-Id: <1322394365-3214-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

These do what they say on the tin.

Jonathan

Jonathan Cameron (2):
  staging:iio:Documentation: cleanup properly in buffer handling code
  staging:iio:generic_buffer example - handle endian differences

 drivers/staging/iio/Documentation/generic_buffer.c |    8 ++++++
 drivers/staging/iio/Documentation/iio_utils.h      |   25 ++++++++++++++++---
 2 files changed, 29 insertions(+), 4 deletions(-)

-- 
1.7.7.3

