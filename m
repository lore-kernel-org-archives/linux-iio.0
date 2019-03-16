Return-Path: <SRS0=kDFh=RT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D092C43381
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 16:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A19A21900
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 16:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552752065;
	bh=45p14o7XAXziKj/bRUV9kn51jA6xSXauRZ/lIi0h1+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DLkQAc//9SyTFlmd0fv3GXv5Ce+IamMFrHN7whDRrN2NjKj4DUcs43wI6OJ9FeghI
	 DzAEuU/p+adMR8u1quQOl9ztPNFCP6iwbhXR3iwH9xf3ikJxExahQmJ6PjPGvlaTIu
	 1WTQ0hL7yDLjrj4ylOHhM0PqWNQkaiHrRVGhFVN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfCPQBE (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 Mar 2019 12:01:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:32844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfCPQBE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Mar 2019 12:01:04 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6448121900;
        Sat, 16 Mar 2019 16:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552752064;
        bh=45p14o7XAXziKj/bRUV9kn51jA6xSXauRZ/lIi0h1+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UmR01JElhf+9J/rBsvoNQA0g1964e6RYmQvtl+86FZp1T8CH+4kj1qik1eHcTb1C4
         4Myloz6dLpAJUvxeC53cYz/RBFsJEDtsNKZtexqeAp627tPtCK4SJkR4pHDcOtQ139
         37dPfbRklXXGUuti1COUDeE3MrWGRDjYhKZU4lMM=
Date:   Sat, 16 Mar 2019 16:00:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: dac: mcp4725: add missing powerdown bits in
 store eeprom
Message-ID: <20190316160059.10e133e2@archlinux>
In-Reply-To: <15603225-C392-42AE-92A1-893BB7C322E3@gmail.com>
References: <20190311114239.30512-1-jeff.dagenais@gmail.com>
        <15603225-C392-42AE-92A1-893BB7C322E3@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 12 Mar 2019 08:32:22 -0400
Jean-Francois Dagenais <jeff.dagenais@gmail.com> wrote:

> > On Mar 11, 2019, at 07:42, Jean-Francois Dagenais <jeff.dagenais@gmail.com> wrote:
> > 
> > When issuing the write DAC register and write eeprom command, the two
> > powerdown bits (PD0 and PD1) are assumed by the chip to be present in
> > the bytes sent. Leaving them at 0 implies "powerdown disabled" which is
> > a different state that the current one. By adding the current state of
> > the powerdown in the i2c write, the chip will correctly power-on exactly
> > like as it is at the moment of store_eeprom call.
> > 
> > This is documented in MCP4725's datasheet, FIGURE 6-2: "Write Commands
> > for DAC Input Register and EEPROM" and MCP4726's datasheet, FIGURE 6-3:
> > "Write All Memory Command".
> > 
> > Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
> > ---  
> 
> I forgot to add:
> 
> Acked-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> 
> in v2
> 
> v3 just for that?
Ah,  I picked up v1 and fixed it anyway.  So don't bother ;)

Jonathan
