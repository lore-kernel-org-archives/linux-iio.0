Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:34336 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbbHQIWa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2015 04:22:30 -0400
Received: by obbfr1 with SMTP id fr1so106018688obb.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2015 01:22:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55CF5940.9000607@kernel.org>
References: <1439287000-31506-1-git-send-email-linus.walleij@linaro.org>
	<CAEnQRZCen5ewAnnuiTSwQ5Yynpx0=_xnb0EUFohqb+v9LhZjzA@mail.gmail.com>
	<55CF5940.9000607@kernel.org>
Date: Mon, 17 Aug 2015 10:22:29 +0200
Message-ID: <CACRpkdYBntDDP_bk2=6HVZ5hmOtg31G-Cm3GZ6BZsQyWop0YoQ@mail.gmail.com>
Subject: Re: [PATCH] iio: percolate error if event fd fails
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Aug 15, 2015 at 5:22 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> Applied to the togreg branch of iio.git.   Initially pushed
> out as testing.  I'm not sending this as a fix as the error
> that resulted was downright missleading, but unlikely to
> have caused any nasty crashes or similar.
>
> If you think if should be going in faster/ for stable then
> let me know.

Nah. No regression, just general improvenent.

Thanks,
Linus Walleij
