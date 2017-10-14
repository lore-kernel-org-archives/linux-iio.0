Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750907AbdJNSTK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Oct 2017 14:19:10 -0400
Date: Sat, 14 Oct 2017 19:19:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, knaack.h@gmx.de,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: make config_item_type const
Message-ID: <20171014191905.182ef33f@archlinux>
In-Reply-To: <CAOH+1jF--6qwgMoedNpQDMHHM9J68bOYScwBKU+H4HHwCjMTug@mail.gmail.com>
References: <1507801276-1716-1-git-send-email-bhumirks@gmail.com>
        <CAOH+1jF--6qwgMoedNpQDMHHM9J68bOYScwBKU+H4HHwCjMTug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 12 Oct 2017 17:05:55 +0200
Bhumika Goyal <bhumirks@gmail.com> wrote:

> On Thu, Oct 12, 2017 at 11:41 AM, Bhumika Goyal <bhumirks@gmail.com> wrote:
> > This is a followup patch for:
> > https://lkml.org/lkml/2017/10/11/375

One quick suggestion - don't use lkml as an archive - it's frequently
down from at least some places (is for me now).

> > https://patchwork.kernel.org/patch/9999649/
> > https://lkml.org/lkml/2017/10/11/469 and
> > https://lkml.org/lkml/2017/10/11/661
> >
> > Make the config_item_type structures const as they are either passed to
> > the functions having the argument as const (link 2,3,4) or they are
> > stored in the const "ci_type" field of a config_item structure (link 1).
> >
> > Done using Coccinelle.
> >  
> 
> Actually, this patch is dependent on the links given in the patch.
> Therefore, this patch
> won't be correct unless the patches in these links gets applied.

Hmm.. This is going to take a while to apply then as we'll have
to wait for those changes to get into my upstream tree, or we
have to agree this goes through the same tree as those.

Best bet may be to resend after the next merge window - or
put together a single patch set with all the dependencies and
the patches using them then someone appropriate can make
an immutable branch from them for the various trees to pull in.

Which route you take is up to you.  Good work in general
though these large cross tree tidy ups can take a while
to get in place!

Jonathan

> 
> > Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> > ---
> >  drivers/iio/dummy/iio_simple_dummy.c   | 2 +-
> >  drivers/iio/industrialio-configfs.c    | 2 +-
> >  drivers/iio/industrialio-sw-device.c   | 6 +++---
> >  drivers/iio/industrialio-sw-trigger.c  | 6 +++---
> >  drivers/iio/trigger/iio-trig-hrtimer.c | 2 +-
> >  drivers/iio/trigger/iio-trig-loop.c    | 2 +-
> >  6 files changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
> > index a45d01e..6205247 100644
> > --- a/drivers/iio/dummy/iio_simple_dummy.c
> > +++ b/drivers/iio/dummy/iio_simple_dummy.c
> > @@ -26,7 +26,7 @@
> >  #include <linux/iio/sw_device.h>
> >  #include "iio_simple_dummy.h"
> >
> > -static struct config_item_type iio_dummy_type = {
> > +static const struct config_item_type iio_dummy_type = {
> >         .ct_owner = THIS_MODULE,
> >  };
> >
> > diff --git a/drivers/iio/industrialio-configfs.c b/drivers/iio/industrialio-configfs.c
> > index 45ce2bc..5a0aae1 100644
> > --- a/drivers/iio/industrialio-configfs.c
> > +++ b/drivers/iio/industrialio-configfs.c
> > @@ -17,7 +17,7 @@
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/configfs.h>
> >
> > -static struct config_item_type iio_root_group_type = {
> > +static const struct config_item_type iio_root_group_type = {
> >         .ct_owner       = THIS_MODULE,
> >  };
> >
> > diff --git a/drivers/iio/industrialio-sw-device.c b/drivers/iio/industrialio-sw-device.c
> > index 81b49cf..90df97c 100644
> > --- a/drivers/iio/industrialio-sw-device.c
> > +++ b/drivers/iio/industrialio-sw-device.c
> > @@ -19,9 +19,9 @@
> >  #include <linux/configfs.h>
> >
> >  static struct config_group *iio_devices_group;
> > -static struct config_item_type iio_device_type_group_type;
> > +static const struct config_item_type iio_device_type_group_type;
> >
> > -static struct config_item_type iio_devices_group_type = {
> > +static const struct config_item_type iio_devices_group_type = {
> >         .ct_owner = THIS_MODULE,
> >  };
> >
> > @@ -156,7 +156,7 @@ static void device_drop_group(struct config_group *group,
> >         .drop_item      = &device_drop_group,
> >  };
> >
> > -static struct config_item_type iio_device_type_group_type = {
> > +static const struct config_item_type iio_device_type_group_type = {
> >         .ct_group_ops = &device_ops,
> >         .ct_owner       = THIS_MODULE,
> >  };
> > diff --git a/drivers/iio/industrialio-sw-trigger.c b/drivers/iio/industrialio-sw-trigger.c
> > index 8d24fb1..bc6b7fb 100644
> > --- a/drivers/iio/industrialio-sw-trigger.c
> > +++ b/drivers/iio/industrialio-sw-trigger.c
> > @@ -19,9 +19,9 @@
> >  #include <linux/configfs.h>
> >
> >  static struct config_group *iio_triggers_group;
> > -static struct config_item_type iio_trigger_type_group_type;
> > +static const struct config_item_type iio_trigger_type_group_type;
> >
> > -static struct config_item_type iio_triggers_group_type = {
> > +static const struct config_item_type iio_triggers_group_type = {
> >         .ct_owner = THIS_MODULE,
> >  };
> >
> > @@ -156,7 +156,7 @@ static void trigger_drop_group(struct config_group *group,
> >         .drop_item      = &trigger_drop_group,
> >  };
> >
> > -static struct config_item_type iio_trigger_type_group_type = {
> > +static const struct config_item_type iio_trigger_type_group_type = {
> >         .ct_group_ops = &trigger_ops,
> >         .ct_owner       = THIS_MODULE,
> >  };
> > diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
> > index 3ee9216..7accd01 100644
> > --- a/drivers/iio/trigger/iio-trig-hrtimer.c
> > +++ b/drivers/iio/trigger/iio-trig-hrtimer.c
> > @@ -30,7 +30,7 @@ struct iio_hrtimer_info {
> >         ktime_t period;
> >  };
> >
> > -static struct config_item_type iio_hrtimer_type = {
> > +static const struct config_item_type iio_hrtimer_type = {
> >         .ct_owner = THIS_MODULE,
> >  };
> >
> > diff --git a/drivers/iio/trigger/iio-trig-loop.c b/drivers/iio/trigger/iio-trig-loop.c
> > index b4b02db..94a90e0 100644
> > --- a/drivers/iio/trigger/iio-trig-loop.c
> > +++ b/drivers/iio/trigger/iio-trig-loop.c
> > @@ -36,7 +36,7 @@ struct iio_loop_info {
> >         struct task_struct *task;
> >  };
> >
> > -static struct config_item_type iio_loop_type = {
> > +static const struct config_item_type iio_loop_type = {
> >         .ct_owner = THIS_MODULE,
> >  };
> >
> > --
> > 1.9.1
> >  

