Return-Path: <SRS0=l2Gr=5D=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C71C10DCE
	for <linux-iio@archiver.kernel.org>; Wed, 18 Mar 2020 10:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDB12077B
	for <linux-iio@archiver.kernel.org>; Wed, 18 Mar 2020 10:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584527091;
	bh=lfwlt6PH0qm1ps1CyVn07BdEnkCDCRSdD4sk09EokhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NtN3JNCUb1EtcjBqHmMQY7nKohRA0HOaessHOdcP6SWWbbNZzf0GooWRiRStsHn9S
	 ns1pbMN7wVy8QEkF2W0PPVPdF2uWffFeELeBqSg/VBWcM6f2jtaCNY6wGh5bFmMxAe
	 k1F+e1vtUfLKTIZ8CU9vO+yJxUDgzW+9KG05ew+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgCRKYu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:24:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgCRKYu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 18 Mar 2020 06:24:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18E1D2077C;
        Wed, 18 Mar 2020 10:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584527089;
        bh=lfwlt6PH0qm1ps1CyVn07BdEnkCDCRSdD4sk09EokhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QwF4KG//4XoESnGfV3asUZHPb6hK3saDB74SgUW1QmIpR2jLwVX41U+7iROe25+0G
         Pmc84Dzyu7gKHkyqYSgkSh/+lwt3iYkpA0cBkUdepA42jhutj/7+w6Hmh34sb3Ib0+
         XllTJBj0swhhRTS5hsNdbhh3tq2eOEFve4Fqkeow=
Date:   Wed, 18 Mar 2020 11:24:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of IIO fixes for the 5.6 cycle
Message-ID: <20200318102433.GB2126918@kroah.com>
References: <20200308170941.6d3b36ab@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308170941.6d3b36ab@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 08, 2020 at 05:09:41PM +0000, Jonathan Cameron wrote:
> The following changes since commit 39bed42de2e7d74686a2d5a45638d6a5d7e7d473:
> 
>   Merge tag 'for-linus-hmm' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2020-01-29 19:56:50 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.6a

Sorry for the delay, now pulled and pushed out.

greg k-h
