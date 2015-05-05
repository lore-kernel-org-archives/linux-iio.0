Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:34726 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751177AbbEEWLm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 May 2015 18:11:42 -0400
Message-ID: <5549401A.4080800@ni.com>
Date: Tue, 05 May 2015 17:11:38 -0500
From: Xander Huff <xander.huff@ni.com>
MIME-Version: 1.0
To: lars@metafoo.de
CC: Jaeden Amero <jaeden.amero@ni.com>, Josh Cartwright <joshc@ni.com>,
	Joseph Hershberger <joseph.hershberger@ni.com>,
	linux-iio@vger.kernel.org
Subject: XADC values read from VAUX0-15 are consistently ~10% less than they
 should be
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Lars,

I've been working on transitioning one of our hardware devices over from using 
the out-of-tree hwmon driver that Xilinx used to provide to the xadc driver you 
added upstream, but I've been having trouble accessing our connected auxiliary 
channels. I've found that for all channels I've tested, after multiplying the 
raw value by the scale value (0.244140625), the resulting mVs are always about 
10 percent less than what we expect them to be. (2.9V instead of 3.3V, 5.4V 
instead of 6V, etc.). I'm interested in any tips you may have on how to debug 
this issue.

Thanks!

--
Xander Huff
Staff Software Engineer
National Instruments
