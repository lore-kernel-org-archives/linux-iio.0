Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:33652 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753374AbcL3Ure (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 15:47:34 -0500
Received: by mail-qt0-f179.google.com with SMTP id p16so399546777qta.0
        for <linux-iio@vger.kernel.org>; Fri, 30 Dec 2016 12:47:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7ccb6107-d7af-2240-5000-800d3cd64205@kernel.org>
References: <20161230173620.30851-1-linus.walleij@linaro.org> <7ccb6107-d7af-2240-5000-800d3cd64205@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 30 Dec 2016 21:47:33 +0100
Message-ID: <CACRpkdYGptxWg4Vky-5dADSamY_L6_qJ7S0k02tvSKxktNhzrQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "iio:st_sensors: align on storagebits boundaries"
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Giuseppe Barba <giuseppe.barba@st.com>,
        Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Dec 30, 2016 at 7:31 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 30/12/16 17:36, Linus Walleij wrote:

>> This reverts commit e7385de5291e347f5bc85985acdce3a3f5096667.
(...)
> It's the last (and infact only fix) in my fixes-togreg branch.
>
> iio: common: st_sensors: fix channel data parsing
>
> With combination of end of year / xmas plus merge window I haven't gotten it
> out yet. Will fix that in the next day or so.
>
> Could you test and see if it fixes what you are seeing?
> At least superficially sounds like the same issue.

You're absolutely right, this fix nails it.

I'll reply to the original patch with my Tested-by.

Yours,
Linus Walleij
