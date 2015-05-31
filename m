Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 06/32] tools:iio:generic_buffer: add check before free
Date: Sun, 31 May 2015 14:39:46 +0200
Message-Id: <a25039ed5112dd904b888d2697df4e8760dcf47d.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

The string trigger_name only gets dynamically allocated, if
!notrigger == true. Therefore add this check before freeing the string.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/generic_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index 0410948..51ae3df 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -358,7 +358,7 @@ error_free_channels:
 	}
 	free(channels);
 error_free_triggername:
-	if (datardytrigger)
+	if (datardytrigger && !notrigger)
 		free(trigger_name);
 error_free_dev_dir_name:
 	free(dev_dir_name);
-- 
2.3.6
