Return-Path: <SRS0=gBti=AP=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACBDC433DF
	for <linux-iio@archiver.kernel.org>; Sat,  4 Jul 2020 18:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B4BC20720
	for <linux-iio@archiver.kernel.org>; Sat,  4 Jul 2020 18:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwYMpFRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgGDSUW (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 4 Jul 2020 14:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgGDSUW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jul 2020 14:20:22 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C9EC061794
        for <linux-iio@vger.kernel.org>; Sat,  4 Jul 2020 11:20:22 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id z5so16503334pgb.6
        for <linux-iio@vger.kernel.org>; Sat, 04 Jul 2020 11:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jDeZ+s2iTZ8p8+JmgfyDT0UiOnqavohY0nCjK43Dmiw=;
        b=bwYMpFRZxJN9RjyqqzATx7/qIbxLmmETRgEYcxude0HGmi+lk8WyAWrkF404E1A8lh
         62f9JGaDlAsOPZuDfgkoTGWypykrgGDEKuZBC1yOHm6j/qa/DzacavyCIqiEIeVq7Cwd
         wD3f1o8d47kELbis0WIsCSub+Bp3iMfolzVxFGqF70mChgae7AyLTnJNjn72e1YDQ0Wl
         I8WeLYnG3b3kCr+nSF8KbffjSa9L8rkNCBbd0ffSvoTGeuPmprXGNVGUdeuHmlWRz5eS
         6rXAoqpJrz3qGnLCl1uVrIgiuJIRhtBFoQ867RyGZQXV0V0Ks0w5k1cooWu251AsuU42
         vV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDeZ+s2iTZ8p8+JmgfyDT0UiOnqavohY0nCjK43Dmiw=;
        b=l9CXh/EQHlbfGbEv1DeVHc+FuUdxdsZGjj2Dq8HBaiqU3EZn6GgYnGGMimq8GoMUl0
         cMU5iWnHG7eWyPiMpRxAW9iSPHzX1iqSQstdsjqkX+BqG4wBDtnTWfx8Bz2l6Ioe+aUb
         nQcbAjSgz+HC6UbBFmBjxHlM1iskBr2Z7qCtRIO3eYPT/DKk9XP9/K534QLleagU9lQB
         IJLUHSxhuijLza4iocFJklCx+jCnD/n4GWtJIxw8ndskhaOWHdVktMr8w+8aWRJpb87F
         QBAUxnnJfrkVRqqjYIjKInwgjthnqBkLawNyeI4Ffdqq7qLsOSVeYqWOI8DGM8htx/7j
         5ASg==
X-Gm-Message-State: AOAM5312MCOOLIK7iN1oTxL9DlxNAve/kceN4KbKXTM1RFsO5L5QO5jE
        Cw6PFWR71aUqnkfBB0qjEuOH8bnL8JAYWg++Tcc=
X-Google-Smtp-Source: ABdhPJzTDPjS5bDU1/p1ofu1IEfI74ZSxRDiA6q5pb0oIzhahi9Btf/OVY0rB4/cVtt1kn5uznu48a9lbYwfGREZ8Kw=
X-Received: by 2002:a63:a05f:: with SMTP id u31mr27761572pgn.4.1593886821739;
 Sat, 04 Jul 2020 11:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200628123654.32830-1-jic23@kernel.org> <20200628123654.32830-20-jic23@kernel.org>
 <CAHp75Vfba8cJkhZVpRyspc7CgrmYy0BjvuBjb4==BFMsa-tCyg@mail.gmail.com> <20200704165832.5dafe051@archlinux>
In-Reply-To: <20200704165832.5dafe051@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 4 Jul 2020 21:20:05 +0300
Message-ID: <CAHp75Vf_jZgntP+53cRCsesRkdN5U64VCnav8D1yhVjtyKxN-g@mail.gmail.com>
Subject: Re: [PATCH 19/23] iio:adc:ti-adc128s052: drop of_match_ptr protection
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jul 4, 2020 at 6:58 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Tue, 30 Jun 2020 10:22:45 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Sun, Jun 28, 2020 at 3:39 PM Jonathan Cameron <jic23@kernel.org> wrote:

> The problem is that not all vendors have an ACPI manufacturer ID
> (or a PNP one). They could probably get one but smaller manufacturers
> are never going to bother.

I understand and this is a real flaw in the ACPI process. But users
(customers) should do something about it.

> > That said, the commit message is misleading a bit here (it might be
> > useful for the components which are not supported by existing ACPI ID.
>
> I'm a bit dubious about encouraging people to use an Intel ID. If it
> were issued by TI for a TI part that would be a different matter.

Here it's an ID corresponding to one of the supported components, so,
PRP0001 makes sense for the rest.
Rephrase the message to be more align with the reality (as per
previous comment on the patch with same matter).

> Obviously there is no problem with Intel issuing an ID, or anyone else
> doing so.

-- 
With Best Regards,
Andy Shevchenko
