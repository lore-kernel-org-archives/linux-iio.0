Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44754 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbdBKJOj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Feb 2017 04:14:39 -0500
To: Greg KH <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>
Subject: [PULL] IIO fixes for 4.11 set 1 - a couple of regression fixes
 (resend as missed 4.10)
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a8b4c6b5-b452-b10e-d0dd-85db54bdbb4b@kernel.org>
Date: Sat, 11 Feb 2017 09:14:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 5c113b5e0082e90d2e1c7b12e96a7b8cf0623e27:

  iio: dht11: Use usleep_range instead of msleep for start signal (2017-01-22 13:35:40 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.11a

for you to fetch changes up to 6a6e1d56a0769795a36c0461c64bf5e5b9bbb4c0:

  iio: pressure: mpl115: do not rely on structure field ordering (2017-02-11 09:00:44 +0000)

----------------------------------------------------------------
First set of IIO fixes for the 4.11 cycle. Regression fixes from 4.10.

These are fixes that came in just to late for the 4.10 cycle.

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
