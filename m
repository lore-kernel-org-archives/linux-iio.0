Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36704 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934858AbcKNQ6j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Nov 2016 11:58:39 -0500
Received: by mail-qk0-f175.google.com with SMTP id n21so102820968qka.3
        for <linux-iio@vger.kernel.org>; Mon, 14 Nov 2016 08:58:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <c9a4b2b3-6c4b-4c3c-da79-eba8398a5a0d@kernel.org>
References: <1478846078-22207-1-git-send-email-eraretuya@gmail.com>
 <1478846078-22207-2-git-send-email-eraretuya@gmail.com> <eef1f86d-a0bf-9c22-4391-aca2680972d5@metafoo.de>
 <c9a4b2b3-6c4b-4c3c-da79-eba8398a5a0d@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 14 Nov 2016 17:58:38 +0100
Message-ID: <CACRpkdY6dJGGAZtVNrYwV9uBzGYRH40aqCtL6XZkEQS2uaiK4w@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging: iio: ad7606: replace range/range_available
 with corresponding scale
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Nov 12, 2016 at 3:24 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> Is it just me who thought, we need a fixed GPI like a fixed regulator?
> Would allow this sort of fixed wiring to be simply defined.
>
> Linus, worth exploring?

So if fixed regulator is for a voltage provider, this would be
pretty much the inverse: deciding for a voltage range by switching
a GPIO.

No previous experience with that, it should be outside of the
GPIO subsystem for sure...

Yours,
Linus Walleij
