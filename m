Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181]:61321 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbaDYQ3E (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Apr 2014 12:29:04 -0400
Received: by mail-vc0-f181.google.com with SMTP id id10so5123459vcb.12
        for <linux-iio@vger.kernel.org>; Fri, 25 Apr 2014 09:29:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1398420888-5506-5-git-send-email-ch.naveen@samsung.com>
References: <1398420888-5506-1-git-send-email-ch.naveen@samsung.com>
	<1398420888-5506-5-git-send-email-ch.naveen@samsung.com>
Date: Fri, 25 Apr 2014 09:29:02 -0700
Message-ID: <CAD=FV=Vt2kLx3UvnS11mONDYp2QMCxXYaGu+XfvN_HdeFOQ0HA@mail.gmail.com>
Subject: Re: [PATCH 4/5] iio: exynos_adc: do a soft reset in case of timeout
From: Doug Anderson <dianders@chromium.org>
To: Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Naveen Krishna <naveenkrishna.ch@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"cpgs ." <cpgs@samsung.com>, Grant Grundler <grundler@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Naveen,

On Fri, Apr 25, 2014 at 3:14 AM, Naveen Krishna Chatradhi
<ch.naveen@samsung.com> wrote:
> Do a soft reset software if a timeout happens.
> This is applicable only for ADC_V2.
>
> Change-Id: I939eaa06254e0b246dd636df9470f2eb392c2be1
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> ---
> This change is a part of the patch reviewed at https://lkml.org/lkml/2013/11/5/92
>
>  drivers/iio/adc/exynos_adc.c |   50 ++++++++++++++++++++++--------------------
>  1 file changed, 26 insertions(+), 24 deletions(-)

Reviewed-by: Doug Anderson <dianders@chromium.org>
