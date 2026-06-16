Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769DB25B0BF
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 00:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569099; cv=none; b=g5xk4Q33A25cqiqh6/nHBE3YjYHCt6BtqPyiHPh9pDidBwI9VOGz8q06cxNRezsQz/R7AQcVjwyS9H0xfVQ38X2WdMa7aiQQP1BxxOm76IfeqqM+0vioGSJ/NspoCYXL1IV+npKRktMWDllw9Cc8G7KWiLf8DplEmVTRB9CxKbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569099; c=relaxed/simple;
	bh=TGiNhBCpIlLVsrpFKC/UHrDinbJmTPPjAIq8nvUHN8Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SiQMsIAZhAZzO5VlxfQlc1mAEz5kwLaK1udkeHeXZ2p2mOt12AgmiYStdgLjRbv1fAMM6uitnZAaM17HQ5ayDDiJAthQbtGetZeykcR8YHcb01GFe6pWqEppSoYPa5bcybrh5rMSv1zQUTr5PrOAq6N7SbMeigq01kZcFgK+K5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCp5R7yS; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCp5R7yS"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-59c9b666822so2726117e0c.3
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 17:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781569096; x=1782173896; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XjgGOrceVekK5pZWWuZNBUzfFHNSRvj+8A/YjnFN7Y=;
        b=UCp5R7yS6NrD4lD2zkZ6TKNMfmgB4zh0fI+tk27aYNvhxLQlSRtpPLqdenoPJVrlY9
         rd6X3jRtJfV/qEBNY9zAx2lF5fwPk6gHdUKMyJkCuYqDbkk9IpINSWrazRBQ1AqZOFQp
         +ub5Ks5NsLh+O3W3IFwMptT+2tBR2Q0vUTY+7K+O+oUTkqcGOyAVmeczMY2uoRF4Qu0p
         MFg+89U9ALDandEvLslrd4OSecsdWcjqfgddwUpXLz4RKQWn9WrFcVUlCi0DKHoanWOK
         WGHQU7i2lMPF1f82fVXcfpCMeB2pLKu8nDxeEIHQ3j+9C79oLPSgaLKBwNn3Xck8vlVo
         JkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781569096; x=1782173896;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+XjgGOrceVekK5pZWWuZNBUzfFHNSRvj+8A/YjnFN7Y=;
        b=FIpnZ/3+Elbrcn95jzJkE0FF6ww7DWSBdFWuwBywASlxr0aO+2E7pZz4ucSFxbtiiA
         JpKPRv5VgEveBQ7m3UVrcpc/1q89tHoirYFXzExHvYLRH+wmlP1vrd5yjryLE+OkEe+U
         qk34tOZiq/YYK9jEooiSHoOe29usZ6RbXNSeC/eXKMYu6wElfaeSP4f0YjbRaYDlxj2r
         T3bgWoDGLoF5wN7SqLSXzPnqsG8DFUtiRSNNePNeDwTFmxsHnTu+17YBSzSFLB7bYpuN
         dlSALsQNyItHE7QznNuNsg5PURTgD+uynmTdQ/CiRBU/Hg48/TFCxV/POIKLF3yFhHcp
         Ilmw==
X-Forwarded-Encrypted: i=1; AFNElJ/53/Vg+FcWzO/2qQS2Ozs1HRjM52d/oDgtKPsXd6C2/c/YzF3MP6cIVJEJNP6tUV66mSASnRp/q2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyiiH/aWtIrvnpNW+l+aRo5pnG3bEshQjILEWV+8sJEOak81x+
	P7l9ouNibDn7aWHvarJsN+NSYl9TX3+hDpYa2JG6SKk6AqhArWhQhK3b
X-Gm-Gg: Acq92OH1Bp5mk6Gde0miJWPBQMq3CMeD0I8aROrMFtLwXoss4BoTb6z0Sd3eCCdi84y
	fElOHsaRHxzGOry3OU2o6cklmW0QwAA1V+ZQXJRCphf/ieonlwv/B59uCmLpTkaU1ejH7gc97AP
	EnFfVLeLWJkws52mUhKzbkzQUKYuu7kcq0OPWTrTHNlY7V+bdxLnYW48pS5WzuY9SwYp0c4Tw9X
	VLszOh8249SF5in+s+4W+Nc8WwuR4tqeiZJc+4pWC1xBjBTpSZ9hir/XcRQjHNb+IOxfN+3vLHD
	+z2+Q2NQhyWKl2visQV7KUKBDaQonc9Jjy/Nv+wttvz+uqNoZR6quQ/V1nFUKhfCGHvzQdXLy7c
	u65iXZbsodwlieWJHx9m1Wmi9MbdTRePbq4paXQz6r7mAkISr3KPRnmPWHR+VTnd+z6p6XjHa8y
	+z9dzpGQ6x9YTxLg8IlR7XMy6c
X-Received: by 2002:a05:6122:d0a:b0:5a5:3eea:4513 with SMTP id 71dfb90a1353d-5bbae06426dmr929168e0c.12.1781569096408;
        Mon, 15 Jun 2026 17:18:16 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bb901ac206sm4803328e0c.14.2026.06.15.17.18.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 17:18:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 19:18:08 -0500
Message-Id: <DJA1J8D91ESA.2XU7OCVKN7LXU@gmail.com>
Cc: "Kurt Borja" <kuurtb@gmail.com>, "Nguyen Minh Tien"
 <zizuzacker@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] iio: adc: new ti-ads112c14 driver
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner (TI)" <dlechner@baylibre.com>, "Jonathan Cameron"
 <jic23@kernel.org>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
In-Reply-To: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>

Hi David,

