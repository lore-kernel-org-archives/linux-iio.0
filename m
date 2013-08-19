Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53452 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab3HSSrQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Aug 2013 14:47:16 -0400
Message-ID: <52127644.3090606@kernel.org>
Date: Mon, 19 Aug 2013 20:47:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 3.11 - set 3
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:

  Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.11c

for you to fetch changes up to 71f42642af7b1bc7c36fb73ad8f7e7ab2ab8b2de:

  iio: adjd_s311: Fix non-scan mode data read (2013-08-19 19:30:21 +0100)

----------------------------------------------------------------
Third round of IIO fixes for the 3.11 series.

Only one fix in this pull request.

A straight forward incorrect read address in the adjd_s311 driver.

----------------------------------------------------------------
Peter Meerwald (1):
      iio: adjd_s311: Fix non-scan mode data read

 drivers/iio/light/adjd_s311.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
