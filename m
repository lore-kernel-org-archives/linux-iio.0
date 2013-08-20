Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db8lp0188.outbound.messaging.microsoft.com ([213.199.154.188]:37905
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750962Ab3HTNLt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 20 Aug 2013 09:11:49 -0400
From: "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Oliver King-Smith <oliverks@elementalsemi.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: DTS Support for AD7192
Date: Tue, 20 Aug 2013 13:10:33 +0000
Message-ID: <6067964B99C6A049AA5840B6F7BB2D0A0299F4@NWD2MBX6.ad.analog.com>
References: <95643F3C-C453-45AE-87B6-0D7D0096EA89@elementalsemi.com>,<520F4828.90300@metafoo.de>
In-Reply-To: <520F4828.90300@metafoo.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Oliver,

Unfortunately, these days I'm out of office, so I will publish the devicetree support patch just next week. I will let you know.

Regards,
Dragos
________________________________________
From: Lars-Peter Clausen [lars@metafoo.de]
Sent: Saturday, August 17, 2013 12:53 PM
To: Oliver King-Smith
Cc: linux-iio@vger.kernel.org; Bogdan, Dragos
Subject: Re: DTS Support for AD7192

On 08/14/2013 09:25 AM, Oliver King-Smith wrote:
> Hello,
>
> I am trying to bring up an AD7192 under the new IIO standard in linux.  I am using the 3.8 version of the kernel on a BeagleBone black.  I am having trouble understand the devices tree structure for industrial IO.
[...]

There is nothing special that needs to be done for IIO devices for devicetree,
but the driver currently does not support devicetree. But I think Dragos has a
patch adding dt support to the driver.

- Lars



