Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69DE44B666
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 17:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520461; cv=pass; b=geCOlyd8SPsXGmUWp2DaG2FLJpHB8YfUY7AQuXsmiix7mw2WFBnxN9LepNPPIE2p4LoN7WqxTkMLHssVP6h4y9Ahs7Fi7iKnF818Odj/9XJZK6tCAQ2qZ8yQt60hF02lUGhqdB0g38XXXGs+xyHi9RXUlxXsTvUsllpVKhNmUNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520461; c=relaxed/simple;
	bh=h9D9YFCPtezo/sI8+ZCF7saxAXvSslRz8fSsmjMonV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dE68Qt+DrE0l296LsZX8d3PnwETDz0Nm95VUv2SVeolHv/i9ZThVUYkIwPTi9Le1SwicvK7iY3WT8SEcssZ0zh3tf/+UhApDpG2mteTxkiSJTn88d+0lIT68xi0mwtJ3+fDh5m0rN+csmdaUCl13nn488SVi/+c4Ep43OaGAFn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0rU4bPn; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0rU4bPn"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-65c7a459105so5071791d50.0
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 10:27:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778520458; cv=none;
        d=google.com; s=arc-20240605;
        b=RmPrkozVY58Odjp/QYr8vAkNjjD8005rKefrIyVOzVVdEYIflRyfa/BpXqBI9lmeED
         yVDiaTrzI0j2EehqGVM6VvpfKLxOmz8akVA0ndpeDLjnzVUn3BIRu5T0PcYB5su6vgU0
         J3trsbi0P+rHVXtWGQXwHaAjkgot3k6NvAVF61qPC9aLEY8qUCY8c0047MPCOJR+7PLW
         xo51iW84pjsXKxI2WJLiP9hdGla+3ZgGi5fVNnkkuOB+iE1UKPCa60cj8rMDJCzdfIJk
         aNxfkjkSj3+9PV+1w8S3Dqt+0rvsF79RssA9MceE8aWqX55UH8Q/HHhDguo6p0gUHTSV
         XNrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZLvsIja7ViCjKxEzY9czuynUWaO0QASbwbJa7qkJCok=;
        fh=oDCcDBpuI98BAY1wHCEr4e7b0gYAV4RYITUZvvCieDo=;
        b=OluBB2GyVIL+ABsSqOPFdc1+u4qS8n5H65HpV2b63bgdGrAuIPnQAYORaMftREGbP4
         I/yyu6JqpOTC7uPx0cS61K3hsEeU8ja4Nolu/im2eTygjp5vExXAQFZZu2H0vorOsN6z
         rAGNVmpQYY/2Z/aA/pvkNlyJDnzmMunYAsrOWfnFhhCNdOE+PnvCrqFhVsqffeEZuGx9
         zZ78B/6j7Kqo3cAUJacai1O/1reye9VFQRK/W+ncYtA/Ul4cMclNrIZLV7feCqbLRYJ2
         N+OdBd4PhGJ1o9BG9ewi6OJZPKSHRLa+g8OBiesR62wtu0d4FyeEPsQMwU9sjKvf5e6K
         MTPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778520458; x=1779125258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLvsIja7ViCjKxEzY9czuynUWaO0QASbwbJa7qkJCok=;
        b=b0rU4bPnnxjOOyaVBvEOKtUmJXxyeXfuCRpXb80fwkdLzrU3ufVC/PTUjcPXAl3oJw
         Y4eHh8FquZypZQEJjRD6lnq1W7E2co4XWbP99Tm/ayL4fdn62uMBcnalX+XNXRPhe1az
         26zUEpY+959Vpn8eObud9ON/W937i+Iwzq98heMyFydtAjuChsoSCtb6473eZbbwwDIl
         TCNBIT/cR103h8ItKi0S1S6UfPAxgUT9mD7GW4ifnsaIsZ+DtjcE0G+mTJ8Th9lljBSO
         VuFAdPULZWdZp0fmoxeX5vjV+tzhOzwNT3r1Wggy+A3KOXa2rc/a0k3lCc6QLJKooaYc
         v/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778520458; x=1779125258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZLvsIja7ViCjKxEzY9czuynUWaO0QASbwbJa7qkJCok=;
        b=npnyjIW49J8ncyvNIYiNYYXzyaeqMWG/YsbQy2w3QkS0U8ozsgCHAtolu2/wV9Om6m
         myuAcZ+XetqXYmoj2qcIwQjfvve603sXoIfPsSWKtCVp5DPtSgRNsRCqAWwpQL/DPoGP
         eMuowrCq2jSy/1LUkI76X24aa3+rogWIUBtm1pSse5FbAE/cBsVWZpHfZuDZR9xAztwf
         f/Wx17VTLfEVsqewA9vPfzN2Xn3mA5R+mZ26Zb3pTgYU2AAJaF1jsZ8gZjcFU03xB8W6
         8AQZcrSI+tWWihtXcKYWGFXX6K8tjUws36b/Tk/8qSB5vDFJ6fsnwVk+uAfL12hJa8oD
         l+jw==
