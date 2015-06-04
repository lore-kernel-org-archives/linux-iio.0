Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52859 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751773AbbFDHOo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 4 Jun 2015 03:14:44 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>
Date: Thu, 4 Jun 2015 09:14:21 +0200
Subject: Re: [PATCH 1/2 v2] iio: st_accel: support 8bit channel data
Message-ID: <AD0852EA-9390-4EC9-A46B-F9FA18CD72D3@st.com>
References: <1432042622-26703-1-git-send-email-linus.walleij@linaro.org>
 <55606596.5050804@kernel.org>
 <CACRpkdYGcin2Y=dJ=-4_ozONwEJwqrLcpcxQfhj1Bi+RxY+3BQ@mail.gmail.com>
In-Reply-To: <CACRpkdYGcin2Y=dJ=-4_ozONwEJwqrLcpcxQfhj1Bi+RxY+3BQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Sorry I checked but forget to answer...for me it is ok!

Acked.

Denis


> On Jun 4, 2015, at 15:13, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
>> On Sat, May 23, 2015 at 1:33 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 19/05/15 14:37, Linus Walleij wrote:
> 
>>> Some sensors like the LIS331DL only support 8bit data by a single
>>> register per axis. These utilize the MSB byte. Make it possible
>>> to register these apropriately.
>>> 
>>> A oneliner change is needed in the ST sensors core to handle 8bit
>>> reads as this is the first supported 8bit sensor.
>>> 
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> 
>> Looks good to me.  I'll let these sit for a few days though to
>> give Denis and others a chance to check them out before I apply them.
> 
> It's been a few days. Ping on this!
> 
> Yours,
> Linus Walleij
