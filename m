Return-Path: <SRS0=WfKE=QC=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D70CC282C7
	for <linux-iio@archiver.kernel.org>; Sat, 26 Jan 2019 17:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27808218A2
	for <linux-iio@archiver.kernel.org>; Sat, 26 Jan 2019 17:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548524602;
	bh=6DN/a/AcVGjYLQ4BWACIN5bcgCAFwT3ed0GjH5Zuv40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=T2RCmjANTUiOzno+NRcWcrS+z70t7iWfh1aqlmVn14gkVRI3jZ5WBrsmctzuHmz0v
	 tzCxLdtKYoJmgIZ+qAW/hiFimhtVtRjLNV0CUjP3HYzLPYSMffvRGZWNjfR1Xpf9AN
	 G7IN0m354OeCL94ZgtLaSA8FkGu+gEZq/Uot1mXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfAZRnV (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 26 Jan 2019 12:43:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:54034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfAZRnV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 26 Jan 2019 12:43:21 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CC7F217D7;
        Sat, 26 Jan 2019 17:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548524600;
        bh=6DN/a/AcVGjYLQ4BWACIN5bcgCAFwT3ed0GjH5Zuv40=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qk5lXyoikbz6B6opJ1CMRSwZkB1muq5ojof2zQCVZX2JGhMW4YLNoxq5I3FoAR4Z0
         jks+IXkA/YlG41naJ9nfQuwB+QZh9bbbKbrkrYRtzlPb47FMbdml4Saazm4xjbNYFb
         Yj3nAOhKgjCILAfGMERFMAbfr1qK8Yg+ufM3zBws=
Date:   Sat, 26 Jan 2019 17:43:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Phil Reid <preid@electromag.com.au>
Cc:     Justin Chen <justinpopo6@gmail.com>, linux-iio@vger.kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, lars@metafoo.de,
        andriy.shevchenko@linux.intel.com, david@lechnology.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: ti-ads7950.c GPIO Pins
Message-ID: <20190126174315.264a68b1@archlinux>
In-Reply-To: <41ca1578-9bf4-59f1-758e-346d626b7e8a@electromag.com.au>
References: <CAJx26kVrDbxrp+rKQOhao_k5O8LThLcDRs8HibcohVEvhAF3Tg@mail.gmail.com>
        <41ca1578-9bf4-59f1-758e-346d626b7e8a@electromag.com.au>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Jan 2019 09:46:48 +0800
Phil Reid <preid@electromag.com.au> wrote:

> On 24/01/2019 3:36 am, Justin Chen wrote:
> > Hello,
> > 
> > I have an use case where I need to configure the 4 GPIO pins on a
> > ADS7953. The current driver does not support this. What would be the
> > proper way to implement this?
> > 
> > I created an IIO_VOLTAGE channel for each GPIO to enable or disable
> > them, but this doesn't seem right to me.
> > 
> > Any suggestions?  
> G'day Justin,
> 
> 
> What about using the existing gpio framework.
> see iio/adc/stx104.c for an existing example
> search for gpiochip
> 

Absolutely.  Should register with the normal kernel gpio subsystem.
Make sure to also cc the Gpio maintainer and appropriate mailing lists
alongside IIO.  May also need some bindings to explicitly make those
pins GPIOs given they look multipurpose...  Although the driver
doesn't (I think) support any of those other uses yet, we need to
make sure any devicetree bindings allow for them in a clean fashion
and that any such bindings are optional.

Thanks,

Jonathan


> 

