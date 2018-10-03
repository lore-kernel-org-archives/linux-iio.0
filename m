Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f182.google.com ([209.85.215.182]:45318 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeJCWf6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Oct 2018 18:35:58 -0400
Received: by mail-pg1-f182.google.com with SMTP id t70-v6so1733301pgd.12
        for <linux-iio@vger.kernel.org>; Wed, 03 Oct 2018 08:47:02 -0700 (PDT)
Received: from ?IPv6:2001:569:7014:cd00:2dad:2f78:5eb8:a229? (node-1w7jr9qg8sz2o0ibxwzy2aejt.ipv6.telus.net. [2001:569:7014:cd00:2dad:2f78:5eb8:a229])
        by smtp.gmail.com with ESMTPSA id h10-v6sm3714721pfj.78.2018.10.03.08.47.00
        for <linux-iio@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 08:47:00 -0700 (PDT)
To: linux-iio <linux-iio@vger.kernel.org>
From: David Frey <dpfrey@gmail.com>
Subject: CONFIG_IIO_TRIGGERED_BUFFER lacks Kconfig description
Message-ID: <d784af9b-c687-530d-4499-fed635a7409e@gmail.com>
Date: Wed, 3 Oct 2018 08:47:00 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I have noticed that CONFIG_IIO_TRIGGERED_BUFFER doesn't have any
description in Kconfig.  I'm not an expert on Kconfig, but I believe
this means that it is not possible to set the config option explicitly
using menuconfig.  I see this as a problem because it means that you
can't really build the necessary kernel config to support an out of tree
driver which depends on CONFIG_IIO_TRIGGERED_BUFFER.  If I'm wrong about
this, please let me know why.

Thanks,
David
