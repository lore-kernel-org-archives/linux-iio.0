Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:42005 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750930AbbEFSfG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 6 May 2015 14:35:06 -0400
Message-ID: <554A5ED6.3070505@ni.com>
Date: Wed, 06 May 2015 13:35:02 -0500
From: Xander Huff <xander.huff@ni.com>
MIME-Version: 1.0
To: lars@metafoo.de
CC: Jaeden Amero <jaeden.amero@ni.com>, Josh Cartwright <joshc@ni.com>,
	Joseph Hershberger <joseph.hershberger@ni.com>,
	linux-iio@vger.kernel.org
Subject: Re: XADC values read from VAUX0-15 are consistently ~10% less than
 they should be
References: <5549401A.4080800@ni.com>
In-Reply-To: <5549401A.4080800@ni.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/5/2015 5:11 PM, Xander Huff wrote:
> Hi Lars,
>
> I've been working on transitioning one of our hardware devices over from using
> the out-of-tree hwmon driver that Xilinx used to provide to the xadc driver you
> added upstream, but I've been having trouble accessing our connected auxiliary
> channels. I've found that for all channels I've tested, after multiplying the
> raw value by the scale value (0.244140625), the resulting mVs are always about
> 10 percent less than what we expect them to be. (2.9V instead of 3.3V, 5.4V
> instead of 6V, etc.). I'm interested in any tips you may have on how to debug
> this issue.
Nevermind, it turns out I had somehow transcribed the scale value incorrectly 
for my testing. After modifying my test to directly use the scale values from 
our target, the resulting voltages came out as expected

-- 
Xander Huff
Staff Software Engineer
National Instruments
