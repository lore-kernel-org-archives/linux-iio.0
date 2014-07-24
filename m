Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64110 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759021AbaGXNHu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 24 Jul 2014 09:07:50 -0400
Message-ID: <61739.163.33.230.161.1406207197.squirrel@linux.intel.com>
Date: Thu, 24 Jul 2014 13:06:37 -0000 (GMT)
Subject: IIO for PCIe-DMA ADC
From: "Krzysztof Sywula" <krzysztof.m.sywula@linux.intel.com>
To: linux-iio@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi there, I’m designing a PCIe driver for DMA enabled ADC. Is IIO handling
such a combo? I'm based on kernel 3.8.7.

Website:
http://wiki.analog.com/software/linux/docs/iio/iio
says "However typical DMA operated devices such as ones connected to a
high speed synchronous serial (McBSP, SPORT) or high speed synchronous
parallel (EPI, PPI) or FPGA peripherals are also subject to this
subsystem."

which is not clear enough for me to answer that question.

Thanks,
Krzysztof Sywula

