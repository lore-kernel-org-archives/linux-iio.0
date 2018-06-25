Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36824 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752369AbeFYBrz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jun 2018 21:47:55 -0400
Received: by mail-oi0-f68.google.com with SMTP id 14-v6so10989463oie.3
        for <linux-iio@vger.kernel.org>; Sun, 24 Jun 2018 18:47:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180624144734.62f28908@archlinux>
References: <900586c7a4ce55818ab330c738f306c7452191ef.1529550463.git.baolin.wang@linaro.org>
 <95836d610301133ffdac1efa86d7daf4cecb97b7.1529550463.git.baolin.wang@linaro.org>
 <20180622151338.00003622@huawei.com> <CAMz4kuJUeDjTVJqNc4cNv=LwR1HkuFap4vBF7CCcrxNqnTHa-A@mail.gmail.com>
 <20180624143009.48cf14f8@archlinux> <20180624144734.62f28908@archlinux>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Mon, 25 Jun 2018 09:47:54 +0800
Message-ID: <CAMz4kuJb4aRxNKXYkDJ5vQQgFRN+87_br2gp1BtTLji0dp8XHQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: adc: Add Spreadtrum SC27XX PMICs ADC support
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        freeman.liu@spreadtrum.com, Mark Brown <broonie@kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

On 24 June 2018 at 21:47, Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:
> On Sun, 24 Jun 2018 14:30:09 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
>> On Sun, 24 Jun 2018 17:13:00 +0800
>> Baolin Wang <baolin.wang@linaro.org> wrote:
>>
>> > Hi Jonathan,
>> >
>> > On 22 June 2018 at 22:13, Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
>> > > On Thu, 21 Jun 2018 11:14:05 +0800
>> > > Baolin Wang <baolin.wang@linaro.org> wrote:
>> > >
>> > >> From: Freeman Liu <freeman.liu@spreadtrum.com>
>> > >>
>> > >> The Spreadtrum SC27XX PMICs ADC controller contains 32 channels,
>> > >> which is used to sample voltages with 12 bits conversion.
>> > >>
>> > >> [Baolin Wang did lots of improvements]
>> > >>
>> > >> Signed-off-by: Freeman Liu <freeman.liu@spreadtrum.com>
>> > >> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> > >
>> > > One trivial missed bit of cleanup inline.  I'll sort that
>> > > when applying if no one else points anything out before I get back to my
>> > > development machine.
>> >
>> > Thanks.
>>
>> Applied to the togreg branch of iio.git and pushed out as testing
>> for the autobuilders to play with it.
> Sorry, backed out for now.  My togreg tree is non rebasing and
> this is dependant on some stuff that only went in during the merge
> window.
>
> I'll send a pull request to GregKH fairly soon and after that do
> the merge back into my tree to pick that hwspin lock stuff up.
>
> So this will be a week or two before I can apply it without issues.
>
> Give me a poke if I seem to have forgotten about it.

OK. Many thanks for your help.

-- 
Baolin Wang
Best Regards
