Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:51460 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbdJ3AGD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Oct 2017 20:06:03 -0400
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] iio: fix kernel-doc build errors
Message-ID: <613cdb24-5be8-6436-6263-87fa8d9cf4df@infradead.org>
Date: Sun, 29 Oct 2017 17:06:01 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors in kernel-doc notation. Symbols that end in '_'
have a special meaning, but adding a '*' makes them OK.

../drivers/iio/industrialio-core.c:635: ERROR: Unknown target name: "iio_val".
../drivers/iio/industrialio-core.c:642: ERROR: Unknown target name: "iio_val".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc:	Jonathan Cameron <jic23@kernel.org>
Cc:	linux-iio@vger.kernel.org
---
 drivers/iio/industrialio-core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- lnx-414-rc7.orig/drivers/iio/industrialio-core.c
+++ lnx-414-rc7/drivers/iio/industrialio-core.c
@@ -631,7 +631,7 @@ static ssize_t __iio_format_value(char *
  * iio_format_value() - Formats a IIO value into its string representation
  * @buf:	The buffer to which the formatted value gets written
  *		which is assumed to be big enough (i.e. PAGE_SIZE).
- * @type:	One of the IIO_VAL_... constants. This decides how the val
+ * @type:	One of the IIO_VAL_* constants. This decides how the val
  *		and val2 parameters are formatted.
  * @size:	Number of IIO value entries contained in vals
  * @vals:	Pointer to the values, exact meaning depends on the
@@ -639,7 +639,7 @@ static ssize_t __iio_format_value(char *
  *
  * Return: 0 by default, a negative number on failure or the
  *	   total number of characters written for a type that belongs
- *	   to the IIO_VAL_... constant.
+ *	   to the IIO_VAL_* constant.
  */
 ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals)
 {


