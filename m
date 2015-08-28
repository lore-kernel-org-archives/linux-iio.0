Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38490 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200AbbH1O13 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 28 Aug 2015 10:27:29 -0400
Received: by wibgu7 with SMTP id gu7so11069479wib.1
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2015 07:27:27 -0700 (PDT)
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
Subject: [PATCH v5 0/2] iio: adc: hi8435: Add Holt HI-8435 threshold detector
Date: Fri, 28 Aug 2015 17:27:09 +0300
Message-Id: <1440772029-3022-1-git-send-email-vladimir.barinov@cogentembedded.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

This adds the folowing:
- Holt threshold detector driver for HI-8435 chip
- Document HI-8435 DT bindings

PDF file can be found here:
http://www.holtic.com/products/3081-hi-8435.aspx

Vladimir Barinov (2):
[1/2] iio: adc: hi8435: Holt HI-8435 threshold detector
[2/2] dt: Document Holt HI-8435 bindings

---
This patchset is against the 'kernel/git/jic23/iio.git' repo, 'togreg' branch.

 Documentation/ABI/testing/sysfs-bus-iio              |    1 
 Documentation/ABI/testing/sysfs-bus-iio-adc-hi8435   |   43 +
 Documentation/devicetree/bindings/iio/adc/hi8435.txt |   21 
 drivers/iio/adc/Kconfig                              |   11 
 drivers/iio/adc/Makefile                             |    1 
 drivers/iio/adc/hi8435.c                             |  531 +++++++++++++++++++
 6 files changed, 608 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-hi8435
 create mode 100644 Documentation/devicetree/bindings/iio/adc/hi8435.txt
 create mode 100644 drivers/iio/adc/hi8435.c
