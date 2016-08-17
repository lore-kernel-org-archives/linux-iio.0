Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:36249 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835AbcHQHX6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Aug 2016 03:23:58 -0400
Received: by mail-oi0-f44.google.com with SMTP id f189so129012252oig.3
        for <linux-iio@vger.kernel.org>; Wed, 17 Aug 2016 00:23:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <DE81936B-E9FB-40A1-A139-9BCA6841C11F@kernel.org>
References: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
 <1471354423-19186-3-git-send-email-linus.walleij@linaro.org> <DE81936B-E9FB-40A1-A139-9BCA6841C11F@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 17 Aug 2016 09:15:49 +0200
Message-ID: <CACRpkdauRqmbms4t3jcypao32dxy0S+LcdEMH1+m2SW_9G=n3g@mail.gmail.com>
Subject: Re: [PATCH 02/17] iio: accel: kxsd9: Fix raw read return
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	stable <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Aug 16, 2016 at 6:24 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> *whistles whilst pretending this driver has nothing to do with me*
>
> What's really odd is I ran this not long ago and didn't notice this little
> quirk...

Yeah I remember you mentioned it... there must be something that
made it work and tick anyways. Maybe core changes?

If you can get the SPI-based system up we can get the driver in
really nice shape though! It's working like a charm for me at the
end of the series.

Yours,
Linus Walleij
