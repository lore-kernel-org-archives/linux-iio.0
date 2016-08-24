Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:35396 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755218AbcHXWgr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Aug 2016 18:36:47 -0400
MIME-Version: 1.0
In-Reply-To: <770097944.403326.225ddbfe-fd96-4f9b-a2b9-e0173af882ba.open-xchange@email.1und1.de>
References: <cover.1471524593.git.ksenija.stanojevic@gmail.com> <770097944.403326.225ddbfe-fd96-4f9b-a2b9-e0173af882ba.open-xchange@email.1und1.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 24 Aug 2016 19:30:22 -0300
Message-ID: <CAOMZO5AM4_51ahmaC5+XKP1GJg1Ltm=nmB2_Ou8_Hk0zOMSh=A@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] mxs-lradc: Split driver into MFD
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Harald Geyer <harald@ccbib.org>, linux-iio@vger.kernel.org,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Stefan,

On Tue, Aug 23, 2016 at 5:18 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Hi,
>
> [add Fabio's NXP address]
>
>> Ksenija Stanojevic <ksenija.stanojevic@gmail.com> hat am 18. August 2016 um
>> 15:44 geschrieben:
>>
>>
>> Split existing driver mxs-lradc into MFD with touchscreen and
>> IIO part.
>>
>> Tested on I.MX28.
>
> i tested the patch 1 and 2 successful on a i.MX23 board.
>
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

Series looks good. I can't test the touchscreen at the moment because
I don't have access to my mx28evk display, but as it was tested on
mx23 and mx28 we are fine then.

Thanks
