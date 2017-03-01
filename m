Return-Path: <SRS0=O1bF=2K=perches.com=joe@kernel.org>
From: Joe Perches <joe@perches.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	=?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
	Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] HID: allocation neatening and code size reduction
Date: Wed,  1 Mar 2017 11:19:08 -0800
Message-Id: <cover.1488395879.git.joe@perches.com>
List-ID: <linux-iio@vger.kernel.org>

Joe Perches (2):
  HID: Use krealloc
  HID: Remove unnecessary OOM messages

 drivers/hid/hid-a4tech.c          |  4 +---
 drivers/hid/hid-apple.c           |  4 +---
 drivers/hid/hid-asus.c            |  5 +----
 drivers/hid/hid-core.c            | 24 +++++++++++-------------
 drivers/hid/hid-lenovo.c          |  7 ++-----
 drivers/hid/hid-lg.c              |  5 ++---
 drivers/hid/hid-lg4ff.c           |  4 +---
 drivers/hid/hid-logitech-dj.c     | 12 +++---------
 drivers/hid/hid-magicmouse.c      |  4 +---
 drivers/hid/hid-multitouch.c      |  9 +++------
 drivers/hid/hid-ntrig.c           |  4 +---
 drivers/hid/hid-picolcd_core.c    |  1 -
 drivers/hid/hid-picolcd_leds.c    |  1 -
 drivers/hid/hid-prodikeys.c       |  5 +----
 drivers/hid/hid-rmi.c             |  4 +---
 drivers/hid/hid-roccat-arvo.c     |  5 ++---
 drivers/hid/hid-roccat-isku.c     |  5 ++---
 drivers/hid/hid-roccat-koneplus.c |  5 ++---
 drivers/hid/hid-roccat-konepure.c |  5 ++---
 drivers/hid/hid-roccat-kovaplus.c |  5 ++---
 drivers/hid/hid-roccat-lua.c      |  5 ++---
 drivers/hid/hid-roccat-pyra.c     |  5 ++---
 drivers/hid/hid-roccat-ryos.c     |  5 ++---
 drivers/hid/hid-roccat-savu.c     |  5 ++---
 drivers/hid/hid-saitek.c          |  4 +---
 drivers/hid/hid-sensor-hub.c      |  6 +-----
 drivers/hid/hid-sony.c            |  1 -
 27 files changed, 49 insertions(+), 100 deletions(-)

-- 
2.10.0.rc2.1.g053435c
