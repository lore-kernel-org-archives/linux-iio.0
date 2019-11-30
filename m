Return-Path: <SRS0=DXtU=ZW=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0991C432C0
	for <linux-iio@archiver.kernel.org>; Sat, 30 Nov 2019 16:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758532072C
	for <linux-iio@archiver.kernel.org>; Sat, 30 Nov 2019 16:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0MyfDKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfK3QS3 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 30 Nov 2019 11:18:29 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:44021 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfK3QS3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Nov 2019 11:18:29 -0500
Received: by mail-lf1-f47.google.com with SMTP id l14so24735562lfh.10
        for <linux-iio@vger.kernel.org>; Sat, 30 Nov 2019 08:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JJvnHrshoIjuJRmQ6JxlRGMs/9RUxIQygL03/NZuTSQ=;
        b=f0MyfDKlWffCV1AqZCS4+P84RjJ6VcANCoOsbfbfraEq1HzSIobOJpJn9g4Wq44Fu4
         eeg0buy0vWAn+WpEqToXyMLbS8S9EN2EQdblLxRfsjPH2VbclA/jnt2YVV3q3q8+ceM8
         vh+DkVvBVyhvIP/CYzuabLOYZqs55UtzKoPmTLnajYHcT8w/IzvyrrQW28QfLTAE+983
         zPni1iGRf4ki04mWXGTyhyJIXp52CfHZkqkISu0QNEwG8xmiD+jRFI0v3DhyeY84ztK0
         ZYp2PPrsJ+EzXXKbtdwEu6jlrvH2mOgAz7CAgSqoInt8NdB3iTZbuYkQNiJvXinugto6
         oqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JJvnHrshoIjuJRmQ6JxlRGMs/9RUxIQygL03/NZuTSQ=;
        b=d6F3gVOuZHSmyUyxqjNIKJ5QEvtZf0UPNudoOqyzJFD99bhFbZHrK3H0dXucXqW1LH
         mHnytlIoz7fskUosSHFcSJKQncIFNh8JP1c19dtBKvfpcA6rXuP7TvXvylw8Xiwn2jqN
         yNUXqXJYUgyEIjTfc8OF4s8VEn9f99qI5EsWkmeLilyPQq2whhwh0n0fqSS7K28kHC6s
         PQQrFxjHmeBphu/R7lHjMerrkp412GirIlsqLN0HNsKS6TuAV62qqH15sffDJpee1ZRc
         zOGFL8zI0mDmnPeiPw8f04wycycQuAGqp2SerhP5zQME1bOmJMXEmJPOItJVQpZbVZa7
         /7Ow==
X-Gm-Message-State: APjAAAVWRwPqDHPHys7T6XVOJGKlb+/7b4TjFgO/31JH14n3no0OqBtI
        H9s1QAhsUQg9EMageVfdg0JEJUhnNeC+tgQILGw=
X-Google-Smtp-Source: APXvYqy9/abvtURREUHdTgZGQvoX62OI7Sq9orbdGVv3gO3V643GUunx6+UmlUJajdr8VcaP4tH+6JZJRis5hkl7K3k=
X-Received: by 2002:a19:f80a:: with SMTP id a10mr28285521lff.107.1575130707270;
 Sat, 30 Nov 2019 08:18:27 -0800 (PST)
MIME-Version: 1.0
References: <CAKxs2cBVnL=6ZNbKgYRppaeUBM3xuog5BHdtmJHRxwttSfjugg@mail.gmail.com>
 <CAKxs2cC1Bqoc6kyz9Cidf_3MHQA-6ZAQJns2pU2CqJ-pMj9ZKA@mail.gmail.com>
 <e2db511fcaad2d1d08180995e836c22791b9e3b6.camel@analog.com>
 <CAKxs2cDzm+3WJSp=tHpHy31M5qQaQ=ddKvwoQuP=wzawWKZd6A@mail.gmail.com>
 <74bff1fe1eab887d3d19f3cff3fc02afbc52a12d.camel@analog.com>
 <CAKxs2cBRC1Mkx5+jtW+BNqA_53GL1K2C8Hppf7wuY6SMPiMi+Q@mail.gmail.com>
 <CAKxs2cD=hRpQfAxnWWU-4PJOwuWrqpkcJZ-_AVLCvRui8iOmAA@mail.gmail.com>
 <36ecb0e0-a593-2064-caf0-9b161c36f9b4@metafoo.de> <CAKxs2cDCox2k19ErZYKQxaw_gyOHzxtQTMwZe8TpcgeO+smNdw@mail.gmail.com>
In-Reply-To: <CAKxs2cDCox2k19ErZYKQxaw_gyOHzxtQTMwZe8TpcgeO+smNdw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 30 Nov 2019 13:18:42 -0300
Message-ID: <CAOMZO5BAuPx49USDQ7B5ji2xUYK+eqGeMYtBifCQ_jPX5eBtOQ@mail.gmail.com>
Subject: Re: Doubts in getting started with the Analog AD7928 driver
To:     Daniel Junho <djunho@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Daniel,

On Sat, Nov 30, 2019 at 12:45 PM Daniel Junho <djunho@gmail.com> wrote:

> Yes. The problem was exactly this! I applied this patch to the kernel
> and it worked.

Maybe you could submit such commit to stable so that it can be applied
to the 4.4 stable tree.

Regards,

Fabio Estevam
