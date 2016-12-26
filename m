Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:52079 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbcLZWES (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Dec 2016 17:04:18 -0500
Date: Mon, 26 Dec 2016 23:04:04 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        linux-iio@vger.kernel.org, lee.jones@linaro.org
Message-ID: <1600801097.88831.1482789844722@email.1und1.de>
In-Reply-To: <1482531319-26935-1-git-send-email-khoroshilov@ispras.ru>
References: <1482531319-26935-1-git-send-email-khoroshilov@ispras.ru>
Subject: Re: [PATCH] iio: mxs-lradc: fix error handling in mxs_lradc_probe()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Alexey Khoroshilov <khoroshilov@ispras.ru> hat am 23. Dezember 2016 um 23:15 geschrieben:
> 
> 
> During transition to using devm_input_allocate_device()
> goto to resource deallocation block was replaced by return
> in case of error in iio_device_register().
> That is wrong since resources are left undeallocated.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Fixes: 962ed43a3eac ("iio: mxs-lradc: remove mxs_lradc_ts_unregister")

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

But since Ksenija's patch series [1] (which doesn't have this issue) this patch is only relevant for stable.

Thanks

[1] - http://marc.info/?l=linux-iio&m=148131774219426&w=2
