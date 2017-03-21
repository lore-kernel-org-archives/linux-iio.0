Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33703 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932882AbdCUQNd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 12:13:33 -0400
Received: by mail-pg0-f66.google.com with SMTP id 79so17271198pgf.0
        for <linux-iio@vger.kernel.org>; Tue, 21 Mar 2017 09:13:32 -0700 (PDT)
Date: Tue, 21 Mar 2017 09:03:49 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de,
        outreachy-kernel@googlegroups.com, Michael.Hennerich@analog.com,
        lars@metafoo.de, gregkh@linuxfoundation.org,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 0/2] IIO coding tasks
Message-ID: <20170321160348.GA1859@d830.WORKGROUP>
References: <20170321133021.6737-1-arushisinghal19971997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170321133021.6737-1-arushisinghal19971997@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Mar 21, 2017 at 07:00:17PM +0530, Arushi Singhal wrote:
> Patchseries of IIO coding tasks

This wouldn't be a patchset.  Although they touch the same
driver, the changes are unrelated.  See more below...
> 
> Arushi Singhal (2):
>   staging: ad7759: Replace mlock with driver private lock

This one is already been submitted.  If you have a v2 for it, then v2
the original patch.

>   staging: iio: ade7759: Move header content to implementation file

This patch is done and applied already.  See the Coding Task #1 notes
in the IIO Tasks page.

alisons

> 
>  drivers/staging/iio/meter/ade7759.c   | 56 +++++++++++++++++++++++++++++++++--
>  drivers/staging/iio/meter/ade7759.h   | 53 ---------------------------------
>  2 files changed, 54 insertions(+), 57 deletions(-)
> 
> -- 
> 2.11.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170321133021.6737-1-arushisinghal19971997%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