X-Forwarded-Encrypted: i=1; AFNElJ+Qx0uaAj0T9zaHz4wL0WGOXvWMFYhVQO5neLQPtaliFBXg5btfUWTrxCUnjqtz9PrGROCctuIKcLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxROTXTPdmQO5tICYinWJyrYaSrzCJuR7YZdSPLoL1D2R7sUdyN
	zKDLmH6wT0IIbFzvuXhWMkC599szGz2j9w96B6byfBjXPRrnUFP6hp6FxU96/5JVgKbsltcPiJI
	OcXRokZhATpnQKF8X/zg0ACQxXku5vxU9Mix/6nM=
X-Gm-Gg: Acq92OF5GELg/wSR6Lv48OIs7sr4ZJwJebu/GpaVgLG+95HDmG2xu1hNXLVS7kwpUCE
	YMC/ygK/VtwSznegQAMFRudIehoc0gT/83OOLStVUQH1jG+rUN1gcdQDBFgufC/M11HmR5fcgS6
	xTkjUenuQkiiu+aTpGofiU1i2tf4f/ea1tNRyDTfUu8mpNBw/KCqiLeT36BXmp0g6sPBOhxZ8ep
	nfRPR/d3XzdHQzoaaWEkDHmcSNHcPhq5fx1yxcYZY4UuGdMID6EzAP6a9sPSnvR/J6TEuXHhYDf
	QM5vxOZHag==
X-Received: by 2002:a05:690e:43c3:b0:657:a6a4:6ee2 with SMTP id
 956f58d0204a3-65ddd49c373mr259490d50.3.1778520458444; Mon, 11 May 2026
 10:27:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507223337.48437-1-m32285159@gmail.com> <CAKqfh0ELaB7ifXNT3EkuC-K9s=V-mNgQ9WZt0ufVgmSD3xGQeQ@mail.gmail.com>
 <20260511181749.32d64889@jic23-huawei>
In-Reply-To: <20260511181749.32d64889@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 11 May 2026 12:27:27 -0500
X-Gm-Features: AVHnY4LvzYLRNzA6jMDGdDvYVL-mZvasmSlqDQhyIHulccLOOwEfKsneVhONO0U
Message-ID: <CAKqfh0GHY_WkiLQK3rhDYtvyab-iQdiUmGFHnYjix=K3xLXJ8A@mail.gmail.com>
Subject: Re: [PATCH v5] iio: imu: kmx61: Use guard(mutex)() over manual locking
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 12:17=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Fri, 8 May 2026 08:03:45 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
>
> > Hi Jonathan,
> >
> > On Thu, May 7, 2026 at 5:33=E2=80=AFPM Maxwell Doose <m32285159@gmail.c=
om> wrote:
> > >
> > [snip]
> > > @@ -945,29 +942,26 @@ static int kmx61_write_event_config(struct iio_=
dev *indio_dev,
> > >         if (state && data->ev_enable_state)
> > >                 return 0;
> > >
> > > -       mutex_lock(&data->lock);
> > > +       guard(mutex)(&data->lock);
> > >
> >
> > Correct me if I'm wrong but this looks like a TOCTOU race, was
> > reported by sashiko at
> > https://sashiko.dev/#/patchset/20260507223337.48437-1-m32285159%40gmail=
.com.
> > If this is a confirmed race I'll get a fix out this evening.
> Indeed looks like a correct report.
>
> Take your time though. I'm swamped anyway so will be a while before
> I get to any new patches (probably!)
>

Alrighty sounds good. Dunno if we merge this or not and then send the
fix just in case or if I base it off of the original. Former seems
preferable.

best regards,
max



> >
> > best regards,
> > max
>
