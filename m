Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52921 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbcDQKYJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Apr 2016 06:24:09 -0400
Subject: Re: [PATCH RFT 3/5] iio: mxs-lradc: move STMP reset out of ADC init
To: Marek Vasut <marex@denx.de>, Juergen Borleis <jbe@pengutronix.de>,
	Stefan Wahren <stefan.wahren@i2se.com>
References: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com>
 <1460648909-2657-4-git-send-email-stefan.wahren@i2se.com>
 <201604150848.44242.jbe@pengutronix.de> <5710BE85.10403@denx.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <57136444.2010002@kernel.org>
Date: Sun, 17 Apr 2016 11:24:04 +0100
MIME-Version: 1.0
In-Reply-To: <5710BE85.10403@denx.de>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/04/16 11:12, Marek Vasut wrote:
> On 04/15/2016 08:48 AM, Juergen Borleis wrote:
>> Hi Stefan,
>>
>> On Thursday 14 April 2016 17:48:27 Stefan Wahren wrote:
>>> This patch moves the STMP reset out of ADC init function
>>> in order to make it never fail. This is also necessary
>>> for PM ops.
>>
>> What do you mean with "make it never fail"?
> 
> He wants to make the function invoke only functions which don't return
> error value. Not a great wording, but the patch makes it clear.
I've reworded to make this a little clearer and applied it to the togreg branch
of iio.git initially pushed out as testing for the autobuilders
to play with it (also giving time for any more comments on it to come through)

Jonathan
> 
>>> [...]
>>
>> jb
>>
> 
> 

