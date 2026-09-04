Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDCC440A32
	for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2026 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559878; cv=none; b=TrsocrKkhmPujXpm0iN/ObJl2BqxM34h1Q94TxCe7fXmkSwc9yJ3vaqgmlmfEteA2OjYZEsvSY5Uu6hfqqvlCPCWN1YOA14YqE/GicdzsZJiWJQ5t3zr3SUY5fRB2wC1QxlNszA/GMJ51DDzbiKRsK1xIvX2PAMeq1VeWRYXs3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559878; c=relaxed/simple;
	bh=3LWM1zvZ/OFo8O+h4r0roRLbKpHSFn6xfkytvcIrswY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NBFpIBtFvF46QNX1XCHH8giGixvJkJT2jK37fPNRQwue/HB2uOOvY/4F22F5Qxg7ZRiJbjtEwMJDKqN0h6gpiFmXUz6oAORVWukjQGek/oNYmC5R32+5R7dvQs3p6WTOm0DR1BcIEWizE5x9LTGUV1cVxDMRWMQz3IaTdlA7QyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=SUS4DRlI; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="SUS4DRlI"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4b3b1b3b992so951055b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2026 15:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788559868; x=1789164668; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=j9w+dqtzGg1gXJIVAsCylI6dnTVUVwCFECkpc4h/Vp4=;
        b=SUS4DRlIxaPj9RbHdLsjmr+qcSguj0IB2r/Mp8HUZK0GWOanuH03OERdliF3w3JGg7
         vpMj1nkqsIageaBqRC8qpQganJmeDhvnYaNHKQrenh78xmBNXcvT3dW9YtbA+2LWz9l/
         pb9WKxtaA2t8WMYTe5/qoNsYbrToGPBSL9+4S5tGMnLgTQr+YKdv9zqkRX+32r3QD+L1
         4/6rNKke5E1Ik9tt0UApQ50WRAFwhJu5l30G4Au7vD5Poq+qIb6sX5GJC4aYWMwjUyoM
         XVjS2PrVauba+Bic9jj5aKj9ELm7dvAu7in/U0BxSjGE25FqP+DX+ZJq504UFATOyJP1
         Zgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788559868; x=1789164668;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j9w+dqtzGg1gXJIVAsCylI6dnTVUVwCFECkpc4h/Vp4=;
        b=KctxilgVN7bvn+2e//TcgVytkaDkWQ659R7ww9E0yRxBrPseofEDzkBFXRnu4gPvu/
         2zb/35yAd5KA/lzaXSCrS22Xe/EecwEBhr8OV3F2mU9u32M7lYstsfn+TNLd6doC7jBO
         JbYiUTcDealplGJIt79AslmaQMoHtd+wLLx2p0eXngJd28KjM0eS03kr4tws7jY4wMY/
         kWEn2GgTihAe93Fl0N3n02u84j3lhR7fl9zmYSLGjR/yTN3WxZucjWsRBifEsn/JUIa1
         HohJN5SG1HmQs74N70JLvH06EXzcxf3aJ7MxmSTKTFW5rfg0pxqDv9Xz+U8KAlms3AJB
         tR8A==
X-Forwarded-Encrypted: i=1; AKwUvBwUsJEBbLEJEVEwWwRDqo6/6eoPkYbG5lKsQBEEELGxpeyezbbf2lwW+J+3aaX8vumdl7B5WqPUxeo=@vger.kernel.org
X-Gm-Message-State: AFuF++l2YxdL4bFUGaVt6Iid+YAbCk1wOd9dd1/VFvw1ICIInGWi3bXZ
	s7dxHqopKPBCQSCipikM51Zjj4wJ2C2x5CzKXctyKT6G5vtdfvb4AAuHJ4Jjv3jJHEo=
