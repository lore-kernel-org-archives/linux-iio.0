Return-Path: <SRS0=UYdU=5G=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C81BC4332D
	for <linux-iio@archiver.kernel.org>; Sat, 21 Mar 2020 17:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0A22076F
	for <linux-iio@archiver.kernel.org>; Sat, 21 Mar 2020 17:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584811276;
	bh=ZnSAqtrhUAG+X7F2ZLoeV+FolVsaUPM8D6kykK+Je5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZJ7mayDD/6WRVJOwwtlc0bFiFuSn2taEftVBeKzulJ/DPF+d6dWrjC3StgtKkLDI5
	 wW0G43IrCASOjhHX40YfFYRRY7Pwr/vStSJkZaSycUQdNuokLp3+otDdprJQgijWwj
	 1o5IDvAadeFsLYmfGLsvNInFzDIk+imlkVFEQEFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgCURVP (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 21 Mar 2020 13:21:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgCURVP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Mar 2020 13:21:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C4C120724;
        Sat, 21 Mar 2020 17:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584811275;
        bh=ZnSAqtrhUAG+X7F2ZLoeV+FolVsaUPM8D6kykK+Je5E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P0/qkk5h1z7SkuAlp0OHDUa/VRxaURrpwKxtm39+a3g1IFEYGUHcag+VvZ8qkOfak
         6TccdLohdAEUtrdRPbG92tHECiTRT76ArUaT/UbDiYLpSaPKVETvwge0tqlSzfgsjt
         irmVTuFp3dsTxawbSWS3FimFvgVn51S2MCyFmW4E=
Date:   Sat, 21 Mar 2020 17:21:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <Laszlo.Nagy@analog.com>, <Andrei.Grozav@analog.com>,
        <Michael.Hennerich@analog.com>, <Istvan.Csomortani@analog.com>,
        <Adrian.Costina@analog.com>, <Dragos.Bogdan@analog.com>
Subject: Re: [PATCH v11 2/8] include: fpga: adi-axi-common.h: add version
 helper macros
Message-ID: <20200321172110.03524338@archlinux>
In-Reply-To: <20200321085315.11030-3-alexandru.ardelean@analog.com>
References: <20200321085315.11030-1-alexandru.ardelean@analog.com>
        <20200321085315.11030-3-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 21 Mar 2020 10:53:09 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The format for all ADI AXI IP cores is the same.
> i.e. 'major.minor.patch'.
> 
> This patch adds the helper macros to be re-used in ADI AXI drivers.
> 
> Acked-by: Moritz Fischer <mdf@kernel.org>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied,

Thanks,

Jonathan

> ---
>  include/linux/fpga/adi-axi-common.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/fpga/adi-axi-common.h
> index ebd4e07ae3d8..141ac3f251e6 100644
> --- a/include/linux/fpga/adi-axi-common.h
> +++ b/include/linux/fpga/adi-axi-common.h
> @@ -16,4 +16,8 @@
>  #define ADI_AXI_PCORE_VER(major, minor, patch)	\
>  	(((major) << 16) | ((minor) << 8) | (patch))
>  
> +#define ADI_AXI_PCORE_VER_MAJOR(version)	(((version) >> 16) & 0xff)
> +#define ADI_AXI_PCORE_VER_MINOR(version)	(((version) >> 8) & 0xff)
> +#define ADI_AXI_PCORE_VER_PATCH(version)	((version) & 0xff)
> +
>  #endif /* ADI_AXI_COMMON_H_ */

