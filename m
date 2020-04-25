Return-Path: <SRS0=dRc7=6J=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85BDC54FCB
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 15:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 996592071E
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 15:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587828418;
	bh=klMtI9c3hsQkJBnE/PQB846p6NO18kKSrKvujZqCmyE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=W2JlmhvRZ+ssNbiQdmqY86caUdWudeKl9Qt/hVtJ43720/WBIJD63GLKSQB3h2LvO
	 yfIccxhC1Ux5s7kpAd4SMVlnCv3EJOzIDwnRp+s2XOaAZixpeGkX/938HHhCeCIKsk
	 d1Y0UmwPS20XmkFabxLElD4iUv1dppSyVOwDpJ+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDYP06 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 25 Apr 2020 11:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgDYP05 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 11:26:57 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BAFB2071C;
        Sat, 25 Apr 2020 15:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587828417;
        bh=klMtI9c3hsQkJBnE/PQB846p6NO18kKSrKvujZqCmyE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AgvRLrfwdIcN4PU4N6ZeEvepO/7MhSbURHVSzkbu0D3ePNlhkU2z12/mJ2M5RkrGX
         P+WKoJtRWDt6VTZgo/imzA1NAfE30saDAaVYwfU8veNQ5jgEdkZ0QsjTo+/ad/BSEp
         PYreFMi1kHatennuFh/dk0vV1MRluGWhyn/KV7hU=
Date:   Sat, 25 Apr 2020 16:26:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     mani@kernel.org
Cc:     robh+dt@kernel.org, narcisaanamaria12@gmail.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [RESEND PATCH v3 0/3] Add Reset and Wakeup support for CCS811
Message-ID: <20200425162652.1fa2fc5b@archlinux>
In-Reply-To: <20200414184930.5576-1-mani@kernel.org>
References: <20200414184930.5576-1-mani@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Apr 2020 00:19:27 +0530
mani@kernel.org wrote:

> From: Manivannan Sadhasivam <mani@kernel.org>
> 
> Hello,
> 
> This patchset adds external reset and wakeup support for CCS811 VOC
> gas sensor. The nRESET and nWAKE pins available on the device are
> utilised to provide these functionalities.
> 
> The patchset has been validated using CCS811 connected to STM32MP1 based
> board over I2C.
> 
> While at it, the devicetree yaml binding and OF match table for this sensor
> are also added.
> 
> Thanks,
> Mani

All applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> Changes in v3:
> 
> * Added ccs811_set_wake(false) to all error paths before calling it actually
> * Added Andy's reviewed-by tag
> * Added comment for reset procedure and dropped error print for gpio request
> 
> Changes in v2:
> 
> * Fixed DT binding schema and switched to dual license (GPL/BSD)
> * Returned actual error code from devm_gpiod_get_optional()
> * Dropped of.h include and of_match_ptr()
> 
> Manivannan Sadhasivam (3):
>   dt-bindings: iio: chemical: Add binding for CCS811 VOC sensor
>   iio: chemical: Add support for external Reset and Wakeup in CCS811
>   iio: chemical: Add OF match table for CCS811 VOC sensor
> 
>  .../bindings/iio/chemical/ams,ccs811.yaml     |  51 ++++++++
>  drivers/iio/chemical/ccs811.c                 | 112 ++++++++++++++++--
>  2 files changed, 152 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml
> 

