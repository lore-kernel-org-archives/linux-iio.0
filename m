Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:35849 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753344AbdAZJ5T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Jan 2017 04:57:19 -0500
Received: by mail-io0-f176.google.com with SMTP id j13so34357394iod.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Jan 2017 01:57:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a8c5e07542db7c2e9a930b1a9658f74234184365.1484838095.git.vilhelm.gray@gmail.com>
References: <cover.1484838095.git.vilhelm.gray@gmail.com> <a8c5e07542db7c2e9a930b1a9658f74234184365.1484838095.git.vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 26 Jan 2017 10:57:17 +0100
Message-ID: <CACRpkdaCNzSf6NbMCoLy7HHQMZypUqmmLFWOy8_rWQOS2b=unA@mail.gmail.com>
Subject: Re: [PATCH 3/5] gpio: gpio-mm: Add set_multiple callback function support
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

> The Diamond Systems GPIO-MM series provides registers where 8 lines of
> GPIO may be set at a time. This patch add support for the set_multiple
> callback function, thus allowing multiple GPIO output lines to be set
> more efficiently in groups.
>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Patch applied.

Yours,
Linus Walleij
