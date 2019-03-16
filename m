Return-Path: <SRS0=kDFh=RT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A32C43381
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 16:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5BD2186A
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 16:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbfCPQdu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 Mar 2019 12:33:50 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:45226 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfCPQdu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Mar 2019 12:33:50 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 623BC9E759D;
        Sat, 16 Mar 2019 16:33:48 +0000 (GMT)
Date:   Sat, 16 Mar 2019 16:33:46 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Gaston Gonzalez <gascoar@gmail.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Testing ad9833 with Diolan DLN2 adapter
Message-ID: <20190316163346.3d488d46@archlinux>
In-Reply-To: <20190315134126.f5wonniwj7k4j2wf@localhost.localdomain>
References: <20190313193523.k6vipjv33uoiqx25@localhost.localdomain>
        <CA+U=Dsry=kmJdr+BwfULTRaU=YF9KMeYd6jxwj8+5Q8bZRt4=g@mail.gmail.com>
        <0e0834534fb79e0d20033b5ca29cfe5c611fd960.camel@analog.com>
        <20190314202102.qcn43e67xgcmzuhv@localhost.localdomain>
        <ec6489650b98e7eafa39c72bdbbff36981dbc940.camel@analog.com>
        <20190315134126.f5wonniwj7k4j2wf@localhost.localdomain>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Mar 2019 10:41:26 -0300
Gaston Gonzalez <gascoar@gmail.com> wrote:

> On Fri, Mar 15, 2019 at 07:19:22AM +0000, Ardelean, Alexandru wrote:
> > On Thu, 2019-03-14 at 17:21 -0300, Gaston Gonzalez wrote:  
> > > [External]
> > > 
> > > 
> > > On Thu, Mar 14, 2019 at 01:44:50PM +0000, Ardelean, Alexandru wrote:  
> > > > On Thu, 2019-03-14 at 15:39 +0200, Alexandru Ardelean wrote:  
> > > > > [External]
> > > > > 
> > > > > 
> > > > > On Wed, Mar 13, 2019 at 9:36 PM Gaston Gonzalez <gascoar@gmail.com>
> > > > > wrote:  
> > > > > > 
> > > > > > Hi,
> > > > > > 
> > > > > > I am trying to test an ad9833 module like the one in [1] using
> > > > > > Diolan
> > > > > > DLN2
> > > > > > adapter and the driver ad9834.c
> > > > > > 
> > > > > > So far I get the DLN2 adapter correctly registered as master device
> > > > > > (below the spi debug output) but the ad9833 driver doesn't even
> > > > > > probe.
> > > > > > 
> > > > > > Below the spi log output and pin connections. I'm using the testing
> > > > > > branch of the iio repo. The ad9834 and dln2 drivers were compiled
> > > > > > as
> > > > > > modules.
> > > > > > 
> > > > > > The question is: should this setup probe or extra steps are needed?  
> > > > > 
> > > > > Hey,
> > > > > 
> > > > > I'm assuming you enabled the driver in the kernel ?
> > > > > How does your device-tree look ?
> > > > > 
> > > > > There is some documentation about this chip/driver:
> > > > >   
> > > > 
> > > >   
> > https://wiki.analog.com/resources/tools-software/linux-drivers/iio-dds/ad9834  
> > > > > 
> > > > > The old doc still assumes that the driver is using the old
> > > > > platform-data mechanism.
> > > > > It needs a bit of updating, but some info should still be useful.  
> > > > 
> > > > There's this device-tree overlay example/reference for the Raspberry
> > > > PI:
> > > > 
> > > >   
> > https://github.com/analogdevicesinc/linux/commit/7e0b66336ed05dab97c5663f7bc43822c79199dd  
> > > > 
> > > > A lot of our chips/eval-boards are interface with the PI.
> > > >   
> > > 
> > > Hi Alexandru,
> > > 
> > > Thank you for your reply.
> > > 
> > > Yes, I inserted the driver, but I didn't use any device-tree for this
> > > device.
> > > 
> > > To be completely honest I read the AD9834 Analog wiki page, I thought
> > > about
> > > adding the ad9834_platform_data and spi_board_info but then I saw that
> > > the
> > > ad9834_platform_data structure was removed in commit 80109c32, so I
> > > thought
> > > 'I'm missing something...' that's why I asked.
> > > 
> > > I will try using the files in the Analog tree you pointed to.  
> > 
> > I updated the wiki page.
> > If you see issues with it, feel free to point them out.
> > 
> > We keep wanting to do a refresh of the entire wiki, but that's a big effort
> > right now (given new things we have to do). But, if we do it on-demand
> > (like this) it also helps us get a feel for what's being used.
> > 
> > Thanks
> > Alex
> >   
> 
> That's great.
> 
> Thank you, it is really appreciated.
Hi Gaston,

When you have this working please do post the final method and DT
for future reference if anyone finds this thread!

Thanks,

Jonathan

> 
> Gaston
> 
> > > 
> > > Thanks a lot!
> > > 
> > > Gaston
> > >   
> > > > > 
> > > > > Thanks
> > > > > Alex
> > > > >   
> > > > > > 
> > > > > > Any help appreciated.
> > > > > > 
> > > > > > Thanks,
> > > > > > 
> > > > > > Gaston
> > > > > > 
> > > > > > Hardware device
> > > > > > ---------------
> > > > > > 
> > > > > > [1]
> > > > > >   
> > https://www.amazon.com/Alloet-AD9833-Generator-Programmable-Triangle/dp/B07GS1CDXZ/ref=sr_1_1?keywords=ad9833&qid=1550752799&s=gateway&sr=8-1  
> > > > > > 
> > > > > > Kernel tree: IIO, testing branch.
> > > > > > 
> > > > > > DLN2 - AD983 connections
> > > > > > ------------------------
> > > > > > 
> > > > > >  - SS -> FSY
> > > > > >  - SCK -> CLK
> > > > > >  - MOSI -> DAT
> > > > > >  - GND -> GND
> > > > > >  - VCC_OUT -> VCC
> > > > > > 
> > > > > > SPI debug output
> > > > > > ----------------
> > > > > > 
> > > > > > [65465.572149] usb 1-1.2: New USB device found, idVendor=a257,
> > > > > > idProduct=2013, bcdDevice= 1.00
> > > > > > [65465.572155] usb 1-1.2: New USB device strings: Mfr=1, Product=2,
> > > > > > SerialNumber=0
> > > > > > [65465.572158] usb 1-1.2: Product: Diolan DLN2
> > > > > > [65465.572160] usb 1-1.2: Manufacturer: Diolan
> > > > > > [65466.553970] dln2 1-1.2:1.0: Diolan DLN2 serial 33629166
> > > > > > [65466.554925] usbcore: registered new interface driver dln2
> > > > > > [65466.733716] dln2-spi dln2-spi.3.auto: cs_num = 5
> > > > > > [65466.734198] dln2-spi dln2-spi.3.auto: freq_min = 2000, freq_max
> > > > > > =
> > > > > > 18000000
> > > > > > [65466.734453] dln2-spi dln2-spi.3.auto: bpw_mask = 0xFF80
> > > > > > [65466.735044] dln2-spi dln2-spi.3.auto: registered master spi0  

