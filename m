Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:35796 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752771AbcIIPZT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Sep 2016 11:25:19 -0400
Received: by mail-yw0-f176.google.com with SMTP id j1so48918647ywb.2
        for <linux-iio@vger.kernel.org>; Fri, 09 Sep 2016 08:25:18 -0700 (PDT)
From: Laura Abbott <labbott@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Laura Abbott <labbott@redhat.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: Use type header from kernel tree
Date: Fri,  9 Sep 2016 08:24:53 -0700
Message-Id: <1473434693-5495-1-git-send-email-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


The iio tools have been updated as new event types have been added to
the kernel. The tools currently use the standard system headers which
means that the system may not have the newest defintitions. This leads
to build failures when building newer tools on older hosts:

gcc -Wall -g -D_GNU_SOURCE   -c -o iio_event_monitor.o
iio_event_monitor.c
iio_event_monitor.c:59:3: error: ‘IIO_UVINDEX’ undeclared here (not in a
function)
  [IIO_UVINDEX] = "uvindex",
   ^~~~~~~~~~~
iio_event_monitor.c:59:3: error: array index in initializer not of
integer type
iio_event_monitor.c:59:3: note: (near initialization for
‘iio_chan_type_name_spec’)
iio_event_monitor.c:97:3: error: ‘IIO_MOD_LIGHT_UV’ undeclared here (not
in a function)
  [IIO_MOD_LIGHT_UV] = "uv",
   ^~~~~~~~~~~~~~~~
iio_event_monitor.c:97:3: error: array index in initializer not of
integer type
iio_event_monitor.c:97:3: note: (near initialization for
‘iio_modifier_names’)
<builtin>: recipe for target 'iio_event_monitor.o' failed

Switch to using the header from the kernel tree to ensure the newest
defintions are always picked up.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 tools/iio/iio_event_monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index d9b7e0f..f02523d 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -26,7 +26,7 @@
 #include <sys/ioctl.h>
 #include "iio_utils.h"
 #include <linux/iio/events.h>
-#include <linux/iio/types.h>
+#include "../../include/uapi/linux/iio/types.h"
 
 static const char * const iio_chan_type_name_spec[] = {
 	[IIO_VOLTAGE] = "voltage",
-- 
2.7.4

