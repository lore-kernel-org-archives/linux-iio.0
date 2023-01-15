Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616BEC3DA78
	for <linux-iio@archiver.kernel.org>; Sun, 15 Jan 2023 18:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjAOSZZ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 15 Jan 2023 13:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjAOSZY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Jan 2023 13:25:24 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 15 Jan 2023 10:25:22 PST
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D500872A5
        for <linux-iio@vger.kernel.org>; Sun, 15 Jan 2023 10:25:22 -0800 (PST)
Received: from localhost (88-113-26-56.elisa-laajakaista.fi [88.113.26.56])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id d28f9099-9501-11ed-8d6d-005056bd6ce9;
        Sun, 15 Jan 2023 20:24:18 +0200 (EET)
From:   andy.shevchenko@gmail.com
Date:   Sun, 15 Jan 2023 20:24:17 +0200
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     jic23@kernel.org, swboyd@chromium.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: proximity: sx_common: Add old register mapping
Message-ID: <Y8RE0QBbNWbfwi0l@surfacebook>
References: <20221220193926.126366-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220193926.126366-1-gwendal@chromium.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Tue, Dec 20, 2022 at 11:39:26AM -0800, Gwendal Grignou kirjoitti:
> Older firmwares still send sensor configuration using a list of
> registers with opaque values defined during sensor tuning.
> sx9234 and sx9360 sensor on ACPI based devices are concerned.
> More schema to configure the sensors will be needed to support devices
> designed for windows, like Samsung Galaxy Book2.
> 
> Support schema is: "<_HID>.<register_name>". For instance
> "STH9324,reg_adv_ctrl2" in:
> 
>     Scope (\_SB.PCI0.I2C2)
>     {
>         Device (SX28)
>         {
>             Name (_HID, "STH9324")  // _HID: Hardware ID
> ...
>             Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
>             {
>                 ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /*
> Device Properties for _DSD */,
>                 Package (0x3F)
>                 {
> ...
>                     Package (0x02)
>                     {
>                         "STH9324,reg_adv_ctrl2",
>                         Zero
>                     },`

...

Can we use acpi_device_hid() from the ACPI companion device instead of calling
acpi_match_device()?

Note that in this case you won't need half of this patch that passes acpi_id
here and there.

...

> +	scnprintf(prop, ARRAY_SIZE(prop), "%s,reg_%s", id->id, reg_def->property);

Why c? The regular snprintf() will work the same since you haven't checked for
the error.

-- 
With Best Regards,
Andy Shevchenko


