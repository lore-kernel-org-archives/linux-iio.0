Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:61061 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755448AbcIXGXQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Sep 2016 02:23:16 -0400
Subject: [PATCH 0/7] iio: Fine-tuning for several function implementations
References: <566ABCD9.1060404@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>
To: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <c11fbb47-1fd3-4e9e-042e-0f271cfef814@users.sourceforge.net>
Date: Sat, 24 Sep 2016 08:22:43 +0200
MIME-Version: 1.0
In-Reply-To: <566ABCD9.1060404@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 24 Sep 2016 08:10:08 +0200

Some update suggestions were taken into account
from static source code analysis.

Markus Elfring (7):
  Use kmalloc_array() in iio_scan_mask_set()
  Rename a jump label in iio_buffer_store_watermark()
  Rename a jump label in iio_buffer_store_enable()
  Rename a jump label in iio_buffer_write_length()
  Rename a jump label in iio_scan_el_ts_store()
  Rename a jump label in iio_scan_el_store()
  Adjust checks for null pointers in six functions

 drivers/iio/industrialio-buffer.c | 55 ++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

-- 
2.10.0

