Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:43466 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751035AbdKHIaC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Nov 2017 03:30:02 -0500
Received: by mail-wm0-f47.google.com with SMTP id r68so15734194wmr.0
        for <linux-iio@vger.kernel.org>; Wed, 08 Nov 2017 00:30:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CY1PR02MB2091620DAA142CD469AE357BC7510@CY1PR02MB2091.namprd02.prod.outlook.com>
References: <CY1PR02MB2091620DAA142CD469AE357BC7510@CY1PR02MB2091.namprd02.prod.outlook.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 8 Nov 2017 10:30:00 +0200
Message-ID: <CAEnQRZATAMfWiErKeG5ENR0os85fvmxd0OftPkQtZELAZvKdxQ@mail.gmail.com>
Subject: Re: bmi160 drivers
To: David Frey <DFrey@sierrawireless.com>, contact@bosch-sensortec.com
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi David,

+ contact@bosch-sensortec.com

On Tue, Nov 7, 2017 at 8:49 AM, David Frey <DFrey@sierrawireless.com> wrote=
:
> Hi,
>
> I was working with a vendor kernel based on an older version of Linux (3.=
14) and I backported the bmi160 driver that I found in a recent stable vers=
ion of Linux.  That worked fine.  More recently, I picked up another slight=
ly newer vendor kernel (3.18) for a slightly different product and I notice=
d that it already included a bmi160 driver.  I was surprised to discover th=
at it was a totally different driver.  The driver appears to have been writ=
ten by BoschSensortec (who makes the bmi160 hardware) and is available on g=
ithub here: https://github.com/BoschSensortec/drivers
>
> The driver in the regular linux kernel (originally written by Daniel Balu=
ta and submitted to this mailing list) is around 800 lines of .c and .h fil=
es.  The Bosch driver is around 37000 lines of .c and .h files.  I'm not su=
re how the drivers compare in terms of features.  It seems that the Bosch d=
river is a bit older (based on the commit logs on github).  So I'm wonderin=
g:
>
> Why were two drivers written?

Because at the moment I wrote the driver and sent it upstream there
was no driver from BoshSensortec.

I think the driver wrote by BoschSensortec supports all the features
of the chip (including hardware fifo), but it also
has a lot of non standard attributes (so not easy acceptable upstream).

I was planning at some point to implement hw fifo support but got
derailed with other things.

> Was there a discussion about which driver to include in the Linux kernel?=
  (I couldn't find any discussion on this mailing list)

No, AFAIK. BoshSensortec never sent a request for their driver to be
merged upstream.

I am not sure about their code license?

https://github.com/BoschSensortec/drivers/commit/092cab48836cf0ca9ad3bb67cf=
86f5b7aa239d95#diff-a87e4e16f3f8950aafedf0b7b32c613f

but perhaps it worths someone looking at enhancing the upstream
driver. I will try to see in the next few weeks if we can work with
BoschSensortec
for them to upstream their missing parts from upstream.

Hope this helps.

Daniel
