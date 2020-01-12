Return-Path: <SRS0=I6or=3B=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B000FC32771
	for <linux-iio@archiver.kernel.org>; Sun, 12 Jan 2020 11:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816A721569
	for <linux-iio@archiver.kernel.org>; Sun, 12 Jan 2020 11:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578829973;
	bh=U/FDRN1TNFRXg5iYqLbtuTm8rCtlnIgLX9b24jQjVuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=izfDZ5vBpXZCOmKrpBn/QBw4ybi3TAUl7a7Ro3dJQSjt0OHg8zUpenKE6YUUoKEPY
	 AYPWEEMshQdaBnK5kdJ5xA554GVrugkrn5UEF2rdHJfxNr7ZwmlmXcfA6EZgSfo5Eb
	 obYp9gq8r/al6DFPKDbFoHUEi/tUBAThikYfGhSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732741AbgALLwx (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 12 Jan 2020 06:52:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:40188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732739AbgALLww (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Jan 2020 06:52:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF2B721569;
        Sun, 12 Jan 2020 11:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578829972;
        bh=U/FDRN1TNFRXg5iYqLbtuTm8rCtlnIgLX9b24jQjVuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p87ycqLf7k6Djvhcpc/t8QXUOCxgGBEeGfXUn8NG5EYdIStBVpiQMqDPZv7bp66Sk
         Txfd/9jRzx9Zjsmja4eXxKcUt9BgYYG/r5kZpurCaYfqFqHRgMO22ZtGH+Ityg39/q
         eYEuiKavRgqabLH3a/Qe/759pNZqAg7bANEgR4lU=
Date:   Sun, 12 Jan 2020 12:52:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] Second set of IIO fixes for the 5.5 cycle.
Message-ID: <20200112115249.GA532026@kroah.com>
References: <20200105110051.445c9a95@archlinux>
 <20200112114653.01370ef8@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200112114653.01370ef8@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 12, 2020 at 11:46:53AM +0000, Jonathan Cameron wrote:
> Hi Greg,
> 
> Just wondering if this one slipped through the net?
> 
> If we are cutting it a bit fine for the upcoming merge window
> then I'm happy if you want to apply these to your staging/staging-next
> tree instead of staging/staging-linus.

Sorry, I was waiting for the 5.5-rc6 kernel to be out to merge this in,
as I already had a bunch of staging fixes go into that.  I was going to
merge this Monday morning.

But if you want these into the linux-next tree now, I can always take
them into my staging-next tree right now, but I figured I could wait a
week for these as I caught up with other stuff :)

thanks,

greg k-h