On Mon Jun 15, 2026 at 4:59 PM -05, David Lechner (TI) wrote:
> This adds support for TI ADS112C14 and ADS122C14 ADC chips.
>
> The closest thing we've seen to this in the kernel already is ads124s08.
> However, that has a completely different register map and the DT
> bindings are incomplete and the driver is extremely basic. So I've just
> started from scratch here.
>
> We've also had a similar submission recently for ADS1220 [1]. That chip
> is in a similar situation to ads124s08 in that it has a different
> register map (but the submitted DT bindings are better than the ones for
> ads124s08, even if still a bit incomplete). And literally as I was
> writing the previous sentence, another series [2]  was sent for yet
> another similar family of chips (ADS1262). That one is even more complex
> in the feature set than the ones I am working on. I was going to polish
> up the driver a bit more before submitting it, but now it seems more
> urgent to coordinate with the other two series to align on how we would
> like to handle all of these.
>
> [1]: https://lore.kernel.org/linux-iio/20260610151342.44274-1-zizuzacker@=
gmail.com/
> [2]: https://lore.kernel.org/linux-iio/20260612-ads126x-v1-0-894c788d03ed=
@gmail.com/
>
> All of these chips have in common that they are designed for use with
> RTDs and thermocouples and so they look very similar to each other in
> terms of wiring and feature set, even if the register maps are
> different. They are in the gray area where we could either keep them
> separate because they are just different enough, or we could do like
> we've done before with ad_sigma_delta and have a bit of an abstraction
> layer for the register differences and otherwise try to share as much
> code as possible. Normally, I would lean towards keeping them separate,
> but in this case, I'm considering trying to share code because the
> devicetree bindings for the inputs is complex and is going to be mostly
> the same across all of these chips.

The channel configuration is indeed very similar for the three chips.
All three have IDAC, BOC and VREF configurations.

>
> If we decide to go the route of sharing code, we could still merge this
> series as-is and then do the refactoring to add the abstraction layer in
> a follow-up series that also adds support for the first of the other
> chips.

Do you have a proposal of how such an abstraction would look like? I do
like the idea of abstracting the firmware parsing, scales and shared
calculations.

>
> This series includes just basic support for reading single measurements
> from the ADC and gain selection via the scale attribute. I plan to
> follow this up with additional series to add support for buffered reads,
> filtering/oversampling configuration, event support, gpio controller
> support and perhaps a few other things that are slipping my mind right
> now.
>
> The most interesting part about this (that I alluded to above) is the
> way channels are handled. These are multipling ADCs with differential
> and single-ended inputs. But what sets them apart from other similar
> chips is that since they are designed for use with RTDs, there can also
> be a current output required to excite the RTD and this current output
> might be different for different channels. So the way I conceptualized
> the channels is that the devicetree specifies the conditions needed
> to take a particular measurement rather than being purely a physical
> channel.
>
> This makes things more flexible, but does make the driver a bit more
> complex. For example, knowing when the current output needs to be
> enabled or disabled. For now, I have chosen a lazy-enable where they
> are not turned on until the first measurement is taken that requires
> them, but then they stay on until another measurement is taken that
> doesn't require them. This can lead to some oddness with the diagnostic
> channels that may be measuring something that indirectly requires the
> current output (i.e. the external reference voltage when it is connected
> to a resistor rather than a power supply). This means you need to take
> a measurement that requires the current output to be enabled before the
> diagnostic channels will give accurate readings.

This is the same approach I took around the BOC, it feels kinda hacky
but it makes sense. Just an idea I thought about just now: What if we
have an additional write-only "_enable" sysfs attribute for these
channels?

The approach I took for the IDAC was to have a single configuration that
it's enabled for all channels. This makes some sense in my device when
thinking about optimal software sequencial reads, because of the
register layout, but I also see the value in having per-channel IDAC
configuration. I think I will take your approach, so we have the same
channel configuration around this.

Have you thought about how to implement the BOC? In the ADS1262 the
feature can be found "Sensor Bias". What I did was add per channel DT
properties for this too.

Another question. When you implement power management in the future,
will you enable autosuspend? IDAC currents will be lost if autosuspend
is enabled. Is this acceptable? In my case I did enable autosuspend, but
I have some doubts about this.

>
> I have also pushed a branch to [3] that contains the start of some
> documentation for this driver that can give some more insight into how
> the implementation works. It still needs some work and also documents
> some things that haven't been implemented yet, so I haven't included it
> in this series yet.
>
> [3]: https://github.com/dlech/linux/blob/b4/iio-adc-ti-ads122c14/Document=
ation/iio/ads112c14.rst
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> David Lechner (TI) (4):
>       dt-bindings: iio: adc: add ti,ads122c14
>       iio: adc: add ti-ads112c14 driver
>       iio: adc: ti-ads112c14: implement gain on internal short SYS_MON ch=
annel
>       iio: adc: ti-ads112c14: add measurement channel support
>
>  .../devicetree/bindings/iio/adc/ti,ads112c14.yaml  |  224 +++++
>  MAINTAINERS                                        |    8 +
>  drivers/iio/adc/Kconfig                            |   12 +
>  drivers/iio/adc/Makefile                           |    1 +
>  drivers/iio/adc/ti-ads112c14.c                     | 1053 ++++++++++++++=
++++++
>  include/dt-bindings/iio/adc/ti,ads112c14.h         |   11 +
>  6 files changed, 1309 insertions(+)
> ---
> base-commit: ec039126b7fac4e3af35ebccaa7c6f9b6875ba81
> change-id: 20260514-iio-adc-ti-ads122c14-d0b92479334e
>
> Best regards,
> -- =20
> David Lechner (TI) <dlechner@baylibre.com>

--=20
Thanks,
 ~ Kurt
