Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34689 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932285Ab2HPTqx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Aug 2012 15:46:53 -0400
Message-ID: <502D4E2B.5010109@kernel.org>
Date: Thu, 16 Aug 2012 20:46:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO Fixes for v3.6-rc1
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 95d1c8c7e26e303ccab5b65fe0ce04f70f42ea8a:

  iio: lm3533-als: Fix build warnings (2012-08-16 20:24:38 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/v3.6-rc1-iio-fixes

for you to fetch changes up to 95d1c8c7e26e303ccab5b65fe0ce04f70f42ea8a:

  iio: lm3533-als: Fix build warnings (2012-08-16 20:24:38 +0100)

----------------------------------------------------------------
IIO fixes for v3.6-rc1

These mostly consist of fixes from Lars-Peter Clausen that were
the first part of a large series reworking the drivers concerned.
Turns out these drivers had quite a wealth of minor bugs.

Also here are some build warning fixes for lm3533-als and
adjd_s111 (both new drives in this cycle).
Final elements are a a div factor overflow and a warning
related fix in a couple of Analog Devices drivers.

All in all nothing major, but a worthwhile bunch of short
fixes.

----------------------------------------------------------------
