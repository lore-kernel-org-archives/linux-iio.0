Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:33392 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbbFDHN2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 4 Jun 2015 03:13:28 -0400
Received: by obbea3 with SMTP id ea3so26242732obb.0
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2015 00:13:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55606596.5050804@kernel.org>
References: <1432042622-26703-1-git-send-email-linus.walleij@linaro.org>
	<55606596.5050804@kernel.org>
Date: Thu, 4 Jun 2015 09:13:27 +0200
Message-ID: <CACRpkdYGcin2Y=dJ=-4_ozONwEJwqrLcpcxQfhj1Bi+RxY+3BQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] iio: st_accel: support 8bit channel data
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis CIOCCA <denis.ciocca@st.com>,
	Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, May 23, 2015 at 1:33 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 19/05/15 14:37, Linus Walleij wrote:

>> Some sensors like the LIS331DL only support 8bit data by a single
>> register per axis. These utilize the MSB byte. Make it possible
>> to register these apropriately.
>>
>> A oneliner change is needed in the ST sensors core to handle 8bit
>> reads as this is the first supported 8bit sensor.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Looks good to me.  I'll let these sit for a few days though to
> give Denis and others a chance to check them out before I apply them.

It's been a few days. Ping on this!

Yours,
Linus Walleij
