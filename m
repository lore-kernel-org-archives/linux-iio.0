Return-Path: <SRS0=lRSj=4S=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6F1C3F2CD
	for <linux-iio@archiver.kernel.org>; Sun,  1 Mar 2020 14:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D13222C2
	for <linux-iio@archiver.kernel.org>; Sun,  1 Mar 2020 14:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583073265;
	bh=/5V1DU1Pod9kXIN7kIdUg6/o4lbHnX4peY9h4Q28sno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xzKbuYTAR7YcqnhVlBkt1QDgDYmGxGm9d6i33d4f2BiBcXrhhKYKoNTtoA5apGPXs
	 MZZzW/7xNoXp0beMcFOCmxieR/n6i/enkyEFJ6wDtLNx/NK3pO4KB6in4GdzRc116P
	 XVd052zni7twNIRSbtUtN3LI6JfrWiqBxHp8JqdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgCAOeY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 1 Mar 2020 09:34:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:50400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgCAOeY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Mar 2020 09:34:24 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42875214DB;
        Sun,  1 Mar 2020 14:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583073263;
        bh=/5V1DU1Pod9kXIN7kIdUg6/o4lbHnX4peY9h4Q28sno=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mpd6f7IUn9mlKlABdlfsb6VWX/taJoXAW1SS/wrZdyKgQEPLkXDyPZMMJPJVQBqS6
         wictpMPNVwrJP1k1sOYfxEJD02k5djgQm1WTkHuKO2XvRX2pZNBZYiSQfQwfPV5sJV
         jYbchJJmHEV2B6RnNBimvTcQlYn/ovi/Ot4roQGs=
Date:   Sun, 1 Mar 2020 14:34:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     dragos.bogdan@analog.com, JManeyrol@invensense.com,
        linux-iio@vger.kernel.org
Subject: Re: [GSOC][RFC] Proposal
Message-ID: <20200301143418.438ce7f9@archlinux>
In-Reply-To: <5e581673.1c69fb81.9fd7b.25c2@mx.google.com>
References: <5e55473d.1c69fb81.82355.928d@mx.google.com>
        <5e581673.1c69fb81.9fd7b.25c2@mx.google.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 28 Feb 2020 00:50:15 +0530
Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:

> On Tue, Feb 25, 2020 at 09:41:37PM +0530, Rohit Sarkar wrote:
> > Hi,
> > I am proposing to work on the accelerometer MPU6050 as my primary
> > project for the summer. The work items are outlined in [1] thanks to
> > Jean.
> > If time permits (which it should), I will be picking up other tasks
> > outlined in [2] by Jonathan and Alexandru.
> > 
> > 
> > Would like to hear people's views on this.
> > 
> > [1]: https://marc.info/?l=linux-iio&m=158257639113000&w=2
> > [2]: https://marc.info/?l=linux-iio&m=158261515624212&w=2
> > Thanks,
> > Rohit
> >   
> 
> Hey guys,
> would love some feedback on this.
> There are no proposals as such on the GSOC IIO page [1].
> Was wondering if there is any new iio driver that can be made into a
> gsoc project.

Hi Rohit,

A couple of questions.   Do you have a gsoc mentor lined up?

You should discuss a proposal with whoever that is.

My gut feeling is that the features suggested by Jean-Baptisite
do not form a particularly good focus for the body of a gsoc project.
There are too many rather disassociated items, without a connected
'story'.

They are good items for getting familiar with the subsystem and
a particular driver but for the actual project you probably want
something that is more 'yours' in the sense that you drive it from
initial prototypes through to final upstream code.

Previous projects have (I think) mostly centred on support for a new
driver. 

Thanks,

Jonathan


