Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45683 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755383Ab2GLTSi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Jul 2012 15:18:38 -0400
Message-ID: <4FFF2307.7020807@kernel.org>
Date: Thu, 12 Jul 2012 20:18:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: linux-iio@vger.kernel.org
Subject: [GIT PULL] IIO fixes for staging-next.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 7b7627410e2c211f24787f61e6419e16d259aa13:

  iio: Fix inkern remove incorrect put of device (2012-07-08 20:02:31 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
tags/fixes-togreg-3.6a

for you to fetch changes up to e59b9afecf7ddf52d31d24e800b473f19c23cfe0:

  iio: double unlock on error path (2012-07-12 20:00:20 +0100)

----------------------------------------------------------------
Various minor IIO fixes for staging-next.

----------------------------------------------------------------
Dan Carpenter (1):
      iio: double unlock on error path

Gerard Snitselaar (1):
      iio: dac: ad5064: fix section mismatch in ad5064_init() in linux-next

Lars-Peter Clausen (2):
      staging:iio:max1363: Don't free uninitialized variable
      iio: ad5064: Move bus write callbacks to #if protected sections

 drivers/iio/dac/ad5064.c               | 40
+++++++++++++++++-----------------
 drivers/iio/inkern.c                   |  3 ++-
 drivers/staging/iio/adc/max1363_ring.c |  5 +++--
 3 files changed, 25 insertions(+), 23 deletions(-)
