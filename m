Return-Path: <SRS0=p/QY=TR=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2796BC04AB4
	for <linux-iio@archiver.kernel.org>; Fri, 17 May 2019 12:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E9620873
	for <linux-iio@archiver.kernel.org>; Fri, 17 May 2019 12:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PS1wK7iR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfEQMMj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 17 May 2019 08:12:39 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:35410 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbfEQMMj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 May 2019 08:12:39 -0400
Received: by mail-oi1-f182.google.com with SMTP id a132so4997459oib.2
        for <linux-iio@vger.kernel.org>; Fri, 17 May 2019 05:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+CE3cRwNtvVJbDSnoBZF4aYMg3faJwKpdn8cFu4F30M=;
        b=PS1wK7iRSuIpEa4yDgK7yABQMQZfknmGyrLkwvYJbCnWn+UCzbGcu/Sup7eI1WYKgI
         /LXnqmqh12BS0zdwPwA8bC0W7boqA2/9V8rtjTFKLAe1nxfztolkWJtgJe7SFEGMt4En
         VWEhRxi8Pb17mMo1e5bjSi3O/UMnzKKXwDvcScsaOmfacvCQ1oNSgw1Gf4nyKfXQN2Q0
         ngz37XV0FZfTTxfaax0nAk2rpugYGj48pag+tt0zXx9TyVcbbEM7yv2uVI8gXGVokeN7
         VmpOFEqo8iDvzoHJLcBelIrhi4pWPAoAUzxyRFLezv80Ow0hSVG2xuI8yBxyYHGKDc4k
         iJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+CE3cRwNtvVJbDSnoBZF4aYMg3faJwKpdn8cFu4F30M=;
        b=c0Jg/ea3I0O8FBo3FqIAGq5dNOvwIn3oxY7WcOYId9bxjktQu3QOU8M1bfuFY0WBAx
         KWduuXehEYItV7vZWsJpeaOAEpu39Dot4HV2Zhomtn32ySSr7qn9ZQolkpfzAHACMtJl
         XYY6k5/G63SOkpI/M7Ff8j6/VG2O4wxYDtCm9JbFhbT3beBqtb/CoiAQu9YW7bpDY+8e
         mVw2ooVt97bsZyutqgeOUE+cXwuUeuRHWBw8PndG+H6ecL1srvs1xZjaoaI5lsB751OU
         FwWksjp0+qk3AFFFzhLWwGDAxZZrAwQm9xtW8CQYw1MEXNHHJteW8Aa04FK14W7b14J+
         aV0w==
X-Gm-Message-State: APjAAAVzg3R+iKGupPAy0srwNmQqK1vglOfZGs6S6l9FPpMW6hdgxj0j
        vbajMh1e7NG+hkPJqCTblue6f+N1dOowj4+3TCM=
X-Google-Smtp-Source: APXvYqzIq9OZrzQour5nUoykcgYolt2g7oRFXUxBFTZ5pwDWmPI64stIc7O575e2pHur7LP5MV1Qw/MWNlQ+XfZMDmY=
X-Received: by 2002:aca:db88:: with SMTP id s130mr1168525oig.159.1558095158434;
 Fri, 17 May 2019 05:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAL8zT=hNLEDCkaBc9jugfQtoWpL_f89KZe3oqoKrVwgWb0Q9vg@mail.gmail.com>
In-Reply-To: <CAL8zT=hNLEDCkaBc9jugfQtoWpL_f89KZe3oqoKrVwgWb0Q9vg@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 17 May 2019 15:12:25 +0300
Message-ID: <CA+U=Dsoc3AMUdoVqUNdDAVb+-jfq_uPT6Wn9zAVBvzxiG5nCFw@mail.gmail.com>
Subject: Re: AD7450 support
To:     Jean-Michel Hautbois <jhautbois@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        "Hennerich, Michael" <michael.hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, May 16, 2019 at 5:28 PM Jean-Michel Hautbois
<jhautbois@gmail.com> wrote:
>
> Hi there,
>
> I have an OMAP3 board on which an AD7450 is connected on the mcspi1 bus.
> https://www.analog.com/media/en/technical-documentation/data-sheets/AD7450.pdf
>

Hey,

That chip looks like it could fit nicely into the ad7476 driver.
Thanks for looking into this.

Alex

> From what I understand, this is a very simple one channel ADC, and I
> suppose (looking for a confirmation :)) it could be added to the
> ad7476 IIO driver ?
>
> Thanks,
> JM
