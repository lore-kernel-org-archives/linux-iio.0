Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 01/32] tools:iio:generic_buffer: fix order of freeing data
Date: Sun, 31 May 2015 14:39:41 +0200
Message-Id: <106ad3c604e57db622bd4a274a4429b25b5af1bd.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

data gets allocated before buffer_access, so it should be freed in reverse
order. Otherwise, if allocating buffer_access fails, an attempt to free it
would be taken, which should not happen.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/generic_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index f805493..15f2a40 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -345,10 +345,10 @@ int main(int argc, char **argv)
 
 error_close_buffer_access:
 	close(fp);
-error_free_data:
-	free(data);
 error_free_buffer_access:
 	free(buffer_access);
+error_free_data:
+	free(data);
 error_free_buf_dir_name:
 	free(buf_dir_name);
 error_free_triggername:
-- 
2.3.6
