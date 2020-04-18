Return-Path: <SRS0=1voA=6C=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5562CC38A29
	for <linux-iio@archiver.kernel.org>; Sat, 18 Apr 2020 15:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A5C8221E9
	for <linux-iio@archiver.kernel.org>; Sat, 18 Apr 2020 15:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587224772;
	bh=gAUQLU0v6aIaqVNJTJyUkmBKiT7bjoHQztA86lZZWUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=T5j7ySTXGf1S5mcx9aqlEuUYG2UGwFP95vpp345c6yucSzB4YKNKJRb630hUVRaPC
	 6ohx5NJdW61TWpvf1TNgePR3hw8dmIwkVYV37fW0WKHlkryhAvkkYZecCATxnr+agt
	 JeDrGsKkndXpPVVKrw8+SMOHZCCThlrQnnQv8E/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgDRPqL (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Apr 2020 11:46:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgDRPqL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Apr 2020 11:46:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0569214AF;
        Sat, 18 Apr 2020 15:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587224770;
        bh=gAUQLU0v6aIaqVNJTJyUkmBKiT7bjoHQztA86lZZWUw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=icNAzWYO9Tb9HX63e1cMv730uULPHXtmDTpWrg7Xq+GVvDnTrnFV2mxwUllJeY8rn
         Mb7cOjY5/B13H3mLoVcbxMWLw7WYp0dQJUxbqogSFbWFRbQMJL6WCXz5+69OtZqHVL
         0KnGWdkIsElRZ2ju1aPpnRpqvH0a63bTOSG2krsg=
Date:   Sat, 18 Apr 2020 16:46:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iio: documentation ltc2632_chip_info add
 num_channels
Message-ID: <20200418164606.42ad772f@archlinux>
In-Reply-To: <20200416012016.21422-2-chris.ruehl@gtsys.com.hk>
References: <20200416012016.21422-1-chris.ruehl@gtsys.com.hk>
        <20200416012016.21422-2-chris.ruehl@gtsys.com.hk>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Apr 2020 09:20:09 +0800
Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:

> The documentation for ltc_2632_chip_info missed the desciption for the
> num_channels. This trivial patch adds it.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>

Please make sure to pick up tags from earlier versions.  Uwe
gave one to v3 + added a fixes tag to make it explicit which
commit introduced the field but didn't document it.

I'm in two minds on whether to leave that in the commit when I
take it as the AI bot may well pick the patch up and backport
it which seems a bit pointless if harmless!

Still if you respin please add it and I can make up my mind then.
In meantime the series needs DT review.

> ---
> v4:
> Fix commit text.
> 
>  drivers/iio/dac/ltc2632.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
> index 7adc91056aa1..2a84ea654645 100644
> --- a/drivers/iio/dac/ltc2632.c
> +++ b/drivers/iio/dac/ltc2632.c
> @@ -24,6 +24,7 @@
>  /**
>   * struct ltc2632_chip_info - chip specific information
>   * @channels:		channel spec for the DAC
> + * @num_channels:	DAC channel count of the chip
>   * @vref_mv:		internal reference voltage
>   */
>  struct ltc2632_chip_info {

