Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33055 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932887AbcI3RpU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Sep 2016 13:45:20 -0400
Received: by mail-pa0-f67.google.com with SMTP id oz2so5053468pac.0
        for <linux-iio@vger.kernel.org>; Fri, 30 Sep 2016 10:45:20 -0700 (PDT)
Date: Fri, 30 Sep 2016 21:49:22 +0530
From: Sandhya Bankar <bankarsandhya512@gmail.com>
To: corbet@lwn.net, amsfield22@gmail.com, daniel.baluta@gmail.com,
        linux-iio@vger.kernel.org
Cc: outreachy-kernel@googlegroups.com
Subject: [PATCH] iio: Documentation: Correct the path used to create triggers.
Message-ID: <20160930161922.GA11685@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Correct the path used to create triggers.

Signed-off-by: Sandhya Bankar <bankarsandhya512@gmail.com>
---
 Documentation/iio/iio_configfs.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/iio/iio_configfs.txt b/Documentation/iio/iio_configfs.txt
index f0add35..4e5f101 100644
--- a/Documentation/iio/iio_configfs.txt
+++ b/Documentation/iio/iio_configfs.txt
@@ -82,8 +82,8 @@ users to create hrtimer triggers under /config/iio/triggers/hrtimer.
 
 e.g:
 
-$ mkdir /config/triggers/hrtimer/instance1
-$ rmdir /config/triggers/hrtimer/instance1
+$ mkdir /config/iio/triggers/hrtimer/instance1
+$ rmdir /config/iio/triggers/hrtimer/instance1
 
 Each trigger can have one or more attributes specific to the trigger type.
 
-- 
1.8.3.1

