Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE06D38BF6A
	for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 06:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791615211; cv=none; b=EZzzVhUdNv0PdUeCbRhEUp9wgsVW6O5C4avURkcPmZlz4Oz3kGM1AZmTmFXQxqcRuzQ94x6mEyQsz5oANURVyC4gDHKAe5utctAz7un2/7l7mYhjIlBdeRVrS1VXG1ZLYbcHjy5zmguR37fyN0T941F6sOEKBtoi5mxHnr5Ozu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791615211; c=relaxed/simple;
	bh=Izq1WUWwO4gkeOYG5YUvRNCmch16xNzCDSW4SZwKMSk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l1pmTqBZM+xMuvM/ap7/hsGV0gswOY4fEhb1fO0b3rCyXr7eYiybYM3PeGg9AlSdTTzNP1iPsWWoKt3leXR7/agc7VF/HoaABRrpPtJgSUJgjj5SQy2ChxpdrAgv8RltBhR+EN9+TD+fZZ/39+fxSMUApyKZajXIYpWMttqUhKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rq8B3FI7; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rq8B3FI7"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33fb4680717so1363984eec.1
        for <linux-iio@vger.kernel.org>; Fri, 09 Oct 2026 23:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791615210; x=1792220010; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cjq7AnqjwhfvNhe6NCBFetT/+h6XAPYtRfohPvQs4Uw=;
        b=Rq8B3FI7S06J1du3u78Rzav+rE5t7aaiYQ61ZDFiouFIh6UJ1ofmXlZTmuX/lcXz60
         iF0GSAwOo/1HJPvR5v1tSPS9H988akOPA0GDjChpe15NDwOIlJXYYdm7CBW+NmiLSSXL
         Rg8b0vct5Fs+SFhRTcwv5IiaMd+ompTukhJYfl9J2ku4QaAR5PPhQIx5kXUiRkOvsxtR
         DoSL5nd530Bo/gAW3Q5OxISVhIbPRUN/Pp3uweZUMQ7UJoz1uURF2Aoy91C26n2xB3Gm
         2J+OCQVevkaG0rlb083qj1gMcgkKYwoNNjEeeISpxgSSSFobId7XG9L0abtuseSdjfwL
         zKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791615210; x=1792220010;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cjq7AnqjwhfvNhe6NCBFetT/+h6XAPYtRfohPvQs4Uw=;
        b=vKwW+iOJKL8eO0dNVtIz/RddZJluTVICmgheyrWjVZY7DoX67cgP8CFRiIwP6Oo+wr
         kYl7SfYhbBPMIVYLakLIKpE3Y98KQ3atB+0NhY0vwssB7LDZc9ElWB45gyn6YxLUtZXZ
         fKukaDuXwvpbmfXNP8F76adeSFgqwjR7AERcWkjjqP0SwtoA3hRfUMY5Z9Bje9XHIKPz
         AZb1eL/J1bIcqu8/fIGI6o+8Gu794i7ypnk/qx6/Bqe3B9n3IMnBxwGqh8hn7R3Oroyf
         2C7t26ySOb6udnPBw32sOn+Iy9w6NGQd7pzSxJYXLPAoqJ59UNB7ptnx1DGwRYFRGjWj
         4gcQ==
X-Forwarded-Encrypted: i=1; AKwUvByEmNEnqzpfUZTxfenIQlsUd9rP1Pvq4osZ/DdXzOyRMjQdms309qoJj1ExXx2uUyktpuCwW2mbpZY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIN0xASt4XaAJrtujvvGqqbkpOCLrMQhb184+NaxsycIXtAQ56F
	fIFiHw62ovtub6D5HIKOCTQODQ65iCaBRS4nt0qrGneBDUzhBZ8SVQU8
