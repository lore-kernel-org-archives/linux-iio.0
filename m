Return-Path: <SRS0=dHBm=U6=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFAEC0650E
	for <linux-iio@archiver.kernel.org>; Mon,  1 Jul 2019 09:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D314E21743
	for <linux-iio@archiver.kernel.org>; Mon,  1 Jul 2019 09:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561971748;
	bh=CYz7hUtRKBwaUPejT2s4Y9pfmGP9H5URGDOSmv4ZmF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bSmyJhsY6ne0hTHc5j8HUSrGHqeVemMpt2jFqPaU8VzTmkuQWq1NSejGudqr8ggIe
	 cf/vvovmke4sLXJ8cSAPT9hoDKPK3I1Y6I/FZe3VZ+uwx+nlHW5nGtknZHoKgL6S7c
	 trmsKsTyJ0/ZaaOXv9x9j0Grb5Kz5apvFEDPZYL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfGAJC2 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 1 Jul 2019 05:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728184AbfGAJC2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Jul 2019 05:02:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31EE321743;
        Mon,  1 Jul 2019 09:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561971747;
        bh=CYz7hUtRKBwaUPejT2s4Y9pfmGP9H5URGDOSmv4ZmF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FNPqYQKGKkUgr/bdu+3C+KPJSWZpB6hCgjVJGdcWsrXoEFaaaLrmFjWXwsIpHMwsK
         OWEQdnnNX/fZ4hlJlXxPokiE+0Q3PB81F0nU8jrya6VWug9d+e5bA7KCp77W56pzBt
         Zvlq3JnCgODOqzuq4phSxF8HduIGubiUYjlElf2k=
Date:   Mon, 1 Jul 2019 10:59:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] Second set of IIO new device support, features and
 cleanups for the 5.3 cycle.
Message-ID: <20190701085958.GA11465@kroah.com>
References: <20190627204945.104a3af2@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627204945.104a3af2@archlinux>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 27, 2019 at 08:49:45PM +0100, Jonathan Cameron wrote:
> The following changes since commit 1f48d056287d58f425c4f36705764f2ba802feba:
> 
>   MAINTAINERS: Add entry for anybuss drivers (2019-05-24 21:20:43 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.3b

Pulled and pushed out.  NOte, there was one tiny merge issue that you
might want to check that I got correct.

thanks,

greg k-h
