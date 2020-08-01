Return-Path: <SRS0=1Shn=BL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B9FC433E0
	for <linux-iio@archiver.kernel.org>; Sat,  1 Aug 2020 16:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1466B207FB
	for <linux-iio@archiver.kernel.org>; Sat,  1 Aug 2020 16:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596297767;
	bh=p2oDC8N96YV8ZYXENTyf4/gTFtcs++qxxMizDPrcRDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=giANYBhN6OuTOOIijj4uzsLgf5aA45jaCUgPX+lJ3QNnaT4iRfB8GXfP7LJqCB9US
	 UKMaPAVzHlNiPZ9GxA3LdQ0zZ28jPzm9aAXyYXX/vUKfH+35jUYJ0DUOopOsMKy9he
	 UWbwkD3ijvi7YxXteLvrulVL1OIYtww6CCAus060=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgHAQCo (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 1 Aug 2020 12:02:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgHAQCn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Aug 2020 12:02:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 487AA207BC;
        Sat,  1 Aug 2020 16:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596297763;
        bh=p2oDC8N96YV8ZYXENTyf4/gTFtcs++qxxMizDPrcRDg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YwHwRk01ZdxpAR7bbkL/Psag7Er8KU65zF/vJW/GDIO4EhfSKtjwqmELyMfHmwGvr
         csVCHv7u8gvajzdrvWYiywe/hLiCKs+/rgctewH8QYauc+KLedUkh63tuCL3b1vEwe
         4VxHmyBJbu6hZv25YpVbFhY85erKyHZePQMc49oM=
Date:   Sat, 1 Aug 2020 17:02:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christian Eggers <ceggers@arri.de>
Cc:     <stable@vger.kernel.org>, "Hartmut Knaack" <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: trigger: sysfs: Disable irqs before calling
 iio_trigger_poll()
Message-ID: <20200801170234.2953b087@archlinux>
In-Reply-To: <20200727145714.4377-1-ceggers@arri.de>
References: <20200727145714.4377-1-ceggers@arri.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Jul 2020 16:57:13 +0200
Christian Eggers <ceggers@arri.de> wrote:

> iio_trigger_poll() calls generic_handle_irq(). This function expects to
> be run with local IRQs disabled.

Was there an error or warning that lead to this patch?
Or can you point to what call in generic_handle_irq is making the
assumption that we are breaking?

Given this is using the irq_work framework I'm wondering if this is
a more general problem?

Basically more info please!

Thanks,

Jonathan


> 
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> Cc: stable@vger.kernel.org
> ---
>  drivers/iio/trigger/iio-trig-sysfs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
> index e09e58072872..66a96b1632f8 100644
> --- a/drivers/iio/trigger/iio-trig-sysfs.c
> +++ b/drivers/iio/trigger/iio-trig-sysfs.c
> @@ -94,7 +94,9 @@ static void iio_sysfs_trigger_work(struct irq_work *work)
>  	struct iio_sysfs_trig *trig = container_of(work, struct iio_sysfs_trig,
>  							work);
>  
> +	local_irq_disable();
>  	iio_trigger_poll(trig->trig);
> +	local_irq_enable();
>  }
>  
>  static ssize_t iio_sysfs_trigger_poll(struct device *dev,

