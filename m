Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from da1vs04.rockwellcollins.com ([205.175.227.52]:64896 "EHLO
        da1vs04.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728579AbeJLVvQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Oct 2018 17:51:16 -0400
Received: by mail-wm1-f70.google.com with SMTP id y14-v6so7468473wmd.1
        for <linux-iio@vger.kernel.org>; Fri, 12 Oct 2018 07:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <1539198063-29825-1-git-send-email-matthew.weber@rockwellcollins.com>
 <CAJCx=g=sGs2js5uQQWFJg7yumeoGypd9hYsh=TX65vyXDiRSfw@mail.gmail.com>
In-Reply-To: <CAJCx=g=sGs2js5uQQWFJg7yumeoGypd9hYsh=TX65vyXDiRSfw@mail.gmail.com>
From: Matthew Weber <matthew.weber@rockwellcollins.com>
Date: Fri, 12 Oct 2018 09:18:24 -0500
Message-ID: <CANQCQpb6D9TXugjA=3j5K3iTPLkUx4WN04idmJBswvKJWFaQ1w@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio:temperature: Add MAX31856 thermocouple support
To: matt.ranostay@konsulko.com
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Matt,

On Fri, Oct 12, 2018 at 12:44 AM Matt Ranostay
<matt.ranostay@konsulko.com> wrote:
>
> On Thu, Oct 11, 2018 at 3:10 AM Matt Weber
> <matthew.weber@rockwellcollins.com> wrote:
> >
> > From: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> >
> > This patch adds support for Maxim MAX31856 thermocouple
> > temperature sensor support.
> >
> > More information can be found in:
> > https://www.maximintegrated.com/en/ds/MAX31856.pdf
> >
> > NOTE: Driver support only Comparator Mode.
> >
> > Signed-off-by: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> > Signed-off-by: Matt Weber <matthew.weber@rockwellcollins.com>
> > ---
> >
>
> Overall the driver looks nifty..  But just curious why you didn't use
> SPI regmap versus using direct spi read/writes?
>

No specific reason, we were more familiar with direct.  Good to note
though and we'll consider that next time or if we open the code back
up.

Matt
