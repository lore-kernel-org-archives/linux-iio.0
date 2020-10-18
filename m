Return-Path: <SRS0=x94u=DZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C590FC433DF
	for <linux-iio@archiver.kernel.org>; Sun, 18 Oct 2020 18:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6718321655
	for <linux-iio@archiver.kernel.org>; Sun, 18 Oct 2020 18:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeI37/MF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgJRS3J (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 18 Oct 2020 14:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgJRS3J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 14:29:09 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A5CC061755;
        Sun, 18 Oct 2020 11:29:08 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 10so4647065pfp.5;
        Sun, 18 Oct 2020 11:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YhKxtKap6Pg66R8IThOkPzKVVHg3CECR5dk8D1mogFs=;
        b=FeI37/MF0a3MLwqdZ7Mc43KQxBaI7EI1wQbV46C0xHiNDFH3p9oNSHpNP74JJry2MU
         gDhZaBkkhn9KCdly8lYF+Dlj3OWSQ5KLfSP9HvyrxAUPMXiVDV88NSu7C5jGqtjAC18t
         hqc+gb19BOzDGgsmGqIcSXt17hxCK4aeEWQ9Yd1cgfEf1OciznSAOGm1ngPYQ1xaIU3/
         7WbVBjXY+eJor+OXxOuQfE+/1COzW46E0rTJ0GA8idAIc7y1SFWas723xdMj2VH3M9Ug
         hkhaYHmuwv34d2BYLY2fSRWBH3ZDH/CTt25iy4k431TWst7W0Vn9fnIlX9QsvtRBVJVk
         TQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YhKxtKap6Pg66R8IThOkPzKVVHg3CECR5dk8D1mogFs=;
        b=DwnWVcezKPnjpCnUM+TpIglk5zKY5YwVstsgoLlquEDHIE8D5AeUxxDy0O2I9n1XwS
         le7S/hKn+W6/Mhm+s6Inmr/MHTiqLicixuTJyHc5mOki/B2tvxTQOMyfJy+A/OY8ZGVS
         v1gNtu40Kge8FOE5YlaPjEp6cYuPqA5/06dAEd0ZE2Yqujn20o0NST1+vN7w+jFv+eEw
         pcIBw81EHu5/apMFyTiFQS5DnfFjEx/phw60oJ9wlByU9OMXFf51Av2nJqzkLVq+GUid
         4XyPOrFpGxTeh2HTehmvRZZ9rRiCYmDcHK1VK95wGWNQwfun2lGqPdf6HnTqxbxz328o
         8pjQ==
X-Gm-Message-State: AOAM532pHgwTeMOYfhMqquaRmKRt5knXsCooG3+ZqilXTmZ8Fj1J/fIO
        CySO6Ay+qOzaxc2vCSM5ZT/UTjOWVYGpYyjwBps=
X-Google-Smtp-Source: ABdhPJxiDq/CZEnC5cQO5RjAJLmdc4WB5HNZG0ZIBdrwlccwkWDshdG87/gwAQWggC8a0WQS8cz7WM5ZsZkG0tIg/JQ=
X-Received: by 2002:a63:1e02:: with SMTP id e2mr1480626pge.74.1603045748399;
 Sun, 18 Oct 2020 11:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201018150442.GA219064@ubuntu>
In-Reply-To: <20201018150442.GA219064@ubuntu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 18 Oct 2020 21:28:52 +0300
Message-ID: <CAHp75Vch2jPwZm8gVC6zRs6k=BR23Mb15Q4R4VbpMZ5FwshNLQ@mail.gmail.com>
Subject: Re: [PATCH v3] iio: light: vcnl4035 add i2c_device_id
To:     Vaishnav M A <vaishnav@beagleboard.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 18, 2020 at 6:47 PM Vaishnav M A <vaishnav@beagleboard.org> wrote:
>
> Add i2c_device_id table for the vl53l0x-i2c driver,
> helps in device instantiation using i2c_new_client_device

In all your patches please refer to the functions like function().
For example, here is i2c_new_client_device().

> or from userspace in cases where device-tree based description
> is not possible now (Example: device on a gbphy i2c adapter
> created by greybus)

Don't forget proper English punctuation, like periods at the end of sentences.

-- 
With Best Regards,
Andy Shevchenko
