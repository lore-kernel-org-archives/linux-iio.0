Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:44040 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380Ab3IJPU0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2013 11:20:26 -0400
Received: by mail-wg0-f54.google.com with SMTP id e11so5767478wgh.9
        for <linux-iio@vger.kernel.org>; Tue, 10 Sep 2013 08:20:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1378817379-8238-8-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
	<1378817379-8238-8-git-send-email-lee.jones@linaro.org>
Date: Tue, 10 Sep 2013 08:20:24 -0700
Message-ID: <CAOesGMj+YzkE5bAxUqFYWoJ-RURDdCK5MUWYTc+gWFQMB3KWkg@mail.gmail.com>
Subject: Re: [PATCH 07/38] ARM: ux500: CONFIG: Enable ST's IIO Accelerometer
 Sensors by default
From: Olof Johansson <olof@lixom.net>
To: Lee Jones <lee.jones@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	jic23@cam.ac.uk, Arnd Bergmann <arnd@arndb.de>,
	LinusW <linus.walleij@linaro.org>, denis.ciocca@st.com,
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Sep 10, 2013 at 5:49 AM, Lee Jones <lee.jones@linaro.org> wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/configs/u8500_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
> index 6b29109..24f88d6 100644
> --- a/arch/arm/configs/u8500_defconfig
> +++ b/arch/arm/configs/u8500_defconfig
> @@ -39,6 +39,7 @@ CONFIG_BLK_DEV_RAM_SIZE=65536
>  CONFIG_SENSORS_BH1780=y
>  CONFIG_IIO=y
>  CONFIG_IIO_ST_PRESS=y
> +CONFIG_IIO_ST_ACCEL_3AXIS=y
>  CONFIG_NETDEVICES=y
>  CONFIG_SMSC911X=y
>  CONFIG_SMSC_PHY=y

This is ridiculous.

I know lwn.net's patch author statistics are fun to be on, but
splitting this and the other config update into two patches? Really?


-Olof
