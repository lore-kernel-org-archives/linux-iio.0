Return-Path: <SRS0=wTBL=4Y=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEE6C10F00
	for <linux-iio@archiver.kernel.org>; Sat,  7 Mar 2020 15:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D7920656
	for <linux-iio@archiver.kernel.org>; Sat,  7 Mar 2020 15:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583594737;
	bh=jTfoDTpBht4Oo/wm8OLluLVKnLxr7/DLRPtg/24rA6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NcfM4vegCZm5Q1rF4FerVRX1RRHH4BKak0/MRiCm2z/0HHK3bIwDGatw9FXHWj9I3
	 58M7JSa4xp43fpjHfz/H/6IYQGOUiapOxkAzck/HxlZerq5Q5mEUOQPL6MxSHyhjZg
	 Seh+v81ipoHmYQYYKTGFPArov10sjDbz34w9kAns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgCGPZg (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 7 Mar 2020 10:25:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbgCGPZg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 10:25:36 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A3D920656;
        Sat,  7 Mar 2020 15:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583594735;
        bh=jTfoDTpBht4Oo/wm8OLluLVKnLxr7/DLRPtg/24rA6c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gsGxyz+O+VogMCFWxY3SocOCsWoXO/Jf3bCMTr09LZGu9hvriHha288PP0urxzqGD
         uWGG1j/wauuukU3doF14pEC2pV2Dc0NsI/wa12hw9dk3qH0vX5TOla/N2cyZu1yEAx
         TwdcaOh2SW+nLDliZ1zKVG/nDJDm30Sc5ZYB5raE=
Date:   Sat, 7 Mar 2020 15:25:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <mranostay@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        matt.ranostay@konsulko.com
Subject: Re: [PATCH v2] iio: potentiostat: lmp9100: fix
 iio_triggered_buffer_{predisable,postenable} positions
Message-ID: <20200307152531.159f14fb@archlinux>
In-Reply-To: <CAKzfze8KMLG=GbMvZ9eydOer5wZw-i7_5fJVjpFcZ6fqyoHgJQ@mail.gmail.com>
References: <20200304093633.32264-1-alexandru.ardelean@analog.com>
        <20200304094105.2586-1-alexandru.ardelean@analog.com>
        <CAKzfze8KMLG=GbMvZ9eydOer5wZw-i7_5fJVjpFcZ6fqyoHgJQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 4 Mar 2020 13:17:36 -0800
Matt Ranostay <mranostay@gmail.com> wrote:

> On Wed, Mar 4, 2020 at 1:38 AM Alexandru Ardelean
> <alexandru.ardelean@analog.com> wrote:
> >
> > The iio_triggered_buffer_{predisable,postenable} functions attach/detach
> > the poll functions.
> >
> > For the predisable hook, the disable code should occur before detaching
> > the poll func, and for the postenable hook, the poll func should be
> > attached before the enable code.
> >
> > The lmp9100 was attaching a poll function but never detaching it via any
> > IIO disable hook.
> >
> > This change adds the detaching of the poll function, and moves/renames
> > lmp91000_buffer_preenable() function to lmp91000_buffer_postenable().
> > The idea is to make it more symmetrical, so that when the
> > iio_triggered_buffer_{predisable,postenable} functions get removed, it's
> > easier to see.
> >
> > Fixes: 67e17300dc1d7 ("iio: potentiostat: add LMP91000 support")
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> 
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

I'm not going to rush this one in as it's been like this for a while

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it,

Thanks,

Jonathan

> 
> > ---
> >
> > Changelog v1 -> v2:
> > * forgot to call iio_triggered_buffer_postenable() in
> >   lmp91000_buffer_postenable() in v1
> >
> >  drivers/iio/potentiostat/lmp91000.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> > index a0e5f530faa9..2cb11da18e0f 100644
> > --- a/drivers/iio/potentiostat/lmp91000.c
> > +++ b/drivers/iio/potentiostat/lmp91000.c
> > @@ -275,11 +275,20 @@ static int lmp91000_buffer_cb(const void *val, void *private)
> >  static const struct iio_trigger_ops lmp91000_trigger_ops = {
> >  };
> >
> > -static int lmp91000_buffer_preenable(struct iio_dev *indio_dev)
> > +static int lmp91000_buffer_postenable(struct iio_dev *indio_dev)
> >  {
> >         struct lmp91000_data *data = iio_priv(indio_dev);
> > +       int err;
> >
> > -       return iio_channel_start_all_cb(data->cb_buffer);
> > +       err = iio_triggered_buffer_postenable(indio_dev);
> > +       if (err)
> > +               return err;
> > +
> > +       err = iio_channel_start_all_cb(data->cb_buffer);
> > +       if (err)
> > +               iio_triggered_buffer_predisable(indio_dev);
> > +
> > +       return err;
> >  }
> >
> >  static int lmp91000_buffer_predisable(struct iio_dev *indio_dev)
> > @@ -288,12 +297,11 @@ static int lmp91000_buffer_predisable(struct iio_dev *indio_dev)
> >
> >         iio_channel_stop_all_cb(data->cb_buffer);
> >
> > -       return 0;
> > +       return iio_triggered_buffer_predisable(indio_dev);
> >  }
> >
> >  static const struct iio_buffer_setup_ops lmp91000_buffer_setup_ops = {
> > -       .preenable = lmp91000_buffer_preenable,
> > -       .postenable = iio_triggered_buffer_postenable,
> > +       .postenable = lmp91000_buffer_postenable,
> >         .predisable = lmp91000_buffer_predisable,
> >  };
> >
> > --
> > 2.20.1
> >  

