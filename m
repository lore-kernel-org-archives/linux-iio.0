Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932557AbcLAMa6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Dec 2016 07:30:58 -0500
Subject: [PATCH 10/39] Annotate hardware config module parameters in
 drivers/iio/
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: gnomes@lxorguk.ukuu.org.uk, minyard@acm.org,
        linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        dhowells@redhat.com, linux-security-module@vger.kernel.org,
        keyrings@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Date: Thu, 01 Dec 2016 12:30:55 +0000
Message-ID: <148059545558.31612.1279403857733187213.stgit@warthog.procyon.org.uk>
In-Reply-To: <148059537897.31612.9461043954611464597.stgit@warthog.procyon.org.uk>
References: <148059537897.31612.9461043954611464597.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When the kernel is running in secure boot mode, we lock down the kernel to
prevent userspace from modifying the running kernel image.  Whilst this
includes prohibiting access to things like /dev/mem, it must also prevent
access by means of configuring driver modules in such a way as to cause a
device to access or modify the kernel image.

To this end, annotate module_param* statements that refer to hardware
configuration and indicate for future reference what type of parameter they
specify.  The parameter parser in the core sees this information and can
skip such parameters with an error message if the kernel is locked down.
The module initialisation then runs as normal, but just sees whatever the
default values for those parameters is.

Note that we do still need to do the module initialisation because some
drivers have viable defaults set in case parameters aren't specified and
some drivers support automatic configuration (e.g. PNP or PCI) in addition
to manually coded parameters.

This patch annotates drivers in drivers/iio/.

Suggested-by: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: William Breathitt Gray <vilhelm.gray@gmail.com>
cc: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org
---

 drivers/iio/adc/stx104.c  |    2 +-
 drivers/iio/dac/cio-dac.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
index 7e3645749eaf..a805bd543acb 100644
--- a/drivers/iio/adc/stx104.c
+++ b/drivers/iio/adc/stx104.c
@@ -49,7 +49,7 @@
 
 static unsigned int base[max_num_isa_dev(STX104_EXTENT)];
 static unsigned int num_stx104;
-module_param_array(base, uint, &num_stx104, 0);
+module_param_hw_array(base, uint, ioport, &num_stx104, 0);
 MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
 
 /**
diff --git a/drivers/iio/dac/cio-dac.c b/drivers/iio/dac/cio-dac.c
index 5a743e2a779d..dac086129edf 100644
--- a/drivers/iio/dac/cio-dac.c
+++ b/drivers/iio/dac/cio-dac.c
@@ -39,7 +39,7 @@
 
 static unsigned int base[max_num_isa_dev(CIO_DAC_EXTENT)];
 static unsigned int num_cio_dac;
-module_param_array(base, uint, &num_cio_dac, 0);
+module_param_hw_array(base, uint, ioport, &num_cio_dac, 0);
 MODULE_PARM_DESC(base, "Measurement Computing CIO-DAC base addresses");
 
 /**

