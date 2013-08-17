Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:53867 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752148Ab3HQJxd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 17 Aug 2013 05:53:33 -0400
Message-ID: <520F4828.90300@metafoo.de>
Date: Sat, 17 Aug 2013 11:53:44 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Oliver King-Smith <oliverks@elementalsemi.com>
CC: linux-iio@vger.kernel.org, Dragos Bogdan <Dragos.Bogdan@analog.com>
Subject: Re: DTS Support for AD7192
References: <95643F3C-C453-45AE-87B6-0D7D0096EA89@elementalsemi.com>
In-Reply-To: <95643F3C-C453-45AE-87B6-0D7D0096EA89@elementalsemi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/14/2013 09:25 AM, Oliver King-Smith wrote:
> Hello,
>
> I am trying to bring up an AD7192 under the new IIO standard in linux.  I am using the 3.8 version of the kernel on a BeagleBone black.  I am having trouble understand the devices tree structure for industrial IO.
[...]

There is nothing special that needs to be done for IIO devices for devicetree, 
but the driver currently does not support devicetree. But I think Dragos has a 
patch adding dt support to the driver.

- Lars

