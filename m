Return-Path: <SRS0=u9I9=6R=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34E4C28CBC
	for <linux-iio@archiver.kernel.org>; Sun,  3 May 2020 13:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FBA620757
	for <linux-iio@archiver.kernel.org>; Sun,  3 May 2020 13:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588510944;
	bh=MDdvbtM4B+/uUtYcIVT0fyHgUwq7b+YVAu1Yf0fwo44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zdaM2AaeX0FEwCdzV5jg5nG0bmj5F2iSl1uTbIikJctJO9/ymxrAMVpW9t2+ju/fP
	 zcbHyMwWac+J1F/fL4jPebOYiWDae2/dP1jbMgqErJKBPgkx9QTjwJvHjDoc61lHGj
	 GVShjCyHvmFQUtokpI3R7pP8GjLm549BIqWU5Z7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgECNCY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 3 May 2020 09:02:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbgECNCX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 09:02:23 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 456C22073E;
        Sun,  3 May 2020 13:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588510943;
        bh=MDdvbtM4B+/uUtYcIVT0fyHgUwq7b+YVAu1Yf0fwo44=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D5y8voz94Cas8LFxSPBgQxS9obhk6cErB9pWGGQJT0NozmIH16z9IGJkns970eeVh
         7mYHWT2wz3bc27zTEDXM8KXjdu6vqIvQzZfvtKOt4pEvJISCkGNh6muU56Gn+FWnOU
         0jCiZKnLyQJIRK4K9B/HT8YRmf5vh/LRK/kctmes=
Date:   Sun, 3 May 2020 14:02:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Pop, Cristian" <Cristian.Pop@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Berghe, Darius" <Darius.Berghe@analog.com>,
        "Caprioru, Mircea" <Mircea.Caprioru@analog.com>
Subject: Re: AD 5766 driver software reset during runtime
Message-ID: <20200503140218.6862a3a6@archlinux>
In-Reply-To: <CH2PR03MB5271407F0344001EB87E1427E7AA0@CH2PR03MB5271.namprd03.prod.outlook.com>
References: <CH2PR03MB5271407F0344001EB87E1427E7AA0@CH2PR03MB5271.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 Apr 2020 06:52:50 +0000
"Pop, Cristian" <Cristian.Pop@analog.com> wrote:

> Hello to all,
> 
> For those who are receiving this email for the second time, it seems
> that linux-iio@vger.kernel.org, doesn't accept HTML format emails, so
> this is a plain text version.
> 
> I have been developing a linux kernel drive for a DAC converter,
> ad5766 and it supports changing the output span range, from eight
> available output ranges during runtime. This is done setting scale
> and offset attributes trough a `write_raw` call. When changing the
> range during runtime for this chip, a software reset is necessary,
> before writing to the span register. Do you think this is acceptable
> upstream? Should we make the span ranges selectable at runtime? From
> what I heard, it's not always a good idea to do reset of a device at
> runtime.

There is no fundamental issue with doing resets at runtime - we often
have to do this to get out of error conditions etc and it also often
happens if we remove and reprobe a device.

What I really don't want to see is a userspace reset control.  If
some other control requires a reset to actually set the value, then fine.

I would suggest you want to block that control unless all the dac
channels are disabled.  Right now it looks like the driver
doesn't support power down, but I think the hardware does from
a quick glance at the datasheet.  Resetting with powered up channels
sounds like a bad idea to me.

Thanks,

Jonathan

> 
> AD5722 software reset in driver before setting a new offset / range:
> https://github.com/analogdevicesinc/linux/blob/4c7d019397e696dcaf735c52169a92fcbe5b5b8b/drivers/iio/dac/ad5766.c#L309
> 
> AD5722 software reset in driver, before setting a new scale / range:
> https://github.com/analogdevicesinc/linux/blob/4c7d019397e696dcaf735c52169a92fcbe5b5b8b/drivers/iio/dac/ad5766.c#L357
> 
> AD5722 datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/AD5722_5732_5752.pdf
> 
> Thanks and best regards,
> Cristian Pop

