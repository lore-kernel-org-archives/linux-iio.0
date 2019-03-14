Return-Path: <SRS0=pjyC=RR=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ACFC43381
	for <linux-iio@archiver.kernel.org>; Thu, 14 Mar 2019 20:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76392077B
	for <linux-iio@archiver.kernel.org>; Thu, 14 Mar 2019 20:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmQ588eB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfCNUVU (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:21:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39301 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfCNUVU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Mar 2019 16:21:20 -0400
Received: by mail-qt1-f193.google.com with SMTP id t28so7672136qte.6;
        Thu, 14 Mar 2019 13:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CdCSeZ3uBRu5DuVQS4AOy62tYzHdrAD+5IHHcpW0dL4=;
        b=GmQ588eBtrS0bDOgNRmgf1W6Bt0XA0uCEo4hL5H/kAMTlgltvHrOsJD3g6Dlg9rQPt
         AjgfHzDnOko4LVvROEXi8uW2uqZQ7a+KuPPrOOZpWzlsFUPVySYoJ0sCSLRETY4vCTQI
         sI+mcplcqcjOCtxRTZPYJWgN8p2Mpvg/338K6rBvoe0oSIiVdjxb5RXwtzssKLDi0wsB
         TlFnAah0ta/Up6vIyQerajBZV8b+6qIqFtLTeTSCg+B8dPxXT+pA9DDIFkEm5SymxQj3
         QVICJ7onz9G+kH51afQq3WPJZsRAQoU04v79KquCy7979gVnsgj2uYNrwv7FdFP4fO7S
         FtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CdCSeZ3uBRu5DuVQS4AOy62tYzHdrAD+5IHHcpW0dL4=;
        b=nkYiwkGzEZE83HRWb6WWV+vEkTl/WN+QRPdp9WTCqxruArRjJbNfoNTV69nOWtckMT
         cDhODISAnyWLZ+nucvSoT2RpbiqmhvTzEgw2EpwcrzE/ZaQXUSkuP6InoZXkwRL5Xlz1
         E0M35cDvl3WW6fzbCYAz3Qdbj4Pk1qYfqpHs2mHOFr26VNKR+TmUCLMlvttUs7UgOr7A
         PWwZym1DywMiZ3imOwD2ML/3iaGUG2hr6j0sivgj8JxdftLtXBStxkylhRh7b2qqMdG9
         GzGqiRiLewapF8DZKyokoE7mifAKZIT0Nda1G/dgmnrgKFe3mODWJbwT7LdvTY9fo8lA
         j2HA==
X-Gm-Message-State: APjAAAUOnwYqZrP9teNBmcUkr/d2Z2nS+Bi2p8ol/4nECKRUVihwUuyU
        7Lw7Ky6Y7ndDuk3WATp6CZ8=
X-Google-Smtp-Source: APXvYqwgznsifHX+oLLtv0/wS611d/UNASR9QmRKFcq+UYgzk1UvGjAoECiIUIeg4oL47fziU0WgDQ==
X-Received: by 2002:aed:233c:: with SMTP id h57mr40735191qtc.233.1552594878914;
        Thu, 14 Mar 2019 13:21:18 -0700 (PDT)
Received: from localhost.localdomain ([181.166.206.110])
        by smtp.gmail.com with ESMTPSA id n91sm8332733qte.94.2019.03.14.13.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 13:21:17 -0700 (PDT)
Date:   Thu, 14 Mar 2019 17:21:02 -0300
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Testing ad9833 with Diolan DLN2 adapter
Message-ID: <20190314202102.qcn43e67xgcmzuhv@localhost.localdomain>
References: <20190313193523.k6vipjv33uoiqx25@localhost.localdomain>
 <CA+U=Dsry=kmJdr+BwfULTRaU=YF9KMeYd6jxwj8+5Q8bZRt4=g@mail.gmail.com>
 <0e0834534fb79e0d20033b5ca29cfe5c611fd960.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e0834534fb79e0d20033b5ca29cfe5c611fd960.camel@analog.com>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 14, 2019 at 01:44:50PM +0000, Ardelean, Alexandru wrote:
> On Thu, 2019-03-14 at 15:39 +0200, Alexandru Ardelean wrote:
> > [External]
> > 
> > 
> > On Wed, Mar 13, 2019 at 9:36 PM Gaston Gonzalez <gascoar@gmail.com>
> > wrote:
> > > 
> > > Hi,
> > > 
> > > I am trying to test an ad9833 module like the one in [1] using Diolan
> > > DLN2
> > > adapter and the driver ad9834.c
> > > 
> > > So far I get the DLN2 adapter correctly registered as master device
> > > (below the spi debug output) but the ad9833 driver doesn't even probe.
> > > 
> > > Below the spi log output and pin connections. I'm using the testing
> > > branch of the iio repo. The ad9834 and dln2 drivers were compiled as
> > > modules.
> > > 
> > > The question is: should this setup probe or extra steps are needed?
> > 
> > Hey,
> > 
> > I'm assuming you enabled the driver in the kernel ?
> > How does your device-tree look ?
> > 
> > There is some documentation about this chip/driver:
> > 
> https://wiki.analog.com/resources/tools-software/linux-drivers/iio-dds/ad9834
> > 
> > The old doc still assumes that the driver is using the old
> > platform-data mechanism.
> > It needs a bit of updating, but some info should still be useful.
> 
> There's this device-tree overlay example/reference for the Raspberry PI:
> 
> https://github.com/analogdevicesinc/linux/commit/7e0b66336ed05dab97c5663f7bc43822c79199dd
> 
> A lot of our chips/eval-boards are interface with the PI.
>

Hi Alexandru,

Thank you for your reply.

Yes, I inserted the driver, but I didn't use any device-tree for this device.

To be completely honest I read the AD9834 Analog wiki page, I thought about
adding the ad9834_platform_data and spi_board_info but then I saw that the
ad9834_platform_data structure was removed in commit 80109c32, so I thought
'I'm missing something...' that's why I asked.

I will try using the files in the Analog tree you pointed to.

Thanks a lot!

Gaston

> > 
> > Thanks
> > Alex
> > 
> > > 
> > > Any help appreciated.
> > > 
> > > Thanks,
> > > 
> > > Gaston
> > > 
> > > Hardware device
> > > ---------------
> > > 
> > > [1] 
> > > https://www.amazon.com/Alloet-AD9833-Generator-Programmable-Triangle/dp/B07GS1CDXZ/ref=sr_1_1?keywords=ad9833&qid=1550752799&s=gateway&sr=8-1
> > > 
> > > Kernel tree: IIO, testing branch.
> > > 
> > > DLN2 - AD983 connections
> > > ------------------------
> > > 
> > >  - SS -> FSY
> > >  - SCK -> CLK
> > >  - MOSI -> DAT
> > >  - GND -> GND
> > >  - VCC_OUT -> VCC
> > > 
> > > SPI debug output
> > > ----------------
> > > 
> > > [65465.572149] usb 1-1.2: New USB device found, idVendor=a257,
> > > idProduct=2013, bcdDevice= 1.00
> > > [65465.572155] usb 1-1.2: New USB device strings: Mfr=1, Product=2,
> > > SerialNumber=0
> > > [65465.572158] usb 1-1.2: Product: Diolan DLN2
> > > [65465.572160] usb 1-1.2: Manufacturer: Diolan
> > > [65466.553970] dln2 1-1.2:1.0: Diolan DLN2 serial 33629166
> > > [65466.554925] usbcore: registered new interface driver dln2
> > > [65466.733716] dln2-spi dln2-spi.3.auto: cs_num = 5
> > > [65466.734198] dln2-spi dln2-spi.3.auto: freq_min = 2000, freq_max =
> > > 18000000
> > > [65466.734453] dln2-spi dln2-spi.3.auto: bpw_mask = 0xFF80
> > > [65466.735044] dln2-spi dln2-spi.3.auto: registered master spi0
