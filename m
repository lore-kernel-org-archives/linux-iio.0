Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1E323909F
	for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 23:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773616843; cv=none; b=P3ljTwBgVqWqhIG3knOST5EdtBttCXRLjtcQqOPiP4o5teZv5/f4e+2nX0QQTEnSx/52AGafJiLTPAxVqKVeOv8hl1wJosncF9FutGgCz2LfUXBHVg5RDqPut/RSYMDKrIgRTAAKWnGaSfhZbs7Ymy9k3NSGI0UAVpi7pgHan0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773616843; c=relaxed/simple;
	bh=Vj5x1vUv4SFvnor1CgHfsWPBhzIC7+CaxxXc809b7kE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGx2b113HHkRrHVVjYdYxTxmNErtRTsZdW905gy4BJCxLfgW3h+mcmE76gFX1FUNJ40lbYfgLv/ZtWgzVJntEx/VTsdNABTu2QWQLvZy1LzTwNSZ0D6kCeddh6aIC4iTJCchNSancwE9cTgh+Kr5V/rYsQ6BWcDBqZmGp9nLDLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64acd19e1dfso3625774d50.0
        for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 16:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773616842; x=1774221642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bXxvI7dwyBvyYzzG73LmHExQnMN7J8QMVgYTtKMjrPI=;
        b=FnmrwGgFZxTxq3AxRYf5thQD7SqnmKWl1Ckt7JgI3ywDGTNnnvQKb1j5PHDAaOTc/Q
         rqxFGA63DwZl9Adnef0aLLKQWD27bEI03eKTcyzwa/sOxP7Ii83gJv4Jkz4UT71FTp1c
         de1arqTiA67foFAJF9RtCShpGA3s4kb0wSNhRWKEzstW1zFCWtoEKf1u8/GRR6vME6NR
         EZ11mqxQJme59NxsO0/91e9xPu8HyLEYSbaF1+BV5cG9cu0sZMdwkKhOUVAB90Axvkwp
         16odMQ+CRk2Lq/aF/zAHWVipow8F167164WSI1FAwfUSoiddvpuQfHrPmoNEGVhl8sFn
         3dkw==
X-Forwarded-Encrypted: i=1; AJvYcCXWvhR2K627O2p4AqP/2W6K93db4snu8bfCQq+96hUFlvP7Sz1yPRV8WOZoEIiCpxdkmkEFxPkLr9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsjc6UpGgpoBk3P5Q/QrKMr+3ufsD+K46kwRQzFLAz0MqFmR5e
	uX83iMRtKhgTXM+BhtcomGid1Obk4xRYIvt5gwj5Q80P04wUjs4iwmWgDpiPqtpp
X-Gm-Gg: ATEYQzwpTw9mQaOj2hZ7rWGJRXVgCpRzcHujqxwT9QfMEWISzCPrKeSpqe9DHle3uht
	FMH1H1ugRkUJyK5TEOlgF9lKDN7m+jdYHPtT0qvQJhaj1tub9DNXZF/X6biAy/4szJ23G0NkJsx
	KqSE7IGItRPxLTaam/4L8jJoIAexnzEZx6P90TOHSp7zC4WFigG1bC7shnNBxWJGechlatlK5VZ
	f4cFoVJs8fahbiwT05X/iRpfpbit2MhD885fAGduc8sQMwXDFopECtuKJBK1uepKoyYuLJqXr0d
	eUcyppNw9L64zZkynRh0HEH7HgkNt7JKukfKFwKGyW/ZKPaJbG2V8U6QwHOhQ1OmoZsV5MDK0iA
	LyJ4XpYuMPglsLVWYjdEJha447a/dyekX42C1uYTaqUqsIecCnP5z/dDDp6ILmoxnx2dCwaSOGs
	39qR9Zxf4pq5QhSPm7JDmiS0SZs5Ra0n0lDL/nOHAkrgnVUG5NLukptrLLEaHYKlNJvWy00GmPZ
	iyRg7ZWgZLwIlaYxyDcst2I5l81Qkc8+W1ZAZh5Ydz2uT+QFqUM
X-Received: by 2002:a53:d058:0:10b0:64c:c616:c351 with SMTP id 956f58d0204a3-64e62fb7ec7mr8843217d50.40.1773616841557;
        Sun, 15 Mar 2026 16:20:41 -0700 (PDT)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com. [74.125.224.41])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e65ba7b31sm4715608d50.20.2026.03.15.16.20.41
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2026 16:20:41 -0700 (PDT)
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ae222d978so4188734d50.1
        for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 16:20:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCI9/KAT4Y8y13DPODh3hL76PrSipffq+8cU+a3RI9x8fwRgMQUcVgB3zv9Utz1qw33/yIF8ST3W4=@vger.kernel.org
X-Received: by 2002:a53:da11:0:b0:64c:f871:6530 with SMTP id
 956f58d0204a3-64e63096361mr8599821d50.77.1773616840979; Sun, 15 Mar 2026
 16:20:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311224044.21480-1-email@sirat.me> <abLNbGUmaA7K0s68@ashevche-desk.local>
 <CANn+LW+F2bVMAGwoF8q9yBpF3x5r_hWDqvE3_JYjcLd16A_cEA@mail.gmail.com>
 <a2486bc7-13be-4567-a53c-b37921df7bcd@baylibre.com> <CANn+LWK2OZ1dm0TAstM2hr6O6h2nEPRrNfje0mC3a2uc0HEwVQ@mail.gmail.com>
 <20260315185715.2f97c496@jic23-huawei>
In-Reply-To: <20260315185715.2f97c496@jic23-huawei>
From: Sirat <email@sirat.me>
Date: Mon, 16 Mar 2026 05:20:29 +0600
X-Gmail-Original-Message-ID: <CANn+LWL85Ot6yrfuNB4qw3YoUJPyE1YD2gf9PPPGoAGv8EOJ9w@mail.gmail.com>
X-Gm-Features: AaiRm53i9h1kwoP9wlywp23JgrxSmvP7tSNKDT_tz5So4h089_CJJFwdpbLmuhk
Message-ID: <CANn+LWL85Ot6yrfuNB4qw3YoUJPyE1YD2gf9PPPGoAGv8EOJ9w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] iio: proximity: add driver for ST VL53L1X ToF sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 12:57=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Sat, 14 Mar 2026 21:25:44 +0600
> Sirat <email@sirat.me> wrote:
>
> > On Sat, Mar 14, 2026 at 8:39=E2=80=AFPM David Lechner <dlechner@baylibr=
e.com> wrote:
> > >
> > > On 3/12/26 10:12 AM, Sirat wrote:
> > > > On Thu, Mar 12, 2026 at 8:28=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@intel.com> wrote:
> > > >>
> > > >> On Thu, Mar 12, 2026 at 04:40:35AM +0600, Siratul Islam wrote:
> > > > ...
> > > >>> ---
...
> Can make it required in the binding. Just explain clearly why
> it should be there.  The driver should carry on coping without
> it though (and leave a comment so we don't break that in the future).
>
> Jonathan
>
> >
>
Just to make sure that I understand this correctly,

I will
  - make vdd-supply required and add a description of what it is.
  - add a comment in the driver like "vdd-supply is required in the DT
binding but we continue if missing to support older DTs."
  - also add reset-gpio description and update the example to include the v=
dd.

 I'll send v6 after a few days.

Thanks,
Sirat
>
>
