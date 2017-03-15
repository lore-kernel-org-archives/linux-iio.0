Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:58305 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbdCOVSB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 17:18:01 -0400
Date: Wed, 15 Mar 2017 22:10:45 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Cc: linux-input@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        pmeerw@pmeerw.net, jic23@kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, harald@ccbib.org, fabio.estevam@freescale.com,
        linux-iio@vger.kernel.org, marex@denx.de
Message-ID: <365485304.502411.1489612245583@email.1und1.de>
In-Reply-To: <20170314110545.54jz53xx36vsc3bo@dell>
References: <cover.1488380468.git.ksenija.stanojevic@gmail.com>
 <b568984a536229aab4e5d704be1c1de388d4222a.1488380468.git.ksenija.stanojevic@gmail.com>
 <282870591.38324.1488399050890@email.1und1.de>
 <20170301204855.GG30349@dtor-ws> <20170314110545.54jz53xx36vsc3bo@dell>
Subject: Re: [PATCH v14 1/5] mfd: mxs-lradc: Add support for mxs-lradc MFD
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Ksenija,

> Lee Jones <lee.jones@linaro.org> hat am 14. März 2017 um 12:05 geschrieben:
> 
> 
> On Wed, 01 Mar 2017, Dmitry Torokhov wrote:
> 
> > On Wed, Mar 01, 2017 at 09:10:50PM +0100, Stefan Wahren wrote:

...

> > > 
> > > Since touchscreen is optional it doesn't make to try to register it, notice in the touchscreen driver there is no touchscreen, give the user a confusing error and finally disable the clock.
> > > 
> > > Here are my suggestions:
> > > 
> > > 1) Use the solution from Patch V6 but with an explaining comment that touchscreen is optional
> > > 
> > > if (!lradc->touchscreen_wire)
> > > 	return 0;
> > > 
> > > 2) Return a special error from touchscreen registration so mfd knowns this result is expected.
> > > 
> > > I'm open for better solutions.
> > > 
> > > @Lee: What's your opinion?
> > 
> > I am not Lee, but given that this module already parses touchscreen
> > properties and knows whether there is touchscreen or not, #1 seems
> > simple and logical.
> 
> Sorry for the delay, I'm currently behind on my mail due to vacation
> and conferences.
> 
> +1
> 

could you please submit a V15? It would be great to get this into 4.12.

Thanks
Stefan