X-Gm-Gg: AYBFou3VDMWosm97wvmG32fsUm3wGU+rdyyTz5TxsZjpcsqj43k/FxDk1G/y2oSWbGJ
	yMTZkeysbrdZq510EwAbD7dFvUSoovePFQOeQfn/jTQplvyGAQpv+Y71MAEZO8CmZdBQdtn46Kl
	E5IcfPxDqe5waw5QcnKKHyBDKjG0jsZ5Ii2A2hulI9JIcmFwaZsrL9Y7NF/lfGthQxijHf17yhR
	kWIfyzScuo2aYL6zhKPnLvkI5hAvryRxsEFcBNwyVd8U94begmlu130lm73lgtPbxTWpB5jXVXq
	MjgBeJ0MdgyB6rcKyoJB4j+dS5AYsXBjkfsuWgVnlbf+oQFhgYbRLkcOqOWkiCfBmCslFiLz1HL
	339Dw0uNvKXLPtYPPK3XJErulituBGwRKdvtEmSgBN3aUVYbkkb5ZDDfn6I8DtlfPO35PqbxwHA
	cXfmksQkfs482Hv5yZG20r8kbZqw7YfsWo5Akc2EyhhTB0VUEclu2DwMK63bPewCvvc24QJOp0A
	nD5
X-Received: by 2002:a05:6808:1825:b0:4b2:b4d3:f919 with SMTP id 5614622812f47-4b961749d17mr7777439b6e.14.1788559867828;
        Fri, 04 Sep 2026 15:11:07 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4324:3ccf:e2bf:d545])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b970d1ff95sm3187113b6e.6.2026.09.04.15.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 15:11:07 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Subject: [PATCH v2 00/10] iio: adc: ti-ads112c14: add filter support
Date: Fri, 04 Sep 2026 17:09:45 -0500
Message-Id: <20260904-iio-adc-ti-ads112c14-filter-support-v2-0-f86592360658@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5VPS26DMBC9CvK6U2waUpJV71FlYZtxMlXAdMagR
 hF374T0Al09Pc37zd0IMqGYY3U3jAsJ5VFJ81KZePHjGYF65aaxzd529h2IMvg+QiEFca6Jbge
 JrgUZZJ6mzAU63+671qb2YJPRpIkx0c/W8nl6cpnDF8byiP5TMH7PWl+eMhO8IMQ8DFSOlfqlZ
 hyyXmtdUCsWGs/mkXYhKZlv2wuL28z/Wrs4sLDr34K3Nvrkuo/gb1cKjK/ab07ruv4CYHBCPSc
 BAAA=
X-Change-ID: 20260807-iio-adc-ti-ads112c14-filter-support-8a56850f590f
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9206; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=3LWM1zvZ/OFo8O+h4r0roRLbKpHSFn6xfkytvcIrswY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqm0GwYusFTVnkp+UnvL3QnxiIvJm3/zQEq5zO3
 y+WTRe3f92JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaptBsAAKCRDCzCAB/wGP
 wGmCCACDc5aRwS/RCHl868Nvo5RI/AzHd5Y4AA6+2sxcga5BjoqHhifiBRRvZuiNpjyi5agpR52
 G0d8TO5mgE05d/CBfJMKRcCtysK47olpuWxpYAiye2zQ2BcTJS//Sdlcy3TG8nceytpU5AaRvXn
 IoTX3vxFTcPUBVYZ+JRy62GzH/t1C/tvONR1LoIVYi5nICWeI52GDd/PZ/u9dxEcsJifWdDbuLQ
 +3ZYb2N7lfy78O0MUdy0ePnzgPJ09ocRZ2WmqUFOwTLXDdPtxxTMYfFGaTBgKJYlR6mnWmd16iU
 V1BsxuZHqISoRk3HLK/jZWfXOq9JM6LKXaJyJWmFo9zOYnR1
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

I was hoping to avoid this, but until [0] lands, sashiko doesn't know
how to handle patch series with dependencies. So I have combined my
three outstanding ti-ads112c14 series into a single one. It's really
too much all at once, but this seems the best way to speed up the review
process at the moment.

[0]: https://github.com/sashiko-dev/sashiko/pull/389

