Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:34952 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbcDOKwH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Apr 2016 06:52:07 -0400
Message-ID: <5710BE85.10403@denx.de>
Date: Fri, 15 Apr 2016 12:12:21 +0200
From: Marek Vasut <marex@denx.de>
MIME-Version: 1.0
To: Juergen Borleis <jbe@pengutronix.de>,
	Stefan Wahren <stefan.wahren@i2se.com>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFT 3/5] iio: mxs-lradc: move STMP reset out of ADC init
References: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com> <1460648909-2657-4-git-send-email-stefan.wahren@i2se.com> <201604150848.44242.jbe@pengutronix.de>
In-Reply-To: <201604150848.44242.jbe@pengutronix.de>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/15/2016 08:48 AM, Juergen Borleis wrote:
> Hi Stefan,
> 
> On Thursday 14 April 2016 17:48:27 Stefan Wahren wrote:
>> This patch moves the STMP reset out of ADC init function
>> in order to make it never fail. This is also necessary
>> for PM ops.
> 
> What do you mean with "make it never fail"?

He wants to make the function invoke only functions which don't return
error value. Not a great wording, but the patch makes it clear.

>> [...]
> 
> jb
> 


-- 
Best regards,
Marek Vasut
