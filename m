Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:49644 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab2A2LFH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2012 06:05:07 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/5] Remove use of isvisible for attr groups that are coppied.
Date: Sun, 29 Jan 2012 11:05:45 +0000
Message-Id: <1327835145-20886-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Greg,

These are all fixes.

These patches were originally part of a series that squished the attribute
groups entirely, but whilst everyone was happy with these, the final patch
was dropped.

Anyhow, the eventual attribute groups that get registered are mostly
built from the iio_chan_spec structures. These groups are just used
to pass in bits the core doesn't handle.  This made it it rather
difficult to ensure that the is_visible function was consistent
(as it would be applied to a much larger set than apparent if we
coppied it on as is) and in the vast majority of cases its use was
trivial anyway.

If a good reason for using is_visible comes up, then the right option will be
to first verifying if the element comes from these attribute
groups that are passed in before calling the is_visible function provided
in these groups.  Anyhow, not too bad, but not currently necessary.

Even if we do put this in, these cases are easier to read (and in somecases
shorter) when not using it.

Jonathan

Jonathan Cameron (5):
  staging:iio:adc:ad7192 unwind use of is_visible for attribute group.
  staging:iio:dds:ad9834 unwind use of is_visible for attrs.
  staging:iio:dac:ad5446 unwind use of is_visible for attrs.
  staging:iio:adc:ad7606 unwind use of is_visible for attrs.
  staging:iio:adc:adt7310/7410 sticking plaster fix for broken event
    attrs.

 drivers/staging/iio/adc/ad7192.c      |   43 ++++++++++-------
 drivers/staging/iio/adc/ad7606_core.c |   83 +++++++++++++++++++++------------
 drivers/staging/iio/adc/adt7310.c     |   21 ++-------
 drivers/staging/iio/adc/adt7410.c     |   21 ++-------
 drivers/staging/iio/dac/ad5446.c      |   33 ++++---------
 drivers/staging/iio/dds/ad9834.c      |   53 +++++++++++++--------
 6 files changed, 128 insertions(+), 126 deletions(-)

-- 
1.7.8.4

