Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:64748 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220Ab3AXQMW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Jan 2013 11:12:22 -0500
Received: by mail-lb0-f180.google.com with SMTP id q12so2358628lbc.39
        for <linux-iio@vger.kernel.org>; Thu, 24 Jan 2013 08:12:21 -0800 (PST)
Received: by mail-lb0-f169.google.com with SMTP id m4so6276014lbo.0
        for <linux-iio@vger.kernel.org>; Thu, 24 Jan 2013 08:12:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <510104BD.2020500@metafoo.de>
References: <1358775470-21278-1-git-send-email-ch.naveen@samsung.com>
	<1358917086-4148-1-git-send-email-ch.naveen@samsung.com>
	<50FFDD2A.9040102@metafoo.de>
	<CAD=FV=VgrpPSLrwwrzFDFLBXTw+-t3C=UwnS6b53o41hxM_AyQ@mail.gmail.com>
	<510104BD.2020500@metafoo.de>
Date: Thu, 24 Jan 2013 08:12:17 -0800
Message-ID: <CAD=FV=VRKqeRxvcV1-aQCbu0FoTpMiVVXoNiVEx5SxLe3N_tgQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: add exynos5 adc driver under iio framwork
From: Doug Anderson <dianders@chromium.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	linux-iio@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-samsung-soc@vger.kernel.org, gregkh@linuxfoundation.org,
	Naveen Krishna <naveenkrishna.ch@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Lars,

Thank you for your comments / thoughts...


On Thu, Jan 24, 2013 at 1:54 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> adc: adc@12D10000 {
>
>         #io-channel-cells = <1>;
>         io-channel-output-names = "adc1", "adc2", ...;
>
>         ncp15wb473@0 {
>                 compatible = "ntc,ncp15wb473";
>                 ...
>                 io-channels = <&adc 0>; // First ADC channel

I'm not an expert, but I think the typical way is:
* No need to include a handle to &adc.  It's logically our parent.  In
a similar way i2c devices don't specify their parent bus--they are
just listed under it.
* The "0" should be specified with reg = <0>

Everything else about this syntax looks good.

To implement this I'd imagine that we'll need a new API call, right?
In this case the thermistor driver won't know the name of the channel.
 It can find the ADC (the struct device and probably other things) and
knows a channel index.  Am I understanding properly?

I think Naveen expressed the same question, though he said it a bit
differently than me.

-Doug
