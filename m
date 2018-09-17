Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:57530 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeIRAuq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Sep 2018 20:50:46 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 17 Sep 2018 12:22:01 -0700
From: Stefan Agner <stefan@agner.ch>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: max9611: Avoid implicit enum conversion warning
In-Reply-To: <CAKwvOdkygBGNUkJj6zmBO=na-mXPKCeYQ+Grx49Gcyj2O9XJXw@mail.gmail.com>
References: <20180915052511.2243-1-natechancellor@gmail.com>
 <20180916105351.1bf859ee@archlinux> <20180916151513.GA10200@flashbox>
 <CAKwvOdkygBGNUkJj6zmBO=na-mXPKCeYQ+Grx49Gcyj2O9XJXw@mail.gmail.com>
Message-ID: <6cae089a39c7423be9837b89ca50c8e9@agner.ch>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17.09.2018 09:52, Nick Desaulniers wrote:
> On Sun, Sep 16, 2018 at 8:15 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
>>
>> On Sun, Sep 16, 2018 at 10:53:51AM +0100, Jonathan Cameron wrote:
>> > On Fri, 14 Sep 2018 22:25:11 -0700
>> > Nathan Chancellor <natechancellor@gmail.com> wrote:
>> >
>> > > Clang warns when an enumerated type is implicitly converted to another.
>> > >
>> > > drivers/iio/adc/max9611.c:292:16: warning: implicit conversion from
>> > > enumeration type 'enum max9611_conf_ids' to different enumeration type
>> > > 'enum max9611_csa_gain' [-Wenum-conversion]
>> > >                         *csa_gain = gain_selectors[i];
>> > >                                   ~ ^~~~~~~~~~~~~~~~~
>> > > 1 warning generated.
>> > >
>> > > Change the type of the variable 'gain_selectors' to int so that Clang
>> > > understands this is expected behavior.
>> > >
>> > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
>> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>> > How does this interact with the patch that Stefan Agner sent for
>> > the same issue last week?
> 
> + Stefan in case he has additional thoughts.  I don't feel strongly
> about one patch vs the other.
> 

FWIW, only one is needed.

I prefer mine slightly over Nicks since it continues to use struct max9611_conf_ids which is the type required by the max9611_read_single() function..

I don't have a strong opinion though, and did not look deeper into why the driver makes the differentiation between struct max9611_conf_ids and ax9611_csa_gain...

--
Stefan


>> >
>> > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=b1ec0802503820ccbc894aadfd2a44da20232f5e
>> >
>> > Thanks,
>> >
>> > Jonathan
>> >
>>
>> Hi Jonathan,
>>
>> Sorry for the overlap. My patch is not necessary. I was working off
>> of linux-next so I didn't catch this. I'll be better about checking
>> maintainer trees before sending patches in the future.
>>
>> Thanks for the quick response!
>> Nathan
>>
>> > > ---
>> > >  drivers/iio/adc/max9611.c | 2 +-
>> > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > >
>> > > diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
>> > > index 0538ff8c4ac1..3c358b16a8fa 100644
>> > > --- a/drivers/iio/adc/max9611.c
>> > > +++ b/drivers/iio/adc/max9611.c
>> > > @@ -275,7 +275,7 @@ static int max9611_read_csa_voltage(struct max9611_dev *max9611,
>> > >                                 u16 *adc_raw,
>> > >                                 enum max9611_csa_gain *csa_gain)
>> > >  {
>> > > -   enum max9611_conf_ids gain_selectors[] = {
>> > > +   int gain_selectors[] = {
>> > >             CONF_SENSE_1x,
>> > >             CONF_SENSE_4x,
>> > >             CONF_SENSE_8x
>> >
