Return-Path: <cristina.opriceana@gmail.com>
Date: Fri, 10 Jul 2015 14:01:18 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com, octavian.purdila@intel.com,
	julia.lawall@lip6.fr
Subject: [PATCH v2 3/4] tools: iio: generic_buffer: Maintain fprintf()
 messages consistent
Message-ID: <62a8cc18f7034b2190536c0cd2e49d5d42256790.1436524490.git.cristina.opriceana@gmail.com>
References: <cover.1436524490.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1436524490.git.cristina.opriceana@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Ensure that both of the error messages get to the
same standard stream.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
---
 tools/iio/generic_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index af350cc..ac9b954 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -325,7 +325,7 @@ int main(int argc, char **argv)
 	ret = build_channel_array(dev_dir_name, &channels, &num_channels);
 	if (ret) {
 		fprintf(stderr, "Problem reading scan element information\n");
-		printf("diag %s\n", dev_dir_name);
+		fprintf(stderr, "diag %s\n", dev_dir_name);
 		goto error_free_triggername;
 	}
 
-- 
1.9.1
