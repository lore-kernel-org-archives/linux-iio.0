Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:21247 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935724Ab3DPOhj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Apr 2013 10:37:39 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MLC00B3CRAJXTM0@mailout4.samsung.com> for
 linux-iio@vger.kernel.org; Tue, 16 Apr 2013 23:37:38 +0900 (KST)
From: Jacek Anaszewski <j.anaszewski@samsung.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org, achew@nvidia.com
Subject: iio:magnetometer:ak8975: Add support for DT and interrupt handling
Date: Tue, 16 Apr 2013 16:37:18 +0200
Message-id: <1366123040-17917-1-git-send-email-j.anaszewski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

These patches add 'data ready' interrupt handling for AK8975
magnetometer, so as to provide more efficient alternative of
waiting for the end of conversion. This short series adds also
support for parsing 'gpios' property when initializing from oftree.

Thanks,
Jacek Anaszewski
