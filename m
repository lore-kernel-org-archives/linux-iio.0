Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ea0-f171.google.com ([209.85.215.171]:62288 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405Ab3IJPam (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2013 11:30:42 -0400
Received: by mail-ea0-f171.google.com with SMTP id n15so3982346ead.16
        for <linux-iio@vger.kernel.org>; Tue, 10 Sep 2013 08:30:41 -0700 (PDT)
Date: Tue, 10 Sep 2013 16:30:37 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Olof Johansson <olof@lixom.net>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	jic23@cam.ac.uk, linux-iio@vger.kernel.org,
	LinusW <linus.walleij@linaro.org>, denis.ciocca@st.com,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/38] ARM: ux500: Remove PrimeCell IDs from Nomadik I2C
 DT nodes
Message-ID: <20130910153037.GA11227@lee--X1>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-2-git-send-email-lee.jones@linaro.org>
 <CAOesGMgySNLKo_H0h4MCbAWvyW0h2bWa96drWBpnhAYYQwH9mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAOesGMgySNLKo_H0h4MCbAWvyW0h2bWa96drWBpnhAYYQwH9mw@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> On Tue, Sep 10, 2013 at 5:49 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > Turns out that they're actually not required and the driver probes just
> > fine without them. The ID is incorrect at the moment anyway. They actually
> > currently specify the stn8815.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> How did you test this patch? What hardware did you boot it on and with
> what config?

Snowball, u8500_defconfig.

Why? Don't you have the same result with yours?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
