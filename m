Return-Path: <SRS0=pjyC=RR=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449C4C43381
	for <linux-iio@archiver.kernel.org>; Thu, 14 Mar 2019 13:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161FE2085A
	for <linux-iio@archiver.kernel.org>; Thu, 14 Mar 2019 13:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVM9i8VT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfCNNju (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:39:50 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33185 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfCNNju (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Mar 2019 09:39:50 -0400
Received: by mail-oi1-f193.google.com with SMTP id z14so4418580oid.0;
        Thu, 14 Mar 2019 06:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/N+/GuskxRD9/ahpBnMxGzZdt+aZEP9ZCjcLZHMjIvk=;
        b=ZVM9i8VTIVQIvm6Uds7/5m6fSSKBxH96/D402WsoHP3ZRQZI3copGpgA8SdL9gLgcK
         uB2Ltv018gz0SU/WI3Ds96BxCqFzyMBNN+3EORL8UEVtfNChpOGp3YUaGGl2Fo8FAzlQ
         +1bUU6vLT3p8uqr8/fIx4kNAMW7GtCpNC3XUk+O+B+J7arYtjFrM2nb66wnE4NeFY6nB
         e3zfw/R3Gj9QD4+MhI0/5XCvLVHB5cKBe8/bs5e9/B5uRX6oeFug5BRgzkIEQpHD/Xmr
         M55QtNiEmdzh4Fi/RcXGSi1cBMOFqSDL/wm3TMya5Nl2ZTqK3JdSCgxbhDT/EA9775Fn
         9BMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/N+/GuskxRD9/ahpBnMxGzZdt+aZEP9ZCjcLZHMjIvk=;
        b=e+kXi4crnXx0PdYn974hvhWR5I8ls74ULTGLgfK0GDVAIjfe9z1hnhqBTR6wUbRDtP
         OlckpwDGvqV0w67JxXunZZAh7NREQfVvOejJkd+FwVKtuvj3p47p60iJuMgyUAmIcG8B
         ifpgH7o+ygoiSki9jpLWFk5+NjYzteN3k1kbL+y4pQ+6kmXLUAGRVMztniwg1MJ3rb5d
         MljgEGEXfj4Bk4QgR4cCQExsVgXsJdJq6D6X9HlUI0yllPLtZX4Nr/7RvHZ7N7oEjWAw
         JxJOszkNpTuj9n+K04ZzfUEh42LMVqbSD/zvD31FTGaWat0pFR9CpY9sHegBtkz3Yfo3
         aRMg==
X-Gm-Message-State: APjAAAU44ahpaxyb6kA3i/f4kcAkr2jedBggcONKIyuc3MGLu97w8t1E
        zasnnHpY/TpvcAn/1QusNMoODsGrLxEYGk8cDzI=
X-Google-Smtp-Source: APXvYqzcgH4sQPTctwaBIpFVZ8exfCJq6ymaKCydWLDzhRVZfU9v6uQgJahjenFA+i/sNGqA2I52qFKsoOYmeFaab4A=
X-Received: by 2002:aca:b388:: with SMTP id c130mr2014072oif.117.1552570788792;
 Thu, 14 Mar 2019 06:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190313193523.k6vipjv33uoiqx25@localhost.localdomain>
In-Reply-To: <20190313193523.k6vipjv33uoiqx25@localhost.localdomain>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 14 Mar 2019 15:39:37 +0200
Message-ID: <CA+U=Dsry=kmJdr+BwfULTRaU=YF9KMeYd6jxwj8+5Q8bZRt4=g@mail.gmail.com>
Subject: Re: Testing ad9833 with Diolan DLN2 adapter
To:     Gaston Gonzalez <gascoar@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-spi@vger.kernel.org,
        alexandru.ardelean@analog.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 13, 2019 at 9:36 PM Gaston Gonzalez <gascoar@gmail.com> wrote:
>
> Hi,
>
> I am trying to test an ad9833 module like the one in [1] using Diolan DLN2
> adapter and the driver ad9834.c
>
> So far I get the DLN2 adapter correctly registered as master device
> (below the spi debug output) but the ad9833 driver doesn't even probe.
>
> Below the spi log output and pin connections. I'm using the testing
> branch of the iio repo. The ad9834 and dln2 drivers were compiled as
> modules.
>
> The question is: should this setup probe or extra steps are needed?

Hey,

I'm assuming you enabled the driver in the kernel ?
How does your device-tree look ?

There is some documentation about this chip/driver:
https://wiki.analog.com/resources/tools-software/linux-drivers/iio-dds/ad9834

The old doc still assumes that the driver is using the old
platform-data mechanism.
It needs a bit of updating, but some info should still be useful.

Thanks
Alex

>
> Any help appreciated.
>
> Thanks,
>
> Gaston
>
> Hardware device
> ---------------
>
> [1] https://www.amazon.com/Alloet-AD9833-Generator-Programmable-Triangle/dp/B07GS1CDXZ/ref=sr_1_1?keywords=ad9833&qid=1550752799&s=gateway&sr=8-1
>
> Kernel tree: IIO, testing branch.
>
> DLN2 - AD983 connections
> ------------------------
>
>  - SS -> FSY
>  - SCK -> CLK
>  - MOSI -> DAT
>  - GND -> GND
>  - VCC_OUT -> VCC
>
> SPI debug output
> ----------------
>
> [65465.572149] usb 1-1.2: New USB device found, idVendor=a257, idProduct=2013, bcdDevice= 1.00
> [65465.572155] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [65465.572158] usb 1-1.2: Product: Diolan DLN2
> [65465.572160] usb 1-1.2: Manufacturer: Diolan
> [65466.553970] dln2 1-1.2:1.0: Diolan DLN2 serial 33629166
> [65466.554925] usbcore: registered new interface driver dln2
> [65466.733716] dln2-spi dln2-spi.3.auto: cs_num = 5
> [65466.734198] dln2-spi dln2-spi.3.auto: freq_min = 2000, freq_max = 18000000
> [65466.734453] dln2-spi dln2-spi.3.auto: bpw_mask = 0xFF80
> [65466.735044] dln2-spi dln2-spi.3.auto: registered master spi0
