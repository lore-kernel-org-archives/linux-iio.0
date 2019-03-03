Return-Path: <SRS0=rKOe=RG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43207C43381
	for <linux-iio@archiver.kernel.org>; Sun,  3 Mar 2019 09:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0672E20836
	for <linux-iio@archiver.kernel.org>; Sun,  3 Mar 2019 09:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WKN47ZfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfCCJMn (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 3 Mar 2019 04:12:43 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46940 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfCCJMn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Mar 2019 04:12:43 -0500
Received: by mail-lj1-f195.google.com with SMTP id v16so1688431ljg.13
        for <linux-iio@vger.kernel.org>; Sun, 03 Mar 2019 01:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HmLJWt8K5S/nB8MiZ35Y63gOWOA+M10qOBsjuiy/ijg=;
        b=WKN47ZfLe480jUkwFOIA7MCA3RJYpmi0jgLG2SwdowjbIdJEJUQ9jnY/hrsfpS0Wa1
         aXXiHuxm7DK7fySsLjBi0RIpiGw83858AaW96frnO7Ht4NK3ktK27Msh/t6uSHNo1RRU
         UsMQgpif4IBs+QYYmEvH+lBBz0guVpC4DiEuU9xqCdD+YCOkcCqIg4MRDGD13F0/vW5D
         zblcIlPtf1kAX3Kcghy0UOc3o6O+Tm0M12uz/sLLDYSt3k6WVgP9SVpLxa0OOhkVZaK6
         kf8OThau3F79c7vls8Ecoyl8NgvDjjTIsHnsuBWbTDt2QkXvhM8T4kTVCn5C9ftovnOl
         f1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HmLJWt8K5S/nB8MiZ35Y63gOWOA+M10qOBsjuiy/ijg=;
        b=QTwHwrj4Y9n1LnFaaqyNp4bOLvto3E9k2J4sexH+tTC+uxAJq/Pqlajunrx7quWF0P
         7+JpxmU7ph7mrDiUbF+1RZnkx5tNdzFGoxdAKtVr0Ak1mH5a6+2eJDFOwwXCtxxM5Qo4
         kXN+dKQdS6xvQr0sbYbGzkwVlE1zR9XoY0NRzsW+vIYU6/WB3JjNni95r8NwuT2tupBk
         ep7CPtVBdH36+HTqjZsn7Xv7AZG/sqmsYHcuZj/1jXetqAwH+GMqk9W+YkhPylvZSw7j
         6xhqOtBZXkbDpGhfNl8TxsKr7djt8G4MKB8L96hv5/z1Vlxhq2/RcABehzZBqFbDJ5yZ
         SaqA==
X-Gm-Message-State: APjAAAVi4rwHltnV3pQAH7Qlu1JbaItJolWuXGnxmlNk5+cH3BZB32PK
        Jbzam4HGVw8NRVDFo6yza84c+dSBXEpAlSxs4C3V8w==
X-Google-Smtp-Source: APXvYqzol49Wi5BPmfWc8VkMoW7uudM0hYTDFe7CZFdOxC05yiTWQzZ6xjRqj4BnMNpZfQ3eRkYCCYuB8CTmGXGD8uY=
X-Received: by 2002:a2e:5bc9:: with SMTP id m70mr7484589lje.159.1551604361306;
 Sun, 03 Mar 2019 01:12:41 -0800 (PST)
MIME-Version: 1.0
References: <20190302165455.6594-1-cerg2010cerg2010@mail.ru>
In-Reply-To: <20190302165455.6594-1-cerg2010cerg2010@mail.ru>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 3 Mar 2019 10:12:28 +0100
Message-ID: <CACRpkdaCv9xp1UgnKqkfNRK_4F-gONQLzeM8nj-3LQMrCXm1pw@mail.gmail.com>
Subject: Re: [PATCH] iio: gyro: mpu3050: fix chip ID reading
To:     Sergey Larin <cerg2010cerg2010@mail.ru>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 2, 2019 at 5:55 PM Sergey Larin <cerg2010cerg2010@mail.ru> wrote:

> According to the datasheet, the last bit of CHIP_ID register controls
> I2C bus, and the first one is unused. Handle this correctly.
>
> Signed-off-by: Sergey Larin <cerg2010cerg2010@mail.ru>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
