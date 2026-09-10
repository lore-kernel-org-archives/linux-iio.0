Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBC93AB292
	for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074881; cv=none; b=iblbWmmw8DwjM0n3I/3aV884L0etNeS4NOBF+62BCo4JUOkqYg/a3vaxlIrOII1Av8xSK9hmxzryr4XlXyv+xm5fDcE1/4TXnv9/sgQpokHY9gEr1tZE1EUkpzDpC9mPRaJkLfSkkVuH/v+7VN02JINgBHm4KI/5xn/dfceuwWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074881; c=relaxed/simple;
	bh=2MRf0iEATe9QMwEIa9W63i8mjSRtVs8e8r/JWhbc2Nk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WfpZS7e4+6oFtxdzBG81meNzh90962gPb4cKjtBWbynA0flzwnbJUjtIEj5NpxwuPjLt5nSj+0eJikuQq8npb6Rpndzq8IdC5EWEKNJ/i25urBdr94bTNCUnrthmtYg4AuKKM45CIqTYPQ3jDww6GV3VleVP57HN979xsPJDNSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=RhtFNV5s; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="RhtFNV5s"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4b3a61bdf22so216325b6e.3
        for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 14:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789074871; x=1789679671; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/2o2KBBoY3eBbW7X60cO8yzKvW06Wsw8NjBHTGQ5Xxw=;
        b=RhtFNV5sKqjGosuimOP3yjUKMlWVtoPUL9E8dcfzD/ZyAzr0XB0YXPXD+eyWzuQdSz
         gIq/MMAmS43IDxi6QIUX3YIc33sijZBN3t4Kc1E13IQGh4iRD6Lx0NtJ9G6jySa6ZxYu
         TA7GtvaxzAlrGi0B2dgSWTeLDL08ksqIxEpmqZb1/pOC3EKql52a265kIx1S5MhOE+BF
         w5fzJtWGexsD7BccZ+YJAb7Yoj1yknY7PMS3aum0skzooa7OtG4m/A/f4SBspM4WiSo7
         NfHtGywwoX4nvMl+qH/lzjfYiekdTH4g7CyS/7ufhE3YCa8dvRMavNsM/UX/a44awgiq
         jjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789074871; x=1789679671;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/2o2KBBoY3eBbW7X60cO8yzKvW06Wsw8NjBHTGQ5Xxw=;
        b=PcvRaq3tJWHaRaFtIYnqzskAJKYgDUwYj7KpxVerI93QQsIjpXQFawAf+RUCWeyr5c
         ygr26wpu7wBSxns+Xz+i1omFdn9Lqok8D9BOW8x2K9eEWO8gWUGbn69LOAZxjZKszvRs
         sjBESTJn/m0RyIZdYUxsEMR8sFGQx0totyMHbPwn24XHLEa6jrhly+OZw3WxCZfxSRxp
         xiebIxK12nTM+3shkZhTa1pF0pVm1fXu+JD7F2jfqdv8aUBb+lKfAKEzyjIRxG4HHho7
         oeyDKeD32+ME5N2f0lYzYJsdfw5Snr0vBeydzjt5VygzAG5OJLiP63V6G3cV4hwqo/qk
         sW8w==
X-Forwarded-Encrypted: i=1; AKwUvByl6jKdrr6h5/fknI8N7el1Ihp8ttRuxKvOYiv638Y7rH3sPNJhVLbBMyTRoae49nzCkRfVGkYqFCA=@vger.kernel.org
X-Gm-Message-State: AFuF++lICr87k3LeUlxmg1cvTQBBUKW9BUbpkXUdE2P/ZZlViuyukf3m
	mIsfibYsDBXZ3LSApoFZHB5hZFjvNPopX5OdMh8PW9M4VjpnPHK01Ik4WtsrQVZ/wko=
X-Gm-Gg: AYBFou1ZvkCsDrAl25Itv/sbghZzJ1aeR9uubamqbHsCr/ARfZtKEe9C2sLW5ucx1o0
	JSHHRh92Wey44KR5/JjOBZiSFNbxMPEo7iWqXc+Rm1iuDhljN9eV/DnlohX4mzFRQtDNr8Eui55
	WkCUP8ZVIMK3Jvm9fDZt7MyNDBTi07pX5+7ZmBAR/waTXa7VaD5oywOYr44+GvO46JOtBFeFc8H
	MjuO83VmHbXpRzAbEx0pOemf+EhqrElKsQaFaPR296a9LniyI8TIdPpyg1k4Nc+UhnoRRw6WZxc
	sMjEJ/IoB2cQMcPA4LJpS/gEwwFwXCdzGDiJihidp2Y5B1KTEDuRE74z6LwDZgMk3+Z16/aEBel
	TaSwrRbQyENcjp6uGq1tAjKKgsWyYNXz6IM2c6sTCHkYYRLmnYajsfLK4uA2TjRGSsnzlhQI+NL
	S17sRnQ2df+aiLksEonMzfKmFqdEaeKHMd6bD6H6JorM/IcZfax6P2bCtf6FMnxrvK6EBAEzpbv
	TAg
