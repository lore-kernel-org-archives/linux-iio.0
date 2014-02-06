Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relaygw4-3.mclink.it ([213.21.178.146]:36796 "EHLO
	relaygw4-3.mclink.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbaBFVIc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2014 16:08:32 -0500
Received: from [195.110.128.82] (HELO smtpoutgw1.mclink.it)
  by relaygw4-3.mclink.it (CommuniGate Pro SMTP 6.0.6)
  with ESMTP id 11342912 for linux-iio@vger.kernel.org; Thu, 06 Feb 2014 21:53:29 +0100
Date: Thu, 6 Feb 2014 21:53:27 +0100
From: Alessandro Rubini <rubini@gnudd.com>
To: lars@metafoo.de
Cc: john3909@gmail.com, linux-iio@vger.kernel.org, broonie@kernel.org,
	flatmax@flatmax.org
Subject: Re: DMA sampling and IIO
Message-ID: <20140206205327.GA11958@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52F35C5B.7080409@metafoo.de>
References: <52F35C5B.7080409@metafoo.de>
  <CF17C5B7.1940A%john3909@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> We do have patches for better integration of DMA (especially for high speed 
> devices) into the IIO framework[1]. This is not yet upstream since it is 
> still a bit WIP, but I'm confident that it will find it's way into upstream 
> soon.

ZIO already supports dma. And mmaping the buffer from user space.  It
is in the design since inception, and in the code since Feb 2012 (git
log says).

/alessandro
