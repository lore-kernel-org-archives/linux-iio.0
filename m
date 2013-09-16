Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:55368 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079Ab3IPLLW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2013 07:11:22 -0400
Received: by mail-ea0-f173.google.com with SMTP id g10so1954306eak.18
        for <linux-iio@vger.kernel.org>; Mon, 16 Sep 2013 04:11:21 -0700 (PDT)
Date: Mon, 16 Sep 2013 12:11:18 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Denis CIOCCA <denis.ciocca@st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 38/38] iio: magn-core: st: Provide support for the
 LSM303DLH
Message-ID: <20130916111118.GM3999@lee--X1>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-39-git-send-email-lee.jones@linaro.org>
 <5234A28D.1030409@kernel.org>
 <20130916073151.GB3999@lee--X1>
 <5236D03D.2030506@st.com>
 <20130916100809.GI3999@lee--X1>
 <5236DADD.3040205@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <5236DADD.3040205@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 16 Sep 2013, Denis CIOCCA wrote:

> Hi Lee,
> 
> > The driver mentions that the first group of sensors have a WAI of 
> > 0x3c: #define ST_MAGN_1_WAI_EXP 0x3c And when I print out the WAI read 
> > from the device: Requested device: lsm303dlh_magn - read WAI: 0x3c I 
> > guess I could have been lied to again by the board's datasheet again 
> > and the attached device isn't actually a LSM303DLH, but how can I tell 
> > for sure? 
> On LSM303DLH you have to read 0x0a 0x0b and 0x0c registers, you have to 
> find 0x48, 0x34 and 0x33. I think in the snowball there is the LSM303DLHC.

I'm inclined to agree with you. I'll make the necessary changes.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
