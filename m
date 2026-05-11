Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AF03C3BFF
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506679; cv=pass; b=U+LnrQK+NLEELeUE4B+sWzqdWEPnjrqzhWy02yJsLgJvuOPEVoc8yABDBKe8FPhR4QG6aJ82/m1b4QuM+JXNO9MMWg9D1J0k/8pZNpDuZL/0EMau6JvjtTZwaqmAOSGf3ZM0Y7TWdv90ZTCvd0HfZ8x27loMbrQFv52198qLpwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506679; c=relaxed/simple;
	bh=MqK/xodQHwrwmB5/fY8M0K073ecxhdZ0Go+EE/N0eZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1nhiH4xv77UDKvmgceijYM+rrQQE81Z7iXWQpLFH6LTEsNbBxpnNliiRXaMoAgGws+21lFwYG2TSLKsMuzpRNi/s7d6cXqyUgxuf4/8haND1G9lHwmL2XZDqrpWsT4Rtc9ELkBYgbkNSVeyufe5Rah9ruGpDzf2WD4tbYvnZ7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXzT1LFW; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXzT1LFW"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a86bfa2a4eso4924985e87.1
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 06:37:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778506676; cv=none;
        d=google.com; s=arc-20240605;
        b=jmNX22sw5M2vSV7rtsUui/Iw3fqPcukOr6QObeWgQtpddpA/3ChL3MqfaeLUfAVi9m
         0DJrCkgyQM7ubqAIil0Icr00acrYgvC9/RavoOCIoideWsaxY9+sR7TNVVHTo6bxbFNV
         ps82luoTKUNsmcXOS0hiy1U6XiS+V0qQDqiOgnVN/32fGzFOHVxcvbtTnxn+YTUWca5L
         sgJk1yanDFZcxD0qXRWbTJ6B11nergta9+DBEg3FP3U3wn769o/RPAx6i/2Ml4NvBZLn
         HBIUWenXWB/4wJmqtkJz1o+vZOi1oW/LI5E1rQIkHTbcVRYf2unrqzLejp8xDxJ1t9Rt
         VouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+BvpBk9c5HfMc6g1IDQVeuAZm4EzARcqUTlDj7fkJEA=;
        fh=1FvuMxNowMdav+pbqkbzsKt4WWph7Hx5VLCUndDHrWg=;
        b=hrXEbRiV3Tmp11eJV5qQfUhpJ8MY5HOjxC9o1BS2jdqKRwnO5YFzpsngwYkd2mIRva
         w0vdf5cXYg0dNpPaZ9k3ndMYNESad+fs8hdwdkSCXHBuKmfkyTEoowJ69onUw5k1zjJz
         h+BZLFTbs9QOKacKfmY9UQpjU6sweHBha3bQnXm8oRljE1x01dEm8Sl0E1rP2/cBPCW4
         DIMX8s7pBThiHJ1cOgNATKwADYFtRzK/MX51X3ZPpMiFR0EYBnliQ8JZRZ6UNtw9qOVm
         en8wT1jWPClzZoTBW1t20uo0z/vbEtwJf3J6/9cCh5xE81v3ORu448cz4uNRvK+8qcRx
         g6rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778506676; x=1779111476; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+BvpBk9c5HfMc6g1IDQVeuAZm4EzARcqUTlDj7fkJEA=;
        b=EXzT1LFW+tOwco87Ns86bqywceV6xeD4ZxIRo2ms9CQ1AbwzT2fqtDLt4Iq0uDnugk
         wbYAREGD1Q5gBRUPls0qqgtmevSCsuSuW0EZ4X6z7pTlDMP7McSDnGOQk1jk08r2VRBU
         0NldHWeSDqk6nfuKcvmULQ3rGqebU56vXE1QTJlukYZquYO625UvdNEUhmJVLjSOVeQo
         fLNHWMjxa91JsK4ANx7sau9ImnUBf9Wk936aPwk1Ra08itphuLR2KVcsNu/em7v4H4OE
         XNtSLnACUIaGKb6XEcllkY9KVnozTYaG4jTT5W9EV7FwzWtHZCe1pzcT9wthNQoQEhoH
         J5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778506676; x=1779111476;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BvpBk9c5HfMc6g1IDQVeuAZm4EzARcqUTlDj7fkJEA=;
        b=qzYZuveB+yy7dbGv22cN4Siflf78+mPSZZ43bPqg5RFXbDpev3d2e2B1+8so/Yj3sq
         /2+AmHyxJYSgduP2gxpK6uCpyNc8TUKIaJf22glt/UD0YEzr78e2VbomIKdF4mAOw8+4
         x6A7ex9oOynlcO7OnUUp3FUQEjgGTay3Hkp6BzS9qdN0A6wwLYAvbWb/AxxtBhceARGr
         OltG+vQlp7tWwda/8NB6KwQmhz/adAWmcHYxRX4ivurjFDp9wgLyEzyQ0mI6b223ivs+
         2j+X3GEdo6YKreQwRQZfkCcQ1RvZIxEYXGRZ8194UgOxsD91cVlKrpw+xWSF1UCxBLMW
         2Pog==
