Return-Path: <SRS0=Ogni=7F=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE4DC433E0
	for <linux-iio@archiver.kernel.org>; Sat, 23 May 2020 08:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41BF1206C3
	for <linux-iio@archiver.kernel.org>; Sat, 23 May 2020 08:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590223317;
	bh=dxlY0IEO/cs0s9sH92Pnng2mx/muyjDU0TbxQU6ypJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HLp0zY5qlyvnx5nLtL/hwyac0l/cg5iqWnDrKERPQePgPvPIN0apvq4hskQeLDrE6
	 aA1cqpRb29dSLSGSudQX9/hwi1fPsbPgIksR/YlwiTJAvuo9UNHLGVxyoCWCmMBBhD
	 tjojowA9kyD3F5GMXsxjaSOLTRZ4CF3XMgli3RsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387500AbgEWIl4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 23 May 2020 04:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387471AbgEWIl4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 May 2020 04:41:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93706206C3;
        Sat, 23 May 2020 08:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590223315;
        bh=dxlY0IEO/cs0s9sH92Pnng2mx/muyjDU0TbxQU6ypJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KWTHnakJtkifXfrYqe6yzf/0uU2kyK0Sj87mwt20HyF5Qk3H7lJ5MI/U/n2hgwIe7
         h0qDx2YJ4wOuHvkN9vcBips5/Y9u5BV+TRivFOUkn30DfxK+GtTbxbFq1BzMz/LEkm
         gSTlbbMJzFpF3SOHZgqdqkkL47fAFtRqR+45Ub8A=
Date:   Sat, 23 May 2020 10:41:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 3rd set of new devices, cleanups and late breaking minor
 fixes for IIO in the 5.8 cycle.
Message-ID: <20200523084124.GA3450090@kroah.com>
References: <20200522175931.1d91d3e4@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522175931.1d91d3e4@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 22, 2020 at 05:59:31PM +0100, Jonathan Cameron wrote:
> 
> he following changes since commit cef077e6aa4c7dbe2f23e1201cf705f9540ec467:
> 
>   Merge tag 'iio-for-5.8b' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2020-05-15 16:03:28 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.8c

Pulled and pushed out, thanks.

greg k-h
