Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:53996 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755771Ab3ETRJ5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 May 2013 13:09:57 -0400
Received: by mail-la0-f52.google.com with SMTP id fo13so6672857lab.11
        for <linux-iio@vger.kernel.org>; Mon, 20 May 2013 10:09:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369031689-23189-1-git-send-email-ch.naveen@samsung.com>
References: <1369031689-23189-1-git-send-email-ch.naveen@samsung.com>
Date: Mon, 20 May 2013 10:09:55 -0700
Message-ID: <CAD=FV=Xppyb+Y0atygnwA8oBHmGHDx7Bit2fN12GX5Tt-Y9H1A@mail.gmail.com>
Subject: Re: [PATCH] iio: exynos_adc: fix wrong structure extration in suspend
 and resume
From: Doug Anderson <dianders@chromium.org>
To: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: linux-iio <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Naveen Krishna <naveenkrishna.ch@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Naveen,

On Sun, May 19, 2013 at 11:34 PM, Naveen Krishna Chatradhi
<ch.naveen@samsung.com> wrote:
> The exynos_adc device structure was wrongly extracted from the dev*
> correcting the same.
>
> Using the regular conversion of
> struct device* -> struct platform_device* -> struct exynos_adc* seems wrong.
> Instead we should be doing
> struct device* -> struct iio_dev* -> struct exynos_adc*
>
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> ---
>  drivers/iio/adc/exynos_adc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Doug Anderson <dianders@chromium.org>
