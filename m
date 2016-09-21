Return-Path: <mugunthanvnm@ti.com>
From: Mugunthan V N <mugunthanvnm@ti.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>,
        Mugunthan V N <mugunthanvnm@ti.com>
Subject: [PATCH] tools: iio: iio_generic_buffer: fix argument '?' option
Date: Wed, 21 Sep 2016 22:27:58 +0530
Message-ID: <20160921165758.8471-1-mugunthanvnm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

When help ('?') option is passed to the command, the help text
printed but not from '?' switch case of getopt_long() but as a
invalid argument as below. Fix this by adding '?' to opt_String
of getopt_long().

root@am437x-evm:~# ./iio_generic_buffer -?
./iio_generic_buffer: invalid option -- '?'
Usage: generic_buffer [options]...
Capture, convert and output data from IIO device buffer
  -a         Auto-activate all available channels
...

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 tools/iio/iio_generic_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index f39c0e9..85e2329 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -352,7 +352,7 @@ int main(int argc, char **argv)
 
 	register_cleanup();
 
-	while ((c = getopt_long(argc, argv, "ac:egl:n:N:t:T:w:", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "ac:egl:n:N:t:T:w:?", longopts, NULL)) != -1) {
 		switch (c) {
 		case 'a':
 			autochannels = AUTOCHANNELS_ENABLED;
-- 
2.10.0.129.g35f6318
