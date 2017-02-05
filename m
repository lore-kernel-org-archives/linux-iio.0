Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35687 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbdBEKfE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Feb 2017 05:35:04 -0500
To: Greg KH <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 4.10 set 3 - a couple of regression fixes.
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3252b6ab-4e4c-449f-974b-b929fbc8b928@kernel.org>
Date: Sun, 5 Feb 2017 10:35:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 5c113b5e0082e90d2e1c7b12e96a7b8cf0623e27:

  iio: dht11: Use usleep_range instead of msleep for start signal (2017-01-22 13:35:40 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.10c

for you to fetch changes up to 965e77a76a391022868d8a8a8cde348341b6abfb:

  iio: pressure: mpl115: do not rely on structure field ordering (2017-02-05 09:36:52 +0000)

----------------------------------------------------------------
Third set of IIO fixes for the 4.10 cycle. Regression fixes.

Two drivers made an accidental assumption of structure arrangement for
struct iio_dev that are no longer true.  It was a typo in the first place
that happened to work until some elements were added to the structure.

* mpl3115
  - don't rely on structure field ordering
* mpl115
  - don't rely on structure field ordering.

----------------------------------------------------------------
Peter Rosin (2):
      iio: pressure: mpl3115: do not rely on structure field ordering
      iio: pressure: mpl115: do not rely on structure field ordering

 drivers/iio/pressure/mpl115.c  | 1 +
 drivers/iio/pressure/mpl3115.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)
