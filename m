Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-152.synserver.de ([212.40.185.152]:1031 "EHLO
	smtp-out-147.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758223Ab2DMJx6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2012 05:53:58 -0400
Message-ID: <4F87F846.20608@metafoo.de>
Date: Fri, 13 Apr 2012 11:56:22 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 00/14 V2] IIO: Kill off IIO_CHAN macro.
References: <1334310180-22170-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1334310180-22170-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/13/2012 11:42 AM, Jonathan Cameron wrote:
> Hi Greg,
> 
> This is clearly out some old cruft.  Arnd warned me it was
> a stupid idea and I didn't listen :(  Anyhow, I've been meanging
> to do this for ages.  Lars-Peter verified the Analog devices
> driver changes and the rest are my drivers so I doubt anyone will
> look at them even if I let this sit for longer.

For what it's worth I actually looked at all of the patches in this series.
But the conversion of your drivers was pretty straight forward and I
couldn't spot any issues. If you want to you can add

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

to patch 6 and 7 of this series.
