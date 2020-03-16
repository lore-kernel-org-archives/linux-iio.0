Return-Path: <SRS0=e0QT=5B=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19241C0044D
	for <linux-iio@archiver.kernel.org>; Mon, 16 Mar 2020 16:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C608020679
	for <linux-iio@archiver.kernel.org>; Mon, 16 Mar 2020 16:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="kF+76w+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732030AbgCPQU1 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:20:27 -0400
Received: from onstation.org ([52.200.56.107]:41414 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732011AbgCPQU1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Mar 2020 12:20:27 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 790173E9F8;
        Mon, 16 Mar 2020 16:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1584375626;
        bh=HkHcO6dlYtdIjG3i9gGYpV+CJ3ZiBqfycIVzDQRtYdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kF+76w+F8PLSCwPHN0tKqP2gSyXGWVb3MjQq/yqRNUxdsNyiz/9E+l6aks925k96C
         j1N5JXiWNaLRJ3bYa7ahjVRUs3lvqTdXbcG2xpUWj5nZdideAU+bMIbNxM4UefunCC
         A1xLODhPKsCgP1GtVp2cBeX+VbWgs50UraqnwK7s=
Date:   Mon, 16 Mar 2020 12:20:26 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: tsl2772: Use scnprintf() for avoiding
 potential buffer overflow
Message-ID: <20200316162026.GB1526@onstation.org>
References: <20200316124941.8010-1-tiwai@suse.de>
 <20200316124941.8010-3-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316124941.8010-3-tiwai@suse.de>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 16, 2020 at 01:49:41PM +0100, Takashi Iwai wrote:
> snprintf() is a hard-to-use function, it's especially difficult to use
> it for concatenating substrings in a buffer with a limited size.
> Since snprintf() returns the would-be-output size, not the actual
> size, the subsequent use of snprintf() may go beyond the given limit
> easily.  Although the current code doesn't actually overflow the
> buffer, it's an incorrect usage.
> 
> This patch replaces such snprintf() calls with a safer version,
> scnprintf().
> 
> Also this fixes the incorrect argument of the buffer limit size passed
> to snprintf(), too.  The size has to be decremented for the remaining
> length.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Brian Masney <masneyb@onstation.org>
