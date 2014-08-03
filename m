Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns1.siteground282.com ([184.154.233.8]:42524 "EHLO
	serv01.siteground282.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbaHCPIW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Aug 2014 11:08:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Sun, 03 Aug 2014 10:08:29 -0500
From: gmane@reliableembeddedsystems.com
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: iio A/D converter input to input event subsystem
In-Reply-To: <20140803095610.GQ3214@piout.net>
References: <b12ce7f23b622a613c07e9de19ece607@reliableembeddedsystems.com>
 <20140803095610.GQ3214@piout.net>
Message-ID: <33f1c38a7367710e30956080fa02da8a@reliableembeddedsystems.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 2014-08-03 04:56, Alexandre Belloni wrote:
> Hi Robert,

> 
> Did you have a look at uinput? This would allow you to inject input
> events after processing the ADC values in userspace.
> 
> Simple example: http://thiemonge.org/getting-started-with-uinput

Thanks this looks interesting. I had in the meantime a look at iio_hwmon 
[1] which does something similar to what I want for the hwmon subsystem 
instead of the input event subsystem.

Regards,

Robert

[1] 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/hwmon/iio_hwmon.c?id=refs/tags/v3.16-rc7
