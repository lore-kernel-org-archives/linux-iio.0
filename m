Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2] iio: generic_buffer: be helpful about enabling channels
Date: Mon, 10 Aug 2015 10:55:08 +0200
Message-Id: <1439196908-5627-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Currently if generic_buffer is invoked without first enabling any
channels in scan_elements/*_en, it will fail unable to enable the
buffer because bytes_per_datum inside the kernel will be zero if
no channels are available.

It is implied that the user of the program should enable channels
manually or with a script before executing generic_buffer.

Be more helpful by stopping execution if no enabled channels can
be found, and print a helptext that will tell you what is wrong
and what needs to be done.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebased on the "togreg" branch
- Print errors to stderr as requested by Hartmut
---
 tools/iio/generic_buffer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index 9f7b85bf6ada..01c4f67801e0 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -328,6 +328,15 @@ int main(int argc, char **argv)
 			"diag %s\n", dev_dir_name);
 		goto error_free_triggername;
 	}
+	if (!num_channels) {
+		fprintf(stderr,
+			"No channels are enabled, we have nothing to scan.\n");
+		fprintf(stderr, "Enable channels manually in "
+			FORMAT_SCAN_ELEMENTS_DIR
+			"/*_en and try again.\n", dev_dir_name);
+		ret = -ENOENT;
+		goto error_free_triggername;
+	}
 
 	/*
 	 * Construct the directory name for the associated buffer.
-- 
2.4.3
