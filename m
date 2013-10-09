Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:38932 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704Ab3JIMb3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Oct 2013 08:31:29 -0400
Received: by mail-wg0-f49.google.com with SMTP id l18so823414wgh.16
        for <linux-iio@vger.kernel.org>; Wed, 09 Oct 2013 05:31:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5254F9B8.8080205@metafoo.de>
References: <1381263410-29849-1-git-send-email-festevam@gmail.com>
	<5254F9B8.8080205@metafoo.de>
Date: Wed, 9 Oct 2013 09:31:26 -0300
Message-ID: <CAOMZO5Cd3JqEWwgNK-kGf4Nq0aNWmvf_X+KR9bM99yVxXRYUQw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Move mxs-lradc out of staging
From: Fabio Estevam <festevam@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Juergen Beisert <jbe@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Oct 9, 2013 at 3:37 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 10/08/2013 10:16 PM, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> There have been some discussions [1] about removing this driver out of staging,
>> so let's do it now.
>>
>> [1] http://www.spinics.net/lists/linux-iio/msg10091.html
>>
>
> What about the TODO[1] entry that was recently added?

Good catch.

Would it be acceptable if I move the mxs TODO text into mxs-lradc.c?

Regards,

Fabio Estevam
