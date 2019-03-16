Return-Path: <SRS0=kDFh=RT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D90C43381
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 19:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED475218A1
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 19:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfCPTNz (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 Mar 2019 15:13:55 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:46378 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfCPTNz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Mar 2019 15:13:55 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 1F89B9E7589;
        Sat, 16 Mar 2019 19:13:52 +0000 (GMT)
Date:   Sat, 16 Mar 2019 19:13:51 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Karuna Grewal <karunagrewal98@gmail.com>
Cc:     linux-iio@vger.kernel.org, dragos.bogdan@analog.com
Subject: Re: [GSoC] AD7292 driver project
Message-ID: <20190316191351.2373d46d@archlinux>
In-Reply-To: <CAHRz_ybdmvgntoVjvSizUKLKETJasHyucoPM56v2Xrf=3K30Hw@mail.gmail.com>
References: <CAHRz_ybdmvgntoVjvSizUKLKETJasHyucoPM56v2Xrf=3K30Hw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 16 Mar 2019 16:09:36 +0530
Karuna Grewal <karunagrewal98@gmail.com> wrote:

> Hello,
> 
> I'm interested in working on the AD7292 driver for Linux kernel as a
> part of the GSoC project. I've previous experience working with device
> drivers and am also familiar with couple of Linux kernel's subsystems.
> For a starting point I wonder if someone can point out some tasks
> which I could work upon as the project page doesn't elaborate much
> about it.
> In case the idea is to start working on the driver itself I'd like to
> discuss about the same.
> 
> Best Regards,
> Karuna Grewal

Hi Karuna and welcome to IIO.

I have nothing (directly) to do with the GSOC projects, but I'm always
happy to suggest tasks to anyone ;)

Obviously I don't know how 'in depth' you would like, but a couple
of immediate thoughts come to mind.

We have been trying to remove all direct use of the mlock mutex
in struct iio_dev from drivers.  It has one very specific and tightly
defined purpose to protect drivers from trying to do things they
shouldn't when changing from a polled mode to one which is interrupt
driven (DIRECT to BUFFERED).  Unfortunately we weren't great at
enforcing the distinction in the early days of IIO.

The solution is almost always to replace the use of mlock with
either calls to iio_claim_direct_mode (if it is an open coded
version of what the mlock is intended for) or to introduce a
lock within the driver itself with well defined scope covering
whatever mlock was incorrectly being used for.

Another traditional area for people first getting involved in IIO is
to look at the drivers that are still in drivers/staging/iio
but to be honest there are not many left there now so that isn't
as fruitful as it used to be.  If you do want to look at those, do
send a message to the list to confirm no one else is currently
looking a the same driver.

Also very useful if you are going to be looking at IIO drivers is
to get yourself setup with a suitable test board and any random
cheap sensor (dx.com and similar are very cheap if rather slow).

That way you will have verified your buses and similar before
trying to start work on a new sensor.  Far too much time gets wasted
trying to get a device to talk, just to discover something is wrong
in the platform setup and nothing is going out on the wires.

If you want more suggestions, feel free to ask.

Jonathan
