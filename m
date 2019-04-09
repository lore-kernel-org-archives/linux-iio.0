Return-Path: <SRS0=DYZA=SL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6657AC10F0E
	for <linux-iio@archiver.kernel.org>; Tue,  9 Apr 2019 12:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3539A20880
	for <linux-iio@archiver.kernel.org>; Tue,  9 Apr 2019 12:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPrRYB9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfDIMIM (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:08:12 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37985 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfDIMIM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Apr 2019 08:08:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id d13so19362826qth.5
        for <linux-iio@vger.kernel.org>; Tue, 09 Apr 2019 05:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8Cgo1GqwT7HsP5ByHisJ/90ukPfmYbR5JKcQkWzjvLw=;
        b=pPrRYB9JTMW+epFqJiBI6hKTSQa8A2USxhxwVulKa2XKSttQZdUpkoJk9Cku21JxhZ
         Ca66qYHQHoXia8yUpRTo+7EboS2M5MarOQcJ8ww/SFZhmUfLl9Qq98bZITX2xCR0yE5X
         YiWcy/c01pYdFuonUbrzlr0UH5QPheDMlrpAN3A7Ch4k5pl2gownlrGUX646os4iMZkV
         6aJPS0TwNGFuyvKRiv8b3jL/p813IYwAgvlbSA01tsTB7ATTR4ME7j9pq3ZG/VVaexCa
         Bd2GjtjHuGP08p+elVKhRwYGHLzWA2D743KkiWYx6vaicRChjxN3FEtr/clpL+GfngQQ
         CCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Cgo1GqwT7HsP5ByHisJ/90ukPfmYbR5JKcQkWzjvLw=;
        b=aYZEbqWk7JiU9Zv7GXvIVrMkpvxtojUZGdy3z2BLJqXgkNaZRayT6Zvf+ByPZy/BEY
         5smNZN5BjvfzmWvYofGpn7d12g4c63XG8sJ6vRFjl6AhDhKopwIP2pC6mTHzylr2d08r
         WrwJtpehNH38wvvDqN4ZZIn8tXlt7JanUThh00qWcQzMBrQnJxjmt7OrYGF9thg7I+Of
         +GRNEC0U0j5SjTpNUVPvsE6dL+bFKPJcdwJ/Y1QneuLIjP5YDsegWLgoOBJZ641iQvsl
         Hp6K1yz9UeKroCa01LV8YqnTfYgK1Y3K78Xn67IyH6vzKd0hl9vn9z4OYXGtYhEmU9dn
         W+YA==
X-Gm-Message-State: APjAAAUB7wOfExjJL8bRuG1tQNfiKzGFdEi5l+jHilmUlI02geOqwjJC
        SWYvOF2dDoTJRmaSTmDFypTsP0oz2KI=
X-Google-Smtp-Source: APXvYqyL2OMbMYP720xycny+CWpo63KWbCJfR1H7ZRpqhOqsk3XBLPNHB82UuT8PjCplz2WP2+0riQ==
X-Received: by 2002:ac8:3855:: with SMTP id r21mr29579883qtb.264.1554811691674;
        Tue, 09 Apr 2019 05:08:11 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id j93sm20588484qtd.82.2019.04.09.05.08.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Apr 2019 05:08:11 -0700 (PDT)
Date:   Tue, 9 Apr 2019 09:08:07 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Crt Mori <cmo@melexis.com>
Cc:     dragos.bogdan@analog.com, michael.hennerich@analog.com,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        Linux Iio <linux-iio@vger.kernel.org>,
        kernel-usp@googlegroups.com
Subject: Re: RFC on IIO AD7292 driver GSoC proposal
Message-ID: <20190409120807.pevfhpdzfuifayi3@smtp.gmail.com>
References: <20190406194528.qx2tvrriuymb6xnq@smtp.gmail.com>
 <CAKv63us7p3AC6UQfGYj14ZXOPa6R0pEAcJOTqzgRy6ZJGwKqnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv63us7p3AC6UQfGYj14ZXOPa6R0pEAcJOTqzgRy6ZJGwKqnw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 04/08, Crt Mori wrote:
> On Sat, 6 Apr 2019 at 21:45, Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> >
> > Hello.
> >
> > My name is Marcelo Schmitt, I'm a computer science student learning
> > how to contribute to the Linux Kernel in the IIO subsystem. I was told
> > by a friend that Google was encouraging people who contribute to open
> > source projects through the GSoC program and that there was a project
> > for developing a new IIO driver. I intend to continue contributing to
> > IIO and, if possible, engage in this GSoC project. As suggested by
> > GSoC organization, I shared a draft proposal for the project here
> > https://docs.google.com/document/d/1vOegyoC5b90jwLe1PBz4IbKGXaXMozi-RldS5OAZz4Y.
> > It would be really great if anyone could comment on it.
> > Sorry for sending it so close to dead line date.
> >
> 
> Hello,
> Nice read. I am a bit wondering why you have Arduino mentioned for
> couple of tests - I am assuming because its easier to write raw SPI
> with Arduino than what is described in Documentation/spi/spidev ?
> What you have in week 26 (Develop initial documentation), you will
> probably need to send with the first patches of week 23 and 24.

Thanks Mori.
You're right, I'll probably have to start defining ABI when defining
device's external attributes for temperature. Devicetree will probably
be worth carring for after setting voltage regulator for the device.
Changed proposal accordingly.

> 
> Best regards,
> Crt
> 
> > Thanks in advance,
> >
> > Marcelo
