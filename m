Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt1-f175.google.com ([209.85.160.175]:45399 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbeJRC5g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Oct 2018 22:57:36 -0400
Received: by mail-qt1-f175.google.com with SMTP id e10-v6so31334220qtq.12
        for <linux-iio@vger.kernel.org>; Wed, 17 Oct 2018 12:00:33 -0700 (PDT)
From: Giuliano Belinassi <giuliano.belinassi@gmail.com>
Date: Wed, 17 Oct 2018 16:00:28 -0300
To: linux-iio@vger.kernel.org
Cc: kernel-usp@googlegroups.com, renatogeh@gmail.com
Subject: Questions related to some drivers
Message-ID: <20181017190028.wu2kgsooj64beh7o@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

We are a student group and we want to contribute to the linux kernel. We
are thinking in put effort to move a driver from staging to the main tree.
We looked into three drivers:
  
  * adc/ad7780.c
  * adc/ad7816.c
  * impedance-analyzer/ad5933.c

Are these drivers still being worked on? The last commit referencing these
drivers were on march 2018, but they are still in staging since 2010.

We already know that we have to convert from the old api to the new one. It is
OK for us to work on this? Is there something else we can do?

Thank you