X-Gm-Gg: AYBFou2dBx0OF1yaTbZngPH3o+9adM6aw7TWF4KcJiGeWuQC99m8bwm18QkUL5+LNs4
	k5uPqTRVbq9VDr2b+NFGdXN6bU2tOPSjOt3qxARocpqEOfyFwOOQNqd82rpQCYXcvzeESSWL0N4
	O3PdqLvaZAJe+rI+qxDyEoAvZ/OunUPs2asNvdZLvltCbiiHwuicCv/72CEGzBoXJugAwmOqE13
	D5F1kaQrF862hnADFk3TtfOKXdoDh8a0ROLEHNXin7TF+rqPP1eg0jyPb8EGkhEXOoSZVylPRZP
	jBjoNWrmFtYDPg1Pn2ekSljX7woXstr6cJBS6TzQrBA0BGz0Ev06gk91O9C+fZMZztSwU1nPJUu
	yGVYvlrCaYggWFjrXCIPFNY1C31cbVaz6vggzgFHSc1/VjsPBVCytzsi4/7wm8xUrjv8fXdqmMy
	Vd+PwqTnfcYKD4qeLAy95/Gw2pYwmThwm/MCUIK3+m23GwvaAWPKV0TlO63uppY08wvOfZF611/
	46WG/f6XpKizCV673RWAzGW3h+7aUgt2Qhtz3v/4PxGmtT81Q==
X-Received: by 2002:a05:7300:81:b0:353:81a3:9032 with SMTP id 5a478bee46e88-35381a391eamr5036734eec.39.1791615209625;
        Fri, 09 Oct 2026 23:53:29 -0700 (PDT)
