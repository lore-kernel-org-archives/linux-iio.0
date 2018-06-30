Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:53228 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbeF3SAr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jun 2018 14:00:47 -0400
Date: Sat, 30 Jun 2018 19:00:42 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        freeman.liu@spreadtrum.com, Mark Brown <broonie@kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: adc: Add Spreadtrum SC27XX PMICs ADC
 support
Message-ID: <20180630190042.4962bff3@archlinux>
In-Reply-To: <CAMz4kuJb4aRxNKXYkDJ5vQQgFRN+87_br2gp1BtTLji0dp8XHQ@mail.gmail.com>
References: <900586c7a4ce55818ab330c738f306c7452191ef.1529550463.git.baolin.wang@linaro.org>
        <95836d610301133ffdac1efa86d7daf4cecb97b7.1529550463.git.baolin.wang@linaro.org>
        <20180622151338.00003622@huawei.com>
        <CAMz4kuJUeDjTVJqNc4cNv=LwR1HkuFap4vBF7CCcrxNqnTHa-A@mail.gmail.com>
        <20180624143009.48cf14f8@archlinux>
        <20180624144734.62f28908@archlinux>
        <CAMz4kuJb4aRxNKXYkDJ5vQQgFRN+87_br2gp1BtTLji0dp8XHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 25 Jun 2018 09:47:54 +0800
Baolin Wang <baolin.wang@linaro.org> wrote:

> Hi Jonathan,
> 
> On 24 June 2018 at 21:47, Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:
> > On Sun, 24 Jun 2018 14:30:09 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >  
> >> On Sun, 24 Jun 2018 17:13:00 +0800
> >> Baolin Wang <baolin.wang@linaro.org> wrote:
> >>  
> >> > Hi Jonathan,
> >> >
> >> > On 22 June 2018 at 22:13, Jonathan Cameron <jonathan.cameron@huawei.com> wrote:  
> >> > > On Thu, 21 Jun 2018 11:14:05 +0800
> >> > > Baolin Wang <baolin.wang@linaro.org> wrote:
> >> > >  
> >> > >> From: Freeman Liu <freeman.liu@spreadtrum.com>
> >> > >>
> >> > >> The Spreadtrum SC27XX PMICs ADC controller contains 32 channels,
> >> > >> which is used to sample voltages with 12 bits conversion.
> >> > >>
> >> > >> [Baolin Wang did lots of improvements]
> >> > >>
> >> > >> Signed-off-by: Freeman Liu <freeman.liu@spreadtrum.com>
> >> > >> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>  
> >> > >
> >> > > One trivial missed bit of cleanup inline.  I'll sort that
> >> > > when applying if no one else points anything out before I get back to my
> >> > > development machine.  
> >> >
> >> > Thanks.  
> >>
> >> Applied to the togreg branch of iio.git and pushed out as testing
> >> for the autobuilders to play with it.  
> > Sorry, backed out for now.  My togreg tree is non rebasing and
> > this is dependant on some stuff that only went in during the merge
> > window.
> >
> > I'll send a pull request to GregKH fairly soon and after that do
> > the merge back into my tree to pick that hwspin lock stuff up.
> >
> > So this will be a week or two before I can apply it without issues.
> >
> > Give me a poke if I seem to have forgotten about it.  
> 
> OK. Many thanks for your help.
> 
Applied now with dependencies in place.  Applied to the togreg
branch of iio.git and pushed out as testing for the autobuilders
to play with it.

Thanks,

Jonathan

