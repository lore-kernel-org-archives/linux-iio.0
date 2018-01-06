Return-Path: <SRS0=fQ2w=EB=tobin.cc=me@kernel.org>
From: "Tobin C. Harding" <me@tobin.cc>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] fix kernel-docs for struct iio_trigger
Date: Sun,  7 Jan 2018 08:56:04 +1100
Message-Id: <1515275766-31302-1-git-send-email-me@tobin.cc>
List-ID: <linux-iio@vger.kernel.org>

This series was inspired by a warning emitted by sphinx when running
kernel make target 'htmldocs'.

	warning: No description found for parameter 'owner'

Patch 1 adds a kernel-doc description for field @owner.

Patch 2 adds field identifier to kernel-doc string (for @use_count).

v3:
 - Fix up patch title to include correct version number.

v2:
 - Change field identifier from DRIVER to INTERN.
 - Add second patch, change subject line.

v1:
 - [PATCH] iio: add kernel-doc '@owner'

Tobin C. Harding (2):
  iio: add kernel-doc for field @owner
  iio: add field identifier for @use_count kernel-doc

 include/linux/iio/trigger.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.7.4
