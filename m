Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:44387 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab3GBQhr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jul 2013 12:37:47 -0400
Received: by mail-oa0-f49.google.com with SMTP id n9so6620994oag.36
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2013 09:37:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201307021813.18019.marex@denx.de>
References: <1372723722-13902-1-git-send-email-marex@denx.de>
	<201307021403.57543.marex@denx.de>
	<51D2CC68.1080808@free-electrons.com>
	<201307021813.18019.marex@denx.de>
Date: Tue, 2 Jul 2013 13:37:46 -0300
Message-ID: <CAP9ODKoVcH9f-2KMzAbQrfgoFGhz2CU=zJVJu-M8dWcUN4s17w@mail.gmail.com>
Subject: Re: [PATCH] iio: mxs-lradc: Remove useless check in read_raw
From: Otavio Salvador <otavio@ossystems.com.br>
To: Marek Vasut <marex@denx.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jul 2, 2013 at 1:13 PM, Marek Vasut <marex@denx.de> wrote:
> Dear Alexandre Belloni,
>
>> On 02/07/2013 14:03, Marek Vasut wrote:
>> > Dear Alexandre Belloni,
>> >
>> >> Dear Marek,
>> >>
>> >> I don't seem to be hitting that issue. I'm using 3.10rc7. Do you know
>> >> how to reproduce it ?
>> >
>> > The check is just redundant, it's not a bug.
>>
>> Ok, that's what I understood first but then got confused by reports of
>> it solving a bug.
>
> It cannot solve a thing. If it does, then we have a problem.
>
> What kind of bug do you see ? How can I replicate it ? Can you send me a
> testcase?

As I said this code sometimes work. If you put a printf before this
call it sometimes work. So I think we have a race somewhere.

When I were debugging this I found that when it works we have 10
active channels, it seems.

--
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://projetos.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
