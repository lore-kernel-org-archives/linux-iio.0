Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8F438657D
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 07:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778052505; cv=pass; b=Yajm/Gp9eFNWoqykooGu7xypgEEgBwMGxwdKTGZrKBCyUphl46JZ5Wdy3Kj09Qj1/nPvLfu9x8apPNWSkf7jbbaJSjHJlnTCgOrdHcXyHgVyf93A1ztA5B162UXAqF09fpFZGSpGrqM6EVZ27a+p9dg44JB5uKIsbGFvWjBpJuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778052505; c=relaxed/simple;
	bh=tdBafC2HCPoEI0XPI5C1rKJ8ih9PjLQDGt68OlcN3zU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPrqpCweTlLQxJa7Vq/A6tadTcUbslsBx8y1MKEEchgayRqou5lhZ6Uuhngjr1r+/myRLJlO8YizG4LcRsnd+tuaE63Gspo2wBs/7vDes5Afx3569MfzF2KN/SkkJdJmiXiVC5ID1r/S17ZliAtHoOluTmXlQ2KuwTnmS0QruB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q8x1uMSy; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8x1uMSy"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-441209fb77eso353598f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 00:28:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778052498; cv=none;
        d=google.com; s=arc-20240605;
        b=QPR4hMStlTCdrb9/9uyePByAU3z7gdeAnL0R8pWnU53xNjJcUoQyl1pkWNBlfj/5UW
         r7viCYGp6WPnNrdJvV6MVL8V5ADNZaTcxTR1D1p17jKAR4czHRQEqU5VotMZ7CB7KbFO
         IPpFPIOdxDCdbgq7hQGkq7V+IkNlPr2liJ19QsSm3l1v3aVymnBF/64cMkRRDq7Zqh1o
         AtG2CwwItdSKakVhhDQiE7ZbgpOVRv9iUSUVUfDHZBc4DRbnFtTy/BmxVhZ40U16iHuX
         MTsmZMMXIDJk3WFdVmtBNwvOHeUkfICYQWMpTGuKbo7YAbyPrPXpud5m+B5bNqv1SUj0
         zGbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5r7+vlbLgJaJmD7WDsOov2Ix+E6vjJ5fLmj99gVwBQM=;
        fh=rVTj4DVuAzRvJhZrA10KpGO1jJ/ETnfukcN1oTR85yg=;
        b=Uu5FsQQHYuLLhSJCjLHmEln0PXacNznUc8XcMo3dnw31JqOXzk+JBGWTJMtUhMrkuV
         qr2m/d0m4bKioyJXMEDXjdVbkK6qj077RfscCbXK/CqN4cvEpW5YV1ZE8RZczSLa3lg/
         xZfzcNgP0AL0BSp402f4jubO0VAQyyHIIRMAeauRWdMZImp6aJK4s19D+RizYXmabFaV
         TNmFnDsEo/XnY9Tm9+3EsggNmJWZGFTmulYg53m+kCtb5ceDVXbqj5ZVSye+wkwcIwWW
         5GS7K6I+V9hrJwu/75grzjVJ7RYEg2GYEMvmQ2xsPRiKuUTxIEH/GX0fAS8kIVqzE1X4
         Eg6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778052498; x=1778657298; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5r7+vlbLgJaJmD7WDsOov2Ix+E6vjJ5fLmj99gVwBQM=;
        b=q8x1uMSyqKToyPDA6mNXhcw73iJVjn8FPHUzI+dM1CSBaRNwojgZkxVEsLyPRytDqY
         EcDD6IHRPHQlJV7GcsOe/odCItTpJOxp66DA56WH34kWuvVYHJDz0WNU5N5p4RPDz441
         4b3G5MKagGuCd6ZOg0/ezwVQQEmLL+bXt+Dvx6DHl0+SShfys0AjStXPh3WIQLwKzjhB
         vT2VA2KgvgNRh06d9VV/OG+P6k96puRwh65qhYW+AT5WeexTSS/SNhU8RB5mLDh9LLRp
         oen2EDR9CY7apDBdEmynaiwlVeISFiPh3f1Ir/Dkcwmpsg8C1gSYR9/k8eqn1fxuKRQE
         yPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778052498; x=1778657298;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5r7+vlbLgJaJmD7WDsOov2Ix+E6vjJ5fLmj99gVwBQM=;
        b=MbH8TPPhb7T4n20X+myCt95ZfDwlissEILqPWO7mS5NkGidhxSCxx711kD+Tr4j5O3
         KHYwwhhMkPkCLZgBFDvevNBzn5vqWl7yzAv4XBDv130IKfMRi/uxlGa+PanObP6l3Keu
         mlhQI3NjlYKKdUSDeRuJ10r/5gg/rPRym1oKo18cLaHtWJT7YL81T24z1MVa4W7B54Qf
         O7/inqMJzs65TC1WCWj8qcYS/L98W4MydnZdsl6t1d/5GpwFYBmQ86ZwVAj/O0z4LhmA
         746bFo0HMqZIM95YFqwZWBl9+NGlRcjGU2tpry7MYnx41R4s9VyQ8fZI+2Iw+nMiL+DU
         3W6Q==
