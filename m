Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37509 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbeJMAsx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Oct 2018 20:48:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id j23-v6so6512844pfi.4
        for <linux-iio@vger.kernel.org>; Fri, 12 Oct 2018 10:15:25 -0700 (PDT)
Date: Fri, 12 Oct 2018 10:15:23 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Rob Herring <robh@kernel.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: vadc: Update example to include
 unit address for node 'usb-id-nopull'
Message-ID: <20181012171523.GQ22824@google.com>
References: <20181004001432.21218-1-mka@chromium.org>
 <20181004001432.21218-2-mka@chromium.org>
 <20181005204743.GA17135@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20181005204743.GA17135@bogus>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Oct 05, 2018 at 03:47:43PM -0500, Rob Herring wrote:
> On Wed, Oct 03, 2018 at 05:14:31PM -0700, Matthias Kaehlcke wrote:
> > The node has a reg property, therefore its name should include a unit
> > address.
> > 
> > Also change the name from 'usb_id_nopull' to 'usb-id-nopull' to follow
> > DT conventions.
> 
> This is ADC channels? If so, then DT convention would really be 
> "adc@...". 

Is it really? A grep for 'adc@' in arch/${ARCH}/boot/dts yields
mostly ADC controller not channel nodes.

I'm totally fine with changing the name to 'adc@...' if that's the
preference/convention, just want to reconfirm since the actual use is
a bit ambiguous.
