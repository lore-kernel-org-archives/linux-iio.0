Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:50211 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755252AbbHCUTZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 3 Aug 2015 16:19:25 -0400
Message-ID: <55BFCC9C.5040305@ni.com>
Date: Mon, 03 Aug 2015 15:18:36 -0500
From: Xander Huff <xander.huff@ni.com>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>, jic23@kernel.org,
	bigeasy@linutronix.de
CC: knaack.h@gmx.de, pmeerw@pmeerw.net, michal.simek@xilinx.com,
	soren.brinkmann@xilinx.com, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	joe.hershberger@ni.com, joshc@ni.com, nathan.sullivan@ni.com,
	jaeden.amero@ni.com
Subject: Re: [PATCH v3] iio: adc: xilinx-xadc: Push interrupts into threaded
 context
References: <CAKfKVtGTO81wLWk50M303t2WjcBEMEt_LUnsJ3_WmvR_3izUjg@mail.gmail.com> <1437434050-32907-1-git-send-email-xander.huff@ni.com> <55B231DE.4080308@metafoo.de>
In-Reply-To: <55B231DE.4080308@metafoo.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 7/24/2015 7:38 AM, Lars-Peter Clausen wrote:
> Hi,
>
> Sorry, but I don't think this patch has been sufficiently tested against a
> mainline kernel. The driver wont even probe the way it is right now.
>
Thanks for your responses. I'm not sure why it doesn't probe for you since I was 
able to do a fair amount of tests with it on our device.

I'll get to work on your suggestions and hopefully having a v4 out sometime next 
week.

-- 
Xander Huff
Staff Software Engineer
National Instruments
