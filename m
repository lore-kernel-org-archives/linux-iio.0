Return-Path: <SRS0=POtY=OQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679D8C64EB1
	for <linux-iio@archiver.kernel.org>; Fri,  7 Dec 2018 10:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333CF2083D
	for <linux-iio@archiver.kernel.org>; Fri,  7 Dec 2018 10:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GK6UBpEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333CF2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbeLGKRG (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:17:06 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38515 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeLGKRF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Dec 2018 05:17:05 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so3079923lja.5
        for <linux-iio@vger.kernel.org>; Fri, 07 Dec 2018 02:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u2qwGeTgbyO8t9Qo41jExW00AZ74xr7wwI5DVv3f3KE=;
        b=GK6UBpElqng5YekyK5Pw3gUODbsP5BZoRKM82vgztarSH6e26Z5uscUFwcDEC2ktFu
         DmlYkmfY/ShZo7Mu1ijykAjL4Gr27tzxyxJq0uDe8ZdgIOARptXkuUK6P6oXYZ+zNVHO
         g2x7EsQoy2OaAQZiqGgfDTY0NOSO6a92DCqx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u2qwGeTgbyO8t9Qo41jExW00AZ74xr7wwI5DVv3f3KE=;
        b=cC31G5AaQk2nqUrSCcQeeIJamTPlIXoVjdWaMrciMW3HGIYbzHmj9L9IHdSR80h58n
         B8QY/nwCNmNTvw1zlq1ctQvajSzfsoK6ndauskAzQoajwes91NN7pk3RrwVX866e8QEK
         CvJJvS1COvHsCOv+iA1RQ1TE6yPavYKkOFieNGacWVtuRAxbEtwpeG5oi4fhYzqeXEAf
         +mtrh7KwOe7B6S7ZRtT/LKtbyXpgP6JqUQnFOAOL4Eu2d+o77BOviEN1N6Yop4ZJr6+x
         YZr6vr4uV+BaJXyx81aApVjcJ3vXM6n7hrh6Vk88GMAW8we8nAQt92huwEp/HZpd8K3b
         5t+A==
X-Gm-Message-State: AA+aEWYSbJQV+PZveKQPN2OU2Iu0+nKPB9ZmSK6ReI7QE/qAfnvSS5M4
        eSD8Nm4U/jhNpkZDhhKsYmdKEa7BsItvOC9uVBQbLA==
X-Google-Smtp-Source: AFSGD/V2oLQ0Nuk6y6oDbva1kitnEUtEFEMc76OmaRzBcZ3uOfEAcwLOij/Im8eHymzj4xaT5pd5dA9up43dEtWbVww=
X-Received: by 2002:a2e:994:: with SMTP id 142-v6mr853645ljj.120.1544177823765;
 Fri, 07 Dec 2018 02:17:03 -0800 (PST)
MIME-Version: 1.0
References: <20181128175312.9634-1-matheus.bernardino@usp.br> <20181201165550.51a78366@archlinux>
In-Reply-To: <20181201165550.51a78366@archlinux>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Dec 2018 11:16:51 +0100
Message-ID: <CACRpkdaHSZ-WSGo+CcCrMPc=z4Ofy6oG3kxhTGxQJABEw2DF0w@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Replace license text w/ SPDX identifier
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     matheus.bernardino@usp.br, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        eugen.hristev@microchip.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andreas Klinger <ak@it-klinger.de>,
        "Kim, Milo" <milo.kim@ti.com>, Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        kernel-usp@googlegroups.com, ilucas.ms@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Dec 1, 2018 at 5:56 PM Jonathan Cameron <jic23@kernel.org> wrote:

> +CC Linus Walleij as one of his files doesn't have a license...

Sorry about that. I am fine with GPL-2.0 or GPL-2.0+ on
any of "my" files. Feel free to add it with my Acked-by.

Yours,
Linus Walleij
