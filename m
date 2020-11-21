Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF80EC63697
	for <linux-iio@archiver.kernel.org>; Sat, 21 Nov 2020 16:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CCE1221FE
	for <linux-iio@archiver.kernel.org>; Sat, 21 Nov 2020 16:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0Kk8Hmw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgKUQMu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 21 Nov 2020 11:12:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgKUQMu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 11:12:50 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7B1E221FE;
        Sat, 21 Nov 2020 16:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605975169;
        bh=7x4wYtSNBetxkPol30ZM+1YynRxA8tU15vwM+Silb4g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y0Kk8HmwJMHTfFXwSskpSBoR5vThGc5yJ3yCpiMGDw9jQmwm+RkIEOsYmFswRUNrj
         rfbzpycL+FPYbAitfgA57OWYjBxH9r37XqjPh7c9KdgAxlBKe/TxJlgHqA9KrMkc4Q
         UcyEbKVO+47goqGNZ5uuo34gdpwjUwjIQ2/g4Njw=
Date:   Sat, 21 Nov 2020 16:12:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Christian Eggers <ceggers@arri.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: hrtimer-trigger: Mark hrtimer to expire in
 hard interrupt context
Message-ID: <20201121161245.4f8a8a41@archlinux>
In-Reply-To: <20201117130301.724ybjgrqdlgfpxq@linutronix.de>
References: <20201117103751.16131-1-lars@metafoo.de>
        <20201117130301.724ybjgrqdlgfpxq@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Nov 2020 14:03:01 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2020-11-17 11:37:50 [+0100], Lars-Peter Clausen wrote:
> > On PREEMPT_RT enabled kernels unmarked hrtimers are moved into soft
> > interrupt expiry mode by default.
> > 
> > The IIO hrtimer-trigger needs to run in hard interrupt context since it
> > will end up calling generic_handle_irq() which has the requirement to run
> > in hard interrupt context.
> > 
> > Explicitly specify that the timer needs to run in hard interrupt context by
> > using the HRTIMER_MODE_REL_HARD flag.
> > 
> > Fixes: f5c2f0215e36 ("hrtimer: Move unmarked hrtimers to soft interrupt expiry on RT")
> > Reported-by: Christian Eggers <ceggers@arri.de>
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>  
> 
> If I remember correctly, this routine should only be used to poll the
> primary handler. There were patches for the "other" possible things that
> might happen so
> 
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
I've applied them both to the fixes-togreg branch fo iio.git but not
marked them for stable. If you want them in specific stable releases
then please request them explicitly after they've merged.

Thanks,

Jonathan

> 
> for both.
> 
> Sebastian

