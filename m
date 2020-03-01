Return-Path: <SRS0=lRSj=4S=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8288AC3F2CD
	for <linux-iio@archiver.kernel.org>; Sun,  1 Mar 2020 15:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C48B21775
	for <linux-iio@archiver.kernel.org>; Sun,  1 Mar 2020 15:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583078145;
	bh=6+I438xeRY7gAYTcU8UX0mkNDBmhI0egZDPQhExR6O0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1NegF3O+TtXSJoTx51QrzJCPosQAJ2M8ZoaLiIvvQ3hUEimaLcu3GlWYGFB4x7GIN
	 VT0Cco2s5sVGdRnbf2+CZna9QrOo2XQbriyAc90WDzCXun+gZjNn4W3x52szccUjAh
	 f+EQfvOPZWR9ID7IFWAqfP8po4b8tUNHzgo8W9OY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgCAPzo (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 1 Mar 2020 10:55:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgCAPzo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Mar 2020 10:55:44 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7E502468E;
        Sun,  1 Mar 2020 15:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583078143;
        bh=6+I438xeRY7gAYTcU8UX0mkNDBmhI0egZDPQhExR6O0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0TK9SakeMTGV0hJi247oeAJ8fi3Qts9d/8zPqBuRIBisjP80oKOcwXadRp38ZGFoh
         p3isp1RjZX0ycyKrR3BS8Fa9Bei3TNCmnDQ/HsaaWCeohbVFJmpQ38tqijAKBo37Ra
         eHuq/SueeiL/LH04/yR+1FYo2bIZIM8taQ3I96eQ=
Date:   Sun, 1 Mar 2020 15:55:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: imu: adis: update 'adis_data' struct
 doc-string
Message-ID: <20200301155536.400856e8@archlinux>
In-Reply-To: <20200225103319.20751-2-alexandru.ardelean@analog.com>
References: <20200225103319.20751-1-alexandru.ardelean@analog.com>
        <20200225103319.20751-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Feb 2020 12:33:18 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The doc-string has been neglected over time.
> This change updates it with all the missing info.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks

Jonathan

> ---
>  include/linux/iio/imu/adis.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 63e456aa5c8a..20339025c75f 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -43,10 +43,14 @@ struct adis_timeout {
>   * @diag_stat_reg: Register address of the DIAG_STAT register
>   * @prod_id_reg: Register address of the PROD_ID register
>   * @prod_id: Product ID code that should be expected when reading @prod_id_reg
> + * @self_test_mask: Bitmask of supported self-test operations
>   * @self_test_reg: Register address to request self test command
> + * @self_test_no_autoclear: True if device's self-test needs clear of ctrl reg
>   * @status_error_msgs: Array of error messgaes
> - * @status_error_mask:
> + * @status_error_mask: Bitmask of errors supported by the device
>   * @timeouts: Chip specific delays
> + * @enable_irq: Hook for ADIS devices that have a special IRQ enable/disable
> + * @has_paging: True if ADIS device has paged registers
>   */
>  struct adis_data {
>  	unsigned int read_delay;

