Return-Path: <SRS0=UYdU=5G=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4600C4332B
	for <linux-iio@archiver.kernel.org>; Sat, 21 Mar 2020 21:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E5F20754
	for <linux-iio@archiver.kernel.org>; Sat, 21 Mar 2020 21:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4c0/Z4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCUVpK (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 21 Mar 2020 17:45:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40627 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgCUVpJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 17:45:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id t24so5002559pgj.7
        for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2020 14:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DMYBWHNVsPLGdTfXPOqjItHdZoWSDSH5HLd5CNQzSng=;
        b=f4c0/Z4QTwFo3fziYT9f7im9xTQMEsekJ6PbC2vse+cc2sgS8kfuzOmL5hQpTfyNCI
         akRpmhvkOuJJjox7I7FypP+gCzor38h5V0fK/wbzDhPXZWoE7a/smO35a3EoltEs+7L7
         J10x2OKrG/u0nTLMjiuawlFDpkq8yA11X4GbBlQDnI2Jk+ELSdLw+3NfT0CQlSuOpqqj
         JbbZ4MzUOPi+IccmQWZhU0/wvYcT1pHuu6KtYC0wQy+Ns9QERYJ83/n5xs96c9TCRUPc
         7HDhbZQ7vEPTNDFYDKzCU5kaI9qGewsaKbEx6PP/VtoWvyr1kFR7PK0rlrMsV/4SKHBU
         Swhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DMYBWHNVsPLGdTfXPOqjItHdZoWSDSH5HLd5CNQzSng=;
        b=K7UfYb0QoO+jhRrtgZrJxr/WXAl0AJkNFSz/i0OjFrOixaVSNXZNfy0dbiJGjQ/drH
         hQWOqea4qSBWsqAdP+TV1zBmAZb/qauIfER0LhWB4FiCu/d7a++f3Og1CqL+DuLr6aLt
         GEI2LheGa3uO/QADE81xFyF4YFRc+Hoeb9whV4/Wx/N2K1O+L/mbk1l9zmyaUdBxZlon
         h184bnODFZ8eJMEwF0omhwyE8yYQJIez7FwdhRggLGQtKxiJ5Zp2YuBwTmF2SmcvD/kO
         Vrz8OKUeMYWs2W4Gu74XTsmItRNJviKyThnZtJkxZPUWeU1su4ySVa9F+nhg4RMl08Hb
         kGdg==
X-Gm-Message-State: ANhLgQ19Er2c7DJAjVkTMjgCC4N80iyHUzFsR13ms83577fQxwgv7taG
        iYvvzFTwqniPNFmE1uZSD4NLVmSWv930gMZ1w9Q=
X-Google-Smtp-Source: ADFU+vvLQXx83Y+vzMYGTnDN+P8dxrTKVAFj+D0X/k1A02ZPv0chSPkaXqihZqodfz+M/9eqhwhtffB/dEWNyG0FGBk=
X-Received: by 2002:a63:1c4d:: with SMTP id c13mr14657549pgm.4.1584827109029;
 Sat, 21 Mar 2020 14:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200320104031.31701-1-alexandru.ardelean@analog.com>
 <253007c8-38ed-acd8-a506-b22f34d03997@metafoo.de> <3c2ea62e060ae260536766c3ebdd7fe6a1ab5725.camel@analog.com>
 <20200321182144.4c3226ee@archlinux>
In-Reply-To: <20200321182144.4c3226ee@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 21 Mar 2020 23:44:57 +0200
Message-ID: <CAHp75VecU4Y3Jku0hAgh4MuTCocbG1rGKaDsHB3QnjGeu1HiQA@mail.gmail.com>
Subject: Re: [RFC][PATCH] iio: buffer: Don't allow buffers without any
 channels enabled to be activated
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 21, 2020 at 8:22 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Fri, 20 Mar 2020 11:16:12 +0000
> "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
> > On Fri, 2020-03-20 at 11:55 +0100, Lars-Peter Clausen wrote:
> > > On 3/20/20 11:40 AM, Alexandru Ardelean wrote:

> > > > +         if (bitmap_empty(insert_buffer->scan_mask,
> > > > +                 indio_dev->masklength)) {

I guess it's much better to put on one line (despite possible over 80 limit).

-- 
With Best Regards,
Andy Shevchenko