X-Forwarded-Encrypted: i=1; AFNElJ+T+bNK21xdDYNk08SbNLZgRrHJOxDTUBmZDJkMENVsN9tjcmKF/4sKAwrwDv57cqUBZlKzIKV58ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuUXxu9x0l0oMHyffsd/WeepLb8Oz/ZS/Uiiqz3LuWBnsipCER
	L8RWXzBGbkyuPolKNo5UkjGOSfaqzHOZF66ye1Co1vz19XlRjkpwTtl0nNfSgiMDl8YH8jzp9/o
	n8bpyxkJ/gfohIQNyghN6Roh2BOQHoMTDGGK6
X-Gm-Gg: AeBDietxY1SLmX2A9MpgYSD0WRsC5EJgX18h9iXEi8eEnVy2vchCXWiOfaTQSi//9qz
	IGcKGQO4gO5yHTLcYIvRl4AiI8qU/F94uMlkwPN8XDKhSBrjxd0xaUsUcc9zrd/li9o5+9KLOvE
	iSbER2SOR0owlwL/6ou9ppywDz287hJXtdUEq9Z86vvwxacPkoxU0woqtOkDF6gn+hfUMHGjy0M
	RM6KDnvZ5NdSHKaWa3bvZnrs11qD60devHisLkUL5ylLO9bynWpg2SfkaMw8Ma1+BLt4SYQL4mJ
	k3d5evcd0/m3HmdXleNa8ER5k7F3AXRBPn5sYY+Owwq4KmNv2WR1fhy5/xdDJGNMjbWZJ2ojvzc
	aKqi8zH9KQ/tOj326L1Dv9xgqUs4LQDq8tVbkff+7SOaZueIdIxzHtSQ2MN0W43C0vHSjmwE5wm
	s30mnkHzIDvEbgdOgj
X-Received: by 2002:a05:6000:430a:b0:449:31ca:5e53 with SMTP id
 ffacd0b85a97d-45163b89473mr3350164f8f.8.1778052498187; Wed, 06 May 2026
 00:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-6-831b9b5550fc@gmail.com> <afrg7uXqyKs9il1Z@ashevche-desk.local>
 <CALoEA-z+K8FzgwbYfi_aJ3oL6qi2TyXFDYKpmn1Mmjw8XApvNA@mail.gmail.com> <afrrzM67n7NQWdE3@ashevche-desk.local>
In-Reply-To: <afrrzM67n7NQWdE3@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 6 May 2026 09:28:06 +0200
X-Gm-Features: AVHnY4L1-9olo5gcNBeYqHCVDUfKbDaY0Y4yI2GfWhTiaoCqL3QKpOcAZXLmEX8
Message-ID: <CALoEA-w88c3565-U49ic+FDG1mfpohWzMjZmTus+Nj037W0Sow@mail.gmail.com>
Subject: Re: [PATCH v5 06/18] iio: magnetometer: ak8975: pass conversion
 timeouts as arguments
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 May 2026 at 09:20, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, May 06, 2026 at 09:02:15AM +0200, Joshua Crofts wrote:
> > On Wed, 6 May 2026 at 08:34, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, May 05, 2026 at 01:46:02PM +0200, Joshua Crofts via B4 Relay wrote:
>
> ...
>
> > > >  static int ak8975_start_read_axis(struct ak8975_data *data,
> > > >                                 const struct i2c_client *client)
> > > >  {
> > > > -     /* Set up the device for taking a sample. */
> > > > -     int ret = ak8975_set_mode(data, MODE_ONCE);
> > > > +     int ret;
> > > >
> > > > +     /* Set up the device for taking a sample. */
> > > > +     ret = ak8975_set_mode(data, MODE_ONCE);
> > >
> > > But this piece does not belong to the main scope of the patch.
> >
> > Fair, probably a badly resolved merge conflict.
>
> Hmm... Usually what we use is interactive rebase. Very powerful tool!
>
>         `git rebase --rebase-merges --interactive $SHA`

I see, well I use `git rebase -i HEAD~no_of_commits_in_series` and
sometimes I move a different thing by accident. It does get a bit
crowded with 18 patches (yours were fine but I also had to do some
resolution after moving the order)

> where $SHA is the same one that you used as --base for the series.
>
> In conjunction with
>
>         `git reset HEAD~1; git commit -s --interactive -c ORIG_HEAD`
>
> technique, you can easily move parts between patches.
>
> (There are even more advanced techniques, but I'm an old-school guy.)

Good to know, thanks!

-- 
Kind regards

CJD
