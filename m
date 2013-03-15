Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:47203 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920Ab3COSJX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Mar 2013 14:09:23 -0400
Received: by mail-lb0-f170.google.com with SMTP id ge1so3035538lbb.29
        for <linux-iio@vger.kernel.org>; Fri, 15 Mar 2013 11:09:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1363364620-23597-1-git-send-email-ch.naveen@samsung.com>
References: <1363364620-23597-1-git-send-email-ch.naveen@samsung.com>
Date: Fri, 15 Mar 2013 11:09:21 -0700
Message-ID: <CAD=FV=W90mKzmpg4cG_JJ6R6Of1jt=TxOe_1h-nvzs7KeAvDXQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: Kconfig: exynos_adc depends on CONFIG_OF
From: Doug Anderson <dianders@chromium.org>
To: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: linux-iio <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-samsung-soc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Naveen Krishna <naveenkrishna.ch@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Naveen,

On Fri, Mar 15, 2013 at 9:23 AM, Naveen Krishna Chatradhi
<ch.naveen@samsung.com> wrote:
> As the exynos_adc driver only supports device tree registration.
> Making driver depend on CONFIG_OF solves possible errors during probe.
>
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> ---
> Discussion thread for this patch can be found at
> http://www.gossamer-threads.com/lists/linux/kernel/1693284?page=last
>
>  drivers/iio/adc/Kconfig |    1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Doug Anderson <dianders@chromium.org>
