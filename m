Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52892 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075Ab2GHTbC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jul 2012 15:31:02 -0400
Message-ID: <4FF9DFF5.8030903@kernel.org>
Date: Sun, 08 Jul 2012 20:31:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO enhancements.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 0932966b1ca03217c6e0c18375867b1a99ee5af0:

  staging: ccg: print MAC addresses via %pM (2012-07-06 16:24:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
tags/togreg_8_7_2012

for you to fetch changes up to c732a24c5a9392cf3738f5957e0d97d37c09e6e1:

  staging:iio:adt7410: use local platformdata if none is specified
(2012-07-08 10:39:59 +0100)

----------------------------------------------------------------
Mixed back of updates and trivial examples fixes.
Nothing terribly interesting in this one.

8 July 2012

----------------------------------------------------------------
Lars-Peter Clausen (1):
      iio:trigger: Register sysfs file statically

Peter Meerwald (5):
      iio staging: missing newline in printf
      iio: cleanup buffer.h comments
      iio: fix spelling of detach in static func
      iio staging: add recently added modifiers to iio_event_monitor
      iio: kernel version typo in sysfs-bus-iio

Sascha Hauer (2):
      staging iio adt7410: make 16bit mode default
      staging:iio:adt7410: use local platformdata if none is specified

 Documentation/ABI/testing/sysfs-bus-iio            |  2 +-
 drivers/iio/industrialio-trigger.c                 | 42
++++++++--------------
 .../staging/iio/Documentation/iio_event_monitor.c  | 12 +++++++
 drivers/staging/iio/Documentation/iio_utils.h      |  2 +-
 drivers/staging/iio/adc/adt7410.c                  | 28 +++++++++------
 include/linux/iio/buffer.h                         | 17 +++++----
 6 files changed, 56 insertions(+), 47 deletions(-)
