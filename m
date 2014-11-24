Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:58076 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbaKXU0Q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 24 Nov 2014 15:26:16 -0500
Message-ID: <54739462.7060300@gmx.de>
Date: Mon, 24 Nov 2014 21:26:10 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>
CC: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [RFC 6/8] iio: bmc150: introduce bmc150_accel_trigger
References: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com>	<1416246966-3083-7-git-send-email-octavian.purdila@intel.com>	<5472688D.9010801@gmx.de> <CAE1zotKM30FQ1ScrEiPGW4SuLvjTUVpj4eg0wpCLY=UVU_UHxw@mail.gmail.com>
In-Reply-To: <CAE1zotKM30FQ1ScrEiPGW4SuLvjTUVpj4eg0wpCLY=UVU_UHxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Octavian Purdila schrieb am 24.11.2014 11:42:
> On Mon, Nov 24, 2014 at 1:06 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
>>> +
>>> +static void bmc150_accel_unregister_triggers(struct bmc150_accel_data *data,
>>> +                                          int from)
>>> +{
>>> +     int i;
>>> +
>>> +     for (i = from; i >= 0; i++) {
>>> +             if (data->triggers[i].indio_trig) {
>>> +                     iio_trigger_unregister(data->triggers[i].indio_trig);
>>> +                     data->triggers[i].indio_trig = NULL;
>> Better use devm_iio_trigger_free()?
> 
> Wouldn't that be called anyway a little bit later?
I thought it would be cleaner/safer to release it using the opposite of devm_iio_trigger_alloc(), instead of changing its reference to NULL.
> 
>>> +             }
>>> +             i--;
>>> +     }
>> i++ and i-- in the same loop looks like an infinite loop to me. Not to mention what happens on the second attempt to unregister the same trigger.
> 
> Oops.
> 
>>> +}
>>> +
>>> +static int bmc150_accel_triggers_setup(struct iio_dev *indio_dev,
>>> +                                    struct bmc150_accel_data *data)
>>> +{
>>> +     int i, ret;
>>> +
>>> +     for (i = 0; i < BMC150_ACCEL_TRIGGERS; i++) {
>>> +             struct bmc150_accel_trigger *t = &data->triggers[i];
>>> +             const char *name = bmc150_accel_triggers[i].name;
>>> +             int intr = bmc150_accel_triggers[i].intr;
>>> +
>>> +             t->indio_trig = devm_iio_trigger_alloc(&data->client->dev, name,
>>> +                                                    indio_dev->name,
>>> +                                                    indio_dev->id);
>>> +             if (!t->indio_trig) {
>>> +                     ret = -ENOMEM;
>>> +                     break;
>>> +             }
>>> +
>>> +             t->indio_trig->dev.parent = &data->client->dev;
>>> +             t->indio_trig->ops = &bmc150_accel_trigger_ops;
>>> +             t->intr = &data->interrupts[intr];
>>> +             t->data = data;
>>> +             iio_trigger_set_drvdata(t->indio_trig, t);
>>> +
>>> +             ret = iio_trigger_register(t->indio_trig);
>>> +             if (ret)
>>> +                     break;
>>> +     }
>>> +
>>> +     if (ret)
>>> +             bmc150_accel_unregister_triggers(data, i);
>> I think this should be called with i - 1.
> 
> You're right.
> 
> Thanks for the reviews Hartmut, I will send a new version after we
> decide on the hardware buffer approach.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