X-Received: by 2002:a05:6808:3518:b0:4c3:b3e:4e72 with SMTP id 5614622812f47-4c319d4934bmr678410b6e.12.1789074871227;
        Thu, 10 Sep 2026 14:14:31 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fbf1:d0da:69e0:11a0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c330daa42esm347315b6e.4.2026.09.10.14.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 14:14:30 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Subject: [PATCH v3 00/10] iio: adc: ti-ads112c14: add filter support
Date: Thu, 10 Sep 2026 16:12:59 -0500
Message-Id: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WPwW7DIBBEf8XiXGrAhto59T+qHgAvyVaxcQBbj
 SL/ezdOpUo9tafRaHffzN5YhoSQ2aG6sQQrZowTmeapYv5kpyNwHMgzJZQRnXjhiJHbwfOCJFl
 K5WXLA54LJJ6XeY6p8M5q02kRdC8CI9KcIODnnvL2/vB5cR/gyx39vZHgslB8eawxZzNwH8cRy
 6Gi+1wnGCNNa2pQkxacjuxOO2EuMV33F1a5H/+r7Sq54O3QOCuEt0F2r85ez+gSPFP+HrGqH2w
 v2r9hFWFDZ3SvGiOM/o3dtu0LprrAwH4BAAA=
X-Change-ID: 20260807-iio-adc-ti-ads112c14-filter-support-8a56850f590f
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10621;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=2MRf0iEATe9QMwEIa9W63i8mjSRtVs8e8r/JWhbc2Nk=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqox1rdCEj0fb/c334yeA2X+gwOJEeueRugZtTa
 CgobF/iS5yJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaqMdawAKCRDCzCAB/wGP
 wJwYB/4yyHEn+pFa43yQ1oahbrFtqByHigJvdpa5QYZ+H3Q4PBQagUqh8wdem9Ogm/KP+6mvXS5
 A904rJJhtAk6BeybHHT84fqd3DftZV5bURsth34MnQcvwtRw4eKMxhVkwKKiODLxtAuKHI7NKkC
 b1fAoCycqYjIwaqAVNqAurzOSIZBVFGDeua4gyqk8XRiPYGumiJWLJ/FRxrp+qNC5GAUPmL3bks
 xwtap8HpMIJv9OLyg9e7pwOwZyxtdMyKHxoGJy2hgYUn8vTtZMH/sCDiG0U2j7if7cQjkb11xrP
 FYRsYvLr7moh9D/6K/OLxBj5NiVNOnAXYyT+Trlg3H7d20kL
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
  reviewed as v5 [1] (identical to what was sent with [2] but review
  was done on the standalone series)
* patches 4-5: "iio: adc: ti-ads112c14: add burnout current support",
  last posted/reviewed as part of this bigger series [2].
* patches 6-10: "iio: adc: ti-ads112c14: add filter support", last
  posted as v2 [2]

Apart from the changes listed below, the patches are the same as in
those postings.

[1]: https://patch.msgid.link/20260831-iio-adc-ti-ads112c14-continuous-mode-v5-0-76f80a04b94f@baylibre.com
[2]: https://patch.msgid.link/20260904-iio-adc-ti-ads112c14-filter-support-v2-0-f86592360658@baylibre.com

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
Changes in v3:
- Patch 1 (DRDY interrupt): only require the "drdy" interrupt when it is
  actually listed in interrupt-names, falling back to polling mode
  otherwise instead of failing probe (the binding allows interrupt-names
  to list only "fault").
- Patch 3 (continuous mode): allocate and register the DRDY trigger
  before requesting the IRQ, so devres teardown disables the interrupt
  before freeing the trigger (avoids a possible use-after-free that
  sashiko flagged).
- Patch 6 (external clock): use FIELD_PREP() with named values for the
  CLK_SEL bit instead of regmap_set_bits(). Validate that the external
  clock's rate is non-zero.
- Patch 7 (filter support): fix div_u64_rem() pointer-sign warnings in
  the new ODR table code by using local u32 variables for the
  remainder. Use unsigned int instead of u32 for the new loop indices,
  declared locally in each loop.
- Patch 9 (settlingtime attribute): widen the intermediate delay
  calculation to u64 so a large requested settling time saturates
  instead of wrapping around. Rewrap the poll-timeout call.
- Patch 10 (settlingtime ABI): expand the commit message to explain why
  the total settling time isn't simply the difference between the first
  and subsequent sample times.
- Link to v2: https://patch.msgid.link/20260904-iio-adc-ti-ads112c14-filter-support-v2-0-f86592360658@baylibre.com

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
 drivers/iio/adc/ti-ads112c14.c              | 1298 +++++++++++++++++++++++++--
 3 files changed, 1275 insertions(+), 59 deletions(-)
---
base-commit: e7c1d459e542bc4a9c57f558e8ca1b14df7a7eef
change-id: 20260807-iio-adc-ti-ads112c14-filter-support-8a56850f590f

Best regards,
--  
David Lechner (TI) <dlechner@baylibre.com>

