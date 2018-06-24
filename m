Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751812AbeFXNaP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Jun 2018 09:30:15 -0400
Date: Sun, 24 Jun 2018 14:30:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
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
Message-ID: <20180624143009.48cf14f8@archlinux>
In-Reply-To: <CAMz4kuJUeDjTVJqNc4cNv=LwR1HkuFap4vBF7CCcrxNqnTHa-A@mail.gmail.com>
References: <900586c7a4ce55818ab330c738f306c7452191ef.1529550463.git.baolin.wang@linaro.org>
        <95836d610301133ffdac1efa86d7daf4cecb97b7.1529550463.git.baolin.wang@linaro.org>
        <20180622151338.00003622@huawei.com>
        <CAMz4kuJUeDjTVJqNc4cNv=LwR1HkuFap4vBF7CCcrxNqnTHa-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 24 Jun 2018 17:13:00 +0800
Baolin Wang <baolin.wang@linaro.org> wrote:

> Hi Jonathan,
> 
> On 22 June 2018 at 22:13, Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> > On Thu, 21 Jun 2018 11:14:05 +0800
> > Baolin Wang <baolin.wang@linaro.org> wrote:
> >  
> >> From: Freeman Liu <freeman.liu@spreadtrum.com>
> >>
> >> The Spreadtrum SC27XX PMICs ADC controller contains 32 channels,
> >> which is used to sample voltages with 12 bits conversion.
> >>
> >> [Baolin Wang did lots of improvements]
> >>
> >> Signed-off-by: Freeman Liu <freeman.liu@spreadtrum.com>
> >> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>  
> >
> > One trivial missed bit of cleanup inline.  I'll sort that
> > when applying if no one else points anything out before I get back to my
> > development machine.  
> 
> Thanks.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> 
> >> +
> >> +     indio_dev->dev.parent = &pdev->dev;
> >> +     indio_dev->name = dev_name(&pdev->dev);
> >> +     indio_dev->modes = INDIO_DIRECT_MODE;
> >> +     indio_dev->info = &sc27xx_info;
> >> +     indio_dev->channels = sc27xx_channels;
> >> +     indio_dev->num_channels = ARRAY_SIZE(sc27xx_channels);
> >> +     ret = devm_iio_device_register(&pdev->dev, indio_dev);
> >> +     if (ret) {
> >> +             dev_err(&pdev->dev, "could not register iio (ADC)");
> >> +             return ret;
> >> +     }
> >> +
> >> +     platform_set_drvdata(pdev, indio_dev);  
> >
> > Why?  Looks like this is left over from when we had a remove.  
> 
> Sorry, I missed to remove this redundant code.
> 

