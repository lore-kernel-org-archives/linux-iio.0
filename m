Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpbgbr2.qq.com ([54.207.22.56]:56933 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752298AbdDIPVR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Apr 2017 11:21:17 -0400
From: Chen Guanqiao <chen.chenchacha@foxmail.com>
To: pmeerw@pmeerw.net, jic23@kernel.org
Cc: Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        Chen Guanqiao <chen.chenchacha@foxmail.com>
Subject: [PATCH v4 0/1] iio:meter:ade7759: use 4-digit octal permissions
Date: Sun,  9 Apr 2017 23:20:59 +0800
Message-Id: <20170409152100.30778-1-chen.chenchacha@foxmail.com>
In-Reply-To: <20170409043027.13930-3-chen.chenchacha@foxmail.com>
References: <20170409043027.13930-3-chen.chenchacha@foxmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch that fixes coding style problem.

Please note:
the checkpatch.pl will be reports error:
>ERROR: Use 4 digit octal (0777) not decimal permissions
>#320: FILE: drivers/staging/iio/meter/ade7759.c:320:
>+static IIO_DEV_ATTR_CH_OFF(1,
>+						   0644,
>+						   ade7759_read_8bit,
>+						   ade7759_write_8bit,
>+						   ADE7759_CH1OS);
>ERROR: Use 4 digit octal (0777) not decimal permissions
>#325: FILE: drivers/staging/iio/meter/ade7759.c:325:
>+static IIO_DEV_ATTR_CH_OFF(2,
>+						   0644,
>+						   ade7759_read_8bit,
>+						   ade7759_write_8bit,
>+						   ADE7759_CH2OS);
Because the script checks the first parameter as permissions in function like
"IIO_DEV_ATTR_[A-Z_]+" and the IIO_DEV_ATTR_CH_OFF permissions parameter is
second.

So, I think this is a problem of checkpatch.pl.

version 4:
- fixes the IIO_DEV_ATTR_CH_OFF

version 3:
- update the title and patch scription
- divide the patch into two parts

version 2:
- corrected spelling error

Chen Guanqiao (1):
  iio:meter:ade7759: Removing use of deprecated macros (S_IRUGO,
    S_IWUSR)

 drivers/staging/iio/meter/ade7759.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.11.0



