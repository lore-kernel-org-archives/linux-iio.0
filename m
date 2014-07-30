Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:57431 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbaG3Jvv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 30 Jul 2014 05:51:51 -0400
Received: by mail-qa0-f44.google.com with SMTP id f12so1016412qad.17
        for <linux-iio@vger.kernel.org>; Wed, 30 Jul 2014 02:51:51 -0700 (PDT)
MIME-Version: 1.0
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Date: Wed, 30 Jul 2014 11:51:11 +0200
Message-ID: <CA+TH9VkYTQOEaV4OX2HAZcpvXhgcP8e+Mp1m1otnX5v=OPbBCw@mail.gmail.com>
Subject: Why drivers don't depend on CONFIG_REGULATOR?
To: linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello List,

I wasted a little bit of my time this morning understanding why the
regulator I used in my device tree wasn't working, only to discover
later that the regulator support was not enabled in my config.

I think that all the drivers that use a regulator should depend on the
CONFIG_REGULATOR.

Is there a reason why any driver has "depends on REGULATOR" in their
Kconfig entry?

Thank you for your time!

-- 
Profile: http://it.linkedin.com/in/compagnucciangelo
