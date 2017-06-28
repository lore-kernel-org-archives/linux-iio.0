Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:35521 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbdF1VIb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Jun 2017 17:08:31 -0400
Received: by mail-yw0-f174.google.com with SMTP id j11so29593603ywa.2
        for <linux-iio@vger.kernel.org>; Wed, 28 Jun 2017 14:08:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <64278d08a137561f241f440bb0265698@vanmierlo.com>
References: <64278d08a137561f241f440bb0265698@vanmierlo.com>
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Date: Wed, 28 Jun 2017 23:07:50 +0200
Message-ID: <CA+TH9VmavT-VEnuGeQZXWy=GSwnkarm0Q_-kc3K1CmPGZbN1iA@mail.gmail.com>
Subject: Re: iio:adc mcp3422 initial config
To: Maarten Brock <m.brock@vanmierlo.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Marteen,

2017-06-27 11:53 GMT+02:00 Maarten Brock <m.brock@vanmierlo.com>:
> Hello,
>
> Looking in the mcp3422.c iio kernel driver I see a few issues with the
> initialization of the config word for the adc in mcp3422_probe().
>
> 1. It uses MCP3422_CHANNEL_VALUE(1). Why is channel 2 the default?

No particular reason here, it could be changed to channel 0 without problems.

> 2. It tries to set MCP3422_CONT_SAMPLING, but if this first I2C transfer
> fails it will never be set again. The initial config is not stored in
> adc->config and adc->config is uninitialized! All subsequent writes will
> leave MCP3422_CONT_SAMPLING off.

Unfortunately this is true. I had should use adc->config instead of
config there.

> 3. The return value of mcp3422_update_config() is not checked. Not sure if
> it should though. I wouldn't want a single failure to disable the driver. It
> might even be that the adc is not available yet at linux boot time.

And btw also the error condition should be checked.

> Number 2 is the most important one. We saw it fail because our I2C goes
> through an FPGA which was not loaded yet.
>
> I can write a patch, but welcome some insights first.

I'll fix these in minutes, thanks for spotting!

>
> Kind regards,
> Maarten Brock
>



-- 
Profile: http://it.linkedin.com/in/compagnucciangelo
