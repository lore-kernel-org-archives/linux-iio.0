Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9071DC433DB
	for <linux-iio@archiver.kernel.org>; Wed, 24 Mar 2021 12:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6531861A06
	for <linux-iio@archiver.kernel.org>; Wed, 24 Mar 2021 12:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhCXMcZ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 24 Mar 2021 08:32:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232025AbhCXMcO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 Mar 2021 08:32:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F240F61A06;
        Wed, 24 Mar 2021 12:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616589133;
        bh=i8iOv6zeUzr2zVunQQp+80MftgIqQF+AhyG1xG99Zzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HWZpPh4cdjEKwfBkmxQ+2v+YpBoV7B4Y3koR/Jbe0x/LXPeCXkJpN5ZaNLpH92gqN
         WXxA6vvmHV8gcTgp+KdAgjErTrEdhivJsBLfxnKONNRnwbn+dhTUyPOyzcm/VujDLD
         a3fIMB1GXR5JXh+Cd/Md6D8zQsh9z7dYwFiL509U=
Date:   Wed, 24 Mar 2021 13:32:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Swen Kalski <kalski.swen@gmail.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH] Add early return to Method because the else can be
 ignored.
Message-ID: <YFsxSyoTUAeRZtH0@kroah.com>
References: <20210324122050.GA28987@kernel-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324122050.GA28987@kernel-dev>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 24, 2021 at 01:20:50PM +0100, Swen Kalski wrote:
> ---
>  drivers/staging/comedi/comedi_buf.c | 56 ++++++++++++++---------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
