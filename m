Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt1-f174.google.com ([209.85.160.174]:45369 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbeJRTm2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Oct 2018 15:42:28 -0400
Received: by mail-qt1-f174.google.com with SMTP id e10-v6so33751953qtq.12
        for <linux-iio@vger.kernel.org>; Thu, 18 Oct 2018 04:41:50 -0700 (PDT)
From: Giuliano Belinassi <giuliano.belinassi@gmail.com>
Date: Thu, 18 Oct 2018 08:41:45 -0300
To: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc: "giuliano.belinassi@gmail.com" <giuliano.belinassi@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: Questions related to some drivers
Message-ID: <20181018114145.amqff57holmecxpo@smtp.gmail.com>
References: <20181017190028.wu2kgsooj64beh7o@smtp.gmail.com>
 <d0fc5a236a82d03fdbe4d05eb27ff3bd3ac36958.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d0fc5a236a82d03fdbe4d05eb27ff3bd3ac36958.camel@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/18, Ardelean, Alexandru wrote:

Thank you for the reply :-). We will put effort into at least one driver to
remove it from staging.

> Hey,
> 
> Thanks for the notification.
> 
> Yes, all these 3 drivers should be moved out of staging.
> 
> We were planning to start working on them (to move them out of staging),
> but priorities are shifting from one week to the other.
> So, if you guys have the time and are willing to do it, please go ahead,
> and add me, michael.hennerich@analog.com and stefan.popa@analog.com to the
> CC when sending patches, and we will also take a look over your patches.
> 
> If you haven't taken a look already, feel free to also take a look at our
> wiki:
> https://wiki.analog.com/resources/tools-software/linux-drivers-all
> It's more technical for the SW side; it might help with some general info.
> And the datasheets should be available on the analog.com/<product_id>
> pages.
> 
> 
> Thanks
> Alex
> 
> 
> On Wed, 2018-10-17 at 16:00 -0300, Giuliano Belinassi wrote:
> > Hello,
> > 
> > We are a student group and we want to contribute to the linux kernel. We
> > are thinking in put effort to move a driver from staging to the main
> > tree.
> > We looked into three drivers:
> >   
> >   * adc/ad7780.c
> >   * adc/ad7816.c
> >   * impedance-analyzer/ad5933.c
> > 
> > Are these drivers still being worked on? The last commit referencing
> > these
> > drivers were on march 2018, but they are still in staging since 2010.
> > 
> > We already know that we have to convert from the old api to the new one.
> > It is
> > OK for us to work on this? Is there something else we can do?
> > 
> > Thank you
> > 
> 
> -- 
> You received this message because you are subscribed to the Google Groups "Kernel USP" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
> To post to this group, send email to kernel-usp@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/d0fc5a236a82d03fdbe4d05eb27ff3bd3ac36958.camel%40analog.com.
> For more options, visit https://groups.google.com/d/optout.
