Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34879 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbbG2Mye (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jul 2015 08:54:34 -0400
Received: by wibxm9 with SMTP id xm9so199955187wib.0
        for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2015 05:54:33 -0700 (PDT)
From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, cory.tusar@pid1solutions.com
Subject: [PATCH v3 0/7] iio: adc: hi8435: Add Holt HI-8435 threshold detector
Date: Wed, 29 Jul 2015 15:54:29 +0300
Message-Id: <1438174469-19054-1-git-send-email-vladimir.barinov@cogentembedded.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

This adds the folowing:
- Holt threshold detector driver for HI-8435 chip
- Add Holt vendor prefix
- Document HI-8435 DT bindings
- Add periodic polling functionality to SYSFS trigger
- Support triggered events
- Add ABI documentation for debounce_time
- Fix typos in sysfs-bus-iio file

PDF file can be found here:
http://www.holtic.com/products/3081-hi-8435.aspx

Vladimir Barinov (7):
[1/7] iio: adc: hi8435: Holt HI-8435 threshold detector
[2/7] dt: Add vendor prefix 'holt'
[3/7] dt: Document Holt HI-8435 bindings
[4/7] iio: trigger: Add periodic polling to SYSFS trigger
[5/7] iio: Support triggered events
[6/7] iio: Add ABI documentation for debounce_time
[7/7] iio: Fix typos in ABI documentation

---
This patchset is against the 'kernel/git/torvalds/linux.git' repo.

 Documentation/ABI/testing/sysfs-bus-iio               |   16 
 Documentation/ABI/testing/sysfs-bus-iio-adc-hi8435    |   61 +
 Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs |   11 
 Documentation/devicetree/bindings/iio/adc/hi8435.txt  |   25 
 Documentation/devicetree/bindings/vendor-prefixes.txt |    1 
 drivers/iio/Kconfig                                   |    6 
 drivers/iio/Makefile                                  |    1 
 drivers/iio/adc/Kconfig                               |   11 
 drivers/iio/adc/Makefile                              |    1 
 drivers/iio/adc/hi8435.c                              |  659 ++++++++++++++++++
 drivers/iio/industrialio-core.c                       |    4 
 drivers/iio/industrialio-trigger.c                    |   12 
 drivers/iio/industrialio-triggered-event.c            |   68 +
 drivers/iio/trigger/iio-trig-sysfs.c                  |   58 +
 include/linux/iio/iio.h                               |    1 
 include/linux/iio/triggered_event.h                   |   11 
 16 files changed, 939 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-hi8435
 create mode 100644 Documentation/devicetree/bindings/iio/adc/hi8435.txt
 create mode 100644 drivers/iio/adc/hi8435.c
 create mode 100644 drivers/iio/industrialio-triggered-event.c
 create mode 100644 include/linux/iio/triggered_event.h
