Return-Path: <SRS0=gFHn=OW=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE31C65BAE
	for <linux-iio@archiver.kernel.org>; Thu, 13 Dec 2018 12:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9A02086D
	for <linux-iio@archiver.kernel.org>; Thu, 13 Dec 2018 12:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544704684;
	bh=LGrekOKBZpCqjAAKmzezbO6zWNlu5HpLk6BaIFIZbiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1ooLik7CRVPmD/G5oiBpZ+S9O5AJAEuvlPt/DGJQUyCXDKgmJzA4wXON2Hnwha2om
	 LJ9yaz8jizOb40bcCTPIMhfqLhLVVFLV2F646j7fHsKo/Pa6bgOHM+v5hmp7Wov2HR
	 plM+j17uQQon0FAa6py6pal0O527otj/HjLQxorY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9A02086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbeLMMiD (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:38:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728517AbeLMMiD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 Dec 2018 07:38:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C28C2086D;
        Thu, 13 Dec 2018 12:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544704682;
        bh=LGrekOKBZpCqjAAKmzezbO6zWNlu5HpLk6BaIFIZbiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q7+VwOWnkwxx8eHZng2ghW4RoBr9qsYjh4PDhHteIrF7w3JLzMxxxYknvblZcLe6O
         ot8gZ0ikcNC9lGwbGiDejBp+zbaYRhnqlwGOQdG2rsK362iN2nx+1JoF6fyYAyBBqS
         rCYH0VvIP9hqMX6zXcBs60Ni+q4ff8R+XhHfnlkc=
Date:   Thu, 13 Dec 2018 13:38:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] Second set of IIO new device support, features, cleanups
 and minor fixes for 4.21
Message-ID: <20181213123800.GA20099@kroah.com>
References: <20181212183242.27562340@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212183242.27562340@archlinux>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 12, 2018 at 06:32:42PM +0000, Jonathan Cameron wrote:
> The following changes since commit 16c44c57ecd89402a1acc81617cff463ff446fe7:
> 
>   staging: vboxvideo: Rename uint32_t type to u32 (2018-11-23 10:58:47 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.21b

Now pulled and pushed out, thanks.

greg k-h
