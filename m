Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:42722 "EHLO pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752134AbcHXEdd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 Aug 2016 00:33:33 -0400
Date: Wed, 24 Aug 2016 06:23:17 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Matt Ranostay <mranostay@gmail.com>
cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 2/3] iio: chemical: vz89x: add support for VZ89TE part
In-Reply-To: <CAKzfze_Yc7EPekKcSybWBO-Noq_wuYaLx8qKeBSni_8+QSBEsg@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1608240621280.24751@pmeerw.net>
References: <1471923894-12194-1-git-send-email-mranostay@gmail.com> <1471923894-12194-3-git-send-email-mranostay@gmail.com> <alpine.DEB.2.02.1608230735270.12003@pmeerw.net> <CAKzfze_Yc7EPekKcSybWBO-Noq_wuYaLx8qKeBSni_8+QSBEsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> >> -static int vz89x_get_resistance_reading(struct vz89x_data *data)
> >> +static int vz89x_get_resistance_reading(struct vz89x_data *data,
> >> +                                     struct iio_chan_spec const *chan,
> >> +                                     int *val)
> >>  {
> >> -     u8 *buf = &data->buffer[VZ89X_VOC_RESISTANCE_IDX];
> >> +     u32 tmp = *((u32 *) ((u8 *) &data->buffer[chan->address]));
> >> +
> >> +     switch (chan->scan_type.endianness) {
> >> +     case IIO_LE:
> >> +             *val = le32_to_cpu(tmp) & GENMASK(23, 0);
> >
> > could use le32_to_cpup() probably
> 
> Except we need to apply the mask anyway...

but you may save the ugly casting

p. 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