X-Forwarded-Encrypted: i=1; AFNElJ+34I92+cF3/5t4blyqc70VXfUMJ6m6u9q/2G1zWBtL4v7+/qmj9+wKx4n7HKmn0o5uCC3Xhz2B4p0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4fQQg+5XGz8gILt78VO/zzC4642mlXyqmXhadHQMYuBJCMqNy
	13LRrJA5tOjCvDKc/aCdsNiY6ey+hFvLSdG0VDiMrr9qvoZ85KGlt6a5SXGzxYQlm7Hbw6ytU9h
	qtwiNGmwoN5qpWYIx2OmmiUf4duZBFdg=
X-Gm-Gg: Acq92OFC0zvvDhmxh0pJ+wWann/ocP5W3an2zFFLww3ubXVnKt2P4q8mOSGPSS/iZk2
	mP2ed+1pjypg5cZxbk5kka/bcsz5Y2WP+N6ET0wh1OpQGkhyxkd7KQf/KgJc4RoiKmRhR6cF+JQ
	6I9Cl/H1hCqu0eG/AQMd6EVtbD4o5X33YmirxnieTS1i2tw2b7xyvXsi5dkjVUf5b2rZs1+o+qZ
	N1UoiU1QutE4vuB46tFXnXVRJSC2CUSI1mTz5BUNar47wDyrSyKudIkHoMJXxfzgQUFx61Ma5+9
	Fb966aDA33K4ctH0iIXGQfbbupxxdejzcl1tNCJXM3wEc9FFbpSecL2XnXs/iJ6IuBSghuYrQQj
	ZrmnGzBzOjgMu2FcmAzC+Our3wf/WurCghdadFS9u2Y63U9eSHZuyrWLrurh8KjjyeqnBPLPKBg
	UkmQ58A0xbs9xw0WX5HT04OO3TjRY=
X-Received: by 2002:a05:6512:3d0e:b0:5a8:7f49:eea5 with SMTP id
 2adb3069b0e04-5a887ada54dmr6485058e87.4.1778506675728; Mon, 11 May 2026
 06:37:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511-opt3001-cleanup-v1-0-f7879dc3455c@gmail.com>
 <20260511-opt3001-cleanup-v1-7-f7879dc3455c@gmail.com> <20260511143237.040382d8@jic23-huawei>
