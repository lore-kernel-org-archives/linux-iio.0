Return-Path: <SRS0=ud0C=5H=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6651C4332B
	for <linux-iio@archiver.kernel.org>; Sun, 22 Mar 2020 17:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BECA206C3
	for <linux-iio@archiver.kernel.org>; Sun, 22 Mar 2020 17:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584899916;
	bh=T+ytWmZQpGjbAP/os4ys8r0V5Uy2/2QTxKN4sGQ8ZJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VWDfuUDI41Z7wI8eyjpsdMKVRvNhmTWlJjvC0HXn2GCtoOnI3Bp3Wj/8AGS2V4Osd
	 EKLV3ukvGN87FCDLo6KfdmJp0bKOpra222WAKAOu7+rXr3LMKukgSn8/YI4WPzUIzA
	 G+XZpivP/gJNYn7tBPsXAhsJkoYO/qcJI8/hs7G8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgCVR6g (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 22 Mar 2020 13:58:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgCVR6g (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 13:58:36 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DC7D206C3;
        Sun, 22 Mar 2020 17:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584899915;
        bh=T+ytWmZQpGjbAP/os4ys8r0V5Uy2/2QTxKN4sGQ8ZJk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eVSCfN0t+/UVPK+HhohDI2nLzeg40nb9kVvGMwc4Y4EGYqfFAGP4J0/6xpFlV3rGQ
         fb4U7BxavbGYN805zW7ItRdI7BoseRXip+OQhASIH+BCHokPDoTHKTGYQdgSxi9Wwa
         nnWWBkOovHe5RgTETiNhZ9hPAPelqv03iYrDIuLY=
Date:   Sun, 22 Mar 2020 17:58:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Syed Nayyar Waris <syednwaris@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] counter: 104-quad-8: Add lock guards - generic
 interface
Message-ID: <20200322175831.74e10aa7@archlinux>
In-Reply-To: <20200318020506.GA45571@icarus>
References: <20200316124929.GA389@syed.domain.name>
        <20200318020506.GA45571@icarus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Mar 2020 22:14:49 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Mon, Mar 16, 2020 at 06:19:30PM +0530, Syed Nayyar Waris wrote:
> > Add lock protection from race conditions to 104-quad-8 counter driver
> > generic interface code changes. Mutex calls used for protection.
> > 
> > Fixes: f1d8a071d45b ("counter: 104-quad-8: Add Generic Counter interface
> > support")
> > 
> > Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> > ---
> > Changes in v5:
> >  - Change spin lock calls to mutex lock calls
> >  - Modify the title description.  
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Looks good.  I'm not sure right now which tree I'll take this through
(depends on whether it looks like we'll get an rc8 and hence I can sneak
it in for the coming merge window or not).

So poke me if I seem to have forgotten to apply this in a week or so.

Thanks,

Jonathan
