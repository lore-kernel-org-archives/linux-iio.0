Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:55249 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556Ab3IJPft (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2013 11:35:49 -0400
Received: by mail-wi0-f179.google.com with SMTP id hm2so897323wib.12
        for <linux-iio@vger.kernel.org>; Tue, 10 Sep 2013 08:35:48 -0700 (PDT)
Date: Tue, 10 Sep 2013 16:35:43 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Olof Johansson <olof@lixom.net>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	jic23@cam.ac.uk, Arnd Bergmann <arnd@arndb.de>,
	LinusW <linus.walleij@linaro.org>, denis.ciocca@st.com,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 07/38] ARM: ux500: CONFIG: Enable ST's IIO Accelerometer
 Sensors by default
Message-ID: <20130910153543.GB11227@lee--X1>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-8-git-send-email-lee.jones@linaro.org>
 <CAOesGMj+YzkE5bAxUqFYWoJ-RURDdCK5MUWYTc+gWFQMB3KWkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAOesGMj+YzkE5bAxUqFYWoJ-RURDdCK5MUWYTc+gWFQMB3KWkg@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 10 Sep 2013, Olof Johansson wrote:

> On Tue, Sep 10, 2013 at 5:49 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  arch/arm/configs/u8500_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
> > index 6b29109..24f88d6 100644
> > --- a/arch/arm/configs/u8500_defconfig
> > +++ b/arch/arm/configs/u8500_defconfig
> > @@ -39,6 +39,7 @@ CONFIG_BLK_DEV_RAM_SIZE=65536
> >  CONFIG_SENSORS_BH1780=y
> >  CONFIG_IIO=y
> >  CONFIG_IIO_ST_PRESS=y
> > +CONFIG_IIO_ST_ACCEL_3AXIS=y
> >  CONFIG_NETDEVICES=y
> >  CONFIG_SMSC911X=y
> >  CONFIG_SMSC_PHY=y
> 
> This is ridiculous.
> 
> I know lwn.net's patch author statistics are fun to be on, but

Jealousy won't get you anywhere... ;)

> splitting this and the other config update into two patches? Really?

I haven't split anything. I created the patches as I was
enabling/testing the drivers, which was at completely different
times. The only reason they're close together in the set is because I
reorganised it and didn't think it was necessary to squash them
together.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
