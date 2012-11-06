Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:42436 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754421Ab2KFIYA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 6 Nov 2012 03:24:00 -0500
Received: by mail-ee0-f46.google.com with SMTP id b15so83710eek.19
        for <linux-iio@vger.kernel.org>; Tue, 06 Nov 2012 00:23:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1352126906-4560-3-git-send-email-larsi@wh2.tu-dresden.de>
References: <1352126906-4560-1-git-send-email-larsi@wh2.tu-dresden.de>
	<1352126906-4560-3-git-send-email-larsi@wh2.tu-dresden.de>
Date: Tue, 6 Nov 2012 09:23:58 +0100
Message-ID: <CACRpkda3w3x=uioWYZ_=CdMYBf_3Gsi6+V2im1umB6odDuSB8w@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] gpio: add viperboard gpio driver
From: Linus Walleij <linus.walleij@linaro.org>
To: Lars Poeschel <larsi@wh2.tu-dresden.de>
Cc: poeschel@lemonage.de, sameo@linux.intel.com,
	linux-kernel@vger.kernel.org, jic23@cam.ac.uk, khali@linux-fr.org,
	ben-linux@fluff.org, w.sang@pengutronix.de,
	grant.likely@secretlab.ca, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Nov 5, 2012 at 3:48 PM, Lars Poeschel <larsi@wh2.tu-dresden.de> wrote:

> From: Lars Poeschel <poeschel@lemonage.de>
>
> This adds the mfd cell to use the gpio a and gpio b part
> of the Nano River Technologies viperboard.
>
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>

OK I think we can maintain this.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please get Sam to merge this through his MFD tree.

Yours,
Linus Walleij
