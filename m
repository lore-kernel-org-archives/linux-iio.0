Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F55345CAF
	for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774008641; cv=none; b=XCFrpldriUGdl10q9YtXh9u5wm2T1dMjhBSdZcfxLL3y9T4AzWsPZlcAXxmnxs61zrOWkIzKu199VJWiIV9OGrm0kfhaQ0m1pX1CSMSZpsuegIG+CE05b4mxmIQbdNzM3SHm/tnv1lv31cu4LsJ/BgvKnBr1jdKxxOb2KPLNEf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774008641; c=relaxed/simple;
	bh=B3pmlX7fRUqZADkEMiZVMNjp5NfJXRwh+wSOc2Cr4IM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwWEu0VTpImGcBSceCsBd5H5/aAL3vHhr1fnrxo+hI9GUGXohnonuw5JrZsicZNxuQsQp35jX6yLjBnX1U5CEzF9M+JrsP3A6Az3zOytTVwgRqc8SF0CmpXqvdqtkg2VGKjI5KNGiY+JH9UElnN8DNBdzCN/vyzZevWsVzf1RFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64e9f9226a7so1566472d50.2
        for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 05:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774008639; x=1774613439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ATjBD35P3zbZ6+Azz3hbE7hIAK2d60Azv4xoO5wqRiI=;
        b=bbmvMYN+ZzZjz5zgkjb9gdLQwAwU94r1NfA5pg8zdeZYQsvs9v3j+r0QE7nDkVOI9+
         mH7HXw3UNsOGmWOEmSsZql2nUtSl8Gnz4jze0OqlcwC3t688TjpDzQrJTgbgx2GfhKRn
         TZSCU6NQH8UARk+f+/JsjRvONVVpzNyLwgymU5xwZkYcRZoExneG43uwhfAJGSnV+k9G
         jSwOB6pYvUHbi276Uhvnr2kAg1Qd5VI/k4GhLjuq/0NWDTgcPXbCxdkEjq2UeQzlBUWp
         uvFqhE689ievGNMbaiLU2cI5AFxow5aHTiOrXl3wKU0gsK1bYNF+Dg+RvreDUuP2qkMc
         WctQ==
X-Gm-Message-State: AOJu0YxDLyiKcuk9UITURJlPoWFBGSDqXWRmmfjIwCRUgSdtnD3mQYPn
	y1qBKSL3uzmT1UAXxmKvl11DsDVDUTrwqFEt+xuti18SaS8/j+dvkyu2j8Y079v+Tsw=
X-Gm-Gg: ATEYQzzxdGKXiCRQ01T+jNyMsLpa49hAqsF7hvjfUzJibSO5wF+Squyrf6I+JgIj3Uk
	zgIChqHoX0IujA9Z9r/ddSeXVOhioQU6+6Gp9f6YNluupqYv8VvsvFMsJvbUXVT/31DXzysvy3K
	ilWinOP/tBZDZLzWdwUkRjFP34j2dZF2GGeea6XlMMNGIvDZ+huWWPkT7/01IAGTYBb+ehqQdRW
	CpUQ/9TFUtPPLOVy9+DDaSRpCHqS378ivakUC4H3CwnKwt5H0meRumHPcLRdEDzzcf7D8xTENZO
	44jgjjNgLo3vQ2s9uc7AqNAXSqQPzRSveOF2x03PvchK6OfHF+UK+9N9evnifJVh/BUZjNzKIf1
	4pazsf2jRUx4vT7DERMkd2GIUHKzC6pYj/HFDNWy/+J8i34Zto5m4/INyFOHeKm2tDRFXetqG0V
	KoxSUaDPCV5hTsBeG6dmW1Ocy6CTc5Bjwo263X4dJYhNCdq56IPcxmxw0LGSFF76gRsjtA9hbVX
	qLTNrP2VtpBsFALIr2bTCEC0j92mSc1vY/vjsi4ag==
X-Received: by 2002:a53:ca4d:0:b0:64c:b68a:f519 with SMTP id 956f58d0204a3-64eaa8688d8mr2333780d50.80.1774008638847;
        Fri, 20 Mar 2026 05:10:38 -0700 (PDT)
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com. [74.125.224.53])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64eabe7e34esm1301620d50.10.2026.03.20.05.10.36
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 05:10:36 -0700 (PDT)
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ae222d978so2179665d50.1
        for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 05:10:36 -0700 (PDT)
X-Received: by 2002:a05:690e:190c:b0:64e:b4d6:e5d6 with SMTP id
 956f58d0204a3-64eb4d6e6b1mr279913d50.7.1774008636354; Fri, 20 Mar 2026
 05:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319190738.151614-1-email@sirat.me> <20260319190738.151614-2-email@sirat.me>
 <c71a7cbb-d313-4d42-a487-b5f194d4e9bf@kernel.org>
In-Reply-To: <c71a7cbb-d313-4d42-a487-b5f194d4e9bf@kernel.org>
From: Sirat <email@sirat.me>
Date: Fri, 20 Mar 2026 18:10:25 +0600
X-Gmail-Original-Message-ID: <CANn+LWLWiyAo8_+V0EtPyie9AsNZdo+pU2MBhZ1c7im5XhagBA@mail.gmail.com>
X-Gm-Features: AaiRm51RgqLpMK0miW91Gb0hRuE85RHbT74etOPMUjWxfOY7ewwlyNCX6BBm8Jw
Message-ID: <CANn+LWLWiyAo8_+V0EtPyie9AsNZdo+pU2MBhZ1c7im5XhagBA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: proximity: add ST VL53L1X ToF sensor
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 3:05=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 19/03/2026 20:07, Siratul Islam wrote:
> > Add device tree binding documentation for the STMicroelectronics
> > VL53L1X Time-of-Flight ranging sensor connected via I2C.
> >
> > Signed-off-by: Siratul Islam <email@sirat.me>
> > ---
> >  .../bindings/iio/proximity/st,vl53l0x.yaml      | 17 +++++++++++++----
> >  MAINTAINERS                                     |  6 ++++++
> >  2 files changed, 19 insertions(+), 4 deletions(-)
> >
>
> Please read:
> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/s=
ubmitting-patches.rst#L577
>
> If a tag was not added on purpose, please state why and what changed.
>
> Best regards,
> Krzysztof
>

Hi!

The vdd-supply requirement and the pin descriptions changed.
I was not sure if it was a substantial change or not so I did not add
the tag on purpose.

Thanks,
Sirat
