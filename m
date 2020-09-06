Return-Path: <SRS0=IeKv=CP=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BBDC433E2
	for <linux-iio@archiver.kernel.org>; Sun,  6 Sep 2020 15:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF25020714
	for <linux-iio@archiver.kernel.org>; Sun,  6 Sep 2020 15:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599405100;
	bh=M5rWY0aNJn2OXFYGUeQ4NWBm+7NTJJgu5YcRsT+IPJI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=r+Kh6DsKVvv5XJDa9Q/1NIXUUHjgwzFcjK4yJk+Nc0jtGP0kFmGYMhkYIVxGLli9q
	 cWmQmHcQlAMMlF7u0HiGBQxf9DInamtQVyt4MskT+1XBGVDzgrboMwbt+hBi/yctD9
	 0kfomet4Ab16XpFR/3xotDgDW021Y8S1u97CtGp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgIFPLj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 6 Sep 2020 11:11:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728828AbgIFPL3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 11:11:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04FAB20714;
        Sun,  6 Sep 2020 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599405089;
        bh=M5rWY0aNJn2OXFYGUeQ4NWBm+7NTJJgu5YcRsT+IPJI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DuYjdVU0ptka04s/1dCbtcIqxGN90VOMc5XykN3XQIlanRHtuSqlXUNBIyG2cJFFI
         SAO4qzJvKD+hJJLLq/QajhUrA8Vjkpj7XxVk5VCCpineLDqS6ckZRjiUGef/DTttJV
         XdD9Sg9SW0H4LAEcz18YquocppTzSaFi+7fW0lHo=
Date:   Sun, 6 Sep 2020 16:11:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: First set of new device support etc for the 5.10
 cycle
Message-ID: <20200906161125.725e49aa@archlinux>
In-Reply-To: <20200906145741.GA314751@kroah.com>
References: <20200906133958.6fec0a17@archlinux>
        <20200906145628.GA290336@kroah.com>
        <20200906145741.GA314751@kroah.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 6 Sep 2020 16:57:41 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sun, Sep 06, 2020 at 04:56:28PM +0200, Greg KH wrote:
> > On Sun, Sep 06, 2020 at 01:39:58PM +0100, Jonathan Cameron wrote:  
> > > The following changes since commit bc752d2f345bf55d71b3422a6a24890ea03168dc:
> > > 
> > >   staging: hikey9xx: Kconfig: add regulator dependency (2020-08-18 19:15:47 +0200)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.10a  
> > 
> > Pulled and pushed out, thanks.  
> 
> Oops, spoke too soon, I get the following error when trying to push:
> Verifying "Fixes:"...		                
> 
> Commit: 1bebdcb928eb ("drivers/iio/humidity/hdc2010.c:305:2-3: Unneeded semicolon")
> 	Fixes tag: Fixes: 016b57638b47 ("iio: humidity: Add TI HDC20x0 support")
> 	Has these problem(s):
> 	        - Target SHA1 does not exist
> 
> Can you fix this up and send a new pull request?
Gah!  I forgot to check.  Sorry about that. New pull in a few moments.
At least it was the top patch on the tree.

Jonathan

> 
> thanks,
> 
> greg k-h

