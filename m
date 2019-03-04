Return-Path: <SRS0=hh5H=RH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F1AC43381
	for <linux-iio@archiver.kernel.org>; Mon,  4 Mar 2019 09:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86AD20823
	for <linux-iio@archiver.kernel.org>; Mon,  4 Mar 2019 09:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="f3xc7VDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfCDJ13 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:27:29 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41908 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfCDJ13 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Mar 2019 04:27:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id n2so4668801wrw.8
        for <linux-iio@vger.kernel.org>; Mon, 04 Mar 2019 01:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JfbwlTvNmDYzgaeK0KsaYBXRE49UOvQ959liBv3RtE0=;
        b=f3xc7VDgMfjARXfQCRQzyaYQtTL15Wu5Qogt8QVOX0bX+aBWPcuLJf/tUr0fVPw+TU
         5sFAAseVNZbp54SAa0d1TJqzGl6yqtkTHNeAXuhOOHPvCPAu+ZLQUGF6ilwrKAkHoTn6
         vltg84BMX2Fc3zwkusLgLY8BayXXq60pWO8cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JfbwlTvNmDYzgaeK0KsaYBXRE49UOvQ959liBv3RtE0=;
        b=VBmn7Li/NvLXZWsDfF6u2HotdfzhMet5Ak8qcIvRYYiMmH/M9/d88VNel7CaCuqlvZ
         wp9M2ACA/hHtRV0DdfYBSO2ywqkRnXNncf8yuPpRQhGBAT28pNsn0uNi3An/V7PnYJxL
         PZ2wXGzh1mPYf9UaeCICkDG4aFJAmR6SJOImTEXuQ4ZJkqFfi9ntbzwhckpQJA+Adosd
         ZLk06lyqpDFSAoSSYqNfkCXHG+ZE1hQjRRJyx/kTMy+GB8VQOBzZpfCO6zKdxj9DJL4J
         elKrNosCdeFLJ9tF7+bSF9IX2ARo1ot25LRi77o7b4fTtAIG53px2VTRhT/Ic/PyI6WX
         KvEg==
X-Gm-Message-State: APjAAAXERmHg6g0gUrN9zWD7ZlRhIARhi50bCTGN3oKlBmwivK+1eNt1
        qJ0dHphkZmvNokqPzjfjNOyvONmikRV4dXou8hsIiQ==
X-Google-Smtp-Source: APXvYqyTmiI6E4k9qatVbFHJrQXlNzLgCAMa37SKK151r9GeKwnvp8zdepVmtXnTr8hyJCKzLgQD09Jthw8Xex61+oM=
X-Received: by 2002:a5d:6209:: with SMTP id y9mr12854867wru.140.1551691645559;
 Mon, 04 Mar 2019 01:27:25 -0800 (PST)
MIME-Version: 1.0
References: <1525613447-32734-1-git-send-email-michael@amarulasolutions.com>
 <20180506183745.325e67b8@archlinux> <96251f75-6a0b-9668-b103-8d2453bf8bba@metafoo.de>
 <c9d22ad5-ba57-486a-fad9-7e1260dc2b62@metafoo.de> <20180507181714.34760596@archlinux>
 <CAOf5uwkX70XULEAgb_yZVGrCEqvDzZn+o-FV8vAC5ytKvjQc4w@mail.gmail.com>
 <CAOf5uw=KfbgtBRkw4OTk+6oGYFfv4dbh4bM_P9zqPjd1MhjV9Q@mail.gmail.com>
 <20180512104533.7d74aa01@archlinux> <CAOf5uwmfMOyb3kJ5g4wMOc78waaF+LNMRm5ZXKADMoTnMWj4GA@mail.gmail.com>
 <20180512120750.182a9de1@archlinux> <CAOf5uwnV8BQcw3sUK+GRKzbjwDcQ-zGs6ZRPUVoUGZgjNcm5vw@mail.gmail.com>
 <CAOf5uwktQ85i4uxTmonr9weGB19b7W+3ztY6E7P797A+w1S_bQ@mail.gmail.com> <20190303171154.1838e05f@archlinux>
In-Reply-To: <20190303171154.1838e05f@archlinux>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Mon, 4 Mar 2019 10:27:13 +0100
Message-ID: <CAOf5uwnRzSQtTmrBTWpFE7RREqLWXYb2hvDngugOiZp934fbDQ@mail.gmail.com>
Subject: Re: [PATCH] iio: potentiometer: add driver for Maxim Integrated DS1807
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan

