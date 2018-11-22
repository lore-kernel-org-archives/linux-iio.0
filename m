Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37111 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404988AbeKWI0V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Nov 2018 03:26:21 -0500
MIME-Version: 1.0
References: <1542872803-29060-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1542872803-29060-1-git-send-email-hofrat@osadl.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Thu, 22 Nov 2018 22:44:55 +0100
Message-ID: <CAFBinCAXt1GPFMptVXrGYi-TsgSxSyNqeWFuz=B=vWV3c1+zwA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: meson-saradc: check for devm_kasprintf failure
To: hofrat@osadl.org, jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        carlo@caione.org, khilman@baylibre.com, yixun.lan@amlogic.com,
        xingyu.chen@amlogic.com, gregkh@linuxfoundation.org,
        dan.carpenter@oracle.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Nov 22, 2018 at 8:52 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
>
> devm_kasprintf() may return NULL on failure of internal allocation thus
> the assignments to  init.name  are not safe if not checked. On error
> meson_sar_adc_clk_init() returns negative values so -ENOMEM in the
> (unlikely) failure case of devm_kasprintf() should be fine here.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thank you for the patch!
I tested the non-error case on my Odroid-C1 and it still works fine.


Regards
Martin
