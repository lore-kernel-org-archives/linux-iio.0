Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:52049 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754750AbaAAXEJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 1 Jan 2014 18:04:09 -0500
Received: from [192.168.0.80] ([188.102.227.0]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0Lbi2Z-1Vb0do3N5n-00lGrx for
 <linux-iio@vger.kernel.org>; Thu, 02 Jan 2014 00:04:07 +0100
Message-ID: <52C49EE6.3090703@gmx.de>
Date: Thu, 02 Jan 2014 00:04:06 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: [PATCH V2 0/2]staging:iio:ad799x fix error_free_irq, use devm_request_threaded_irq
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset will:
  - fixes error_free_irq to check if an IRQ was requested before removal
  - move to devm_request_threaded_irq to make device-removal easier

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
V2: Split into two patches
