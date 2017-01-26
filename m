Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:34519 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753387AbdAZJ4S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Jan 2017 04:56:18 -0500
Received: by mail-io0-f181.google.com with SMTP id l66so34487145ioi.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Jan 2017 01:56:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d8301960672e52f7f157e050f5c8be63810ff34e.1484838095.git.vilhelm.gray@gmail.com>
References: <cover.1484838095.git.vilhelm.gray@gmail.com> <d8301960672e52f7f157e050f5c8be63810ff34e.1484838095.git.vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 26 Jan 2017 10:56:16 +0100
Message-ID: <CACRpkdZSurWPz5C4mvi6tD4d-xmye1fNsdJAmfNxjwx9z=Ohug@mail.gmail.com>
Subject: Re: [PATCH 2/5] gpio: 104-idio-16: Add set_multiple callback function support
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

> The ACCES 104-IDIO-16 series provides registers where 8 lines of GPIO
> may be set at a time. This patch add support for the set_multiple
> callback function, thus allowing multiple GPIO output lines to be set
> more efficiently in groups.
>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Patch applied.

Yours,
Linus Walleij
