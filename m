Return-Path: <SRS0=lRSj=4S=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B08DC3F2D1
	for <linux-iio@archiver.kernel.org>; Sun,  1 Mar 2020 14:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AE2222C2
	for <linux-iio@archiver.kernel.org>; Sun,  1 Mar 2020 14:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583072544;
	bh=284bXu3fOQE3oH2K6kBifonaQN3cfx19oSrJKcI1laQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lUCqoKae6Fl+/C3kfSSyr8hqwZrd8wzCZVL9kzp6RPZ13GYOyw73JY7I8ng7mbE/K
	 5KuJVyUyhsdtA4OiOTuoIYXWwpJvIoK1CGMad9kh1sWPawc1vgMN00A2r8RwwBI7EE
	 PNrdNw3LjJMy8GMOT5tlbR4B6prpSi24oVDQMchw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgCAOWY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 1 Mar 2020 09:22:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:48922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgCAOWY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Mar 2020 09:22:24 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C20A214DB;
        Sun,  1 Mar 2020 14:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583072543;
        bh=284bXu3fOQE3oH2K6kBifonaQN3cfx19oSrJKcI1laQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xvUBe1ao1Shm7OhRFs3MFZHLAet62r8+I5nvPCuVLMprKpC4cbXhwpLRVZbogbfKL
         tnya97ypNrQLVKEbv/EzYf1O1Ylr0revkYHQMFsSaWt3TIcxcQe+oSkPaQJG8GLGoF
         tEDvTNAk2iecSLZMcMX4X4AB35uME1EKpyk47BlU=
Date:   Sun, 1 Mar 2020 14:22:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Wen-chien Jesse Sung <jesse.sung@canonical.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: st_sensors: remap SMO8840 to LIS2DH12
Message-ID: <20200301142218.07a50a42@archlinux>
In-Reply-To: <a4f690f2-19a5-fc67-8072-eb14b8df0017@redhat.com>
References: <20200224095426.25681-1-jesse.sung@canonical.com>
        <a4f690f2-19a5-fc67-8072-eb14b8df0017@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 24 Feb 2020 20:23:28 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 2/24/20 10:54 AM, Wen-chien Jesse Sung wrote:
> > According to ST, the HID is for LIS2DH12.
> > 
> > Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>  
> 
> I added the original "SMO8840" entry since I did not have any
> docs I just copied the "SMO8A90" entry. Looking at the driver
> the only difference seems to be that the LNG2DM only has 8 bits
> accuracy where as the LIS2DH12 has 12 bits. I can confirm that
> this patch works on my Lenovo Ideapad Miix 320, for which the
> original patch was submitted, and that I indeed get 12 bits of
> accuracy with this patch.
> 
> So this patch is:
> 
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
Applied to the fixes-togreg branch of iio.git with fixes
and stable tags added.

Whilst it isn't vital this gets backported, it seems unlikely
to do any harm.

Thanks,

Jonathan

> Regards,
> 
> Hans
> 
> 
> 
> 
> > ---
> >   drivers/iio/accel/st_accel_i2c.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> > index 633955d764cc..849cf74153c4 100644
> > --- a/drivers/iio/accel/st_accel_i2c.c
> > +++ b/drivers/iio/accel/st_accel_i2c.c
> > @@ -110,7 +110,7 @@ MODULE_DEVICE_TABLE(of, st_accel_of_match);
> >   
> >   #ifdef CONFIG_ACPI
> >   static const struct acpi_device_id st_accel_acpi_match[] = {
> > -	{"SMO8840", (kernel_ulong_t)LNG2DM_ACCEL_DEV_NAME},
> > +	{"SMO8840", (kernel_ulong_t)LIS2DH12_ACCEL_DEV_NAME},
> >   	{"SMO8A90", (kernel_ulong_t)LNG2DM_ACCEL_DEV_NAME},
> >   	{ },
> >   };
> >   
> 

