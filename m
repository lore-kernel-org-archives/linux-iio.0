Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org
Subject: [PATCH 0/4] iio: missing ABI documentation
Date: Fri,  2 May 2014 17:54:45 +0200
Message-Id: <1399046089-6616-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Hi,

this tried to document some ABI in use for a long time but never
properly documented; I think it is beneficial to say what things
are supposed to be even while certain existing drivers may violate
it

this is meant as an RFC

cheers, p.

Peter Meerwald (4):
  iio: Add intensity including ir and both modifiers to ABI
    documentation ex-post
  iio: Add ABI documentation for illuminance
  iio: Add ABI documentation for proximity
  iio: Fix spelling of illuminance in gp2ap020a00f driver

 Documentation/ABI/testing/sysfs-bus-iio | 29 +++++++++++++++++++++++++++++
 drivers/iio/light/gp2ap020a00f.c        |  8 ++++----
 2 files changed, 33 insertions(+), 4 deletions(-)

-- 
1.9.1
