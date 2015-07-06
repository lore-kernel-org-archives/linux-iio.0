Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34193 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755209AbbGFWzD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jul 2015 18:55:03 -0400
Date: Tue, 7 Jul 2015 01:52:23 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com, octavian.purdila@intel.com,
	julia.lawall@lip6.fr
Subject: [PATCH 3/4] tools: iio: generic_buffer: Maintain fprintf() messages
 consistent
Message-ID: <3ac6176c52e202b9ed3bfbb64b944776d50c9a6d.1436220932.git.cristina.opriceana@gmail.com>
References: <cover.1436220932.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1436220932.git.cristina.opriceana@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

