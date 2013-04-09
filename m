Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58715 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110Ab3DIRon (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Apr 2013 13:44:43 -0400
Message-ID: <51645387.5090706@kernel.org>
Date: Tue, 09 Apr 2013 18:44:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO cleanups and fixes (IIO set 4 for the 3.10 cycle)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 5993f3a2692eed3c74c86882155b8703a0060ad5:

  staging: comedi: remove unnecessary dev->board_name initialization (2013-04-08 11:44:07 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.10d

for you to fetch changes up to ff3fc8eb470ff0e47466c291148a30f958d6691d:

  staging:iio:dummy: Fix mismatch and export sysfs entry (2013-04-09 18:29:52 +0100)

----------------------------------------------------------------
Fourth set of changes for iio in the 3.10 cycle.  This time just a fix an
a cleanup.

The fix is to the dummy driver for some inconsistent specification of
parameters available vs parameters supplied.

The cleanup is for some silly memcmp usage.

----------------------------------------------------------------
Jin Feng (1):
      staging:iio:dummy: Fix mismatch and export sysfs entry

Tony Luck (1):
      staging:iio:adt7316 Fix some 'interesting' string operations

 drivers/staging/iio/addac/adt7316.c    | 26 +++++++++++++-------------
 drivers/staging/iio/iio_simple_dummy.c | 11 +++++++++--
 2 files changed, 22 insertions(+), 15 deletions(-)
