Return-Path: <amsfield22@gmail.com>
Date: Tue, 26 Jul 2016 20:17:43 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tools: iio: iio_generic_buffer: initialize channel array
 pointer
Message-ID: <20160727031734.GA31933@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Uninitialized channel pointer causes segmentation fault when we
call free(channel) during cleanup() with no channels initialized.
This happens when you exit early for usage errors.  Initialize
the pointer to NULL when it is declared.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---
 tools/iio/iio_generic_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 0e8a1f7..ae68bf0 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -348,7 +348,7 @@ int main(int argc, char **argv)
 	int notrigger = 0;
 	char *dummy;
 
-	struct iio_channel_info *channels;
+	struct iio_channel_info *channels = NULL;
 
 	register_cleanup();
 
-- 
2.1.4
