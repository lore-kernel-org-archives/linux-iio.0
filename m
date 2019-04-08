Return-Path: <SRS0=7Ar9=SK=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B403C282CE
	for <linux-iio@archiver.kernel.org>; Mon,  8 Apr 2019 08:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF78F20880
	for <linux-iio@archiver.kernel.org>; Mon,  8 Apr 2019 08:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="hs5Q0nyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfDHIiO (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:38:14 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50516 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfDHIiO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Apr 2019 04:38:14 -0400
Received: by mail-it1-f195.google.com with SMTP id q14so19435592itk.0
        for <linux-iio@vger.kernel.org>; Mon, 08 Apr 2019 01:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uu6uH0llopAiCFUJ3W/PV5mf18F/NWjQXr1OpuE7v7A=;
        b=hs5Q0nyfCCjpvWrKn/1jYOq5pX+rI168RDPMWBdCeM+xLm0Jvyr1f3pBdSAZ0h72Ra
         ozfxX48ahoYCuu4nSCicT2jwpI/w9aijUBj4dG/9xcPRqXM7tPOBgRNakXTAdIvmfJe/
         chTbhoiY7WodHREjHnCqB7zT6GcOLAB90eillOILt8tjrHtApvF/DL3fHOVObMKxezK4
         itcdQv0Ec4bzoIle76bxfKCQnyI9loTHAnsCM90VnHakx5gue0pEsJf1CGM9Ou9jJebi
         XyFhLhgOs5OLux+aozFo82ccdYZXRE6CBbnPiwhCVhKF8TFDn4eRZthPZ1Znmd7F/M2f
         zz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uu6uH0llopAiCFUJ3W/PV5mf18F/NWjQXr1OpuE7v7A=;
        b=gMmTda6eIPwKqKTvBwzDHdteDrowPBsSOAyKr4tcUztjFNYvkwoToPjwK/VQqHldFQ
         pCGqg0WY9ihegiAqvzXKwjnvGN2vPvlj2FsJ2O7mgZhLTEKAR3EMqJZsTWR2L3M7yv/3
         Yb6T7N/otLlPnvOHH3ozGuhvFoEU1s9OuNXfiGouDJYyUviPqRPaQItBIJewZEjysyxY
         yQKqScYmlqW5BZhQFQEgNgJpqMBiz7OZxMlrFu6Kns18ggW6e13HCK/0ZQbH8od+qBop
         OGjSiWYdCn5lGEh6AIxBCXzr4XA3Rm4Du/l5k9bWdXLTsP3J/NAbATMQKw0VaB55+9AZ
         7l2Q==
X-Gm-Message-State: APjAAAUX1ScuKQiBlqGwxO3uVKMrbA6Z2+CGpe9DyYS0IH3W5PwgsROU
        RhKgmPucHMPiSxUrmEpgbvYKXov8aLNtDxmSuOZdCg==
X-Google-Smtp-Source: APXvYqxdSTHlKaV5tkliH6Z/3644pXXdN/hb8T1AQKPVPcbf+60tYk9aOneKf/LxGEDLfVliQrYl4czYaOf5SnYwlp4=
X-Received: by 2002:a24:7c9:: with SMTP id f192mr1080820itf.97.1554712693205;
 Mon, 08 Apr 2019 01:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190406194528.qx2tvrriuymb6xnq@smtp.gmail.com>
In-Reply-To: <20190406194528.qx2tvrriuymb6xnq@smtp.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Mon, 8 Apr 2019 10:37:37 +0200
Message-ID: <CAKv63us7p3AC6UQfGYj14ZXOPa6R0pEAcJOTqzgRy6ZJGwKqnw@mail.gmail.com>
Subject: Re: RFC on IIO AD7292 driver GSoC proposal
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     dragos.bogdan@analog.com, michael.hennerich@analog.com,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        Linux Iio <linux-iio@vger.kernel.org>,
        kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 6 Apr 2019 at 21:45, Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
>
> Hello.
>
> My name is Marcelo Schmitt, I'm a computer science student learning
> how to contribute to the Linux Kernel in the IIO subsystem. I was told
> by a friend that Google was encouraging people who contribute to open
> source projects through the GSoC program and that there was a project
> for developing a new IIO driver. I intend to continue contributing to
> IIO and, if possible, engage in this GSoC project. As suggested by
> GSoC organization, I shared a draft proposal for the project here
> https://docs.google.com/document/d/1vOegyoC5b90jwLe1PBz4IbKGXaXMozi-RldS5OAZz4Y.
> It would be really great if anyone could comment on it.
> Sorry for sending it so close to dead line date.
>

Hello,
Nice read. I am a bit wondering why you have Arduino mentioned for
couple of tests - I am assuming because its easier to write raw SPI
with Arduino than what is described in Documentation/spi/spidev ?
What you have in week 26 (Develop initial documentation), you will
probably need to send with the first patches of week 23 and 24.

Best regards,
Crt

> Thanks in advance,
>
> Marcelo