Received: from [192.168.100.70] (host-200-61-172-117.iplanisp.com.ar. [200.61.172.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb5e9sm13009650eec.20.2026.10.09.23.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 23:53:28 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v5 00/10] iio: adc: Add TI ADS126X ADC family support
Date: Sat, 10 Oct 2026 03:52:39 -0300
Message-Id: <20261010-ads126x-v5-0-49e331cb2fed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13QwY7CIBAG4FcxnMUwQymwJ9/DeKAwVRK1LmjTT
 dN3X6qbbePxB76fzIwsU4qU2ddmZIn6mGN3K0FtN8yf3e1EPIaSGQpUAGi5CxmwHnjb1CC0Eso
 7YuX1PVEbh1fT4VjyOeZHl35exT3Mp3NHLWrA/44euODGVl4bE4SksD9dXbzsfHdlc0ePK4dmc
 Vhc1UCDEiSqxn06uTgj9OJkca2xFlXQqC1+umrl1v9VxUHwqMn6+XLtpvfwib6fZXuPvw1M0y/
 fejlfWwEAAA==
X-Change-ID: 20251129-ads126x-fb6107505cae
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4723; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=Izq1WUWwO4gkeOYG5YUvRNCmch16xNzCDSW4SZwKMSk=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFknH5ypWprzUNpyVeIri6dTD5U+bdCU2l7gc+x5KgdXd
 tems18LOkpZGMS4GGTFFFnaExZ9exSV99bvQOh9mDmsTCBDGLg4BWAixfsZ/mkZdSdo5S7Yl96e
 4B+wvPamGGdfM8sevxk1G90XbcvgYmH4p7i6Y17uRab0yU0zKvueblmsXRNgbKz88JOLyQX3mWz
 PuAE=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Hi all,

I apologize for the long delays between versions. This month has been
very busy at university plus some personal stuff. I expect to have more
time now, so development should be faster. Thanks for your patience!

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
v5:

  dt-bindings
  -----------

  - Change the '#io-channel-cells' layout to <adc inp inn>: the first cell
    selects ADC1 (1) or ADC2 (2), and the other two cells select the
    positive and negative inputs, instead of addressing channels by reg.
    Document the monitor input numbers (11-14).

  - Drop the per-compatible '#io-channel-cells' constraints.

  - Allow hexadecimal unit addresses in channel node names.

  - In the first example, describe the refp3 and refn3 supplies used by
    the channel's reference-sources.

  ti-ads1262
  ----------

  - Get the device name from match data (struct ads1262_chip_info) instead
    of reading the device ID register at probe.

  - Translate io-channel specifiers by the channel's positive and negative
    inputs.

  - Cache the AVDD and AVSS voltage values to avoid locking issues later
    when the VBIAS regulator is introduced.

  - Channels using the internal reference on both sides (internal-p,
    internal-n) no longer need the AVSS voltage.

  - Only treat the supply as bipolar when the AVSS voltage is non-zero.

  - Optimize the buffer SPI message in preenable() and release it in
    postdisable(), so it can't race the trigger handler when a trigger
    other than DRDY is used.

  - Reject multi-channel sampling with the DRDY trigger when the buffer is
    enabled, instead of in validate_scan_mask(), which missed trigger
    changes made after the scan mask was set.

  - Report REFOUT as AVSS + 2.5 V through a .get_voltage() callback instead
    of a fixed 2.5 V, so it is correct with bipolar supplies.

  - @Andy:

    I didn't convert the reset GPIO into a reset controller for two
    reasons. The most important one is that we need exclusive control
    over the line because it also acts as PWDN, depending on the
    timings. The second is that we are currently using it to keep the
    chip powered-on, so we would need to depend on CONFIG_RESET_GPIO to
    avoid issues, and that seems a bit unnecesary.

    Also I didn't use variables for the single-channel and diff-channels
    properties because IMO it's easier to read that way.

    Let me know what you think about these.

  Misc:

  - Drop the redundant <linux/compiler_attributes.h> include.
  - Annotate st->channels with __counted_by_ptr(num_channels).
  - Rename ADS1262_POWER_TRANS_USECS to ADS1262_POWER_TRANS_US.
  - Turn ads1262_default_channel into a macro instead of a static const.
  - Add unit suffixes to the clock rate constant and field.
  - Use ret == 0 for the completion timeout check.
  - Join the ads1262_regmap_write() call onto one line.
  - Split the initialization of i in ads1262_parse_channels() and move
    it next to its first use.
  - Use the ?: operator for the clock rate fallback.
  - Rename ads1262_supply_setup() to ads1262_supplies_setup().
  - Drop the NULL check in ads1262_regulator_disable().

v4: https://patch.msgid.link/20260828-ads126x-v4-0-1dc27e9c0260@gmail.com
v3: https://patch.msgid.link/20260807-ads126x-v3-0-f89925d72792@gmail.com
v2: https://patch.msgid.link/20260628-ads126x-v2-0-4b1b231325ba@gmail.com
v1: https://patch.msgid.link/20260612-ads126x-v1-0-894c788d03ed@gmail.com

---
Kurt Borja (10):
      dt-bindings: adc: add excitation-current-chopping property
      dt-bindings: iio: adc: support the TI ADS126x ADC family
      iio: adc: add the ti-ads1262 driver
      iio: adc: ti-ads1262: support per-channel sampling frequency
      iio: adc: ti-ads1262: support per-channel reference and gain
      iio: adc: ti-ads1262: support input chopping
      iio: adc: ti-ads1262: support excitation currents
      iio: adc: ti-ads1262: support triggered buffer sampling
      iio: adc: ti-ads1262: support REFOUT and VBIAS regulators
      iio: adc: ti-ads1262: support common mode supplies

 Documentation/devicetree/bindings/iio/adc/adc.yaml |    8 +
 .../devicetree/bindings/iio/adc/ti,ads1262.yaml    |  381 ++++
 MAINTAINERS                                        |    7 +
 drivers/iio/adc/Kconfig                            |   14 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ti-ads1262.c                       | 2136 ++++++++++++++++++++
 6 files changed, 2547 insertions(+)
---
base-commit: 04434a1d0f311d76b1f15fa987918b471a0b8c6a
change-id: 20251129-ads126x-fb6107505cae

-- 
Thanks, 
 ~ Kurt

