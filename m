Return-Path: <SRS0=wvAN=YF=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E41C4360C
	for <linux-iio@archiver.kernel.org>; Sat, 12 Oct 2019 12:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3226E2089C
	for <linux-iio@archiver.kernel.org>; Sat, 12 Oct 2019 12:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570883324;
	bh=1YbgJ/J12R+z312o+ensQL9fyrAPgTbCCfwViS1/dMQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=D8Si6SjZBfqDz988yUidvbEKJXN/m0Q4W7eZ+hd8/+Wb3fU9Jzv5qRI2yMCzq9pmn
	 bGsUBVlF9rZkIjlgWgxrlyQmoAPyvYeiGt8ixS1OctKDZJfaksLlCy2uHvfAr3mYKu
	 X9PUo1G01i+iW1BVHoajE+LFSSFcyYHiNiVJk0Ow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfJLM2n (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 12 Oct 2019 08:28:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728979AbfJLM0n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 08:26:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69B8B2089C;
        Sat, 12 Oct 2019 12:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570883202;
        bh=1YbgJ/J12R+z312o+ensQL9fyrAPgTbCCfwViS1/dMQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PEP7YEFuQ1LkRoBdIOYSSn7cCpfDDYHV8UyLnaOw2Abb+o+MiG1J5cmWpTnSV06B5
         sfFZOHNvWFfouFGUoT/VOJ+aTjKD7yYaNXFuIkbDJer7A3neGPqR/nQO2P0tLsZk2d
         n4FExRM1MAfC30prIvoNfpl/0mNsX4iTlOkRLbyc=
Date:   Sat, 12 Oct 2019 13:26:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
        martin@geanix.com, rjones@gateworks.com,
        lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 11/13] iio: imu: st_lsm6dsx: add missing kernel
 documenation
Message-ID: <20191012132638.6d494fa8@archlinux>
In-Reply-To: <f211bb25-f90f-71b6-6df9-2bd03f3ba0b7@geanix.com>
References: <cover.1570367532.git.lorenzo@kernel.org>
        <08d98185ff40de1b2183446d6da61fffcafb9b7f.1570367532.git.lorenzo@kernel.org>
        <f211bb25-f90f-71b6-6df9-2bd03f3ba0b7@geanix.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 7 Oct 2019 09:56:10 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> On 06/10/2019 15.22, Lorenzo Bianconi wrote:
> > Add missing kernel doc for st_lsm6dsx_hw data structure
> > 
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>  
> Reviewed-by: Sean Nyekjaer <sean@geanix.com>
Applied.

Thanks,

J
> > ---
> >   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > index 5692ea695f04..40532f99ba4b 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -345,6 +345,9 @@ struct st_lsm6dsx_sensor {
> >    * @ts_sip: Total number of timestamp samples in a given pattern.
> >    * @sip: Total number of samples (acc/gyro/ts) in a given pattern.
> >    * @buff: Device read buffer.
> > + * @irq_routing: pointer to interrupt routing configuration.
> > + * @event_threshold: wakeup event threshold.
> > + * @enable_event: enabled event bitmask.
> >    * @iio_devs: Pointers to acc/gyro iio_dev instances.
> >    * @settings: Pointer to the specific sensor settings in use.
> >    */
> >   

