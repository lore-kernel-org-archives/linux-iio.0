Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.ispras.ru ([83.149.199.45]:32922 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750979AbcIBIFN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 2 Sep 2016 04:05:13 -0400
From: Pavel Andrianov <andrianov@ispras.ru>
Subject: A potential race in drivers/iio/adc/vf610_adc.ko
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vaishali Thakkar <vaishali.thakkar@oracle.com>,
        ldv-project@linuxtesting.org
Message-ID: <8ad6537e-718a-4c5d-4f51-958e585b3727@ispras.ru>
Date: Fri, 2 Sep 2016 11:05:09 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Hi!

There is a potential race in drivers/iio/adc/vf610_adc.ko.
Handlers vf610_set_conversion_mode and vf610_write_raw are called via 
device_attibute interface, but they are related to different attributes, 
so may be executed in parallel. vf610_set_conversion_mode acquires the 
mutex indio_dev->mlock, and vf610_write_raw does not. Thus updating the 
structure 'info' may be performed simultaneously.

Should vf610_write_raw also acquire the same mutex indio_dev->mlock?

-- 
Pavel Andrianov
Linux Verification Center, ISPRAS
web: http://linuxtesting.org
e-mail: andrianov@ispras.ru
