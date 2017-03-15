Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33064 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbdCOUBE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 16:01:04 -0400
Date: Wed, 15 Mar 2017 15:00:59 -0500
From: Rob Herring <robh@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] iio: adc: add max1117/max1118/max1119 ADC driver
Message-ID: <20170315200059.3n4uvt5mgqtrtnnt@rob-hp-laptop>
References: <1488717210-25151-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1488717210-25151-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Mar 05, 2017 at 09:33:30PM +0900, Akinobu Mita wrote:
> This adds max1117/max1118/max1119 8-bit, dual-channel ADC driver.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  .../devicetree/bindings/iio/adc/max1118.txt        |  21 ++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/adc/Kconfig                            |  12 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/max1118.c                          | 310 +++++++++++++++++++++
>  4 files changed, 344 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/max1118.txt
>  create mode 100644 drivers/iio/adc/max1118.c
