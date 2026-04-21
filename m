Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773513D7D71
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776780577; cv=pass; b=Q3V3PW0W82ckeYqgdjrRxvqE1L3Nhf09rbnVeYhASCGhXdTE7CbDHbRLv047mKMo05LJ3e9Hhy7BgKunwWSvloiSm92klXwSKBJcOVQKPU4qLsQQdOS5qxIWJQAIqZMgu1LsilVqduPr715+zDgFu5YaH9+tofC81kfa8Dxdjkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776780577; c=relaxed/simple;
	bh=X7ORq6mS/TNqyjQb39gDaXZOf2n64cjXWTFvRWeQgCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzUWjvSAwqLJ5wOddGSeqKAeWB8vC6rtuktKDUi5EQSNBthhDohlOVkwt/x4OeDHqP6JDUoZ5GWxh3UwnNpf10Lh8NObsOhEQd8NnJHetNC+rTLoxbZmQuVCi4BapCa7Vy7lNS2K9FLpvjKXTT3CFv09fHkN/Qk9tbSW0FbhgcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icU74S7m; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icU74S7m"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79ea87af213so73561687b3.0
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 07:09:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776780575; cv=none;
        d=google.com; s=arc-20240605;
        b=TjIkYfHF9KodMStCx/7u2Z41AyBvOUPEvOsXrrBkdJYp+J+5/irm6xe0HifYkjwvCu
         ZJ6SDByN/bRuhkwD95AXXrLghHfM9eYyD3CK/HbXUdZhYDB/FjK/1iy6CdOnZydh/iLx
         5YrAQRAJoQbOu2VF5MGXHDFTNLMPUnYu8wHejtc7F4QxvLyq2hW8wVKTryeUsb/+mFlo
         7zoqSbFTbdNb8hQoqswNFL7ZSRW6OXrBNojO3U7JDtE59/yhVMQfoOTJGwNxhNuZ5GmM
         LufURFCS5cvJ7emu7cC4jxUUncWrzW53jT7PujMTePUAZh3xMg605M3YaRlip/5XyDW1
         ohSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C1pHwHQ9SVvj8JIDmzJQWk+plh9JuV1QDAUDCq0jbXc=;
        fh=jwGRbWhCJV8oBBrHhuDYhVsYHM3jgjs6L4nn0U7/oc4=;
        b=dwbx5FyjAt92QvbH14r2bMlj0SimWzuaIOpjrDylOcFUIaMKbIHmdMiZQTBCjPjSmb
         5bSs2Bb7+HGXhf0UhObtIacBXQOe8Vmt3aowv6+xtac9bts4g6LSTkq+/HEwfQdwuf/e
         y4dkmkvddue7hbtO2goppizfYxuIEq4y8cH0ere4IDhrLOslJsGzDPPK5fR7zSnLoEPR
         7cSrXkcaePbB2kjd9H+Bbo8GNYFH7jxuLf4aDhLAz9omCbr3MtVCvuX6EvdPytEkJXIE
         m5vIia0f2ig5mDya5O3vddyM6PFxC3d7cp4pujDs9GJlTep15P0XKhSpJD8eFax5KD/j
         38mA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776780575; x=1777385375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1pHwHQ9SVvj8JIDmzJQWk+plh9JuV1QDAUDCq0jbXc=;
        b=icU74S7mw9134/chtjjPjdH6vfno5sclizUbE/4XMmQxvRxjOFbRnPrWuYIbc2SrF4
         B2ppIFYfOaf1LmcVmNLMd8OuAJ4x+At5eyR4sOyMtP9vV6vkdVU20GREXjYa4KzbND9N
         Q7JBDz26aiTNE4ipzLFoAADihS28T8gl22/bJZiqwIPd88ITVhN4ibP7e1mKA7XbkXXQ
         SqkNRVD+pZIQt0z6QpQQwcsNoy9g4tcEcv8yDKB3US8+plI/WRg7zEmJQ9qsFNihTjZR
         oYHbUK4hKzWLRT9PMZ8Ln0QZKxROYiR9N6gxg4ZSRfq78x3QQmWutMLnxERno4v84FV/
         rxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776780575; x=1777385375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C1pHwHQ9SVvj8JIDmzJQWk+plh9JuV1QDAUDCq0jbXc=;
        b=ipRKG+OTO7yKIAuVVxb7ZLsxPEN9PAyrLTcVUQ/Y1A0Vea/mWHcatCp38KbZcUBtrO
         soZEjtbh3Q3kX6aQI+jtVPTOiuu8xryzq6dQsNy3MrkWzbg28nvBnrn6jag9XhqQnFhy
         6KV6atfeuNCDhJT5zpzd24ukS+WG5NSKZdp20p1gjncu306ZDjYUC4XYEfZ07F5Jy5Fb
         757C9/Vs3oHdCfZ01UOsbSHK5nFuet9qHfqwDwu1DBAD10XvVWLFqjIOkAdpi4QYUrHs
         dXO9XIhyVuaxctRDkEFvSb+yv0QnSoGEPVi2sYCfk8Wmg9dHh4Bd7KSaWZ+JqroP/VPY
         Cy4w==
