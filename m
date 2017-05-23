Return-Path: <SRS0=T1uy=45=cogentembedded.com=nikita.yoush@kernel.org>
Subject: Re: [PATCH 2/4] iio: hi8435: avoid garbage event at first enable
To: Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Matt Ranostay <mranostay@gmail.com>, Gregor Boirie
 <gregor.boirie@parrot.com>, Sanchayan Maity <maitysanchayan@gmail.com>
References: <20170519144802.14427-1-nikita.yoush@cogentembedded.com>
 <20170519144802.14427-2-nikita.yoush@cogentembedded.com>
 <1df453fe-3ea4-a2fb-94e4-7462c2a2fad2@cogentembedded.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeff White <Jeff.White@zii.aero>, Chris Healy <Chris.Healy@zii.aero>
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <f4fca01f-97ea-2cfd-2ee3-b20188415fe9@cogentembedded.com>
Date: Tue, 23 May 2017 10:21:40 +0300
MIME-Version: 1.0
In-Reply-To: <1df453fe-3ea4-a2fb-94e4-7462c2a2fad2@cogentembedded.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

>> +    int ret;
>> +    u32 tmp;
>> +
>> +    if (state) {
>> +        ret = hi8435_readl(priv, HI8435_SO31_0_REG, &tmp);
>> +        if (ret < 0)
>> +            return ret;
>> +        if (tmp & BIT(chan->channel))
>> +            priv->event_prev_val |= BIT(chan->channel);
>> +        else
>> +            priv->event_prev_val &= ~BIT(chan->channel);
>>   -    priv->event_scan_mask &= ~BIT(chan->channel);
>> -    if (state)
>>           priv->event_scan_mask |= BIT(chan->channel);
>> +    } else
>> +        priv->event_scan_mask &= ~BIT(chan->channel);
>>   
> 
> This will race with hi8435_iio_push_event for priv->event_scan_mask.

I was under impression that mutual-exclusion is provided by core. Now I
see it is not. Will submit a fix soon.

> Since you adding raw access then it is reasonable to initialize
> priv->event_prev_val in hi8435_read_raw.

This will cause complex interdependency between events and raw access.
E.g. should we generate event if change was discovered while processing
raw access from user space?  If we do, then we break semantics "events
generated only under trigger".  If we don't, we need complex state handling.

> Then use the following sequence for your application:
> 1. read raw value
> 2. enable events

So what if:
- one application calls read raw,
- then, far later, signal changes,
- then, far later, other application enables events?

Should second application get notification of change that happened long
before in enabled events?  I think no.

There is fundamental race between start-of-monitoring and
change-of-signal-near-start-of-monitoring. To avoid it, reading signal
must be either atomic with start of monitoring (which is not possible
with IIO API), or done after start of monitoring (which moves handling
of this race to user side).

Nikita
