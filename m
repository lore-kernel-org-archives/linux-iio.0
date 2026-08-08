Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E8E72623
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 00:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786148436; cv=none; b=MdjuZPYRK7brxWrm4mXWpCf1p3kqtfVzlv0IUu6PiFtPmCL04aE+1J5FwyQDkQNIjYrQToSfS8E6GvnmAKJv2UfXeU1mkJZKiBTlw7v1m2umxJnKDGyMniSiN4yRZBAtWvDxuVa0gF65m9mSispwNeCkuhd4W/vP0jNet/X0X10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786148436; c=relaxed/simple;
	bh=Gi3Ghc/Ir6ktdQRFJhJk7usYPJZ8ES5ulfhKzTeDUXM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ueEzLYMd1kLA5z/J0OaowTkA6GOu4tDgX6D+yFdJ4etzW+eUfqJ1y3B7h7Jye+hUzq46I6OeTD26YJou+nQjpsYc8WVbk2aFIG0mnm8DgRa30iLojJ9dFNB0kmOI+YF6ORLBMMAgmkhtBg5yWGOOd4nPLYlW0XxN8PcBf0A4y0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Tkw+Uohe; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Tkw+Uohe"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e6128bd9b3so82790a34.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 17:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786148433; x=1786753233; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uFsMCLBuInPP9bGUt6nQTfS3u1xnH/4OkEAjt+9Fos4=;
        b=Tkw+UoheQf0kLJQXsPkCNrairQrd967cJk3uIGIRQsCrcKZPElCSeXOw1MKaYnqEdX
         qMJ1xFMFUBlLExlQenFU8aKDoogdQJFRRdWr7fJy9TizFkmR1lIXNvcPhvLYcfCbpIDN
         DxhQWkNCZvhZVWZEuG6jw/LkCpP0Nrktrc9VfT7kSNH9ykGNsDNR77ElistH1LHhMltb
         CU3NKjCHDFHyQVzLgQ6ZYB852dgGsLXPJahICkyzK5nDRdbhyu5IRN5hLsTAaoUO0IsM
         tpO8FeROpIQpQC40qTpG+erBeeryUA1G/CZf5ktvesJqJ0p+oCR3ygPBjmco5BeLtxsY
         SudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786148433; x=1786753233;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uFsMCLBuInPP9bGUt6nQTfS3u1xnH/4OkEAjt+9Fos4=;
        b=VAsfylAKWOxZzLOK1WGF3DN/ZgePHgJY/xMY3oEnfh8RCFgmAOLxVXHt36fetT1MEp
         Efv+g+oSm/2dIEWHDc3ZT7kM28UsH02gBvDP/60l569vqm3xV7CATlCqdHd+C1luaGWf
         Z8ytM0qnc5ZAxuI5n7rsjn64wOItSWZDGA9mRgGzIom5ict/t8RXk0GsoXrDprEQHgoM
         kjEJS0hORsNPzwn7+WHJw2i9aFMjI0hcJPGKXpH+h3wh6fkZl3Mk783ruQsmBmEWGKfI
         6RHku11lEfeKzvuLj7xijC2/bGq0FYpWEcBC5pJb33qUgOAlMiebSuBBG/a79k0k1tuR
         1i4g==
X-Gm-Message-State: AOJu0Yw/4IMrHOeah/TXbCYkmXZjRF5dGavGnzeIVclgiOp58LtZYfVB
	SrU7SZIlRqKl5/tv85ARTQz/H7wE03PcOz/nuwR0PrSKalI0TYSuMwICWl9/sxDY0y9eMHgtr5+
	FbWeDidk=
X-Gm-Gg: AR+sD1386Vlw0DKY4Oq6xU44rQ9UGCGgVDXtz6uLAT2ieFIA3d1bM0tsHnDmN9R7VkN
	9IeKH6hEDaWzPKzONbTE5C2J8ykYzDhlj5316y2H0F9XWxRN6n0lD3E5m8BnzK59yC0xlJ+30GR
	VVQLhC02z2OcbyFaHh6OKxL9YVrU5V9XJz5FrV9uUCgh5PZU3ISzqYey2XZvCaoMgNnpab/4jdc
	gow/YO5pCu5gka8YvcLFbw5rSV5hFITglPunbms+tw4Bt5GzgJFz5TeAlL1q6oU5EQimsDZXTyd
	3Oh3btbmN2zRTZ/I73hlwh915Fk4z1RfcPzoOTseGb5z+pguP5Q422B6G64Ecwi/gJG2oj4pTGH
	+xqypl1cTtWccvHlzEWeaqXYR48I1usqmhMxzjRkBsM2tlvEs3wmrRLuvxP3+Xoc3Yi5VtsX0sz
	o8WS9bRE4Nbe6r+L1esej7bvbnv5JfPpmMs02lA37v+/4R+LQ7I2G7yXcgtO5lTmjOHx91jJpNU
	4w=
