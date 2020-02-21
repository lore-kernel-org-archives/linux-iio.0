Return-Path: <SRS0=70H6=4J=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D94C35646
	for <linux-iio@archiver.kernel.org>; Fri, 21 Feb 2020 13:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC272073A
	for <linux-iio@archiver.kernel.org>; Fri, 21 Feb 2020 13:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582290844;
	bh=GSUnXzZDnVK1JR5RPGd8iMwG93ajLzgH3fqWj/GzeGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=flEGOyouezg7PpoqMcfO+zMxpSnE80gsXHiIgkqbavAsjUUUcKW7b6/I7eJwBCHin
	 c1/qWtCgJ8IHI06U0zvVhObXcaz8TG0wNh4tGZMn9mQJXGllPZgGYO3p1YckZFbxyL
	 tMm/vigVkVFoWyENc90ijK06rLILCTL6JS6j/HeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBUNOE (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:14:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:44954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbgBUNOE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 08:14:04 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80DC72073A;
        Fri, 21 Feb 2020 13:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582290843;
        bh=GSUnXzZDnVK1JR5RPGd8iMwG93ajLzgH3fqWj/GzeGA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y9oRT1CdyB9mmI9DD/dyroJCmr/CIH7wlHUSxiwZAs4anlTgGvLt6VoUiTkISXGDZ
         aIIcs3aRK0wetHE597M9IghixvB0iFHlk1qQVtFwtYkG64mMZcfwhE1f9F/oYBYsNk
         C9r+G/HTi0PuRXIKDqYjawr2O0oDTz6RZckZL6Ys=
Date:   Fri, 21 Feb 2020 13:13:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: imu: adis: update 'adis_data' struct
 doc-string
Message-ID: <20200221131359.3b5f54d8@archlinux>
In-Reply-To: <20200221114943.2056-2-alexandru.ardelean@analog.com>
References: <20200221114943.2056-1-alexandru.ardelean@analog.com>
        <20200221114943.2056-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 21 Feb 2020 13:49:42 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The doc-string has been neglected over time.
> This change updates it with all the missing info.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Looks good to me.  Will pick up in v2.
> ---
>  include/linux/iio/imu/adis.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 0787a3aabd05..11c915b61ae2 100644
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

