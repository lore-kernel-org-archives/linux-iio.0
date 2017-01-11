Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34703 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760416AbdAKXLj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Jan 2017 18:11:39 -0500
Received: by mail-qk0-f181.google.com with SMTP id a20so3257505qkc.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Jan 2017 15:11:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170111174933.22523-1-colin.king@canonical.com>
References: <20170111174933.22523-1-colin.king@canonical.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 12 Jan 2017 00:11:37 +0100
Message-ID: <CACRpkdbGrtRa5=QzzCa6M4hAbLeHwrzRtPd3gbFf=Y84aVON5w@mail.gmail.com>
Subject: Re: [PATCH] iio: magnetometer: ak8974: remove redundant zero timeout check
To: Colin King <colin.king@canonical.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jan 11, 2017 at 6:49 PM, Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> At the end of the delay loop timeout will always be zero
> and hence the check for !timeout will always be true. Remove
> the redundant check and the redundant return 0 at the end of
> the function.
>
> Fixes CoverityScan CID#1357168 ("Logically dead code")
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Clever Coverity scan.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
