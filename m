Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8012264D6
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 20:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779827484; cv=pass; b=tgicFA5Ls6ICIuzkO/MvqgHgtDrykUzHRhXJxaMgONensWAmPraUAXeDDrR66bh9eyF8HnD7B0sPSjkBodVnu5n62bQKw5BiGi8tsJjBrh0AfSCHH9nHn9oBuFIIH5u3LjxBDJOe+BXOLItv/QV3TUkm9WQ9+ab60TIVUx4pAxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779827484; c=relaxed/simple;
	bh=vq32mdaOZyU+fLyCUqzi9rcfnu5m2E9XQN4o06/2REM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ozeVaOBV4m6lkFyEcJ4SsURRGYfhNq3GfQCVEUToYsbREvSJ3pdpFM+rY5YMq7SbWMq6nBqVNEUZMcw11CG8a/97aZFtaDbpZ7Gh7PwoM60KW/o1mQQ72aCPlSQ2nxPfQX1u6zTiJ7hLoT0t4civO00mqRNgGXSIVLGfLTGJ+eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TflESoTr; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TflESoTr"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7cb343d343fso102788567b3.2
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 13:31:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779827481; cv=none;
        d=google.com; s=arc-20240605;
        b=hhQm4RH0Y/rUTziIvXebeFnvkhUHJct/PvxF6TEXsvxdRrqRi/5sAlxpGUgSHQ5FNW
         ojr4tYQgBzbf64qu/dF6E9a5wNco4R0gVz5Sh7FPo9ajIjd/1N813JC5CmAVVUuZ14Ae
         MCODuvtlkpRV0JSc5taIkW0kuAOostWEl8YJjsIHTWKUPZ4w6519gQKQz4OzYZBvVo75
         W5cNOSF5GxqWwerTonNEazaWwwh/v+CAlINg7PGgyq69I3kopakWo+CKVvUkf/ZUzFtj
         5dhFZRZOt0O0SgS19UT+YzxsWlLnpr4qp/bZeevDcq9R7zS29fWPK2SQNf7xg36L1Euj
         eo5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b+N6Sg///Mvegw8N6uTx2qmJTcQ1hM4LOa7reevgko8=;
        fh=nIx/ab2fIkd+Tc2F9H9gU3qvjRlBtzcXf4nNYdi5wBs=;
        b=KbHaZuBO6VXDQyKEGQtytMDQQyMihGLKuLUJtZPZ7yKm3bhRLVzXNGX+Z0KLMFAe39
         tHQ8kSACm1PzMW5gCIGieKdiz1Vv4PtrATBKrA0y1xsD7GzUllgI2TTojBdr4yznpI3c
         nWbbNKdYf0wKF0k/mgqDJrVLCM2SEZ14zU9x0M8Abe5aQEkgjLRz/ZS3FJ1YKQf+l7i1
         CWyTsbx1R6y46TTwhfElUGDAeUVPLyyfTXRgP8OUQRT2C6PFSRDk+ExCkG7tFsRlcOCU
         y8HdJd8gL5bIWb6SzJh5yaj3vKgw+BXhFr2qJ6BYOyI23EzYfz/5exUpQ7ZcfcByNmQG
         3Wyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779827481; x=1780432281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+N6Sg///Mvegw8N6uTx2qmJTcQ1hM4LOa7reevgko8=;
        b=TflESoTrvF5wrnvF8+SAlHxaJg2IZQAYtx6GqMMv60EnBBfOJOLoa6Iht70cuwhWyP
         Prh/sPlsHxhMnA8ugQp8HCPRZ/Q0R8LQGsmQdsY8CB/1J1aN70nF/acVWtx2MR0ak706
         7mw/n/YoYh0H1S9q+G6iZVmAcZ9Oo8N/ATIRty2ezB4JgHeLk8Zf4DiS/87dzsBxsdJU
         gKeWkaYnwgPZZZp4FaDciLPVGMO3MWFTj/0GC/7LSLoEANy879ScxztOVf7VLgGwPhTg
         BzWqYQvsKXJEi6S4a5LBcqgcGWjYo2uSBjIn5azFSOVQXpv86fNF8A268gzJ6hpVRaKk
         YJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779827481; x=1780432281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b+N6Sg///Mvegw8N6uTx2qmJTcQ1hM4LOa7reevgko8=;
        b=fmBjlqPcmo2VIZNeSrnwEAjDXe9z9D5W9QU3X4mKibKs8zwdH6jd5iHLf9p403uFqR
         9U/lqjVL1wHqrNBSXHXoNMan+FH3i4H/Zoc8yxjCq1lBcsff6alqCyjTyRrPd9Ytf+K1
         xu8jEkTbKHoqErBWaJ2k2zj53S7EQvVeH8kDOSLeEZwbnCqGOiT2ROZR2kLVnJWRo19b
         INbOcZShtUjvuDYSF2KpiZyhUOjSOEOHsO8maMV8hvQzzkvf4dZTIS8k9NarQe151An4
         61JbznWiVVZ9jLylBb0jEBJKgogE4NcxNtKX8gzq3mBbIFHRbL76OugNEBsnS7zsXtr+
         q0hw==