X-Forwarded-Encrypted: i=1; AFNElJ9Hsl5Fzcw3+fdL0V9Lsl61fKkKtbiVB9z42qfZXKfmyYQAVxv96ud7nlKHcq+juJfCaBh+LVsCPmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx43/8yrFnPQKAmy2TcJPhKcTReeD0k1WQoCgpvRCwOLe0Co5Y3
	coKgJ/izD90O7IdSMI2qrLiOuk9aTo+eqEgQlVhecLro1HSB/QTDpLiP7X8nuUOYqw3CobaYa+/
	ZLEoOwEC5HSHFrPHYyMuR95fSRtAKD+s=
X-Gm-Gg: AeBDievf5meIUqxWKFwk7fCwm+1NnLUNB1Z0eWcM7C1YR05MRV+8EVBIkScNlQ0w0dg
	PW8SVzjJULcS8q8PaWZ4qwAE9VwuYD4n3W5v9mlqpdKISUVMoBxsCG8cOk+NHIyUxHmhqGsJCh/
	PboJAB4pmwUD8PPe3K/RLKce+KKIHKVYP3xkfgaosyuJmVYGneJVe9LOVAPHa2rxVqecK2TW0lF
	nVrqMTo2ibmpKIdhBedWkeWjTiwDgt8MCbqI6U3/lRq3GoWiJdXm/hp+aPIbjR4UE8+IPvCIGB0
	g65Jhl89V4hEL+r1Cw==
X-Received: by 2002:a05:690e:c48:b0:651:bad2:1eda with SMTP id
 956f58d0204a3-65311c6834cmr13288046d50.44.1776780575356; Tue, 21 Apr 2026
 07:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412154748.24937-1-matheusgiarola@usp.br> <20260413205043.43f8833c@jic23-huawei>
In-Reply-To: <20260413205043.43f8833c@jic23-huawei>
From: Matheus Giarola <matheustpgiarola@gmail.com>
Date: Tue, 21 Apr 2026 11:09:24 -0300
X-Gm-Features: AQROBzA6DGfbnGJcIBFlMil-G5S6CllcWuwEIYzTFA1Bb_b8MY4T1IW5zpj37NY
Message-ID: <CABGH8=YM0GoDz=ksqNa2NMQjZ-omv7bRwPbkBwz4YdDo0Q3OMA@mail.gmail.com>
Subject: Re: [PATCH v4] iio: adc: ad7280a: replace mutex_lock() with guard(mutex)
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, matheusgiarola@usp.br, arthurpilone@usp.br, 
	davidbtadokoro@ime.usp.br
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 4:50=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sun, 12 Apr 2026 12:47:48 -0300
> Matheus Giarola <matheustpgiarola@gmail.com> wrote:
>
> > Use guard(mutex) instead of mutex_lock()/mutex_unlock(),
> > ensuring the mutex is released automatically when leaving
> > the function scope. The change improves error handling and
> > avoids issues such as missing unlocks. It also simplifies the
> > code by removing 'err_unlock' label and several mutex_unlock()
> > calls.
> >
> > As suggested, in ad7280_read_raw(), wrap the IIO_CHAN_INFO_RAW
> > case in braces, providing a scope for the implicit variable
> > declared by guard(mutex).
> >
> > Also, limit guard(mutex) scope in ad7280_show_balance_timer()
> > to keep it locked just when necessary.
> >
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Matheus Giarola <matheusgiarola@usp.br>
> > ---
> > v4:
> > - limit guard(mutex) scope in ad7280_show_balance_timer()
>
> Some confusion has occured here.  The braces thing works for some
> places (where we bring only trivial extra operations under the lock)
> but don't use it where scoped_guard() is cleaner.

