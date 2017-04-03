Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:36639 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbdDCOaY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2017 10:30:24 -0400
Received: by mail-lf0-f48.google.com with SMTP id x137so75537837lff.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Apr 2017 07:30:23 -0700 (PDT)
Date: Mon, 3 Apr 2017 15:30:20 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Olof Johansson <olof@lixom.net>, bleung@chromium.org,
        martinez.javier@gmail.com, Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        rtc-linux@googlegroups.com, Vic Yang <victoryang@google.com>
Subject: Re: [PATCH 1/7] mfd: cros-ec: Fix host command buffer size
Message-ID: <20170403143020.mti5vdig6vvlcb2d@dell>
References: <20170324174407.25401-1-enric.balletbo@collabora.com>
 <20170324174407.25401-2-enric.balletbo@collabora.com>
 <20170403142357.2usczfylqbg6cgcx@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170403142357.2usczfylqbg6cgcx@dell>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 03 Apr 2017, Lee Jones wrote:

> On Fri, 24 Mar 2017, Enric Balletbo i Serra wrote:
> 
> > From: Vic Yang <victoryang@google.com>
> > 
> > For SPI, we can get up to 32 additional bytes for response preamble.
> > The current overhead (2 bytes) may cause problems when we try to receive
> > a big response. Update it to 32 bytes.
> > 
> > Without this fix we could see a kernel BUG when we receive a big response
> > from the Chrome EC when is connected via SPI.
> > 
> > Signed-off-by: Vic Yang <victoryang@google.com>
> > Tested-by: Enric Balletbo i Serra <enric.balletbo.collabora.com>
> > ---
> > 
> >   This patch is a FIX, and I think that would be interesting see it merged
> > in this release cycle. This should go through the MFD tree and can be picked
> > independently of the other patches. Lee Jones I think this is for you.
> > 
> >  include/linux/mfd/cros_ec.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Applied, thanks.

Scrap that, I'll keep it with the set.

> > diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> > index b3e812f..3b16c90 100644
> > --- a/include/linux/mfd/cros_ec.h
> > +++ b/include/linux/mfd/cros_ec.h
> > @@ -35,10 +35,11 @@
> >   * Max bus-specific overhead incurred by request/responses.
> >   * I2C requires 1 additional byte for requests.
> >   * I2C requires 2 additional bytes for responses.
> > + * SPI requires up to 32 additional bytes for responses.
> >   * */
> >  #define EC_PROTO_VERSION_UNKNOWN	0
> >  #define EC_MAX_REQUEST_OVERHEAD		1
> > -#define EC_MAX_RESPONSE_OVERHEAD	2
> > +#define EC_MAX_RESPONSE_OVERHEAD	32
> >  
> >  /*
> >   * Command interface between EC and AP, for LPC, I2C and SPI interfaces.
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