X-Forwarded-Encrypted: i=1; AFNElJ8Je6doPmNci/N/NCkeGrNZoMq9jjIUqIeZUABP4+xee8Hy52MQ+2AJOtxvkioGzunVugvp3jGeH2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdAs1ltURuEg8eKL3mqmqHP7wSVjFoszFMWWaEVCvRdiK0aTCO
	3NLtgpl40CLp1P/9snNU3RHrWk/xFdm0QL4ytpZ0zZLg+pycsEj40zhWcbD/jmA07VR5NBeNuHs
	ctpgeL1Hi5NGaCvUatp5hDewBQwW/iD8=
X-Gm-Gg: Acq92OEfS4b0pMvqlaDXmlST5ynk7rLIqzh56RySVLEUU5luoA2/yBHOL7QGF+2thTi
	y9Ir1lSEOSpsVyTfoprnQX5au5iT/hKQNDHYbs1zfrpTQU4zJ/E4CijvW/DPuwpFwaj7M6Fqs+V
	RWslHzTsiFD/YHgspqgMUS3HVn7PCc6xgfoSfHYLSR8IvGFuz4stN5S/GBYezNKErtyR9alyJkS
	m62p1uaEftI4Y70BrJ23Uk5hpvtjgMQIFw+rcPQVGuptqepFGIbnJhyBwOwD6CtyFXaRmQBCpPb
	S7Ap++y6dg==
X-Received: by 2002:a05:690c:2608:b0:7d1:fe2a:46d5 with SMTP id
 00721157ae682-7d333bdef5bmr204717247b3.8.1779827480957; Tue, 26 May 2026
 13:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523182531.10146-2-m32285159@gmail.com> <20260526154709.7dfa5f0c@jic23-huawei>
In-Reply-To: <20260526154709.7dfa5f0c@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 26 May 2026 15:31:10 -0500
X-Gm-Features: AVHnY4IAdhhxxJz_D7Gw0GMYMqfF5kVM3rRRnUN7z6vPtvxwd-yKRwDcdtSrN_o
Message-ID: <CAKqfh0ErDrDi++OZiQhJVLujtwKV3vN-zmNZzhz7EfF8wAc-WQ@mail.gmail.com>
Subject: Re: [PATCH v4] iio: chemical: scd30: Replace manual locking with RAII locking
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 9:47=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sat, 23 May 2026 13:25:32 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
>
> > scd30_core.c currently uses manual mutex_lock() and mutex_unlock()
> > calls. Replace them with the newer guard(mutex)() for cleaner RAII
> > patterns and to improve maintainability.
> >
> > Add new helper function scd30_trigger_handler_helper_locked() containin=
g
> > the critical section for scd30_trigger_handler(). After moving
> > scd30_trigger_handler()'s critical section into the new helper, tune up
> > control logic to return ret early and not memcpy() if it's an error
> > condition.
> >
> > In addition, small refactor to replace "?:" operator with regular
> > if/else returns.
> >
> > Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> Just some naming things inline.
>
> I thought about just changing them and applying but decided
> I'd rather you took another look to make sure you agree
> with the suggested changes (and if you do send me a v5)
>
> Thanks,
>
> Jonathan
>
> >  static ssize_t calibration_forced_value_store(struct device *dev, stru=
ct device_attribute *attr,
> > @@ -424,11 +430,13 @@ static ssize_t calibration_forced_value_store(str=
uct device *dev, struct device_
> >       if (val < SCD30_FRC_MIN_PPM || val > SCD30_FRC_MAX_PPM)
> >               return -EINVAL;
> >
> > -     mutex_lock(&state->lock);
> > -     ret =3D scd30_command_write(state, CMD_FRC, val);
> > -     mutex_unlock(&state->lock);
> > +     guard(mutex)(&state->lock);
> >
> > -     return ret ?: len;
> > +     ret =3D scd30_command_write(state, CMD_FRC, val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return len;
> >  }
> >
> >  static IIO_DEVICE_ATTR_RO(sampling_frequency_available, 0);
> > @@ -579,24 +587,36 @@ static irqreturn_t scd30_irq_thread_handler(int i=
rq, void *priv)
> >       return IRQ_HANDLED;
> >  }
> >
> > +/* Meant ONLY for scd30_trigger_handler() */
>
> No need to say this in a comment. The code naming is clear enough. Howeve=
r...
>

Agree here with the removal of said comment.

> > +static int scd30_trigger_handler_helper_locked(struct iio_dev *indio_d=
ev,
> > +                                            int *scan_data, int arr_si=
ze)
>
> Avoid using _locked() in naming.  It isn't clear to readers if that
> means it is locked already, or will lock..  Also somewhat unnecessary
> here. We don't need the function name to say why there is a helper.
>

Ah...I'm honestly not sure. I know we've decided that _locked was
appropriate in certain cases, I wonder if that may also be the case
here. I guess though since I'd have to send a v5 anyways I'll change
that.

>
> arr_size would normally mean array size - i.e. how many ints
> there are in scan_data.  Here it is the size of scan_data - probably
> also make it a size_t
>

Hm, perhaps? I definitely agree with size_t, I'm not so sure on
changing the name. However like I said since I'd likely have to send a
v5 anyways I'll switch up the naming.

>
> So this whole thing becomes
>
> static int scd30_trigger_handler_helper(struct iio_dev *indio_dev,
>                                         int *scan_data, size_t scan_data_=
size)
>
>

Sounds good.

best regards,
max
