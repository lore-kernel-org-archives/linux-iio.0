Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:51938 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbdCQHA4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Mar 2017 03:00:56 -0400
Date: Fri, 17 Mar 2017 08:00:28 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Cc: lee.jones@linaro.org, linux-input@vger.kernel.org,
        pmeerw@pmeerw.net, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, linux-kernel@vger.kernel.org,
        dmitry.torokhov@gmail.com, harald@ccbib.org,
        fabio.estevam@freescale.com, linux-iio@vger.kernel.org,
        marex@denx.de
Message-ID: <1477647400.119703.1489734029091@email.1und1.de>
In-Reply-To: <cover.1489666428.git.ksenija.stanojevic@gmail.com>
References: <cover.1489666428.git.ksenija.stanojevic@gmail.com>
Subject: Re: [PATCH v15 0/5] mxs-lradc: Split driver into MFD
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Ksenija Stanojevic <ksenija.stanojevic@gmail.com> hat am 16. März 2017 um 13:27 geschrieben:
> 
> 
> Split existing driver mxs-lradc into MFD with touchscreen and
> IIO part.
> 
> Tested on I.MX28
> 
> Ksenija Stanojevic (5):
>   mfd: mxs-lradc: Add support for mxs-lradc MFD
>   iio: adc: mxs-lradc: Add support for adc driver
>   input: touchscreen: mxs-lradc: Add support for touchscreen
>   iio: adc: mxs-lradc: Remove driver
>   mfd: Move binding document
> 

Please add my

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

for Patch 1 and 2 :)

Regarding to patch 5 i'm not sure. Shouldn't this go through the DT instead of the mfd tree? Unfortunately the DT maintainers aren't in CC and their ACKs are still missing.
