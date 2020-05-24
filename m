Return-Path: <SRS0=2Dns=7G=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D2AC433E0
	for <linux-iio@archiver.kernel.org>; Sun, 24 May 2020 14:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73ADD207CB
	for <linux-iio@archiver.kernel.org>; Sun, 24 May 2020 14:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590330667;
	bh=+uFSYwJVYAoZY9jwyDI7l6LKmMA7PkxsS64ouRUeJic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MscN9vLgM1rXtwh/ZIirXGg5FIrC6QFdIO/urXuN9SAl2j5dHSg1sQjhQhjSipfNO
	 JvrWQ/M2pJVzuNUo3qIgYCFHt1iOpYdyn8SQsvkhzwz8sx4Nicuwe9POWwzhMI3097
	 hhrRIc9Izp8INycxAyNoHwgOTgM1lv5w122wF1Ko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgEXObG (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 24 May 2020 10:31:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728875AbgEXObG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 May 2020 10:31:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D7A520787;
        Sun, 24 May 2020 14:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590330665;
        bh=+uFSYwJVYAoZY9jwyDI7l6LKmMA7PkxsS64ouRUeJic=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eT8MRP1DN7vZlooI6reVU9m+cnqOnTRSu+U+ndzo79tyZEQgCdH/SCeRRPizMWFfD
         KUwVeXfGJ21tySnVY0T5MQbThEdakCtsrdXL3l9fQV3NOTlePl3Z++URuv3pS6b2WP
         geyIGUTOkUABAqzWoRyrWiFo4h9thKVLFog5JOCI=
Date:   Sun, 24 May 2020 15:31:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: position: iqs624: remove usage of
 iio_priv_to_dev()
Message-ID: <20200524153101.70f8b5d3@archlinux>
In-Reply-To: <20200523015340.GA2690@labundy.com>
References: <20200522065322.9611-1-alexandru.ardelean@analog.com>
        <20200523015340.GA2690@labundy.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 May 2020 20:53:40 -0500
Jeff LaBundy <jeff@labundy.com> wrote:

> Hi Alexandru,
> 
> On Fri, May 22, 2020 at 09:53:22AM +0300, Alexandru Ardelean wrote:
> > We may want to get rid of the iio_priv_to_dev() helper. That's a bit
> > uncertain at this point. The reason is that we will hide some of the
> > members of the iio_dev structure (to prevent drivers from accessing them
> > directly), and that will also mean hiding the implementation of the
> > iio_priv_to_dev() helper inside the IIO core.
> > 
> > Hiding the implementation of iio_priv_to_dev() implies that some fast-paths
> > may not be fast anymore, so a general idea is to try to get rid of the
> > iio_priv_to_dev() altogether.
> > 
> > For this driver, removing iio_priv_to_dev() also means keeping a reference
> > on the state struct.
> > 
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/position/iqs624-pos.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)  
> 
> As a customer of iio, I find it handy that there is an "inverse" to iio_priv.
> In this particular case it saves the container iio_dev from storing a pointer
> to itself.
Hi Jeff,

The actual usecases for this function are rare - this being one of the
few where it is justified due to the notifier chain stuff and need
to embed that in a driver structure.

So I'd rather we did something a bit special in these few cases and
made it harder for people to submit new drivers that jump backwards
and forwards between the iio_dev and the iio_priv structure.

Doing it now is a side effect of Alex's work to make a large chunk
of struct iio_dev opaque. It's easy to handle the forwards case with
a nice macro / inline function as we can embed a pointer to the iio_priv
in the 'internal' structure but the other way around has to involve
an IIO core function call.  We could keep the function around and
rely on an offputting name __iio_priv_to_dev maybe but those tend
to get cut and past all over the place.

Thanks for being understanding as indeed this is less than elegant
in this particular case!

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,


Jonathan

> 
> That being said, this patch is perfectly fine and I have no objection if this
> is the route you and Jonathan opt to take. And so:
> 
> Acked-by: Jeff LaBundy <jeff@labundy.com>
> 
> > 
> > diff --git a/drivers/iio/position/iqs624-pos.c b/drivers/iio/position/iqs624-pos.c
> > index 77096c31c2ba..520dafbdc48f 100644
> > --- a/drivers/iio/position/iqs624-pos.c
> > +++ b/drivers/iio/position/iqs624-pos.c
> > @@ -23,6 +23,7 @@
> >  
> >  struct iqs624_pos_private {
> >  	struct iqs62x_core *iqs62x;
> > +	struct iio_dev *indio_dev;
> >  	struct notifier_block notifier;
> >  	struct mutex lock;
> >  	bool angle_en;
> > @@ -59,7 +60,7 @@ static int iqs624_pos_notifier(struct notifier_block *notifier,
> >  
> >  	iqs624_pos = container_of(notifier, struct iqs624_pos_private,
> >  				  notifier);
> > -	indio_dev = iio_priv_to_dev(iqs624_pos);
> > +	indio_dev = iqs624_pos->indio_dev;
> >  	timestamp = iio_get_time_ns(indio_dev);
> >  
> >  	iqs62x = iqs624_pos->iqs62x;
> > @@ -98,7 +99,7 @@ static int iqs624_pos_notifier(struct notifier_block *notifier,
> >  static void iqs624_pos_notifier_unregister(void *context)
> >  {
> >  	struct iqs624_pos_private *iqs624_pos = context;
> > -	struct iio_dev *indio_dev = iio_priv_to_dev(iqs624_pos);
> > +	struct iio_dev *indio_dev = iqs624_pos->indio_dev;
> >  	int ret;
> >  
> >  	ret = blocking_notifier_chain_unregister(&iqs624_pos->iqs62x->nh,
> > @@ -243,6 +244,7 @@ static int iqs624_pos_probe(struct platform_device *pdev)
> >  
> >  	iqs624_pos = iio_priv(indio_dev);
> >  	iqs624_pos->iqs62x = iqs62x;
> > +	iqs624_pos->indio_dev = indio_dev;
> >  
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> >  	indio_dev->dev.parent = &pdev->dev;
> > -- 
> > 2.25.1
> >   
> 
> Kind regards,
> Jeff LaBundy

