Return-Path: <SRS0=eg2u=B2=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F36EC433DF
	for <linux-iio@archiver.kernel.org>; Sun, 16 Aug 2020 08:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD28206DA
	for <linux-iio@archiver.kernel.org>; Sun, 16 Aug 2020 08:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597567838;
	bh=ABDwvuz2XUNkyftQULHLpjYNTrJrDYwZhm4hjZeHHxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jK6Y9MuFq2TdvQipMzb04RQyRhBmelAuD4iQNByIuwewI1rUfB/icmLu541g4Twe+
	 UwGF0A0GdIYCMZZHPOOAHPbo/a5kTJuzmT8ks+XMJDf/0+mNhwhaBYlk+EoabFSsAT
	 l1n8UjZTldjrcr5ibkHclPWklvPChgrdEs6c92RQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgHPIui (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 16 Aug 2020 04:50:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgHPIuh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Aug 2020 04:50:37 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D54A2065C;
        Sun, 16 Aug 2020 08:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597567837;
        bh=ABDwvuz2XUNkyftQULHLpjYNTrJrDYwZhm4hjZeHHxc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xz+LH3WWtpDO9u6gtneOQQo0nBz0Y8wRQff5pvhwK2Wn9aXv4DNn5L28P8DS7HQ1A
         dsyLqLUiPIA0NJ+swxnz9z9gye+LY2UDCSC7dya6+YVyQzB84H5sPbgFtiI/8Ni21n
         7x66ZWT5qMCP7DmXeJd63Qf2vYsNu6Br1KhzYSmI=
Date:   Sun, 16 Aug 2020 09:50:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] dt-bindings: vendor-prefixes: Add vendor prefix
 for Silan
Message-ID: <20200816095033.196461e7@archlinux>
In-Reply-To: <20200811134846.3981475-2-daniel@0x0f.com>
References: <20200811134846.3981475-1-daniel@0x0f.com>
        <20200811134846.3981475-2-daniel@0x0f.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 Aug 2020 22:48:45 +0900
Daniel Palmer <daniel@0x0f.com> wrote:

> Add a prefix for Hangzhou Silan Microelectronics Co., Ltd.
> 
> Website: http://www.silan.com.cn/

No sign off so I can't take this.  See the bit about Developer's Certificate of
Origin in Documentation/process/SubmittingPatches.rst

 + needs to be cc'd to the devicetree list and maintainers.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index f3d847832fdc..5d18c0607b05 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -934,6 +934,8 @@ patternProperties:
>      description: Shiratech Solutions
>    "^si-en,.*":
>      description: Si-En Technology Ltd.
> +  "^silan,.*":
> +    description: Hangzhou Silan Microelectronics Co., Ltd.
>    "^si-linux,.*":
>      description: Silicon Linux Corporation
>    "^sifive,.*":

