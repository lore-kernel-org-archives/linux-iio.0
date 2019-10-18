Return-Path: <SRS0=N7E/=YL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C90CA9EA9
	for <linux-iio@archiver.kernel.org>; Fri, 18 Oct 2019 18:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1DD21897
	for <linux-iio@archiver.kernel.org>; Fri, 18 Oct 2019 18:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571425105;
	bh=herpOkvm0NcjapKZ3GQXcToHVA+w4DB9g69Uu9DCRpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=B5zGOT0oQ14A+AF+7tZoerMm+DriSMJsQo4iLK3++xpICuHvNgZ2PerN4Gv16XASR
	 nS3hpzIDINxKDE836Y+KpFdBKKV60h2Llr4y18bWl0332AnZ1vJYb80ZKSaBkUqg00
	 a8WBnF+Taymo/Mra3bdHMw0Ee279LmRA/JJsS2T4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391104AbfJRS6Z (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:58:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfJRS6Z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Oct 2019 14:58:25 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93A2720700;
        Fri, 18 Oct 2019 18:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571425104;
        bh=herpOkvm0NcjapKZ3GQXcToHVA+w4DB9g69Uu9DCRpI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TeDI9IE+sakId4lt7QB/bI4IY4Dfx4yh6x9m6ckrnp4466R7BPCxBPNyuasx+3iDY
         W897HsJZPFNz3Cm1FNwUx+9iDC+dquik1hsIsd7xwomQGcS2gsc5OQWetjXWovuj8R
         363o8SirBC9IoAnP7LZqTI4nd7mQAW+DjxkDcrGM=
Date:   Fri, 18 Oct 2019 19:58:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: proximity: pulsedlight v2: Tidy up an endian issue
Message-ID: <20191018195820.19037af4@archlinux>
In-Reply-To: <CAJCx=gnYkdwOOspqa_WynyPsDo8pLhPN3_5UNj6Z2bGWoxr_2A@mail.gmail.com>
References: <20191013102600.1463679-1-jic23@kernel.org>
        <CAJCx=gnYkdwOOspqa_WynyPsDo8pLhPN3_5UNj6Z2bGWoxr_2A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 13 Oct 2019 20:58:26 +0300
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Sun, Oct 13, 2019 at 1:28 PM <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Sparse identified the following
> > CHECK   drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> > drivers/iio/proximity/pulsedlight-lidar-lite-v2.c:144:24: warning: cast to restricted __be16
> > drivers/iio/proximity/pulsedlight-lidar-lite-v2.c:144:24: warning: cast to restricted __be16
> > drivers/iio/proximity/pulsedlight-lidar-lite-v2.c:144:24: warning: cast to restricted __be16
> > drivers/iio/proximity/pulsedlight-lidar-lite-v2.c:144:24: warning: cast to restricted __be16
> >
> > This cleans up by adding a local variable to hold the value whilst
> > it is __be16 before applying endian converstion into eventual destination.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>  
> 
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
Applied. Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> > index 47af54f14756..5b369645ef49 100644
> > --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> > +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> > @@ -136,12 +136,13 @@ static inline int lidar_write_power(struct lidar_data *data, int val)
> >
> >  static int lidar_read_measurement(struct lidar_data *data, u16 *reg)
> >  {
> > +       __be16 value;
> >         int ret = data->xfer(data, LIDAR_REG_DATA_HBYTE |
> >                         (data->i2c_enabled ? LIDAR_REG_DATA_WORD_READ : 0),
> > -                       (u8 *) reg, 2);
> > +                       (u8 *) &value, 2);
> >
> >         if (!ret)
> > -               *reg = be16_to_cpu(*reg);
> > +               *reg = be16_to_cpu(value);
> >
> >         return ret;
> >  }
> > --
> > 2.23.0
> >  

