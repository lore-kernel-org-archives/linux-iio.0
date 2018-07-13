Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:54545 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbeGMHiY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Jul 2018 03:38:24 -0400
Received: by mail-it0-f65.google.com with SMTP id s7-v6so10293983itb.4
        for <linux-iio@vger.kernel.org>; Fri, 13 Jul 2018 00:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180710144737.1136856-1-arnd@arndb.de>
In-Reply-To: <20180710144737.1136856-1-arnd@arndb.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 13 Jul 2018 09:24:52 +0200
Message-ID: <CACRpkdY5oMG0WknSEnG1khTTm_UKwWwdAbAthA54geGhqgyXpQ@mail.gmail.com>
Subject: Re: [PATCH] [v2] Documentation: document ktime_get_*() APIs
To: Arnd Bergmann <arnd@arndb.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Cc: Randy Dunlap <rdunlap@infradead.org>, david@fromorbit.com,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, willy@infradead.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jul 10, 2018 at 4:48 PM Arnd Bergmann <arnd@arndb.de> wrote:

> As Dave Chinner points out, we don't have a proper documentation for the
> ktime_get() family of interfaces, making it rather unclear which of the
> over 30 (!) interfaces one should actually use in a driver or elsewhere
> in the kernel.
>
> I wrote up an explanation from how I personally see the interfaces,
> documenting what each of the functions do and hopefully making it a bit
> clearer which should be used where.
>
> This is the first time I tried writing .rst format documentation, so
> in addition to any mistakes in the content, I probably also introduce
> nonstandard formatting ;-)
>
> I first tried to add an extra section to
> Documentation/timers/timekeeping.txt, but this is currently not included
> in the generated API, and it seems useful to have the API docs as part
> of what gets generated in
> https://www.kernel.org/doc/html/latest/core-api/index.html#core-utilities
> instead, so I started a new file there.
>
> I also considered adding the documentation inline in the
> include/linux/timekeeping.h header, but couldn't figure out how to do
> that in a way that would result both in helpful inline comments as
> well as readable html output, so I settled for the latter, with
> a small note pointing to it from the header.
>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: minor changes suggested by Randy

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

This brings into question commit bc2b7dab629a5
"iio:core: timestamping clock selection support"
that has bothered me for some time. Now that is ABI, but
we might be able to do some recommendations based on the
time base and have a sensible default moving forward.

As I want to make that clock base parsing similar for GPIO
I first thought it was a good idea to support the same clocks,
but now it seems like a bad idea.

IIRC you told me to simply hammer down the clock that
makes the most sense.

At the same time userspace libraries (such as GNU radio) will
be confused if they can't match the timestamping clocks,
as correlating GPIO and IIO events is something they will
want to do. And I guess these clocks are there for a reason.

So asking Lars-Peter and Gregor: from a userspace point
of view, what makes most sense for the usecases you
have seen? Having one consistent time base or all of these
as we currently have? Different clocks under different
circumstances?

Yours,
Linus Walleij
