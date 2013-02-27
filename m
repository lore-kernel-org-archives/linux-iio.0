Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-148.synserver.de ([212.40.185.148]:1100 "EHLO
	smtp-out-148.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab3B0QFi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 11:05:38 -0500
Message-ID: <512E2F31.8000604@metafoo.de>
Date: Wed, 27 Feb 2013 17:07:13 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Chris Micali <chrismicali@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: IIO Drivers
References: <26387F1A648A4D3D9BB4142C4F0AAE98@gmail.com>
In-Reply-To: <26387F1A648A4D3D9BB4142C4F0AAE98@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/26/2013 08:56 PM, Chris Micali wrote:
> Hello Lars,
> 
> I'm doing a bit of hacking on a IIO driver based on some of your drivers on a 3.8 kernel (specifically writing a driver for a TI SPI adc.)  I've been able to get a driver up and working such that I can read directly from the in_voltage0_raw on sysfs and get the correct values but I can't seem to get buffered access working (via iio_cmdsrv.)  I've had a hard time finding any docs on this stuff and I was wondering if you could give me any pointers on where to look or who else perhaps to ask about this stuff?  Any pointers would be very much appreciated!
> 
> Thanks,
> Chris

Hi,

I'm afraid except for the the documentation in
drivers/staging/iio/Documentation/, the kernel doc comments and the skeleton
driver (drivers/staging/iio/iio_simple_dummy*) there is not much additional
documentation available.

The general place to ask questions about IIO is the IIO mailinglist. I've
put it on CC, hope you don't mind.

I think we can help you best if you post your code.

- Lars
