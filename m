Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:44410 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbeJWSOK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Oct 2018 14:14:10 -0400
Date: Tue, 23 Oct 2018 10:51:26 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Giuliano Augusto Faulin Belinassi <giuliano.belinassi@usp.br>
Cc: giuliano.belinassi@gmail.com, alexandru.Ardelean@analog.com,
        linux-iio@vger.kernel.org, renatogeh@gmail.com,
        kernel-usp@googlegroups.com
Subject: Re: Questions related to some drivers
Message-ID: <20181023105126.408ef7ab@archlinux>
In-Reply-To: <CAEFO=4BjSiYeNW_n0PjoC3EqaN1Z8E1XB_CO+FJJdTwZo4enzg@mail.gmail.com>
References: <20181017190028.wu2kgsooj64beh7o@smtp.gmail.com>
        <d0fc5a236a82d03fdbe4d05eb27ff3bd3ac36958.camel@analog.com>
        <20181018114145.amqff57holmecxpo@smtp.gmail.com>
        <CAEFO=4BjSiYeNW_n0PjoC3EqaN1Z8E1XB_CO+FJJdTwZo4enzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 22 Oct 2018 18:56:16 -0300
Giuliano Augusto Faulin Belinassi <giuliano.belinassi@usp.br> wrote:

> Hello,
> I have some questions about the ad7780 driver.
> 
>   * What is the val2 In the line 96 (*val2 = chan->scan_type.realbits
> - 1;)? How it is used? Is it related to the 24-bits ADC precision?

To understand that follow through what the code does when the type of a
read_raw is IIO_VAL_FRACTIONAL_LOG2; 

>   * Why there is a subtraction in the line 99 ( *val -= (1 <<
> (chan->scan_type.realbits - 1)); )? Is the *val initialized with 0? Is
> that related to the formula described in the DATA OUTPUT CODING, at
> page 12?
> https://www.analog.com/media/en/technical-documentation/data-sheets/ad7780.pdf

Yeah, that -= is definitely wrong.  Should just be an assignment to the
negative value.  This is telling userspace that the raw value should be
offset by half of it's maximum range before applying the scale to get
a reading in the IIO base units (here mV IIRC).

> 
> With regards
> 
> 
> On Thu, Oct 18, 2018 at 8:41 AM Giuliano Belinassi
> <giuliano.belinassi@gmail.com> wrote:
> >
> > On 10/18, Ardelean, Alexandru wrote:
> >
> > Thank you for the reply :-). We will put effort into at least one driver to
> > remove it from staging.
> >  
> > > Hey,
> > >
> > > Thanks for the notification.
> > >
> > > Yes, all these 3 drivers should be moved out of staging.
> > >
> > > We were planning to start working on them (to move them out of staging),
> > > but priorities are shifting from one week to the other.
> > > So, if you guys have the time and are willing to do it, please go ahead,
> > > and add me, michael.hennerich@analog.com and stefan.popa@analog.com to the
> > > CC when sending patches, and we will also take a look over your patches.
> > >
> > > If you haven't taken a look already, feel free to also take a look at our
> > > wiki:
> > > https://wiki.analog.com/resources/tools-software/linux-drivers-all
> > > It's more technical for the SW side; it might help with some general info.
> > > And the datasheets should be available on the analog.com/<product_id>
> > > pages.
> > >
> > >
> > > Thanks
> > > Alex
> > >
> > >
> > > On Wed, 2018-10-17 at 16:00 -0300, Giuliano Belinassi wrote:  
> > > > Hello,
> > > >
> > > > We are a student group and we want to contribute to the linux kernel. We
> > > > are thinking in put effort to move a driver from staging to the main
> > > > tree.
> > > > We looked into three drivers:
> > > >
> > > >   * adc/ad7780.c
> > > >   * adc/ad7816.c
> > > >   * impedance-analyzer/ad5933.c
> > > >
> > > > Are these drivers still being worked on? The last commit referencing
> > > > these
> > > > drivers were on march 2018, but they are still in staging since 2010.
> > > >
> > > > We already know that we have to convert from the old api to the new one.
> > > > It is
> > > > OK for us to work on this? Is there something else we can do?
> > > >
> > > > Thank you
> > > >  
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "Kernel USP" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
> > > To post to this group, send email to kernel-usp@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/d0fc5a236a82d03fdbe4d05eb27ff3bd3ac36958.camel%40analog.com.
> > > For more options, visit https://groups.google.com/d/optout.  
> >
> > --
> > You received this message because you are subscribed to the Google Groups "Kernel USP" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
> > To post to this group, send email to kernel-usp@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/20181018114145.amqff57holmecxpo%40smtp.gmail.com.
> > For more options, visit https://groups.google.com/d/optout.  