That makes sense. Sorry about the misunderstanding and thanks for the
correction.
>
> >
> > v3:
> > - correct v2 patch tags
> >
> > v2:
> > - fix missing scope in ad7280_read_raw() by wrapping IIO_CHAN_INFO_RAW
> >   case in braces so as to fix build errors.
> >
> >  drivers/iio/adc/ad7280a.c | 34 +++++++++++++---------------------
> >  1 file changed, 13 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
> > index ba12a3796e2b..f3cbf8810daa 100644
> > --- a/drivers/iio/adc/ad7280a.c
> > +++ b/drivers/iio/adc/ad7280a.c
> ...
>
> > @@ -519,10 +518,11 @@ static ssize_t ad7280_show_balance_timer(struct i=
io_dev *indio_dev,
> >       unsigned int msecs;
> >       int ret;
> >
> > -     mutex_lock(&st->lock);
> > -     ret =3D ad7280_read_reg(st, chan->address >> 8,
> > +     {
> > +             guard(mutex)(&st->lock);
> > +             ret =3D ad7280_read_reg(st, chan->address >> 8,
> >                             (chan->address & 0xFF) + AD7280A_CB1_TIMER_=
REG);
> > -     mutex_unlock(&st->lock);
>
> Not this.  For this case you scoped_guard() or just take the view
> that it doesn't matter if we hold the lock a bit longer.

Alright.  Since Andy pointed out that it would be better if we kept the loc=
k
only where it was necessary in previous versions, I'll change it to
scoped_guard().
>
>
> > +     }
> >
> >       if (ret < 0)
> >               return ret;
> > @@ -551,11 +551,10 @@ static ssize_t ad7280_store_balance_timer(struct =
iio_dev *indio_dev,
> >       if (val > 31)
> >               return -EINVAL;
> >
> > -     mutex_lock(&st->lock);
> > +     guard(mutex)(&st->lock);
> >       ret =3D ad7280_write(st, chan->address >> 8,
> >                          (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG=
, 0,
> >                          FIELD_PREP(AD7280A_CB_TIMER_VAL_MSK, val));
> > -     mutex_unlock(&st->lock);
> >
> >       return ret ? ret : len;
> >  }
> > @@ -737,7 +736,7 @@ static int ad7280a_write_thresh(struct iio_dev *ind=
io_dev,
> >       if (val2 !=3D 0)
> >               return -EINVAL;
> >
> > -     mutex_lock(&st->lock);
> > +     guard(mutex)(&st->lock);
> >       switch (chan->type) {
> >       case IIO_VOLTAGE:
> >               value =3D ((val - 1000) * 100) / 1568; /* LSB 15.68mV */
> > @@ -760,8 +759,7 @@ static int ad7280a_write_thresh(struct iio_dev *ind=
io_dev,
> Just above this is:
>                         if (ret)
>                                 break;
>
> Make that
>                         if (ret)
>                                 return ret;
>
> and same for other such breaks on error.
>
>
> >                       st->cell_threshlow =3D value;
> >                       break;
> >               default:
> > -                     ret =3D -EINVAL;
> > -                     goto err_unlock;
> > +                     return -EINVAL;
> >               }
> >               break;
> >       case IIO_TEMP:
> > @@ -785,18 +783,12 @@ static int ad7280a_write_thresh(struct iio_dev *i=
ndio_dev,
> >                       st->aux_threshlow =3D value;
> >                       break;
> >               default:
> > -                     ret =3D -EINVAL;
> > -                     goto err_unlock;
> > +                     return -EINVAL;
> >               }
> >               break;
> >       default:
> > -             ret =3D -EINVAL;
> > -             goto err_unlock;
> > +             return -EINVAL;
> >       }
> > -
> > -err_unlock:
> > -     mutex_unlock(&st->lock);
> > -
> >       return ret;
> maybe with the changes suggested above used throughout we might not
> be able to get here with out ret =3D=3D 0;
> In which case make that obvious with
>         return 0;
>

Got it, I'll send a v5 with all these changes.

Thanks for all the support and suggestions,
Matheus.
