Return-Path: <SRS0=UYdU=5G=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D46DC43332
	for <linux-iio@archiver.kernel.org>; Sat, 21 Mar 2020 17:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4917F20767
	for <linux-iio@archiver.kernel.org>; Sat, 21 Mar 2020 17:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584811344;
	bh=yaW/gg43wAtQnOV5I1zhn71sAt0VN6CiG0CiFTKcQVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1MouUN/csBvbJ5azCztRoByAENC3q+g1Jkb7FifzYvYn+GZhSwSQWFSmNCMejFybl
	 Kxw9w8lCJGxryKZOgoEMNkiaTIRsyUMiKc7+jcJ5xsR3evMNJOqXgW0zW4Av0c23M3
	 IuGBWDPhKfQl0JrLATjoN4f7FQUKB0aKT5shjnHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgCURWX (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 21 Mar 2020 13:22:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbgCURWX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Mar 2020 13:22:23 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA9D320724;
        Sat, 21 Mar 2020 17:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584811342;
        bh=yaW/gg43wAtQnOV5I1zhn71sAt0VN6CiG0CiFTKcQVc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HJuURLcDsWe6Tbz7fU0WNtL7i64hDDfaFjkJrhvlLfUsnan9Yg0NmQYqCj3E5nywT
         widDiee+AFv7LkJGsAc8RTDzIwGqxdagSoSKhJnxgkZQJWgzgc5B0QvQSwPIJtRLpf
         3YgnRm4laz5/RQp4dFvgyioK32eVWWhqmYRqoq/g=
Date:   Sat, 21 Mar 2020 17:22:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <Laszlo.Nagy@analog.com>, <Andrei.Grozav@analog.com>,
        <Michael.Hennerich@analog.com>, <Istvan.Csomortani@analog.com>,
        <Adrian.Costina@analog.com>, <Dragos.Bogdan@analog.com>
Subject: Re: [PATCH v11 3/8] iio: buffer-dmaengine: use %zu specifier for
 sprintf(align)
Message-ID: <20200321172217.18d9e01b@archlinux>
In-Reply-To: <20200321085315.11030-4-alexandru.ardelean@analog.com>
References: <20200321085315.11030-1-alexandru.ardelean@analog.com>
        <20200321085315.11030-4-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 21 Mar 2020 10:53:10 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The 'size_t' type behaves differently on 64-bit architectures, and causes
> compiler a warning of the sort "format '%u' expects argument of type
> 'unsigned int', but argument 3 has type 'size_t {aka long unsigned int}'".
> 
> This change adds the correct specifier for the 'align' field.
> 
> Fixes: 4538c18568099 ("iio: buffer-dmaengine: Report buffer length requirements")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied thanks.

Given lack of users of this infrastructure, I'm not that fussed
about marking this for stable or similar.  However, I don't
mind someone requesting a backport if it is useful to them.

Jonathan

> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index b129693af0fd..94da3b1ca3a2 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -134,7 +134,7 @@ static ssize_t iio_dmaengine_buffer_get_length_align(struct device *dev,
>  	struct dmaengine_buffer *dmaengine_buffer =
>  		iio_buffer_to_dmaengine_buffer(indio_dev->buffer);
>  
> -	return sprintf(buf, "%u\n", dmaengine_buffer->align);
> +	return sprintf(buf, "%zu\n", dmaengine_buffer->align);
>  }
>  
>  static IIO_DEVICE_ATTR(length_align_bytes, 0444,

