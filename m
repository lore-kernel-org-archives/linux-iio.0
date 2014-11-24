Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:39280 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742AbaKXKmL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Nov 2014 05:42:11 -0500
Received: by mail-wg0-f41.google.com with SMTP id y19so11785012wgg.28
        for <linux-iio@vger.kernel.org>; Mon, 24 Nov 2014 02:42:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5472688D.9010801@gmx.de>
References: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com>
	<1416246966-3083-7-git-send-email-octavian.purdila@intel.com>
	<5472688D.9010801@gmx.de>
Date: Mon, 24 Nov 2014 12:42:10 +0200
Message-ID: <CAE1zotKM30FQ1ScrEiPGW4SuLvjTUVpj4eg0wpCLY=UVU_UHxw@mail.gmail.com>
Subject: Re: [RFC 6/8] iio: bmc150: introduce bmc150_accel_trigger
From: Octavian Purdila <octavian.purdila@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Nov 24, 2014 at 1:06 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
> > +
> > +static void bmc150_accel_unregister_triggers(struct bmc150_accel_data *data,
> > +                                          int from)
> > +{
> > +     int i;
> > +
> > +     for (i = from; i >= 0; i++) {
> > +             if (data->triggers[i].indio_trig) {
> > +                     iio_trigger_unregister(data->triggers[i].indio_trig);
> > +                     data->triggers[i].indio_trig = NULL;
> Better use devm_iio_trigger_free()?

Wouldn't that be called anyway a little bit later?

> > +             }
> > +             i--;
> > +     }
> i++ and i-- in the same loop looks like an infinite loop to me. Not to mention what happens on the second attempt to unregister the same trigger.

Oops.

> > +}
> > +
> > +static int bmc150_accel_triggers_setup(struct iio_dev *indio_dev,
> > +                                    struct bmc150_accel_data *data)
> > +{
> > +     int i, ret;
> > +
> > +     for (i = 0; i < BMC150_ACCEL_TRIGGERS; i++) {
> > +             struct bmc150_accel_trigger *t = &data->triggers[i];
> > +             const char *name = bmc150_accel_triggers[i].name;
> > +             int intr = bmc150_accel_triggers[i].intr;
> > +
> > +             t->indio_trig = devm_iio_trigger_alloc(&data->client->dev, name,
> > +                                                    indio_dev->name,
> > +                                                    indio_dev->id);
> > +             if (!t->indio_trig) {
> > +                     ret = -ENOMEM;
> > +                     break;
> > +             }
> > +
> > +             t->indio_trig->dev.parent = &data->client->dev;
> > +             t->indio_trig->ops = &bmc150_accel_trigger_ops;
> > +             t->intr = &data->interrupts[intr];
> > +             t->data = data;
> > +             iio_trigger_set_drvdata(t->indio_trig, t);
> > +
> > +             ret = iio_trigger_register(t->indio_trig);
> > +             if (ret)
> > +                     break;
> > +     }
> > +
> > +     if (ret)
> > +             bmc150_accel_unregister_triggers(data, i);
> I think this should be called with i - 1.

You're right.

Thanks for the reviews Hartmut, I will send a new version after we
decide on the hardware buffer approach.
