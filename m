Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:50560 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759827Ab3GSNgf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Jul 2013 09:36:35 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MQ600I5XR3GRH20@mailout4.samsung.com> for
 linux-iio@vger.kernel.org; Fri, 19 Jul 2013 22:36:34 +0900 (KST)
From: Jacek Anaszewski <j.anaszewski@samsung.com>
To: linux-iio@vger.kernel.org
Cc: denis.ciocca@st.com, devicetree-discuss@lists.ozlabs.org,
	jic23@kernel.org, l.czerwinski@samsung.com,
	maxime.ripard@free-electrons.com,
	Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: [PATCH v2] iio:lps331ap: Add support for DT
Date: Fri, 19 Jul 2013 15:36:20 +0200
Message-id: <1374240981-13560-1-git-send-email-j.anaszewski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is the second version of the patch from the series (1).

It includes following improvements:
  - added vendor prefix to the driver DT identifier
  - resigned from using LPS331AP_PRESS_DEV_NAME macro
    in few places in favour of clear text
  - fixed description of the interrupt-map elements
    in the DT binding documentation file

(1) http://www.spinics.net/lists/linux-iio/msg08883.html

Thanks,
Jacek

Jacek Anaszewski (1):
  iio: lps331ap: Add support for DT

 .../devicetree/bindings/iio/pressure/lps331ap.txt  |   41 ++++++++++++++++++++
 drivers/iio/pressure/st_pressure_i2c.c             |   11 +++++-
 drivers/iio/pressure/st_pressure_spi.c             |   11 +++++-
 3 files changed, 61 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/lps331ap.txt

-- 
1.7.5.4

