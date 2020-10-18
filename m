Return-Path: <SRS0=x94u=DZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0744DC433DF
	for <linux-iio@archiver.kernel.org>; Sun, 18 Oct 2020 18:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B19EB22261
	for <linux-iio@archiver.kernel.org>; Sun, 18 Oct 2020 18:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Chuc9TiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgJRSaj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 18 Oct 2020 14:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgJRSai (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 14:30:38 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90C4C061755;
        Sun, 18 Oct 2020 11:30:36 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e15so1433700pfh.6;
        Sun, 18 Oct 2020 11:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4kXVR26g01zAlEQKP/uOo8U6LDTHA/+JFKQO/gDiHaQ=;
        b=Chuc9TiQVYJce/kc7HOr6Vz6DqbP0pZzo7CYgprBnNODRns+sPUNWVtpRsSVCDjnEo
         4nB82oFBeiU53kY3fKBigqwmtO6I5LXdFVsxRW83PbOzDpMDhy1YsARLic7xhblwjsTO
         jsKMrChy7ybYJtA+UfXwhFb++Tz8Ty3HBWaTHmc/8CjZQlPjOAqafRmhaX5oYPXOQmE/
         lGq0OSjqwvIN3iC0/qa+Kx6aZNhwSfwgH4yl3Jq6C1QsxdICTe6IJppO19VRUKbcY1U3
         TXd76j9I8MzfccUyHQ/I2W9ERGNorkPGMPZSpmFeIECGRE8gGM1JShp+0gVaYNn5rhgJ
         XfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4kXVR26g01zAlEQKP/uOo8U6LDTHA/+JFKQO/gDiHaQ=;
        b=nHCozOiXylxfy5/Y/5+7iLLNmjj7Vx2QQW2GXHUCUBH5bzikKSksV5tH21hhNHQ3QQ
         0E9zpQ2NjHBe5llcPNKwj23LNeTn1ztQB7WclzcPWL5s8YHJFzxvNLI9XwibAwvheUkd
         NqronOzJp9qNj5lxDYrhdMeeUZ2UKrT2s3gjlJRo0QSFZjSG/vdtf3sQEmIscHyDnQu7
         OhSnbImRoeI8yWLeJbTvbr+R+K/DXK43terVByoPlKgzaDpsK6a94L3jgEkM94tAwk4k
         XX6W3cyWu7cHZVPAcJA4liQAip4yHK8bVV+o0er1r/xkHr/Wk+2FGEaKGXWcyW6ri7E3
         XyoQ==
X-Gm-Message-State: AOAM533MQFnC9o7WL6c40+5iAn7iw4E2WiXd53YyE8LUaf1Cz1Bg9C75
        uYMJrb/PtDfScf7R53jX5RGLvKeCxtJFDz/cCYw=
X-Google-Smtp-Source: ABdhPJzWTQvXj/v1GkdatZGOYL0FByudV3TnGFj4s5kSy+VHi/TWiGAwp8gzYp5FjICavoAKOWpgA24B6tR7FvjqIGs=
X-Received: by 2002:a63:1e02:: with SMTP id e2mr1484262pge.74.1603045836429;
 Sun, 18 Oct 2020 11:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201018151726.GA219649@ubuntu>
In-Reply-To: <20201018151726.GA219649@ubuntu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 18 Oct 2020 21:30:20 +0300
Message-ID: <CAHp75Vdk4J5t3A6b+w2-7M1zfeA2wkaf_QH_HYWZ2TY4xaKmrw@mail.gmail.com>
Subject: Re: [PATCH v3] iio: proximity: vl53l0x-i2c add i2c_device_id
To:     Vaishnav M A <vaishnav@beagleboard.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Song Qiang <songqiang1304521@gmail.com>,
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

On Sun, Oct 18, 2020 at 6:53 PM Vaishnav M A <vaishnav@beagleboard.org> wrote:
>
> Add i2c_device_id table for the vl53l0x-i2c driver,
> helps in device instantiation using i2c_new_client_device
> or from userspace in cases where device-tree based description
> is not possible now (Example: device on a gbphy i2c adapter
> created by greybus)

Same comments as per v1.

-- 
With Best Regards,
Andy Shevchenko
