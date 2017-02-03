Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.206]:58452 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752921AbdBCKLq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Feb 2017 05:11:46 -0500
Date: Fri, 3 Feb 2017 11:11:35 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: apw@canonical.com, joe@perches.com
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org
Subject: [RFC] Resolving "false positive" error message from checkpatch.pl
Message-ID: <20170203101135.GA3663@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all

There is a "false positive" error reported by checkpatch.pl:

ERROR: Use 4 digit octal (0777) not decimal permissions
#272: FILE: drivers/staging/iio/meter/ade7759.c:272:
+static IIO_DEV_ATTR_CH_OFF(1, S_IWUSR | S_IRUGO,
+		ade7759_read_8bit,
+		ade7759_write_8bit,
+		ADE7759_CH1OS);

ERROR: Use 4 digit octal (0777) not decimal permissions
#276: FILE: drivers/staging/iio/meter/ade7759.c:276:
+static IIO_DEV_ATTR_CH_OFF(2, S_IWUSR | S_IRUGO,
+		ade7759_read_8bit,
+		ade7759_write_8bit,
+		ADE7759_CH2OS);

The same for the file drivers/staging/iio/meter/ade7753.c.

We can see that this macro is matched by the pattern "IIO_DEV_ATTR_[A-Z_]+" from
@mode_permission_funcs in checkpatch.pl.

My question is: how this should be fixed?

>From what I can say, it's a false positive so the correct way to fix it is to
change the matching pattern: "IIO_DEV_ATTR_(?!CH_OFF)[A-Z_]+".

Or maybe the fix should be done in iio code - argument position inside this
macro?

-- 
Slawomir Stepien
