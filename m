Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33411 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965838Ab2EPUaH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 May 2012 16:30:07 -0400
Received: by dady13 with SMTP id y13so1464908dad.19
        for <linux-iio@vger.kernel.org>; Wed, 16 May 2012 13:30:06 -0700 (PDT)
Date: Wed, 16 May 2012 13:29:59 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/9] staging: iio: rework sampling rate setting in hmc5843
Message-ID: <20120516202959.GA32210@kroah.com>
References: <1337185331-26616-1-git-send-email-pmeerw@pmeerw.net>
 <1337185331-26616-5-git-send-email-pmeerw@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337185331-26616-5-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, May 16, 2012 at 06:22:06PM +0200, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/magnetometer/hmc5843.c |   51 +++++++++++++---------------
>  1 files changed, 24 insertions(+), 27 deletions(-)

I don't know what tree you made these against, but there is fuzz and I
can't apply it.  I was able to resolve the first 3 patches, but here's
where it got messier.

Please rebase the rest of these patches on the staging-next branch and
resend them so that I can properly apply them.

thansk,

greg k-h
