Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:35205 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753353AbdAZJz2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Jan 2017 04:55:28 -0500
Received: by mail-it0-f47.google.com with SMTP id 203so127059629ith.0
        for <linux-iio@vger.kernel.org>; Thu, 26 Jan 2017 01:55:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0f0f83b416aa42968e0cf66f5290a390d5fb2d8b.1484838095.git.vilhelm.gray@gmail.com>
References: <cover.1484838095.git.vilhelm.gray@gmail.com> <0f0f83b416aa42968e0cf66f5290a390d5fb2d8b.1484838095.git.vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 26 Jan 2017 10:55:26 +0100
Message-ID: <CACRpkdZNho_=Bc5bDZFmsE9JLo+firTq6FyLFv=Qop8USjx0_g@mail.gmail.com>
Subject: Re: [PATCH 1/5] gpio: 104-dio-48e: Add set_multiple callback function support
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jan 19, 2017 at 4:05 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> The ACCES 104-DIO-48E series provides registers where 8 lines of GPIO
> may be set at a time. This patch add support for the set_multiple
> callback function, thus allowing multiple GPIO output lines to be set
> more efficiently in groups.
>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Patch applied.

Yours,
Linus Walleij
