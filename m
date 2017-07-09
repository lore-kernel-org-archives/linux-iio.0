Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:33958 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbdGIEL1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Jul 2017 00:11:27 -0400
Received: by mail-io0-f169.google.com with SMTP id r36so12125794ioi.1
        for <linux-iio@vger.kernel.org>; Sat, 08 Jul 2017 21:11:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170707154448.00006dec@huawei.com>
References: <b60def9a-45dc-bf97-e059-abbe105648b2@topic.nl>
 <20170630145319.20ec3696@jic23.retrosnub.co.uk> <b9dc2313-53da-1566-c0e8-ac18599f59da@topic.nl>
 <CACRpkdaZ=qSbdVxgw4DH_tOeZb0pZBYhhJJOozFn2pn25F_Kag@mail.gmail.com> <20170707154448.00006dec@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 9 Jul 2017 06:11:25 +0200
Message-ID: <CACRpkdbMtP6-bytPePdJb1Aj37YLwt7GDjqqoqFoxYDb3ALVNQ@mail.gmail.com>
Subject: Re: "Generic" MMIO ADC
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>,
        Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Jul 7, 2017 at 9:44 AM, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:

>  Anyhow, doesn't mean the concept of such a driver is bad, merely that
> the tables should form part of the driver code (much like any other driver that supports
> a number of different parts) and be selected by the compatible string.

That works.

drivers/gpu/drm/panel/panel-simple.c

comes to mind.

Yours,
Linus Walleij
