Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 17/32] tools:iio:generic_buffer: catch errors for arguments conversion
Date: Sun, 31 May 2015 14:40:03 +0200
Message-Id: <e72b64f004838c664ff258d0db3cbdff9b6598ec.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <15952408423424396a4ace1522055e17da4afc80.1433072539.git.knaack.h@gmx.de>
References: <15952408423424396a4ace1522055e17da4afc80.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Add handler to catch errors on conversion of numerical arguments.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/generic_buffer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index 9164b27..934b4c9 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -206,13 +206,22 @@ int main(int argc, char **argv)
 			noevents = 1;
 			break;
 		case 'c':
+			errno = 0;
 			num_loops = strtoul(optarg, &dummy, 10);
+			if (errno)
+				return -errno;
 			break;
 		case 'w':
+			errno = 0;
 			timedelay = strtoul(optarg, &dummy, 10);
+			if (errno)
+				return -errno;
 			break;
 		case 'l':
+			errno = 0;
 			buf_len = strtoul(optarg, &dummy, 10);
+			if (errno)
+				return -errno;
 			break;
 		case 'g':
 			notrigger = 1;
-- 
2.3.6
