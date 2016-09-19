Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:53314 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932327AbcISUAR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2016 16:00:17 -0400
Date: Mon, 19 Sep 2016 21:59:47 +0200 (CEST)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, linux-input@vger.kernel.org,
        pmeerw@pmeerw.net, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, dmitry.torokhov@gmail.com, harald@ccbib.org,
        fabio.estevam@freescale.com, linux-iio@vger.kernel.org,
        marex@denx.de
Message-ID: <1902458447.33545.a597c712-96fc-4c91-8338-283c6e98ee0e.open-xchange@email.1und1.de>
In-Reply-To: <cover.1474108510.git.ksenija.stanojevic@gmail.com>
References: <cover.1474108510.git.ksenija.stanojevic@gmail.com>
Subject: Re: [PATCH v6 0/4] mxs-lradc: Split driver into MFD
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Ksenija Stanojevic <ksenija.stanojevic@gmail.com> hat am 17. September 2016 um
> 12:48 geschrieben:
> 
> 
> Split existing driver mxs-lradc into MFD with touchscreen and
> IIO part.
> 
> Tested on I.MX28.

Tested the patch 1 and 2 successful on a i.MX23 board.

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
