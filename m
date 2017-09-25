Return-Path: <SRS0=urO0=A2=gmail.com=harinath922@kernel.org>
From: Harinath Nampally <harinath922@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amsfield22@gmail.com,
	martink@posteo.de
Subject: [PATCH 0/3] This patchset refactors event related functions 
Date: Sun, 24 Sep 2017 23:15:30 -0400
Message-Id: <1506309333-1970-1-git-send-email-harinath922@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Harinath Nampally (3):
Following 2 patches are for refactor:
  iio: accel: mma8452: Rename time step look up struct     to generic
    name as the values are same for all the events.
  iio: accel: mma8452: Rename read/write event value     callbacks to
    generic function name.
Following patch adds new feature:
  iio: accel: mma8452: Add single pulse/tap event detection     feature
    for fxls8471.

 drivers/iio/accel/mma8452.c | 170 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 158 insertions(+), 12 deletions(-)

-- 
2.7.4
