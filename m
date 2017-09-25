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
Subject: [PATCH 0/3] Refactor event related code
Date: Mon, 25 Sep 2017 06:07:41 -0400
Message-Id: <1506334065-2891-1-git-send-email-harinath922@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Rename some struct names and function names to
improve code readability.

Harinath Nampally (3):
  iio: accel: mma8452: Rename structs holding event     configuration
    registers to more appropriate names.
  iio: accel: mma8452: Rename time step look up struct     to generic
    name as the values are same for all the events.
  iio: accel: mma8452: Rename read/write event value     callbacks to
    generic function name.

 drivers/iio/accel/mma8452.c | 180 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 163 insertions(+), 17 deletions(-)

-- 
2.7.4
