Return-Path: <SRS0=9Bew=RM=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A80C43381
	for <linux-iio@archiver.kernel.org>; Sat,  9 Mar 2019 18:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910032081B
	for <linux-iio@archiver.kernel.org>; Sat,  9 Mar 2019 18:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552156080;
	bh=wKF0mJ7wWt7EwxPTBmcWME2lkoj189/yZpvkDMIs+0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bQpt+UHSKKN4evlfimXqA3fYjwPetpc4sj6BzkKfhMAx22X/e6S/4I/Yn46pq6rBb
	 LzJvSHcEnRmHgLhtsIrY4krver875RnayRGo+SV6mj4fK42TUm4dtdJgxDWPCrkQN8
	 yoOkkwgcA2YNLvEkDaVg0m1eNXE0pxAt4eBa79Ro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfCIS2A (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:28:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:49060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbfCIS17 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Mar 2019 13:27:59 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 329A4207E0;
        Sat,  9 Mar 2019 18:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552156079;
        bh=wKF0mJ7wWt7EwxPTBmcWME2lkoj189/yZpvkDMIs+0E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0Ly/4Qi7sIKMjQImkcrv231lK07Cd9PMxlFjr7IErdrW5iSE4EhPAXLalUE89UXr+
         KYdDew5CG0d8hDdtwNDz9P8udzea02agJmEi3Tv/4OnlAGu2ApEWkcHTeRQw8UHVWH
         tm0JtjtVqx+qBIo5bDx2CcCO+DWpT4WoXvDZLsDs=
Date:   Sat, 9 Mar 2019 18:27:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Cc:     linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: dac: mcp4725: add missing powerdown bits in store
 eeprom
Message-ID: <20190309182754.5222143b@archlinux>
In-Reply-To: <20190306205606.30419-1-jeff.dagenais@gmail.com>
References: <20190306205606.30419-1-jeff.dagenais@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

+Cc Peter.
On Wed,  6 Mar 2019 15:56:06 -0500
Jean-Francois Dagenais <jeff.dagenais@gmail.com> wrote:

> When issuing the write DAC register and write eeprom command, the two
> powerdown bits (PD0 and PD1) are assumed by the chip to be present in
> the bytes sent. Leaving them at 0 implies "powerdown disabled" which is
> a different state that the current one. By adding the current state of
> the powerdown in the i2c write, the chip will correctly power-on exactly
> like as it is at the moment of store_eeprom call.
> 
> This is documented in MCP4725's datasheet, FIGURE 6-2: "Write Commands
> for DAC Input Register and EEPROM" and MCP4726's datasheet, FIGURE 6-3:
> "Write All Memory Command".
> 
> Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
sounds fine to me, but I'd like to give Peter a chance to comment.
Give me a poke if it turns out Peter is busy and doesn't get back
to us in a week or two.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/mcp4725.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> index 6ab1f23e5a79..97bb350d1e77 100644
> --- a/drivers/iio/dac/mcp4725.c
> +++ b/drivers/iio/dac/mcp4725.c
> @@ -98,6 +98,7 @@ static ssize_t mcp4725_store_eeprom(struct device *dev,
>  
>  	inoutbuf[0] = 0x60; /* write EEPROM */
>  	inoutbuf[0] |= data->ref_mode << 3;
> +	inoutbuf[0] |= data->powerdown ? ((data->powerdown_mode+1) << 1) : 0;
>  	inoutbuf[1] = data->dac_value >> 4;
>  	inoutbuf[2] = (data->dac_value & 0xf) << 4;
>  

