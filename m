Return-Path: <ao2@ao2.it>
From: Antonio Ospite <ao2@ao2.it>
To: linux-iio@vger.kernel.org
Cc: Antonio Ospite <ao2@ao2.it>,
	Jonathan Cameron <jic23@kernel.org>,
	Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 0/3] iio: accel: kxcjk-1013: new ACPI id and misc cleanups
Date: Wed, 29 Apr 2015 11:01:48 +0200
Message-Id: <1430298111-20127-1-git-send-email-ao2@ao2.it>
List-ID: <linux-iio@vger.kernel.org>

Hi,

with this set I am adding a new ACPI id to kxcjk-1013 and proposing some
minor cleanups.

CC-ing Bastien because he added the is_smo8500_device flag which
I propose to rename in patch 2.

Thanks,
   Antonio

Antonio Ospite (3):
  iio: accel: kxcjk-1013: add the "KXCJ9000" ACPI id
  iio: accel: kxcjk-1013: rename is_smo8500_device to polling_mode
  iio: accel: kxcjk-1013: add some blank lines for readability

 drivers/iio/accel/kxcjk-1013.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
