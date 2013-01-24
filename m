Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:56844 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554Ab3AXAm6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Jan 2013 19:42:58 -0500
Received: by mail-la0-f43.google.com with SMTP id ek20so1388505lab.2
        for <linux-iio@vger.kernel.org>; Wed, 23 Jan 2013 16:42:57 -0800 (PST)
Received: by mail-lb0-f180.google.com with SMTP id q12so1570227lbc.11
        for <linux-iio@vger.kernel.org>; Wed, 23 Jan 2013 16:42:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50FFDD2A.9040102@metafoo.de>
References: <1358775470-21278-1-git-send-email-ch.naveen@samsung.com>
	<1358917086-4148-1-git-send-email-ch.naveen@samsung.com>
	<50FFDD2A.9040102@metafoo.de>
Date: Wed, 23 Jan 2013 16:42:54 -0800
Message-ID: <CAD=FV=VgrpPSLrwwrzFDFLBXTw+-t3C=UwnS6b53o41hxM_AyQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: add exynos5 adc driver under iio framwork
From: Doug Anderson <dianders@chromium.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	linux-iio@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-samsung-soc@vger.kernel.org, gregkh@linuxfoundation.org,
	Naveen Krishna <naveenkrishna.ch@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Lars,

On Wed, Jan 23, 2013 at 4:52 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> Few doubts regarding the mappings and child device handling.
>> Kindly, suggest me better methods.
>
> The patch looks mostly good now. As for the mappings, the problem is that we
> currently do not have any device tree bindings for IIO. So a proper solution
> would be to add dt bindings for IIO.

Can you explain more how you think this would work?  It seems like
just having child nodes as platform drivers would be OK (to me) and
having them instantiated with of_platform_populate() seems reasonable.

...but the one thing that is missing is a way for children to get
access to the channel properly.

The children have access to the ADC "struct device" (it is their
parent device) and have a channel number (their "reg" field), but
there is no API call to map this to a "struct iio_channel".  Is that
all that's needed in this case?  ...or are you envisioning something
more?


Thanks!  :)


-Doug
