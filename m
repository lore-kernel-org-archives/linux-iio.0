Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:35726 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752310AbdBJO6T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Feb 2017 09:58:19 -0500
Date: Fri, 10 Feb 2017 15:56:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL] IIO fixes for 4.10 set 3 - a couple of regression fixes.
Message-ID: <20170210145635.GF24594@kroah.com>
References: <3252b6ab-4e4c-449f-974b-b929fbc8b928@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3252b6ab-4e4c-449f-974b-b929fbc8b928@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Feb 05, 2017 at 10:35:02AM +0000, Jonathan Cameron wrote:
> The following changes since commit 5c113b5e0082e90d2e1c7b12e96a7b8cf0623e27:
> 
>   iio: dht11: Use usleep_range instead of msleep for start signal (2017-01-22 13:35:40 +0000)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.10c

It's a bit late for 4.10 for me, can I just pull this into my -next
branch and will they get to 4.10.1 properly?  Meaning, do that have cc:
stable markings on them?  Or do you want to fix that up and resend this
request?

thanks,

greg k-h
