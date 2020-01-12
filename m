Return-Path: <SRS0=I6or=3B=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D83FC33CA2
	for <linux-iio@archiver.kernel.org>; Sun, 12 Jan 2020 16:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A042084D
	for <linux-iio@archiver.kernel.org>; Sun, 12 Jan 2020 16:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578846946;
	bh=L5AgTOcLlEhMdbuVd6AambD7dSWNE871RYqPD0fbWJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Yqe7fDSQdhuni2GQM5UJaG9ExBM5vmMI0kk/2KJLvZzsxJ+c7IUWju1X0XYCurVwt
	 are8ZCtzAEMD6fvbxASN87+W9+dQ0w/qT+koPCpiVMsAArrrkMoyFNvxBzRgjHCi7m
	 6czgeX4/wzkoWvPAVNqV2VIZKKpnCKW2B7LO8AyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgALQfq (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 12 Jan 2020 11:35:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:49958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729253AbgALQfq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Jan 2020 11:35:46 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E05832084D;
        Sun, 12 Jan 2020 16:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578846945;
        bh=L5AgTOcLlEhMdbuVd6AambD7dSWNE871RYqPD0fbWJw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s02f6JJmkbYDxFBSBR9rkSBO7TlIwLwUgp2oBJM+PT5rXJF4WcHqrAAYQ1+tpBYUX
         Bo5msNbTh8fli86rV6Xo0AUe8mdio8IT0+prOfPgylG/Y3AGYlnywFZttvYKSTskFB
         RLzB2QoWO6By9x7LkS5Nn8zzaalP5BNE0X5xtabQ=
Date:   Sun, 12 Jan 2020 16:35:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] Second set of IIO fixes for the 5.5 cycle.
Message-ID: <20200112163541.0db257e8@archlinux>
In-Reply-To: <20200112115249.GA532026@kroah.com>
References: <20200105110051.445c9a95@archlinux>
        <20200112114653.01370ef8@archlinux>
        <20200112115249.GA532026@kroah.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 12 Jan 2020 12:52:49 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sun, Jan 12, 2020 at 11:46:53AM +0000, Jonathan Cameron wrote:
> > Hi Greg,
> > 
> > Just wondering if this one slipped through the net?
> > 
> > If we are cutting it a bit fine for the upcoming merge window
> > then I'm happy if you want to apply these to your staging/staging-next
> > tree instead of staging/staging-linus.  
> 
> Sorry, I was waiting for the 5.5-rc6 kernel to be out to merge this in,
> as I already had a bunch of staging fixes go into that.  I was going to
> merge this Monday morning.
> 
> But if you want these into the linux-next tree now, I can always take
> them into my staging-next tree right now, but I figured I could wait a
> week for these as I caught up with other stuff :)

Absolutely fine to take them as you planned!  Thanks for the update.

Jonathan

> 
> thanks,
> 
> greg k-h