So we now have:

* patches 1-3: "iio: adc: ti-ads112c14: continuous mode support", last
  posted as v5 [1]
* patches 4-5: "iio: adc: ti-ads112c14: add burnout current support",
  last posted as v2 [2]
* patches 6-10: "iio: adc: ti-ads112c14: add filter support", last
  posted as v1 [3]

Apart from the changes listed below, the patches are the same as in
those postings.

[1]: https://patch.msgid.link/20260831-iio-adc-ti-ads112c14-continuous-mode-v5-0-76f80a04b94f@baylibre.com
[2]: https://patch.msgid.link/20260827-iio-adc-ti-ads112c14-burnout-v2-0-00a1fab9e2d1@baylibre.com
[3]: https://patch.msgid.link/20260807-iio-adc-ti-ads112c14-filter-support-v1-0-4d3ba00caf18@baylibre.com

The rest of this cover letter describes the filter support portion.

TI ADS112C14 has several features related to filtering that are all
interconnected. And to make things more interesting, not of the register
fields map directly to IIO attributes. So this is one of those cases
where we need to bend the rules a bit and just document it (we've
already discussed this a bit in the previous series for this driver and
came to this conclusion).

Here is the high-level overview:

We are adding sampling_frequency, oversampling_ratio, filter_type, and
a (new to IIO) settlingtime attribute.

Since register fields have different meanings depending on filter type
we have a quirky rule that if the filter type is sinc4 or sinc4+sinc1,
then you need to set the oversampling ratio first in order to see the
expected available values for the sampling frequency. For sinc4+sinc1+pf1
it is the other way around, you have to set sampling frequency first
in order to see the expected available oversampling ratios.

In other drivers, we've opted to store the requested values for dependant
attributes like this and pick the closest available one when actually
starting sampling. I opted not to do that here as there is not much
overlap between settings. And as we will see below, there are other
reasons for being picky about sampling frequency.

We also discussed in another series about a proposed settlingtime
attribute. The conclusion was that it should be the total settling time
delay (in seconds) before a chip takes the first sample (after any
settings have changed). In this chip there is a DELAY field in a
register that programs some extra delay in addition to an always present
fixed delay. So the way the attribute will work for this chip is that
the settlingtime_available attribute will list the range including a
minimum value. This happens to be the always present fixed delay. So the
difference between that and the current value of the settlingtime
attribute will be programed as the DELAY value. It also seems that the
fixed latency period includes the conversion time. We've just glossed
over that for now and not subtracted that from the settlingtime
 attribute.

Now, here is where things really get interesting/complicated. There are
even more settings that affect the settling time. We defined the
settling time as just a delay before the first sample. However, there
are a couple of things that trigger the "first" sample. On this chip,
the first sample only counts in continuous sampling mode. So only works
as described when using the DRDY trigger in this driver. When using
a generic trigger, e.g. a hrtimer trigger, single-shot sampling mode
is used, so every sample is a "first" sample and has the settling delay
added. This is mostly a non-issue other than it could throw people off
that they cannot set the hrtimer frequency close to the sampling
frequency attribute and actually get that sampling rate.

And there a few other idiosyncrasies we haven't accounted for. To keep
things simple, we've implemented settlingtime as tDELAY + tLATENCY
(datasheet values). But this actually include the conversion time as
well. Also, tLATENCY is longer if you are coming out of standby mode
(this doesn't matter at this point since we didn't implement power
management, but we wouldn't want to change it and break userspace
later).

Then there is also input chopping where the positive and negative input
channels are swapped in the mux in the ADC on each sample. In these
cases, every conversion requires the settling time because the mux is
switched after every conversion. And the actual first sample has
additional delay (presumably does two conversions). So the first sample
takes tGC_LATENCY = 2 × (tDELAY + tLATENCY) – 12 tMOD and every sample
after that takes tGC_DATA = tDELAY + tLATENCY – 12 tMOD. For this one,
I have valued simplicity over accuracy in the implementation, so it is
the same where settlingtime = tDELAY + tLATENCY and not worried about
the 12 tMOD difference. I think it makes sense to keep settlingtime
as a single tDELAY + tLATENCY in this case since the when the mux
changes after each sample, the next sample is now the first sample after
settings have changed.

