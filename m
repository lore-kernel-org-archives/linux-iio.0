Return-Path: <SRS0=4ymh=7N=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0E3C433E0
	for <linux-iio@archiver.kernel.org>; Sun, 31 May 2020 10:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B99A2076B
	for <linux-iio@archiver.kernel.org>; Sun, 31 May 2020 10:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590921012;
	bh=jd0DVTpfscXz9U0UAW8zAtH95tY4m/P0mcYupDb1RrI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZQgHm0G/FPkh9YZFMAOiDm6FWuQvp3C4+O2llSox0DS21mtZA/Ix4T7uE20QTVWRp
	 zLjq31ndqRqsqaJOjgt6s5CsNgb/VpRZ3RJuWhLild+3JmJIcse6U7sIajm52X2cH/
	 txW7Mq5LhysEk1w1YCYYYy4s3+HBpuYkXjD8UlbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgEaKaL (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 31 May 2020 06:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgEaKaK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 06:30:10 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81A1D2070B;
        Sun, 31 May 2020 10:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590921010;
        bh=jd0DVTpfscXz9U0UAW8zAtH95tY4m/P0mcYupDb1RrI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WNLKe88HtMhjBx1FBqoilYe/kwYnWmZg9apVT2HdHvIaBE30zg0T44BoWn0Ecj2CJ
         U7m7jvy+cEKQJ0Cw1pO41vkHip+NTXV9I7cNgAXwrmu9huPYp/7mJFwQAwp4jZxFhc
         i7CENNAZjpp0RI3ZIyZuoddPsR+tEDowmjKN6U6k=
Date:   Sun, 31 May 2020 11:30:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christian Oder <me@myself5.de>
Cc:     myself5@carbonrom.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chuhong Yuan <hslester96@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mxc4005: add support for mxc6655
Message-ID: <20200531112951.085507de@archlinux>
In-Reply-To: <20200529200550.357118-1-me@myself5.de>
References: <20200529200550.357118-1-me@myself5.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 29 May 2020 22:05:49 +0200
Christian Oder <me@myself5.de> wrote:

> The mxc6655 is fully working with the existing mxc4005 driver.
> Add support for it.
> 
> Signed-off-by: Christian Oder <me@myself5.de>

One query on ACPI bindings.  What is there already may
be missleading :(


> ---
>  drivers/iio/accel/mxc4005.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> index 3d5bea651923..3b8614352cb4 100644
> --- a/drivers/iio/accel/mxc4005.c
> +++ b/drivers/iio/accel/mxc4005.c
> @@ -474,12 +474,14 @@ static int mxc4005_probe(struct i2c_client *client,
>  
>  static const struct acpi_device_id mxc4005_acpi_match[] = {
>  	{"MXC4005",	0},
> +	{"MXC6655",	0},

Do we have a reference for these ACPI bindings?  While they may seem
obvious, memsic don't have a registered PNP or ACPI ID that I can
find.  If these are in the wild (i.e. in shipping firmware) then we
can take them as defacto bindings, otherwise we should avoid making
them so by putting them in the driver.

Quite a few similar bindings got in a while back that I should have
noticed, but I wasn't so familiar with ACPI back then.  Some
scrubbing of these has gone on recently, but there are lots still
left in IIO.

If we aren't sure, then drop the ACPI addition and just leave the 
i2c one below.  Adding an explicit DT binding table would also be
good if that is method you are using to probe this (or PRP0001
from acpi which uses the dt bindings table)

Thanks,

Jonathan


>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, mxc4005_acpi_match);
>  
>  static const struct i2c_device_id mxc4005_id[] = {
>  	{"mxc4005",	0},
> +	{"mxc6655",	0},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, mxc4005_id);

