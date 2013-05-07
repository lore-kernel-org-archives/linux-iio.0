Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:11142 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485Ab3EGKm0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 7 May 2013 06:42:26 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MMF002S2CEND8V0@mailout4.samsung.com> for
 linux-iio@vger.kernel.org; Tue, 07 May 2013 19:42:24 +0900 (KST)
From: Jacek Anaszewski <j.anaszewski@samsung.com>
To: linux-iio@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, achew@nvidia.com,
	s.nawrocki@samsung.com, Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: [PATCH 0/2 V2] iio: magnetometer: ak8975: Add support for DT and
 interrupt handling
Date: Tue, 07 May 2013 12:41:37 +0200
Message-id: <1367923299-30594-1-git-send-email-j.anaszewski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These patches add 'data ready' interrupt handling for AK8975
magnetometer, so as to provide more efficient alternative of
waiting for the end of conversion. This short series adds also
support for parsing 'gpios' property when initializing from oftree.

This is a follow-up of the previous patchset and it includes
following improvements:

- replaced NULL with 'data' in the second argument of the free_irq calls,
  which fixes problem on the module removal
- changed the order of checking for the platform_data and added
  checking for the -EPROBE_DEFER as spotted by Lars-Peter Clausen
- moved ak8975.txt out of staging as spotted by Jonathan Cameron
- modified header description in ak8975.txt
- renamed '0C' to '0c' in the examplary device node in ak8975.txt

Thanks,
Jacek Anaszewski

Jacek Anaszewski (2):
  iio:ak8975 Add support for gpios DT property
  iio:ak8975 Implement data ready interrupt handling

 .../bindings/iio/magnetometer/ak8975.txt           |   18 ++++
 drivers/iio/magnetometer/ak8975.c                  |  103 +++++++++++++++++++-
 2 files changed, 116 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt

-- 
1.7.5.4

