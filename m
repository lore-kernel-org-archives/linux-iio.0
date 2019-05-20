Return-Path: <SRS0=+Kw+=TU=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F34EC04AAF
	for <linux-iio@archiver.kernel.org>; Mon, 20 May 2019 07:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331CE20851
	for <linux-iio@archiver.kernel.org>; Mon, 20 May 2019 07:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558336561;
	bh=9BS42hHZHWqKiHZXdYax9/58MH3i4sUdcwR59yIZHBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MlMfwB7r7X9O7UBtCl9uWSrAPlceM6+edURe7K9nv/QkX0MB1yPecIe6obvrbE3v4
	 WcFGyR/i3HWhuVRJ7r46P6GRXID6IrlkBxxhgvoQ2niR8o0l7LhzIWwkwJSvabAbLN
	 Onr8Gah3oCQ/++w+b1E2IWfVePAkbZ0zsBnQ59D8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfETHQA (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 20 May 2019 03:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbfETHQA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 May 2019 03:16:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDACB20859;
        Mon, 20 May 2019 07:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558336560;
        bh=9BS42hHZHWqKiHZXdYax9/58MH3i4sUdcwR59yIZHBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XoxO8qcAFwAKzvv+dCrAIB4edZbO6hW7Qsob35svyZ3t4ZyIV8zBl6BuON/XVEytP
         Oltyoqz3bferyQCaWVqIxqMY1UqGU7eXKHV610McRjXnU8fVI3r4UWau0csFSGjiNp
         HDaiP4ctXyV4QjBTr6xh7xh3N+/POIoW/Ns571sc=
Date:   Mon, 20 May 2019 09:14:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of new device support, features and cleanups
 for IIO in the 5.3 cycle.
Message-ID: <20190520071453.GA31717@kroah.com>
References: <20190519095700.5ffbb7b4@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190519095700.5ffbb7b4@archlinux>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 19, 2019 at 09:57:00AM +0100, Jonathan Cameron wrote:
> The following changes since commit 575d927c426b83f5f8d5809f46de177cceffe40c:
> 
>   LS1021A: dtsi: add ftm quad decoder entries (2019-04-25 21:33:42 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.3a

Pulled and pushed out, thanks.

greg k-h
