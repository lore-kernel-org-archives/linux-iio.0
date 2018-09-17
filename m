Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39192 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728429AbeIQWUm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Sep 2018 18:20:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id i190-v6so7947260pgc.6
        for <linux-iio@vger.kernel.org>; Mon, 17 Sep 2018 09:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180915052511.2243-1-natechancellor@gmail.com>
 <20180916105351.1bf859ee@archlinux> <20180916151513.GA10200@flashbox>
In-Reply-To: <20180916151513.GA10200@flashbox>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 17 Sep 2018 09:52:18 -0700
Message-ID: <CAKwvOdkygBGNUkJj6zmBO=na-mXPKCeYQ+Grx49Gcyj2O9XJXw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: max9611: Avoid implicit enum conversion warning
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Sep 16, 2018 at 8:15 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Sun, Sep 16, 2018 at 10:53:51AM +0100, Jonathan Cameron wrote:
> > On Fri, 14 Sep 2018 22:25:11 -0700
> > Nathan Chancellor <natechancellor@gmail.com> wrote:
> >
> > > Clang warns when an enumerated type is implicitly converted to another.
> > >
> > > drivers/iio/adc/max9611.c:292:16: warning: implicit conversion from
> > > enumeration type 'enum max9611_conf_ids' to different enumeration type
> > > 'enum max9611_csa_gain' [-Wenum-conversion]
> > >                         *csa_gain = gain_selectors[i];
> > >                                   ~ ^~~~~~~~~~~~~~~~~
> > > 1 warning generated.
> > >
> > > Change the type of the variable 'gain_selectors' to int so that Clang
> > > understands this is expected behavior.
> > >
> > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > How does this interact with the patch that Stefan Agner sent for
> > the same issue last week?

+ Stefan in case he has additional thoughts.  I don't feel strongly
about one patch vs the other.

> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=b1ec0802503820ccbc894aadfd2a44da20232f5e
> >
> > Thanks,
> >
> > Jonathan
> >
>
> Hi Jonathan,
>
> Sorry for the overlap. My patch is not necessary. I was working off
> of linux-next so I didn't catch this. I'll be better about checking
> maintainer trees before sending patches in the future.
>
> Thanks for the quick response!
> Nathan
>
> > > ---
> > >  drivers/iio/adc/max9611.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> > > index 0538ff8c4ac1..3c358b16a8fa 100644
> > > --- a/drivers/iio/adc/max9611.c
> > > +++ b/drivers/iio/adc/max9611.c
> > > @@ -275,7 +275,7 @@ static int max9611_read_csa_voltage(struct max9611_dev *max9611,
> > >                                 u16 *adc_raw,
> > >                                 enum max9611_csa_gain *csa_gain)
> > >  {
> > > -   enum max9611_conf_ids gain_selectors[] = {
> > > +   int gain_selectors[] = {
> > >             CONF_SENSE_1x,
> > >             CONF_SENSE_4x,
> > >             CONF_SENSE_8x
> >



-- 
Thanks,
~Nick Desaulniers
