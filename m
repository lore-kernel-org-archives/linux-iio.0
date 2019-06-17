Return-Path: <SRS0=PgFC=UQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D90C31E5B
	for <linux-iio@archiver.kernel.org>; Mon, 17 Jun 2019 20:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A110F20861
	for <linux-iio@archiver.kernel.org>; Mon, 17 Jun 2019 20:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560803696;
	bh=Z1NJ5UeCc+KxraPZOdun6m/DXBK3RAULDdAUZL8nYK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PIEClZIkGPHGXi9kxOHmMBgU7tUzqyg16WCSrZtCV+SenxRYsl2vQlemA1AaLnNFd
	 2mf3fNRVuzCw+ZBIUzG98/GofHZDDEUJ7DNJcUoBi+JUI0dmf1Gl8ha5Ipz+RmWAyS
	 OEznoKLl8mf5uHPGa/k/SdwpAbFFIQA/XTNCVnmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfFQUe4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 17 Jun 2019 16:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfFQUe4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 Jun 2019 16:34:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4791720861;
        Mon, 17 Jun 2019 20:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560803695;
        bh=Z1NJ5UeCc+KxraPZOdun6m/DXBK3RAULDdAUZL8nYK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ITZzE0Nect6hQs90Nz2Oc/1a7p92ji7u0fGSsbKg6HeGncff0CIfJqKWKQHxvcd8Y
         HJftFLMZfcpSYyGdQBGS89AWXbvzZHTbThc4Y6dqfC4K+u8WCpQuLnH27JeKPmWk6F
         YgEkLPDU0/z0ICA0tSHzJQRKsfJqbTV2fTj7cTNI=
Date:   Mon, 17 Jun 2019 22:34:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] Second set of IIO fixes for the 5.2 cycle.
Message-ID: <20190617203453.GA12696@kroah.com>
References: <20190617201049.6a914ae0@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617201049.6a914ae0@archlinux>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 17, 2019 at 08:10:49PM +0100, Jonathan Cameron wrote:
> The following changes since commit e61ff0fba72d981449c90b5299cebb74534b6f7c:
> 
>   staging: kpc2000: Add dependency on MFD_CORE to kconfig symbol 'KPC2000' (2019-05-24 09:41:09 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.2b

Nicer kernel version this time :)

Now pulled and pushed out, thanks.

greg k-h
