Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:38380 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbdKYPqv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Nov 2017 10:46:51 -0500
Received: from mail-wr0-f179.google.com (mail-wr0-f179.google.com [209.85.128.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: b93043)
        by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 40C0327C5A
        for <linux-iio@vger.kernel.org>; Sat, 25 Nov 2017 23:46:46 +0800 (CST)
Received: by mail-wr0-f179.google.com with SMTP id u40so22623755wrf.10
        for <linux-iio@vger.kernel.org>; Sat, 25 Nov 2017 07:46:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2f78166e4b54d5c0d139121c00a69ee033918da6.1511598241.git.lukas@wunner.de>
References: <2f78166e4b54d5c0d139121c00a69ee033918da6.1511598241.git.lukas@wunner.de>
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 25 Nov 2017 23:46:22 +0800
Message-ID: <CAGb2v67P5hh6XnW2MCZ=RV41z9M0jFs21FSQ+JpApB3Du2YZ3A@mail.gmail.com>
Subject: Re: [PATCH] iio: Add macro to populate struct iio_map array
To: Lukas Wunner <lukas@wunner.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        linux-iio@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Nov 25, 2017 at 4:38 PM, Lukas Wunner <lukas@wunner.de> wrote:
> The GPIO core provides a handy GPIO_LOOKUP() macro to populate a struct
> gpiod_lookup array without having to spell out attribute names (but
> still avoid breakage when attributes within the struct are rearranged
> or added).
>
> The axp288_adc.c driver uses a similar macro to populate a struct
> iio_map array.  Make it available to others.
>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Acked-by: Chen-Yu Tsai <wens@csie.org>
