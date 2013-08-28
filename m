Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qe0-f52.google.com ([209.85.128.52]:43464 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334Ab3H1Pk2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 28 Aug 2013 11:40:28 -0400
Received: by mail-qe0-f52.google.com with SMTP id a11so3566859qen.11
        for <linux-iio@vger.kernel.org>; Wed, 28 Aug 2013 08:40:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHfPSqDYLYDEDqEhd20e4RQP+-ciu+d6MTyOWRi8OHD29dOhSA@mail.gmail.com>
References: <1369031689-23189-1-git-send-email-ch.naveen@samsung.com>
	<CAD=FV=Xppyb+Y0atygnwA8oBHmGHDx7Bit2fN12GX5Tt-Y9H1A@mail.gmail.com>
	<519D3594.4070305@kernel.org>
	<CAHfPSqD0zpR3dRDaH4c3uxHS81vYn6mPyNjCmJ6c-TC1wpZeig@mail.gmail.com>
	<CAHfPSqDYLYDEDqEhd20e4RQP+-ciu+d6MTyOWRi8OHD29dOhSA@mail.gmail.com>
Date: Wed, 28 Aug 2013 08:40:27 -0700
Message-ID: <CAD=FV=V4bGrP58XuL_s2zr_O81iTPNB90MrKengF2JYv5SWi1A@mail.gmail.com>
Subject: Re: [PATCH] iio: exynos_adc: fix wrong structure extration in suspend
 and resume
From: Doug Anderson <dianders@chromium.org>
To: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	linux-iio <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Naveen

On Tue, Aug 27, 2013 at 10:33 PM, Naveen Krishna Ch
<naveenkrishna.ch@gmail.com> wrote:
>> I would like to know any comments on
>>
>> https://patchwork.kernel.org/patch/2513361/
>>
>> Its been pending for a while now.
>>
>> Thanks,
>> Naveen
> Ping
> Any comments please

I assume you're asking for a ping for the _other_ patch (AKA: "Handle
timeout issues"), not the one you're replying to here.

Can you please just do a REPOST of the patch you'd like comments on?

-Doug
