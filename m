Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55220 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbaKDO3r (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Nov 2014 09:29:47 -0500
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NEI00E6GR2EAC10@mailout1.w1.samsung.com> for
 linux-iio@vger.kernel.org; Tue, 04 Nov 2014 14:32:38 +0000 (GMT)
From: Karol Wrona <k.wrona@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Karol Wrona <k.wrona@samsung.com>
Subject: [PATCH 0/1] staging: iio: Add notrigger mode for generic_buffer
Date: Tue, 04 Nov 2014 15:29:38 +0100
Message-id: <1415111379-23951-1-git-send-email-k.wrona@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

Sometimes it is hard to test IIO device with no triggers at all.
This patch adds "-g" option which allows to use generic_buffer app
without bothering about triggers.

Thanks,
Karol

Karol Wrona (1):
  staging: iio: Add notrigger mode for generic_buffer

 drivers/staging/iio/Documentation/generic_buffer.c |   77 ++++++++++++--------
 1 file changed, 45 insertions(+), 32 deletions(-)

-- 
1.7.9.5

