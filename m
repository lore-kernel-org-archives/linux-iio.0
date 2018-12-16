Return-Path: <SRS0=diYI=OZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F9EC43387
	for <linux-iio@archiver.kernel.org>; Sun, 16 Dec 2018 12:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9123C21839
	for <linux-iio@archiver.kernel.org>; Sun, 16 Dec 2018 12:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544963639;
	bh=n/gquyyMU0Uz36e30wWrlGqmlyK4rJl8ZQeM46SxeEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=N20G6k0bqOB59cXeJZujGTKzot54TQsKWHdtmejLtLBuLQEhN3+QSK2lXZEuyXPk1
	 5DcxD8QKUInpIqgbRDJhJa7uVyRuZUg4VxL5x4UHhuqT6wN7Dnfjka0qGYCvO5m7ac
	 8VzYe3tBeh0h9C8cZLIxVpkxTwK+ftQn9vZ7O8gk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbeLPMd7 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 16 Dec 2018 07:33:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730316AbeLPMd6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Dec 2018 07:33:58 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4BE3217F9;
        Sun, 16 Dec 2018 12:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544963638;
        bh=n/gquyyMU0Uz36e30wWrlGqmlyK4rJl8ZQeM46SxeEw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HZhUPtYRT8TDut0YTP8kHr/yFyguU8i6rf6PUjH0m6JKGKA7vkc6oYVhjS6sZEJL5
         j9rqDdbGLi0V0+I6AWa63p1XpZckADb3aMMQaC6RdLqwCzwdvdGlgfcku/+5YyzP/O
         q7Kkpm5vjqfRhnrOm9N5bIqFWuKbiNX2KZ3edL5c=
Date:   Sun, 16 Dec 2018 12:33:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Slawomir Stepien <sst@poczta.fm>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/2] staging: iio: adc: ad7280a: split
 ad7280_channel_init() to more functions
Message-ID: <20181216123353.5fc52d21@archlinux>
In-Reply-To: <20181212171906.GB1738@t480s.localdomain>
References: <20181212170228.28498-1-sst@poczta.fm>
        <20181212170228.28498-2-sst@poczta.fm>
        <20181212171906.GB1738@t480s.localdomain>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 Dec 2018 18:19:06 +0100
Slawomir Stepien <sst@poczta.fm> wrote:

> On gru 12, 2018 18:02, Slawomir Stepien wrote:
> > The ad7280_channel_init function has been split into more specific
> > functions to increase the code readability.
> > 
> > The setting of channel's scan_type.shift to 0, has been removed, since
> > it is the default value.
> > 
> > Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> > ---
> > Since v1:
> > * Added ad7280_init_dev_channels function.
> > * New functions are now using struct iio_chan_spec rather than struct
> >   ad7280_state.
> > * Channel's number on device calculation has been moved to macros.
> > * scan_type.shift assigned has been removed.
> > ---  
> 
> Sorry about not marking this as v2 in the subject line :( I'll fix that on next
> version (if that happens ;)).
> 
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to see if they can break it.

Thanks,

Jonathan


