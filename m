Return-Path: <SRS0=Lp50=RE=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E162FC43381
	for <linux-iio@archiver.kernel.org>; Fri,  1 Mar 2019 13:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71D820850
	for <linux-iio@archiver.kernel.org>; Fri,  1 Mar 2019 13:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FBPKZx85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfCANZw (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:25:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40711 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732808AbfCANZv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Mar 2019 08:25:51 -0500
Received: by mail-lj1-f194.google.com with SMTP id w6so20360032ljd.7
        for <linux-iio@vger.kernel.org>; Fri, 01 Mar 2019 05:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V7YXjj6FthcgYc/eHQE7KUwu0HKMTksPy9gturuX4q4=;
        b=FBPKZx85GGzcqpffUquGe9ktuOQIIN9vFHMr/FLayA9Auy8o5rmp/7DzB/+2vOV4kn
         2D7T3xvnRhCaLwkZDP+Ika35fXiEj/lacLFygIZP8Im32Q3winPVUHL/6/VdMh50B+oa
         /EGHiqoEvXa+m30vbI88tW81nvp0+SsajTfed//xyIjlXUyLrqjuc4Cnvz+JDzUrve6O
         Zg5h8o6EABkuqKF0jlymEAbRdp+TDb5hMB77AjGd8Mt5lnKVwxOhlfhFjTQHra7A0/uu
         i4Ssz8KYl3gRL2E+ENCrQRglQ6hdzELjdKPB/3Btxo87klJxCg9qUgxoxoprVzy9cIMp
         m53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V7YXjj6FthcgYc/eHQE7KUwu0HKMTksPy9gturuX4q4=;
        b=G0lGSIchWKqBWoXkf4EOufQ1Ub2VD7Hna9A30LqgC0tdRvp6Q8KfSHCNjxidTPqWJv
         J99OY54uyJFR1pPHf7kvE0dYrY6cYlMpYyNDX0Ro0h0PNaGO5KuRZ6tRT+VLAzRRbLbt
         o6CbpG3CyQw9jzCVOgx9MmMKCcHzGV1hKwomsn3tiQn9zM4HP/qV0Uq8RKzmzqdtHGSr
         G9C0VK33Y0su9+HDGksBC6UIwcxBZD6Vs9AUJHGgr35a+MLTb10Q+9nQa7rNFdN4WCJu
         3WNJeXK9x5nm4Zbf4FfApKLNnynBT81SleVP8aMVvhmh4QUEU8L/PrY2H/K37A4nxa7j
         kovQ==
X-Gm-Message-State: APjAAAXLJcnLYRRhb/vpYQXcfv9z14gJbsrXzflTTU3NZlYlyzEYGnRK
        d0NrzzIXgbf4bo2uGL4BofMPf1kjfo/WZA+WLCr3xA==
X-Google-Smtp-Source: APXvYqwwClf7Ywf1G84ceXV4hDUegWOuep38etn+0iQeEJeYJJJb7iSvOmsNj/jEsv5orKAP6S3OEQYnDPVeFpJTXQc=
X-Received: by 2002:a2e:2ce:: with SMTP id y75mr2637491lje.126.1551446749098;
 Fri, 01 Mar 2019 05:25:49 -0800 (PST)
MIME-Version: 1.0
References: <1551392209-20004-1-git-send-email-justinpopo6@gmail.com> <1551392209-20004-3-git-send-email-justinpopo6@gmail.com>
In-Reply-To: <1551392209-20004-3-git-send-email-justinpopo6@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 1 Mar 2019 14:25:37 +0100
Message-ID: <CACRpkdaDVvOQnYUGPLFEjqWOnLS=sw=mAn4WkJPHrLtp0gtCdQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: adc: ti-ads7950: add GPIO support
To:     Justin Chen <justinpopo6@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 28, 2019 at 11:17 PM <justinpopo6@gmail.com> wrote:

> From: Justin Chen <justinpopo6@gmail.com>
>
> The ADS79XX has GPIO pins that can be used. Add support for the GPIO
> pins using the GPIO chip framework.
>
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>

This looks good from a GPIO point of view.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
