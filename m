Return-Path: <SRS0=squ6=RU=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C57C43381
	for <linux-iio@archiver.kernel.org>; Sun, 17 Mar 2019 17:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CBB2087C
	for <linux-iio@archiver.kernel.org>; Sun, 17 Mar 2019 17:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Enbusdwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfCQRTB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 17 Mar 2019 13:19:01 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:45654 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfCQRTB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Mar 2019 13:19:01 -0400
Received: by mail-pg1-f182.google.com with SMTP id y3so502057pgk.12
        for <linux-iio@vger.kernel.org>; Sun, 17 Mar 2019 10:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YE9vnTqTHXrC1ZXwpH/JhE1178o3gcc4NNuer9fEUwE=;
        b=EnbusdwzzcHj+GQhfkUiZAgamrONr86iPb2cdd2ObmGI6tMfWx4EMHtyRWGIkw78dy
         8jaghypTdmYu2v19HbEE7hNnv5Nap5EACiGnuSN8vj3+blc6jVxLm3xi96TfCkWQObKq
         MPZesIycZDcgrEyeF5s1A3X9uLl5WCt6AhMyz22E539gIA9Hs7lMvBdY34Vmx+eGw6sB
         kNbCK32ywmMqhXaXHjiK5z8ilWGgYnYdJl5buiOFhZ9NNnEXCt3CCPuxKGMhcl3Od0C7
         NafUpyqG/jJfX5sP7iX1AgrxrqKRYR+IgxIzKTlpzB1KNQXaFyh9TBLesblj37KdEvPj
         fR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YE9vnTqTHXrC1ZXwpH/JhE1178o3gcc4NNuer9fEUwE=;
        b=ss8AyFny9il1dTuWDEbxuFF6NWuYnZk2O+EoVZPA0bPxaba3Et+Rk5/BpetiedMeH0
         JTZrs0TgGejERg81bigKpUxvYPKtrJPXLLmvCWzvxhGM9drP+KwuQED86JDAZIxNOEWB
         Sgc5DkvO7byNP8uH2Tlj9qS6MyL7ILh3B8K4tZDC07dT2xdTf9Uww7EOWsn/ecFmqZY+
         w3ceXRtqmHf+RXXjRpYAdshKrsKEJqjhysyZLZklllQcC50XA3Dugd2gddve9IEBTpTv
         lFHQOCiD5pGunHPzLZqKI8Fc72qRyQf4XDdRXnqjiPKadgM4wfXwlS8oLzJ1G3L+7mef
         7t8A==
X-Gm-Message-State: APjAAAXnPt2AE03sVniVTeGMca9yGup+mG26wnwvh+V2+PnHRGlRjeuq
        GmV2FkUnAwzKBaF/Tbv5iB0=
X-Google-Smtp-Source: APXvYqxboZxglNcSl64BMmx0P2bkCoonPolP5O8rRRGuCs6mEsN5D+uhYKoqJ6Ltd6fYHH0GHKUlkQ==
X-Received: by 2002:a65:6148:: with SMTP id o8mr13800909pgv.442.1552843139975;
        Sun, 17 Mar 2019 10:18:59 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.77.40.178])
        by smtp.gmail.com with ESMTPSA id l7sm25477656pfj.162.2019.03.17.10.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 10:18:58 -0700 (PDT)
Date:   Sun, 17 Mar 2019 22:48:48 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Karuna Grewal <karunagrewal98@gmail.com>
Cc:     linux-iio@vger.kernel.org, dragos.bogdan@analog.com
Subject: Re: [GSoC] AD7292 driver project
Message-ID: <20190317171848.GA7105@himanshu-Vostro-3559>
References: <CAHRz_ybdmvgntoVjvSizUKLKETJasHyucoPM56v2Xrf=3K30Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHRz_ybdmvgntoVjvSizUKLKETJasHyucoPM56v2Xrf=3K30Hw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 16, 2019 at 04:09:36PM +0530, Karuna Grewal wrote:
> Hello,
> 
> I'm interested in working on the AD7292 driver for Linux kernel as a
> part of the GSoC project. I've previous experience working with device
> drivers and am also familiar with couple of Linux kernel's subsystems.
> For a starting point I wonder if someone can point out some tasks
> which I could work upon as the project page doesn't elaborate much
> about it.

Agreed!

You may try the following:
https://kernelnewbies.org/IIO_tasks

Please don't send these Tasks on iio list.

> In case the idea is to start working on the driver itself I'd like to
> discuss about the same.

My personal opinion: Try to get atleast a small patchset accepted in
the kernel. It helps you get familiar with all the tools and how kernel
cycle moves. I strongly agree with Jonathan on 'setup', whatever
hardware you plan to use in the project say., how would you build/test
kernel on Rpi or beagle or QEMU or diolan ? dt-overlay, acpi
enumeration ?

Pray that AD7292 doesn't have an unusual SPI interface.
Otherwise you end up like me ;)

If you really want to try some sensor, I would recommend https://www.tanotis.com/
to buy them as they have cheap and low duty-taxes+GST+ ...

In my case I ordered from mouser IIRC:
₹ 1,459.58(sensor) + ₹ 1,750.58(duty taxes + other taxes from Indian
Gov.)

Yeah, taxes are more than the actual sensor! Surreal :/

Feel free to query mentors and community with questions -- I would
join you too.


Goodluck!
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
