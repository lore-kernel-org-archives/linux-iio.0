Return-Path: <SRS0=+Kw+=TU=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AC8C04AAF
	for <linux-iio@archiver.kernel.org>; Mon, 20 May 2019 07:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0272081C
	for <linux-iio@archiver.kernel.org>; Mon, 20 May 2019 07:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558336621;
	bh=N4vSBSX15Y+BfW6Jf62frsgVR/QPp+8nRJajhL4sUFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SESKw5YIfMVL5eGfeq/Jdt1rBYO3bmtLdJraworU7m1L/1YmWV3C2Dtv7kGbqajee
	 Y+SIGnZJbMkIJfCXdJOlvEZ2z8G4TP99JMG+WS0m3S6l2JnZsh/Ba+h0Gd+S9i/eaA
	 +836oTDEgZOt886jyDmyyU9mMnQODNyFhP0YfKhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfETHRA (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 20 May 2019 03:17:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbfETHRA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 May 2019 03:17:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98F292081C;
        Mon, 20 May 2019 07:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558336620;
        bh=N4vSBSX15Y+BfW6Jf62frsgVR/QPp+8nRJajhL4sUFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wFy9ymGHYd4GD792SzCe0oi10FEE5sYjc4vHLyQoxqYkb9/PU8xe2QK4qNzkLQwFX
         2AxiN8SgGujmXyxP4eGmqNH5iBnSnT5Arj+ON3eJk5RzqvgkyVGdNyjaWCBHe1AAY9
         5u8neG+LZ55DABWrs4JEhedV9js7zwauPDEuh2PQ=
Date:   Mon, 20 May 2019 09:16:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of IIO fixes for the 5.2 cycle.
Message-ID: <20190520071643.GB31717@kroah.com>
References: <20190519093356.4703119a@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190519093356.4703119a@archlinux>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 19, 2019 at 09:33:56AM +0100, Jonathan Cameron wrote:
> The following changes since commit 131ac62253dba79daf4a6d83ab12293d2b9863d3:
> 
>   staging: most: core: use device description as name (2019-04-02 20:23:07 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.2a

Pulled and pushed out, thanks.

greg k-h
