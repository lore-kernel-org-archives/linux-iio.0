Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:57006 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752806AbaGGMX0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 7 Jul 2014 08:23:26 -0400
Message-ID: <53BA91C1.10808@kernel.org>
Date: Mon, 07 Jul 2014 13:25:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis CIOCCA <denis.ciocca@st.com>
CC: Lee Jones <lee.jones@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RESEND PATCH 2/3] iio: st_sensors: add device tree bindings
References: <1404726486-2610-1-git-send-email-linus.walleij@linaro.org> <CACRpkdY+xa6TAOcyEb6ZO37RmshsjmB4WgPD59UPn=WEBnR7nQ@mail.gmail.com>
In-Reply-To: <CACRpkdY+xa6TAOcyEb6ZO37RmshsjmB4WgPD59UPn=WEBnR7nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/07/14 10:52, Linus Walleij wrote:
> On Mon, Jul 7, 2014 at 11:48 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>
>> This adds some basic, simple device tree bindings to the STMicro
>> MEMS sensor drivers.
>>
>> Cc: devicetree@vger.kernel.org
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: Denis CIOCCA <denis.ciocca@st.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> I'd like an indication of if we can merge this thing as I can then merge the
> corresponding device tree changes for Ux500 to the ARM SoC tree.
It's been a while.
No one has commented.
This is pretty obviously good.

Applied to the togreg branch of iio.git - initially pushed out as testing.

Thanks

Jonathan

