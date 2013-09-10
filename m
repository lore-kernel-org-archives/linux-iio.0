Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:33438 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468Ab3IJPX7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2013 11:23:59 -0400
Received: by mail-wg0-f41.google.com with SMTP id a12so753433wgh.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Sep 2013 08:23:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1378817379-8238-2-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
	<1378817379-8238-2-git-send-email-lee.jones@linaro.org>
Date: Tue, 10 Sep 2013 08:23:58 -0700
Message-ID: <CAOesGMgySNLKo_H0h4MCbAWvyW0h2bWa96drWBpnhAYYQwH9mw@mail.gmail.com>
Subject: Re: [PATCH 01/38] ARM: ux500: Remove PrimeCell IDs from Nomadik I2C
 DT nodes
From: Olof Johansson <olof@lixom.net>
To: Lee Jones <lee.jones@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	jic23@cam.ac.uk, linux-iio@vger.kernel.org,
	LinusW <linus.walleij@linaro.org>, denis.ciocca@st.com,
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On Tue, Sep 10, 2013 at 5:49 AM, Lee Jones <lee.jones@linaro.org> wrote:
> Turns out that they're actually not required and the driver probes just
> fine without them. The ID is incorrect at the moment anyway. They actually
> currently specify the stn8815.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

How did you test this patch? What hardware did you boot it on and with
what config?

Thanks!

-Olof