X-Received: by 2002:a05:6830:3152:b0:7e6:f482:df36 with SMTP id 46e09a7af769-7f1e5ed855amr16282814a34.15.1786148432964;
        Fri, 07 Aug 2026 17:20:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b5a7616sm2526147a34.8.2026.08.07.17.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:20:32 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Subject: [PATCH 0/5] iio: adc: ti-ads112c14: add filter support
Date: Fri, 07 Aug 2026 19:19:45 -0500
Message-Id: <20260807-iio-adc-ti-ads112c14-filter-support-v1-0-4d3ba00caf18@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WPy2rDMBBFf8Vo3cGSIym2fqVkYUvjdEptOXqYQ
 si/d5IU2kWhq+HC5Zw7V5ExEWbhmqtIuFOmuHJQL43wb+N6RqDAWXSys7KXRyCKMAYPhfhkpTq
 vNMz0UTBBrtsWU4F+NLY3cjaDnAWTtoQzfT4sr6dnznV6R1/u6O9GwktlfXnWfuyuebiPnf7b7
 eNaaK2xZlhiQAhBGR5qtJWD2w/i9yf/saaa1lgLqF4fpLZ2UNa4Xd0Z05iRXctCxTX8T24TLpH
 Xtkxq+fKIszjdbl8gE5aYUwEAAA==
X-Change-ID: 20260807-iio-adc-ti-ads112c14-filter-support-8a56850f590f
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6637; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Gi3Ghc/Ir6ktdQRFJhJk7usYPJZ8ES5ulfhKzTeDUXM=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqdnYoctWzw0XF2AX75vrQeRsZt9fBfEHu+1s1E
 ph9n4Wn2qWJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanZ2KAAKCRDCzCAB/wGP
 wDJjB/9MKazcUzYhuSTOs5WuaIan7R6hyd1O4rC4GkBY1uTPuzdr2y859PSjlYhsnKsTiytXd/z
 D4Eu7QXakRO4M3q0+RqGXd6/Ypmm8ScSVduO3SaIR0EY1sDd1k6DFgVrGKG77nf4SSdCrXBz703
 Em0RsBmiQewtYuuaNlgTMk0smzSvIMd23yjvuXLzz3cjrz4y6hh/nJIumKuA7n8BC9XR4drnJzC
 da7eg6hUXMsxMVI+s7R9DXk5HDm9cGuz2kPH387Twe5X/vOM78trTeWg5w6Y49IbauypIg9/I/g
 3KoJErxsZ2PDE0XrkwiEp3z7jATfSlVVoUjO7U+wsNu0vP1r
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

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
David Lechner (TI) (5):
      iio: adc: ti-ads112c14: support external clock
      iio: adc: ti-ads112c14: add filter support
      iio: ABI: add sinc4+sinc1+pf1 filter_type
      iio: adc: ti-ads112c14: add settlingtime attribute
      iio: ABI: add settlingtime attributes

 Documentation/ABI/testing/sysfs-bus-iio |  22 +
 drivers/iio/adc/ti-ads112c14.c          | 859 +++++++++++++++++++++++++++++++-
 2 files changed, 862 insertions(+), 19 deletions(-)
---
base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
change-id: 20260807-iio-adc-ti-ads112c14-filter-support-8a56850f590f
prerequisite-change-id: 20260724-iio-adc-ti-ads112c14-continuous-mode-dd1580754609:v3
prerequisite-patch-id: 0be96266a72458a63f7da7ca876d87cdf5769a8b
prerequisite-patch-id: 32ba48fd5eacaee60d50a0272557859cc9ea83ca
prerequisite-patch-id: c1eb09689bd5f259ea0110cbbfb3fa76689bdb04
prerequisite-change-id: 20260724-iio-adc-ti-ads112c14-burnout-184304669165:v1
prerequisite-patch-id: 8723aa599dcf5b836fb81cf1efb6c9096bf60b7a
prerequisite-patch-id: 12754335ccf210bcdeaa8a5d60b2280618d50993
prerequisite-patch-id: ed5d4c1628ef60ed542339fe5fb490383ee8074f
prerequisite-patch-id: b92f5609fcf39e958e78b4dd74c3d323ebb6a161
prerequisite-patch-id: 755be140432ee53c84c3a4112dc8a42d78dfd01c
prerequisite-patch-id: e89fe89cd6ceae3d875219611372a6d48bf0e064

Best regards,
--  
David Lechner (TI) <dlechner@baylibre.com>

