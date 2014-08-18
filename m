Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] MAINTAINERS: Add designated reviewers for IIO subsystem
Date: Mon, 18 Aug 2014 10:29:49 +0200
Message-Id: <1408350589-22372-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Add those persons who generally tend to review new IIO patches to the list of
designated reviewers to make sure that they are Cc'ed on new patches.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Hartmut, Peter if you are OK with this please ack the patch, otherwise I can
respin it to remove you.
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aefa948..3f77be0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4580,6 +4580,9 @@ F:	drivers/media/rc/iguanair.c
 
 IIO SUBSYSTEM AND DRIVERS
 M:	Jonathan Cameron <jic23@kernel.org>
+R:	Hartmut Knaack <knaack.h@gmx.de>
+R:	Lars-Peter Clausen <lars@metafoo.de>
+R:	Peter Meerwald <pmeerw@pmeerw.net>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	drivers/iio/
-- 
1.8.0
