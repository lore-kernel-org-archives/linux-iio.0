Return-Path: <SRS0=Cvcw=IL=gmail.com=vilhelm.gray@kernel.org>
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 0/2] Provide defines for 104-QUAD-8 magic numbers
Date: Thu, 24 May 2018 16:37:35 -0400
Message-Id: <cover.1527193661.git.vilhelm.gray@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Magic numbers can be difficult to understand, and at times hide bugs
that would otherwise be obvious to readers of the source code.

The first patch in this patchset provides a fix for an improperly
selected magic number (an off-by-one error). The second patch adds
defines to remove these magic numbers and thus help make the driver
source code easier to read and debug.

The discovery of the error fixed by the first patch is thanks to these
defines: the improper magic number stuck out like a sore thumb next
to the expected define symbol. So I should have used these defines from
the start.

William Breathitt Gray (2):
  iio: 104-quad-8: Fix off-by-one error in register selection
  iio: 104-quad-8: Provide defines for magic numbers

 drivers/iio/counter/104-quad-8.c | 86 ++++++++++++++++++++++----------
 1 file changed, 60 insertions(+), 26 deletions(-)

-- 
2.17.0
