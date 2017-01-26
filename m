Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:34939 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753412AbdAZJ6I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Jan 2017 04:58:08 -0500
Received: by mail-it0-f52.google.com with SMTP id 203so127092689ith.0
        for <linux-iio@vger.kernel.org>; Thu, 26 Jan 2017 01:58:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2b5658acecdc3e8d922ea8e299bd488e6ee18e2d.1484838095.git.vilhelm.gray@gmail.com>
References: <cover.1484838095.git.vilhelm.gray@gmail.com> <2b5658acecdc3e8d922ea8e299bd488e6ee18e2d.1484838095.git.vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 26 Jan 2017 10:58:07 +0100
Message-ID: <CACRpkdYRFbGfnKoML_dUSi-ti8m7yw4PA7MfO8dK1Qw+Wy=FFQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] gpio: ws16c48: Add set_multiple callback function support
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

> The WinSystems WS16C48 provides registers where 8 lines of GPIO may be
> set at a time. This patch add support for the set_multiple callback
> function, thus allowing multiple GPIO output lines to be set more
> efficiently in groups.
>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Patch applied.

Yours,
Linus Walleij
