Return-Path: <SRS0=EK9n=4D=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56DAC2BA83
	for <linux-iio@archiver.kernel.org>; Sat, 15 Feb 2020 16:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B855D2083B
	for <linux-iio@archiver.kernel.org>; Sat, 15 Feb 2020 16:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581783084;
	bh=7KEq88QVO/CaRCAffnDsUy0udYm4NmK62VSZRwI8ZyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TO2W2cxvDUcDPLHNLwLdkfdiJZPjRN84GIEGR32aQmN+UasMOv76GBJXyM39hFetH
	 JqnGLArBKT0pdDTPctpXm4a8Q6uhugQli1y3wfrDgnx79zfBSxxhrX4TITpf/l7OS2
	 alQj+YicuGO0IvtBKlPapvmOgAFDqvrfOz1m3Fec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgBOQLY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 15 Feb 2020 11:11:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:48806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgBOQLY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Feb 2020 11:11:24 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1B4A2072D;
        Sat, 15 Feb 2020 16:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581783083;
        bh=7KEq88QVO/CaRCAffnDsUy0udYm4NmK62VSZRwI8ZyI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vQfpN7p6u2UAcRlUh4I2sKHlcWwcYR4urpjzU3BcxBi28m5G3Fok7IE6NQIqYzs29
         SXei3yiNrhZlSxU3vMK9gsniDaIw8VpEFt67TV8vGevkLIKdZKjgRRhlCkGz2lBxz7
         /2n58/X5AVido+4voac2ngdDoulT0MWR5CGO3IJw=
Date:   Sat, 15 Feb 2020 16:11:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] iio: dac: AD5770R: Add support
Message-ID: <20200215161120.5ef22f3d@archlinux>
In-Reply-To: <20200213113916.28070-1-alexandru.tachici@analog.com>
References: <20200213113916.28070-1-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 13 Feb 2020 13:39:14 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> This series of patches adds support for the AD5570R
> 14-bit current DAC.
> 
Change log?

Reviewers are really forgetful so good to say what you've addressed
since previous version either in the cover letter or below the --
in each of the patches.

Thanks,

Jonathan

> Alexandru Tachici (2):
>   iio: dac: ad5770r: Add AD5770R support
>   dt-bindings: iio: dac: Add docs for AD5770R DAC
> 
>  .../bindings/iio/dac/adi,ad5770r.yaml         | 188 +++++
>  drivers/iio/dac/Kconfig                       |  10 +
>  drivers/iio/dac/Makefile                      |   1 +
>  drivers/iio/dac/ad5770r.c                     | 695 ++++++++++++++++++
>  4 files changed, 894 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
>  create mode 100644 drivers/iio/dac/ad5770r.c
> 

