Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:35470 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbcDTRzm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 Apr 2016 13:55:42 -0400
Received: by mail-oi0-f54.google.com with SMTP id p188so54224571oih.2
        for <linux-iio@vger.kernel.org>; Wed, 20 Apr 2016 10:55:42 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Doyle <wpdster@gmail.com>
Date: Wed, 20 Apr 2016 13:55:12 -0400
Message-ID: <CAF_dkJBTS9s6x4Fq+E5eJSRwsd=m6tRHZ9m8hotC6mLzeLberg@mail.gmail.com>
Subject: bmg160 driver
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,
I need to write a SPI mode Linux device driver for the Bosch BMI055
IMU.  I notice that an I2C version of the driver for this part exists
already (at least, in the 4.1 kernel I am using).  I was wondering if
anyone knew of an existing SPI mode driver for this part, or if
anybody had some hints or direction that they could give me regarding
writing such a driver myself.

Thanks.

--wpd