This sort of breaks the definition of sampling frequency though since
in IIO, the 1 / sampling frequency is the time between each sample
being sent over the bus. I don't really want to change how sampling
frequency is implemented here though because the current values match
the datasheet which can be used to infer information like where the
notches in the filter are. The actual observed sampling rate will be
1 / tGC_DATA.

Having written all of this out now though, I'm tempted to go back and
change the settlingtime attribute implementation to be more accurate.
In any case, tDELAY will always be easy to infer because it is the
current value minus the minimum value (from the _available attribute).
Then when using input chopping one could get a reasonably accurate
sample period by taking 1 / sampling_frequency + settlingtime.

We will follow this up later with a documentation patch that explains
all of this too.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
Changes in v2:
- Combined the continuous mode support and burnout current support
  series into this series (see above).
- Rebased on the current iio/testing.
- Bumped KernelVersion to 7.4 in the settlingtime ABI documentation so
  that it matches the rest of the new ABI in this series.
- Patches 1-3 (continuous mode): no changes since v5 [1].
   - FWIW, I didn't think sashiko's comments on the IRQ were realistic.
     This could never be used with a level interrupt. And we haven't
     typically tried to handle spurious interrupts in the past either.
     Everything it suggested could only happen with broken hardware or
     excessive noise (which I suppose counts as broken hardware).
- Patches 4-5 (burnout), changes since v2 [2]:
  - Pass an integer rather than a boolean to FIELD_PREP() for the global
    chop enable bit.
  - Drop the blank line after looking up the measurement.
  - Return the conversion error in preference to the error from turning
    the burnout current back off.
  - Use a local variable for the "burn-out-current-nanoamp" property
    name.
  - Compare against ADS112C14_DEVICE_CFG_BOCS_DISABLED explicitly
    instead of testing for non-zero.
  - Fix KernelVersion in the ABI docs.
- Patches 6-10 (filter support), changes since v1 [3]:
  - Move the driver code that was accidentally squashed into the
    "iio: ABI: add sinc4+sinc1+pf1 filter_type" patch back to the
    "iio: adc: ti-ads112c14: add filter support" patch where it belongs.
  - Fixed typos in the external clock patch commit message.
  - Added a note to the settlingtime ABI documentation that the settling
    time can apply to more than just the first conversion.
- Link to v1: https://patch.msgid.link/20260807-iio-adc-ti-ads112c14-filter-support-v1-0-4d3ba00caf18@baylibre.com

---
David Lechner (TI) (10):
      iio: adc: ti-ads112c14: add DRDY interrupt support
      iio: adc: ti-ads112c14: create data read helper functions
      iio: adc: ti-ads112c14: add continuous mode support
      iio: adc: ti-ads112c14: add burnout current support
      iio: ABI: add sysfs attribute for _burnoutraw
      iio: adc: ti-ads112c14: support external clock
      iio: adc: ti-ads112c14: add filter support
      iio: ABI: add sinc4+sinc1+pf1 filter_type
      iio: adc: ti-ads112c14: add settlingtime attribute
      iio: ABI: add settlingtime attributes

 Documentation/ABI/testing/sysfs-bus-iio     |   27 +
 Documentation/ABI/testing/sysfs-bus-iio-adc |    9 +
 drivers/iio/adc/ti-ads112c14.c              | 1286 +++++++++++++++++++++++++--
 3 files changed, 1263 insertions(+), 59 deletions(-)
---
base-commit: e7c1d459e542bc4a9c57f558e8ca1b14df7a7eef
change-id: 20260807-iio-adc-ti-ads112c14-filter-support-8a56850f590f

Best regards,
--  
David Lechner (TI) <dlechner@baylibre.com>

