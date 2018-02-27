Return-Path: <SRS0=eWmn=FV=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Tue, 27 Feb 2018 10:47:06 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: daniel.baluta@nxp.com, kernel-janitors@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iio:dummy: Add extra paragraphs on Kconfig
Message-ID: <7cfd9fd93e76fede44d328045e7885cd78324a78.1519738995.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1519738995.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1519738995.git.rodrigosiqueiramelo@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch fixes the checkpatch.pl warning:

drivers/iio/dummy/Kconfig:21: WARNING: please write a paragraph that
describes the config symbol fully
drivers/iio/dummy/Kconfig:27: WARNING: please write a paragraph that
describes the config symbol fully

This patch expands the explanation about IIO_DUMMY_EVGEN by using the
code documentation found in iio/dummy/iio_dummy_evgen.c. In the same
way, the information related to IIO_SIMPLE_DUMMY_BUFFER was extracted
from file iio_simple_dummy_buffer.c.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/iio/dummy/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/dummy/Kconfig b/drivers/iio/dummy/Kconfig
index 85e13b2e35bf..c4fd108e91d3 100644
--- a/drivers/iio/dummy/Kconfig
+++ b/drivers/iio/dummy/Kconfig
@@ -24,6 +24,10 @@ config IIO_SIMPLE_DUMMY_EVENTS
 	help
 	  Add some dummy events to the simple dummy driver.
 
+	  The purpose of this is to generate 'fake' event interrupts thus
+	  allowing that driver's code to be as close as possible to that
+	  a normal driver talking to hardware.
+
 config IIO_SIMPLE_DUMMY_BUFFER
 	bool "Buffered capture support"
 	select IIO_BUFFER
@@ -32,6 +36,9 @@ config IIO_SIMPLE_DUMMY_BUFFER
 	help
 	  Add buffered data capture to the simple dummy driver.
 
+	  Buffer handling elements of industrial I/O reference driver.
+	  Uses the kfifo buffer.
+
 endif # IIO_SIMPLE_DUMMY
 
 endmenu
-- 
2.16.2
