Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns1.siteground282.com ([184.154.233.8]:50708 "EHLO
	serv01.siteground282.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbaHCQjZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Aug 2014 12:39:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Sun, 03 Aug 2014 11:39:32 -0500
From: gmane@reliableembeddedsystems.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-iio@vger.kernel.org
Subject: Re: iio A/D converter input to input event subsystem
In-Reply-To: <53DE5898.1040806@kernel.org>
References: <b12ce7f23b622a613c07e9de19ece607@reliableembeddedsystems.com>
 <20140803095610.GQ3214@piout.net>
 <33f1c38a7367710e30956080fa02da8a@reliableembeddedsystems.com>
 <53DE5898.1040806@kernel.org>
Message-ID: <98e9b031c20c4e5f6d428768613e68f8@reliableembeddedsystems.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 2014-08-03 10:43, Jonathan Cameron wrote:
> 
> http://www.spinics.net/lists/linux-iio/msg06881.html (latest version I 
> think).
> The infrastructure for this went in back then, but the input driver
> never quite got the
> attention it needed.

Thanks!

I'll try to have some hardware prototype by end of August and will see 
if I can get my stuff to work as Alexandre suggested.

Ideally I'll try to cook up something similar to your iio_input stuff.

Which mainline kernel version would you suggest?
3.14 or 3.16?

Regards,

Robert


