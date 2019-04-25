Return-Path: <SRS0=ujoz=S3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E94C10F03
	for <linux-iio@archiver.kernel.org>; Thu, 25 Apr 2019 09:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0727120878
	for <linux-iio@archiver.kernel.org>; Thu, 25 Apr 2019 09:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556183407;
	bh=gGjc7pZtdjkA/AD1M5+O35Mg+Ighcvz2I+4wRaRtN1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K84P+nkkG0FBkMLbY4OjvxNb/iG9XpgAdFag87gj3slTtNm+Rr1F8OUq+TCPZ0sY8
	 t9CKcD415jZv9qannW4TVAMKYaIB6hL64JO8TEyTf2RCsZBJ7mKDrdcujHdkEAeLS/
	 pPDmtL1z526Jh017QsEgJ8ng/2/YWAb/42EQnntM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbfDYJKG (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfDYJKG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 25 Apr 2019 05:10:06 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4960020878;
        Thu, 25 Apr 2019 09:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556183405;
        bh=gGjc7pZtdjkA/AD1M5+O35Mg+Ighcvz2I+4wRaRtN1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1f4vlFW7vnnTyTQHWbVtgY+6e1mlsd8LP/LQZ+amIubVHZFkpVhzvjYFHUehR2qwe
         zt71Cu4tXw7t34ITQH+dVhd2pC/be8kWVjtxmA22+SdDYo382HzjO5rZCGwqGvk/ep
         EvV5ChavYqgCgjhoLoxPc0WJRR+wNFlMTZxGknRc=
Date:   Thu, 25 Apr 2019 11:10:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] Second round of new device support etc for IIO in the 5.2
 cycle.
Message-ID: <20190425091003.GA8238@kroah.com>
References: <20190424204931.04005591@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424204931.04005591@archlinux>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 24, 2019 at 08:49:31PM +0100, Jonathan Cameron wrote:
> The following changes since commit 932f98922f6fca9f8c45274346b49058dd50d51a:
> 
>   Merge tag 'iio-for-5.2a-2' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2019-04-04 22:25:29 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.2b

Pulled and pushed out, thanks.

greg k-h
