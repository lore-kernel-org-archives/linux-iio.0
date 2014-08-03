Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57953 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbaHCUnu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Aug 2014 16:43:50 -0400
Message-ID: <53DE9F01.8040002@kernel.org>
Date: Sun, 03 Aug 2014 21:43:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: gmane@reliableembeddedsystems.com
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-iio@vger.kernel.org
Subject: Re: iio A/D converter input to input event subsystem
References: <b12ce7f23b622a613c07e9de19ece607@reliableembeddedsystems.com> <20140803095610.GQ3214@piout.net> <33f1c38a7367710e30956080fa02da8a@reliableembeddedsystems.com> <53DE5898.1040806@kernel.org> <98e9b031c20c4e5f6d428768613e68f8@reliableembeddedsystems.com>
In-Reply-To: <98e9b031c20c4e5f6d428768613e68f8@reliableembeddedsystems.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/08/14 17:39, gmane@reliableembeddedsystems.com wrote:
> Hi,
> 
> On 2014-08-03 10:43, Jonathan Cameron wrote:
>>
>> http://www.spinics.net/lists/linux-iio/msg06881.html (latest version I think).
>> The infrastructure for this went in back then, but the input driver
>> never quite got the
>> attention it needed.
> 
> Thanks!
> 
> I'll try to have some hardware prototype by end of August and will see if I can get my stuff to work as Alexandre
> suggested.
> 
> Ideally I'll try to cook up something similar to your iio_input stuff.
> 
> Which mainline kernel version would you suggest?
> 3.14 or 3.16?
Always as recent as possible.  Anything else makes getting support
from anyone tricky as no one can remember how it used to work :)

Jonathan
> 
> Regards,
> 
> Robert
> 
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
