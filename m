Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:58350 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbdEBCKT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 May 2017 22:10:19 -0400
MIME-Version: 1.0
In-Reply-To: <20170501224559.21028-2-edu.molinas@gmail.com>
References: <20170501224559.21028-1-edu.molinas@gmail.com> <20170501224559.21028-2-edu.molinas@gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 2 May 2017 10:09:52 +0800
Message-ID: <CAGb2v66_F4yHzQaOtO+-yH7d36kx_ahDCTyXkpTKkzGxQ-bYeA@mail.gmail.com>
Subject: Re: [PATCH 2/2] [PATCH 2/2] iio: adc: sun4i-gpadc-iio: Fix module
 autoload when OF devices are registered
To: Eduardo Molinas <edu.molinas@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, knaack.h@gmx.de,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, May 2, 2017 at 6:45 AM, Eduardo Molinas <edu.molinas@gmail.com> wrote:
> If the driver is built as a module, it won't be autloaded if the devices
> are registered via OF code because the OF device table
> entries are not exported as aliases
>
> Before the patch:
> $ modinfo drivers/iio/adc/sun4i-gpadc-iio.ko | grep alias
> alias:          platform:sun6i-a31-gpadc-iio
> alias:          platform:sun5i-a13-gpadc-iio
> alias:          platform:sun4i-a10-gpadc-iio
>
> After the patch:
> $ modinfo drivers/iio/adc/sun4i-gpadc-iio.ko | grep alias
> alias:          of:N*T*Callwinner,sun8i-a33-thsC*
> alias:          of:N*T*Callwinner,sun8i-a33-ths
> alias:          platform:sun6i-a31-gpadc-iio
> alias:          platform:sun5i-a13-gpadc-iio
> alias:          platform:sun4i-a10-gpadc-iio
>
> Signed-off-by: Eduardo Molinas <edu.molinas@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

Can we merge this as a fix for 4.12?