In-Reply-To: <20260511143237.040382d8@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 11 May 2026 15:37:42 +0200
X-Gm-Features: AVHnY4K39JPfhd-7sksMYy78lGGfHNr2Q5unQXSid3SIrKOI1N7RHIUlVzYFjOM
Message-ID: <CALoEA-ywjB5-13v5vfggFfZ3NwDR=x0-KzA6QWgrvJ+VYpMWXA@mail.gmail.com>
Subject: Re: [PATCH 7/7] iio: light: opt3001: switch driver to managed resources
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 15:32, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 11 May 2026 12:04:12 +0200
> Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> > From: Joshua Crofts <joshua.crofts1@gmail.com>
> >
> > Move the driver to use devm_* functions to automate resource
> > management and simplify error handling. This also allows removal
> > of the opt3001_remove() function.
> >
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Hi Joshua
>
> A few things inline.
>
> Jonathan
>
> > ---
> >  drivers/iio/light/opt3001.c | 67 +++++++++++++++++++++++----------------------
> >  1 file changed, 34 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> > index 155794bb28f68a945e20b083e382561ca6ad462e..3ea18d8993da627ae226ac414e8035d8c968861b 100644
> > --- a/drivers/iio/light/opt3001.c
> > +++ b/drivers/iio/light/opt3001.c
> > @@ -804,6 +804,29 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
> >       return IRQ_HANDLED;
> >  }
> >
> > +static void opt3001_power_off(void *data)
> > +{
> > +     struct opt3001 *opt = data;
> > +     int ret;
> > +     u16 reg;
> > +
> > +     ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
> > +     if (ret < 0) {
> > +             dev_err(opt->dev, "failed to read register %02x\n",
> > +                     OPT3001_CONFIGURATION);
> > +             return;
> > +     }
> > +
> > +     reg = ret;
> > +     opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_SHUTDOWN);
> > +
> > +     ret = i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
> > +                                        reg);
> > +     if (ret < 0)
> > +             dev_err(opt->dev, "failed to write register %02x\n",
> > +                     OPT3001_CONFIGURATION);
> > +}
> > +
> >  static int opt3001_probe(struct i2c_client *client)
> >  {
> >       struct device *dev = &client->dev;
> > @@ -822,7 +845,10 @@ static int opt3001_probe(struct i2c_client *client)
> >       opt->dev = dev;
> >       opt->chip_info = i2c_get_match_data(client);
> >
> > -     mutex_init(&opt->lock);
> > +     ret = devm_mutex_init(dev, &opt->lock);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "Failed to initialize mutex\n");
>
> Don't print on this one.  I'm fairly sure it can only return -ENOMEM as
> part of devm registration failing and for those we don't print errors.
> dev_err_probe() won't print anything anyway so it's just noise having
> it here.

Agreed.

>
> > +
> >       init_waitqueue_head(&opt->result_ready_queue);
> >       i2c_set_clientdata(client, iio);
> >
> > @@ -836,6 +862,10 @@ static int opt3001_probe(struct i2c_client *client)
> >       if (ret)
> >               return ret;
> >
> > +     ret = devm_add_action_or_reset(dev, opt3001_power_off, opt);
> > +     if (ret)
> > +             return ret;
>
> This is undoing only part of what happens in the previous call (I think)
> and if we get an error in there (opt3001_configure()) we don't turn the
> power off again.  I'd move this registration into that function - probably after
> the configuration write but before the thresholds etc are set.
>
> That way those error paths are covered and it's more obvious what this
> is undoing.

Okay, seems logical.

> > +
> >       iio->name = client->name;
> >       iio->channels = *opt->chip_info->channels;
> >       iio->num_channels = opt->chip_info->num_channels;
> > @@ -849,9 +879,9 @@ static int opt3001_probe(struct i2c_client *client)
> >
> >       /* Make use of INT pin only if valid IRQ no. is given */
> >       if (irq > 0) {
> > -             ret = request_threaded_irq(irq, NULL, opt3001_irq,
> > -                             IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > -                             "opt3001", iio);
> > +             ret = devm_request_threaded_irq(dev, irq, NULL, opt3001_irq,
>
> Hmm. Without hardware too risky I think to touch it, but why is this only registering
> the interrupt after the userspace interfaces? That seems to be a nasty race.

Good point - this is the way it was ordered originally, so this potential
race has been sitting in the driver for 11 years.

-- 
Kind regards

CJD
