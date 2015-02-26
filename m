Return-Path: <roberta.dobrescu@gmail.com>
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: linux-iio@vger.kernel.org
Cc: daniel.baluta@intel.com,
	octavian.purdila@intel.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH 0/5] iio: Move iio userspace applications out of staging
Date: Thu, 26 Feb 2015 10:49:22 +0200
Message-Id: <1424940567-24877-1-git-send-email-roberta.dobrescu@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The purpose of this patchset is to move iio userpace applications
to tools/iio/.

It adds a missing header to iio_event_monitor in order
to compile without any tricks and adds the implementation of
the functions from iio_utils.h to iio_utils.c.

It also creates a Makefile and gets rid of compilation warnings.

Roberta Dobrescu (5):
  staging: iio: Documentation: iio_event_monitor: Include
    linux/iio/types.h
  staging: iio: Documentation: Introduce iio_utils.c
  iio: Move iio userspace applications out of staging
  tools: iio: Define _GNU_SOURCE in Makefile
  tools: iio: lsiio: Remove unused variables

 MAINTAINERS                                        |   1 +
 drivers/staging/iio/Documentation/generic_buffer.c | 360 -----------
 .../staging/iio/Documentation/iio_event_monitor.c  | 308 ----------
 drivers/staging/iio/Documentation/iio_utils.h      | 683 ---------------------
 drivers/staging/iio/Documentation/lsiio.c          | 163 -----
 tools/iio/Makefile                                 |  16 +
 tools/iio/generic_buffer.c                         | 359 +++++++++++
 tools/iio/iio_event_monitor.c                      | 308 ++++++++++
 tools/iio/iio_utils.c                              | 651 ++++++++++++++++++++
 tools/iio/iio_utils.h                              |  71 +++
 tools/iio/lsiio.c                                  | 158 +++++
 11 files changed, 1564 insertions(+), 1514 deletions(-)
 delete mode 100644 drivers/staging/iio/Documentation/generic_buffer.c
 delete mode 100644 drivers/staging/iio/Documentation/iio_event_monitor.c
 delete mode 100644 drivers/staging/iio/Documentation/iio_utils.h
 delete mode 100644 drivers/staging/iio/Documentation/lsiio.c
 create mode 100644 tools/iio/Makefile
 create mode 100644 tools/iio/generic_buffer.c
 create mode 100644 tools/iio/iio_event_monitor.c
 create mode 100644 tools/iio/iio_utils.c
 create mode 100644 tools/iio/iio_utils.h
 create mode 100644 tools/iio/lsiio.c

-- 
1.9.1
