Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723CD2550AF
	for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774136415; cv=none; b=YRqD2lEF8DyfjNdD0kxtQ+RDqjWt5ecJf7fK3rbG+rXWlnBRdSoINlWiilx2GoQiog9gVuxz1Hpa78v14owrUW4IFL8bVSYFC5GEbrbiekchvHwNZA70WoFzXIff/Y+cbexlE4j/C6PskIYq8q8SzUQRUpliAXEwEPYEm6PHe4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774136415; c=relaxed/simple;
	bh=03us+33m88mRKaEpcnY7w1F++szT5Qz0wSZ5EgbUMqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yw2t/32kzPd/2Tn+7FmwufAyJD4W8rq3hRZhvQhSWQQMiGZSZr9pg/lB2tQVa3hm53Z1Jlu3wkAoOeyyQ4judka1Fo9Zz8C8XN3PBC7WrXdmrzRz+xxBMxY5LBnIMjNB6P73WKCweNBi2ky1x2vsoqv9AYslY9HhmNF6nrA3bNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79a4e5caad6so31704617b3.2
        for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 16:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774136413; x=1774741213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AAamBCEutf15hcPE8pkpuda+NYT3m26yn5a0i27N0ng=;
        b=J/iVdHUq1nDezyppbhd4HTXGzT48jRQyGDT0guGFGz4OrMMAMbgL1Pc7RpntPHZvkx
         ur/PE833DhXkuzry6XtCIhSFKMjJgvA0QBTfAokK2V6cDT+URvjLqTnqcb6SEON1TkU8
         d95shfchXNgBffSBH7OmzQ9zR7+2GPfHux9tJ2VgvUoNb6lC54/5rpASvQwjo12O+LB8
         v76qBdd5At/TpR840spdxMjyaZue1+5jlqEooFfAAZqzmUwkdygShnPO6wF3y8y2/0Sc
         rtLH9Jmd4zoBrsx6FEbCTPtF6KC+o1I16J+vN3RMkme+Aojhdcte8KSlCbWP4bcdhcjs
         6ETQ==
X-Gm-Message-State: AOJu0Yx3f7jkup3/0kFEwDyoOhC5PwIET5+Fr4TVjfcS69UpFdXBZMH6
	6KI1fvnvOQNHi1IUqEhhARoPDU/fKa3KO1cGLuYcH8OiZKmqH4W8Vbwaqc0aqOb7Gd4=
X-Gm-Gg: ATEYQzw/tKoSdtfl6Bl/+EJ85H+HKfLO8FLDowAOJSSU6hI85oZx1qD/4wXRo/0kQYY
	m9ZumLCzfvQ6e6fynqY20RRpUnJV0gcBkEDgm7CEdIjCYEvw5W79iLNqUtRdmnKlz+LIAxo/zgd
	0ocZP8qYl163LX37+Y2iHWLwAKPM3yC/dgA6rp+MGamlg4s/uSYIOgqR602ZbhP2y1279ivQoax
	/HUbrG5wviyF7U+dIymhU2p6MA1984qJuKrREdK6/Zzj4WcNza31sfUy/ckr1kcUZ8KNnosqeOZ
	8Ve1cNU+9I9eOVjguTVadfpgdIc5w7xjviFF8zWMNgmcmq+KkPdUzVZdJA/wAGY9Lf/ZlycWAwC
	ksjzfbp/xNlZ89HJIbLNP8WV3lAp1dU/eIwkotBcxO53rgEK8GdMb2KvCwKlq6FXoRkZ0GAlLUJ
	mAnRsnwUshkrIA6yLOBYyzISGiq50SKv+/3miHpJmgOXrbqMNlew+97qfURHJ9eNYQxL9v7rlGj
	ZBaurWBlq8iEe3sQ1AOAze2nYx3NgZ5wvwFrIJ2Ul6ns7x887tq
X-Received: by 2002:a05:690c:d8b:b0:79a:69d4:ac5d with SMTP id 00721157ae682-79a90ae84a0mr91679647b3.27.1774136413109;
        Sat, 21 Mar 2026 16:40:13 -0700 (PDT)
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com. [74.125.224.43])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a9054bee1sm36175937b3.32.2026.03.21.16.40.12
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 16:40:12 -0700 (PDT)
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64e9f9226a7so2602033d50.2
        for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 16:40:12 -0700 (PDT)
X-Received: by 2002:a53:b466:0:b0:64e:a59f:fca3 with SMTP id
 956f58d0204a3-64eaa6a36d7mr5414313d50.4.1774136411946; Sat, 21 Mar 2026
 16:40:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319190738.151614-1-email@sirat.me> <20260319190738.151614-3-email@sirat.me>
 <20260321172151.1f434680@jic23-huawei>
In-Reply-To: <20260321172151.1f434680@jic23-huawei>
From: Sirat <email@sirat.me>
Date: Sun, 22 Mar 2026 05:40:00 +0600
X-Gmail-Original-Message-ID: <CANn+LW+FNy+oCr+XskZoVS=eeCwnYvoKkFyX5fX2fbv8NbALGQ@mail.gmail.com>
X-Gm-Features: AQROBzAvLoOgRGxh7sqALu5OHkzgOo46gcPVkin7WpjyMuHj1YVI7aaRb077v6I
Message-ID: <CANn+LW+FNy+oCr+XskZoVS=eeCwnYvoKkFyX5fX2fbv8NbALGQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: proximity: add driver for ST VL53L1X ToF sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 11:22=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Fri, 20 Mar 2026 01:07:14 +0600
> Siratul Islam <email@sirat.me> wrote:
>
> > Add support for the STMicroelectronics VL53L1X Time-of-Flight
> > ranging sensor with I2C interface.
> >
> > Signed-off-by: Siratul Islam <email@sirat.me>
> Hi Siratul
>
> Just a few minor things seeing as you are going to v7 anyway.
> If you weren't I'd have applied some or maybe all of these as tweaks
> whilst picking the driver up.
>
No problem at all.
>
> > diff --git a/drivers/iio/proximity/vl53l1x-i2c.c b/drivers/iio/proximit=
y/vl53l1x-i2c.c
> > new file mode 100644
> > index 000000000000..771598b92e04
> > --- /dev/null
> > +++ b/drivers/iio/proximity/vl53l1x-i2c.c
> > @@ -0,0 +1,820 @@
>
---
> > +     /*
> > +      * vdd-supply is required in the DT binding but we
> > +      * continue if it is missing to support older DTs.
>
> Given the driver does nothing different for an auto provided fake regulat=
or
> and one from DT, I'm not seeing the comment as particularly useful.
>
> Drop it.
>
Considering there is zero difference between the fake and real regulators
in terms of functionality of this driver, should we just drop the hard
requirement in the binding?
>

Thanks,
Sirat
