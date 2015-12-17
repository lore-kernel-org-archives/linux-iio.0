Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-224.synserver.de ([212.40.185.224]:1129 "EHLO
	smtp-out-125.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755660AbbLQOpY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Dec 2015 09:45:24 -0500
Message-ID: <5672CA7F.1030707@metafoo.de>
Date: Thu, 17 Dec 2015 15:45:19 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Phil Reid <preid@electromag.com.au>, linux-iio@vger.kernel.org
Subject: Re: IIO and high speed
References: <5670E151.7000909@electromag.com.au>
In-Reply-To: <5670E151.7000909@electromag.com.au>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/16/2015 04:58 AM, Phil Reid wrote:
> G'day All,
> 
> I'm just enquiring what the status / plans are for the IIO high speed
> interface.
> 
> This code is present in libiio to do zero copy operations using IIO_BLOCK*
> ioctls.
> EG: I get a warning when running iio_readdev about high speed not being
> enabled.
> 
> However corresponding code is not in the mainline kernel, I did find
> something at:
> https://github.com/analogdevicesinc/linux.git
> 
> Or has this line of development been discontinued in favour of another plan.
> It looks to be a few years old.

Phase 1, which is DMA buffer support, of the high-speed support was merged
recently. Phase 2, which is mmap and IOCTL support, will follow soon-ish. It
will see some rework first though, support for multiple data planes,
metadata buffers, etc.

- Lars

