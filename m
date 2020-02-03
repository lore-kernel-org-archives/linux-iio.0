Return-Path: <SRS0=iG7M=3X=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF75DC33CAC
	for <linux-iio@archiver.kernel.org>; Mon,  3 Feb 2020 10:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59AB2082E
	for <linux-iio@archiver.kernel.org>; Mon,  3 Feb 2020 10:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uOG4l/EJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgBCKR0 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:17:26 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42112 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgBCKRZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Feb 2020 05:17:25 -0500
Received: by mail-pl1-f193.google.com with SMTP id e8so3058625plt.9;
        Mon, 03 Feb 2020 02:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BI5Btq2BdundVSKnBkH4i1TFYWWU2lOLfpEXkz2+34s=;
        b=uOG4l/EJf8A41gc/jrWj8EHPHycM5dDbt4B75bhhTdoLLLwHOrRFYjwVJm7iW3MmaA
         DjAAMXUI+hBR2vVQ9OXZ+9Xp7LhNCzKguyxX3oE8IjszizV/Jhr0sHESa/OLqKyBg9+x
         t8TmgTUUwcdk0G6KVv3Xk13Q5kvka41iQXWwk7F50eyCTaaDYsJvXlfBYL8LzOrBWszR
         xUgGSsWF5zfk823OiDIDtlAvxCQG+EhsAj7nnETA+Bp7Lq+rOzhVkfKaCBym1UEe/Ra5
         9P0rRsLjziDh+71Bx9dKNnghPeXSy8yP0ToW30/pmaXLkYtlUJQ7rxDySWKKI/nEdzOB
         k91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BI5Btq2BdundVSKnBkH4i1TFYWWU2lOLfpEXkz2+34s=;
        b=degCOYuNyiMDoRC67xhEgwMWLGIKZcEcQehePhdhcQQTWCdP+G2HvwFCHgbgF3AgTB
         6ZTun9q9ontChwbYSv+CWJaHVBX1OLWZzVBvGygRAtKj/wPOvR7zkmHH1N0BCW3ot29b
         +l7f0tcOzfnTN0ErFJIZuZCenlnWxnJ7nSOUA6Z20EidbPZj0n1d/1HMqq6sWendkc6+
         PJVzJ8MuRcLAlghMQLASaMCkQFXE7NSNqpeVViyec0mtpBdE8hMyfZYSVwbI2eaygiz5
         Rw0F3nE/9xovqyHhTz2p4bw9y52U4asLrxfhD4kIAb+iO9i+57AfJ4tgQmdZsIUuKTrq
         NA0g==
X-Gm-Message-State: APjAAAX5cFEEb+jqJJJhEoD3JVoaKBlFJ1SFM2lNWCoiuJS/fVxt1WRd
        xGZuN5kOA2b4Tc6xxivMuVLZ9Om+SyNBjU7reQ0=
X-Google-Smtp-Source: APXvYqzV9MbL08KEx9zQLN9PuY7RQZClzngiq85jd5w3xWNpSBewrq2tMS+iJnHE6y9/aOoQFGFajKLDEHBk7ulmy10=
X-Received: by 2002:a17:90a:b10b:: with SMTP id z11mr29209552pjq.132.1580725045200;
 Mon, 03 Feb 2020 02:17:25 -0800 (PST)
MIME-Version: 1.0
References: <20200129084509.20371-1-beniamin.bia@analog.com> <20200129084509.20371-3-beniamin.bia@analog.com>
In-Reply-To: <20200129084509.20371-3-beniamin.bia@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Feb 2020 12:17:17 +0200
Message-ID: <CAHp75VfbhqvsigBDY_uYsTVwLRGVuBhr0eO1zqSu4ivjd7X-oQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] MAINTAINERS: add entry for hmc425a driver.
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        biabeniamin@outlook.com, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jan 29, 2020 at 10:45 AM Beniamin Bia <beniamin.bia@analog.com> wrote:
>
> Add Beniamin Bia and Michael Hennerich as maintainers for HMC425A
> attenuator.

> +ANALOG DEVICES INC HMC425A DRIVER
> +M:     Beniamin Bia <beniamin.bia@analog.com>
> +M:     Michael Hennerich <michael.hennerich@analog.com>
> +L:     linux-iio@vger.kernel.org
> +W:     http://ez.analog.com/community/linux-device-drivers
> +S:     Supported
> +F:     drivers/iio/amplifiers/hmc425a.c
> +F:     Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml

Had you run parse-maintainers.pl afterwards to see if everything is okay?

-- 
With Best Regards,
Andy Shevchenko