On Sun, Mar 3, 2019 at 6:12 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 23 Feb 2019 10:04:31 +0100
> Michael Nazzareno Trimarchi <michael@amarulasolutions.com> wrote:
>
> > Hi Jonathan
> >
> > Very old thread. I have created Giotto Tune based on this design and
> > now try to attach to ds1807. I have done some hack on the current
> > interface to have it working in alsa. I have some trouble with the API
> >
> >   fragment@3 {
> >                 target = <&sound>;
> >                 __overlay__ {
> >                         compatible = "bcm2708,bcm2708-audio-giotto";
> >                         i2s-controller = <&i2s>;
> >                         io-channels = <&volume 0>;
>
> This is a list, not just one.

with the driver I have tried <&volume 1> <&volume 0>;
>
> >                         #io-channel-cells = <1>;
> >                         nreset = <&gpio 5 1>;
> >                         status = "okay";
> >                 };
> >         };
> >
> >         fragment@4 {
> >                 target = <&spidev0>;
> >                 __overlay__ {
> >                         status = "disabled";
> >                 };
> >         };
> >
> >         fragment@5 {
> >                 target = <&i2c1>;
> >                 __overlay__ {
> >                         #address-cells = <1>;
> >                         #size-cells = <0>;
> >                         status = "okay";
> >
> >                         volume: ds1807@1 {
> >                                 compatible = "maxim,ds1807";
> >                                 reg = <0x28>;
> >                                 status = "okay";
> >                                 #io-channel-cells = <1>;
> >                         };
> >                 };
> >         };
> >
> > This is the overlay and this is the change of the API
> >
> > -static int iio_channel_write(struct iio_channel *chan, int val, int val2,
> > +static int iio_channel_write(struct iio_channel *chan, int index, int
> > val, int val2,
> >                              enum iio_chan_info_enum info)
> >  {
> >         return chan->indio_dev->info->write_raw(chan->indio_dev,
> > -                                               chan->channel, val, val2, info);
> > +                                               &chan->channel[index],
> > val, val2, info);
> >  }
> >
> > +int iio_write_channel_attribute(struct iio_channel *chan, int index,
> > int val, int val2,
> > +                                enum iio_chan_info_enum attribute)
> > +{
> > +       int ret;
> > +
> > +       mutex_lock(&chan->indio_dev->info_exist_lock);
> > +       if (chan->indio_dev->info == NULL) {
> > +               ret = -ENODEV;
> > +               goto err_unlock;
> > +       }
> > +
> > +       if (index < 0 || index > chan->indio_dev->num_channels)

You mean that num_channels is taken in account when you request each of us.
Can one channel has multiple raw output?

> > +               return -EINVAL;
> > +
> > +       ret = iio_channel_write(chan, index, val, val2, attribute);
> > +err_unlock:
> > +       mutex_unlock(&chan->indio_dev->info_exist_lock);
> > +
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(iio_write_channel_attribute);
> >
> > I order to trigger both controls
> >
> > +       ret = iio_write_channel_attribute(&data->iio_ch[0], 0,
> > +                                         val, 0,
> > +                                         IIO_CHAN_INFO_HARDWAREGAIN);
> > +       if (ret < 0)
> > +                return ret;
> > +
> > +       ret = iio_write_channel_attribute(&data->iio_ch[0], 1,
> > +                                         val, 0,
> > +                                         IIO_CHAN_INFO_HARDWAREGAIN);
> > +       if (ret < 0)
> > +                return ret;
> > +
> >
> > The problem is that we can have one iio_dev and multiple raw value for
> > each one.
>
> Absolutely we can, but you need to register multiple channels and get them
> all, not just one and then try and build off that.

Ok I need to check back again

>
> > Is this the correct way?
>
> No.  You need to have multiple channels listed, not just the one.
>
> There are examples in Documentation/bindings/iio/iio-bindings.txt
>

I have followed it but not with expected result. I will try to go in a
mainline kernel

Michael
> I may be misunderstanding what you are trying to do.
>
> Jonathan
>
>
> >
> > Michael
> >
> > On Sat, May 12, 2018 at 2:10 PM Michael Nazzareno Trimarchi
> > <michael@amarulasolutions.com> wrote:
> > >
> > > Hi
> > >
> > > On Sat, May 12, 2018 at 1:07 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> > > > On Sat, 12 May 2018 11:50:23 +0200
> > > > Michael Nazzareno Trimarchi <michael@amarulasolutions.com> wrote:
> > > >
> > > >> Hi
> > > >>
> > > >> On Sat, May 12, 2018 at 11:45 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> > > >> > On Wed, 9 May 2018 11:19:51 +0200
> > > >> > Michael Nazzareno Trimarchi <michael@amarulasolutions.com> wrote:
> > > >> >
> > > >> >> Hi Jonathan
> > > >> >>
> > > >> >>
> > > >> >> On Wed, May 9, 2018 at 11:01 AM, Michael Nazzareno Trimarchi
> > > >> >> <michael@amarulasolutions.com> wrote:
> > > >> >> > Hi
> > > >> >> >
> > > >> >> > On Mon, May 7, 2018 at 7:17 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> > > >> >> >> On Mon, 7 May 2018 18:55:16 +0200
> > > >> >> >> Lars-Peter Clausen <lars@metafoo.de> wrote:
> > > >> >> >>
> > > >> >> >>> On 05/07/2018 06:44 PM, Lars-Peter Clausen wrote:
> > > >> >> >>> > On 05/06/2018 07:37 PM, Jonathan Cameron wrote:
> > > >> >> >>> >> On Sun,  6 May 2018 15:30:47 +0200
> > > >> >> >>> >> Michael Trimarchi <michael@amarulasolutions.com> wrote:
> > > >> >> >>> >>
> > > >> >> >>> >>> The following functions are supported:
> > > >> >> >>> >>> - write, read potentiometer value
> > > >> >> >>> >>>
> > > >> >> >>> >>> Value are exported in DBm because it's used as an audio
> > > >> >> >>> >>> attenuator
> > > >> >> >>> >>
> > > >> >> >>> >> This is interesting.  The problem is that there is no way for
> > > >> >> >>> >> userspace to know that it is reporting in DBm rather than
> > > >> >> >>> >> reporting a linear gain or a straight forward resistance.
> > > >> >> >>> >>
> > > >> >> >>> >> This is rather closer in operation to the analog front end
> > > >> >> >>> >> driver I took the other day than to the other potentiometers
> > > >> >> >>> >> we have drivers for.
> > > >> >> >>> >>
> > > >> >> >>> >> Anyhow, how to solve this?  Two options come to mind.
> > > >> >> >>> >> 1) Look up table mapping to linear gain as per current ABI
> > > >> >> >>> >> 2) Add a new channel type to represent the fact we are
> > > >> >> >>> >> looking at a logarithmic value, letting us handle it as DB.
> > > >> >> >>> >
> > > >> >> >>> > Yeah, I guess it is a bit difficult. I don't think this should be a separate
> > > >> >> >>> > type since we are still describing the same thing, just the scale is
> > > >> >> >>> > logarithmic rather than linear. Translation table doesn't work either since
> > > >> >> >>> > your values would get ridiculous small/large. We could add a db suffix to
> > > >> >> >>> > the type, but that's just terrible. I guess the best we can do is have a
> > > >> >> >>> > scale attribute that says 1dB.
> > > >> >> >>>
> > > >> >> >>> The other problem of course is that dB is a relative unit. The ratio of one
> > > >> >> >>> value to another. Whereas our normal scale refers to an absolute value.
> > > >> >> >> I'm really not keen on this.  We have done the separate types
> > > >> >> >> for humidity already, where we had relative (which is a ratio) and absolute
> > > >> >> >> (which isn't).  It's not pretty though.
> > > >> >> >>
> > > >> >> >> Potentially we could define a new attribute that says this one is
> > > >> >> >> is db or linear but that's ugly too.
> > > >> >> >>
> > > >> >> >> As you asked, are we looking at a part that gets used for anything other
> > > >> >> >> than audio or not?  If just audio, alsa driver does indeed make more sense.
> > > >> >> >>
> > > >> >> >
> > > >> >> > This can be used in audio but even in other field. It's just a potentiometer.
> > > >> >> > Can I know what is wrong to use the same approch of audio ampliefier that we
> > > >> >> > have already in the iio tree?
> > > >> >> >
> > > >> >>
> > > >> >> cat /sys/bus/iio/devices/iio:device1/out_altvoltage0_hardwaregain
> > > >> >> -10.000000 dB
> > > >> >> echo -10 > /sys/bus/iio/devices/iio:device1/out_altvoltage0_hardwaregain
> > > >> >
> > > >> > Wow, somehow that entire thing had slipped my mind.  I guess we went
> > > >> > through the whole question of how to support dB scales years ago
> > > >> > and it has just been very little used.
> > > >> >
> > > >> > Hmm. Sorry for my absent mindedness! Anyhow, there are a few additional
> > > >> > comments that need cleaning up.
> > > >> >
> > > >> > It is going to be a little odd as the only potentiometer (I think) that
> > > >> > is acting as a scale free attenuator, rather that being controlled on the basis
> > > >> > of resistance, but for the part that seems to make sense so fair enough.
> > > >> >
> > > >> > I'm slightly curious to know what you have this wired up to though?
> > > >>
> > > >> I'm design GIOTTO ;) an audio module that use those to control the
> > > >> volume. It's a dsd
> > > >> native sound card that demultiplex i2s to L and R dsd on a pcm1795a.
> > > >> Everything already
> > > >> run under linux. The idea is to create an audio card and connect iio
> > > >> device to the volume
> > > >> to change dsd volume
> > > >>
> > > >> > Are the inputs and outputs invisible to the kernel or is this feeding
> > > >> > into another device?
> > > >>
> > > >> I think a reply above. Anyway we don't want to have driver duplication
> > > >> and I think should be land
> > > >> there
> > > >>
> > > >> >
> > > >> > If we are feeding another device then the work recently done on a
> > > >> > generic AFE driver may be useful.  At somepoint we'll need a version
> > > >>
> > > >> Can you point to it? I need to read about ;)
> > > >
> > > > https://patchwork.kernel.org/patch/10358131/
> > > >
> > > > Should be in linux-next by now ready for the next merge window.
> > > > As it turns out, probably not relevant in your case you will
> > > > probably want to have the sound card as a consumer so that
> > > > the volume control maps nicely via usual interface etc.
> > > >
> > > > Perhaps cc the relevant sound lists and maintainers on next version.
> > > > I don't want to tread on anyone's toes if they are of the view that
> > > > it shouldn't be done this way (should be fine from previous conversations
> > > > with a few of them!)
> > >
> > > Yes it's a good idea. I will try but I need to move my development
> > > board on latest
> > > kernel.
> > >
> > > Michael
> > >
> > > >
> > > > Jonathan
> > > >
> > > >>
> > > >> Michael
> > > >>
> > > >> > of that which deals with standalone amplifiers and attenuators anyway,
> > > >> > but I don't know if it is useful to you.
> > > >> >
> > > >> > Jonathan
> > > >> >
> > > >> > Jonathan
> > > >> >
> > > >> >
> > > >> >>
> > > >> >> uname -a
> > > >> >> Linux linaro-alip 4.4.93 #7 SMP Sun May 6 13:23:08 CEST 2018 armv7l GNU/Linux
> > > >> >>
> > > >> >> Michael
> > > >> >>
> > > >> >> > Michael
> > > >> >> >
> > > >> >> >> Jonathan
> > > >> >> >
> > > >> >> >
> > > >> >> >
> > > >> >> > --
> > > >> >> > | Michael Nazzareno Trimarchi                     Amarula Solutions BV |
> > > >> >> > | COO  -  Founder                                      Cruquiuskade 47 |
> > > >> >> > | +31(0)851119172                                 Amsterdam 1018 AM NL |
> > > >> >> > |                  [`as] http://www.amarulasolutions.com               |
> > > >> >>
> > > >> >>
> > > >> >>
> > > >> >
> > > >>
> > > >>
> > > >>
> > > >
> > >
> > >
> > >
> > > --
> > > | Michael Nazzareno Trimarchi                     Amarula Solutions BV |
> > > | COO  -  Founder                                      Cruquiuskade 47 |
> > > | +31(0)851119172                                 Amsterdam 1018 AM NL |
> > > |                  [`as] http://www.amarulasolutions.com               |
> >
> >
> >
>


-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
