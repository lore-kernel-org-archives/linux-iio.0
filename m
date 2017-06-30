Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx12-04.smtp.antispamcloud.com ([46.165.232.174]:37921 "EHLO
        mx12-04.smtp.antispamcloud.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752533AbdF3NQ2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jun 2017 09:16:28 -0400
Received: from [37.74.225.130] (helo=TOP-EX01.TOPIC.LOCAL)
        by mx12.antispamcloud.com with esmtps (TLSv1:ECDHE-RSA-AES128-SHA:128)
        (Exim 4.86)
        (envelope-from <mike.looijmans@topicproducts.com>)
        id 1dQrXf-0000Qf-5x
        for linux-iio@vger.kernel.org; Fri, 30 Jun 2017 10:44:43 +0200
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: "Generic" MMIO ADC
Message-ID: <b60def9a-45dc-bf97-e059-abbe105648b2@topic.nl>
Date: Fri, 30 Jun 2017 10:44:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

﻿I'm writing an IIO driver for a custom IP, which is pretty simple:

- Map the registers to memory and register IRQ routine
- To start acquisition, write a value to the config register
- On interrupt, read data register, push it into queue
- To stop, write another value to config.

Would it be useful to provide this as a generic driver in Linux, so that you 
can provide the config register and data register offsets and values in the 
devicetree? That would make it work on a lot of similar project without 
everyone coding the same thing.

And a related question: Is there a driver that's close to this?


Kind regards,

Mike Looijmans
System Expert

TOPIC Products
Materiaalweg 4, NL-5681 RJ Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
E-mail: mike.looijmans@topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail



