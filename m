Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154F93B42E6
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 22:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560874; cv=none; b=JgoUn+6Ko6DPAX63leGoW4DVMf/h8OP4bsKmlcyuFonu3C2TPt6znJ0i21s3exDVzA+KKY8Mmq2Yl2+A4MljOaXxMMRWdu/gfGAFXMikj2v0wWik9Lw2SABQa3BmT3nE2o259EvJCCHW1N5zPNBoJNMjAusjEKti1hIUhGwmSSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560874; c=relaxed/simple;
	bh=7Wfkqud95evRiUk0tqjEAg0WLmuc8Okjwq4SqA5dYu0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LiMWxG8bxVRNS961OPiRrGqyakDyiAJ0qDnxyZn5C801G1qdWD78KLtQkkwnzjDNzdERy1V4ZD1ApYLLnHwyncujuxbRwjPPk9iQIHRyyHR7fbGVQTWQX/Ry5c/PS89RIkWHP6dSLbdLaT6Hepo47JSH72tAjLGJg2YXfUBTWvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=fn3ZWIcs; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="fn3ZWIcs"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-43ccd4f6f6eso2477825fac.0
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 15:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781560872; x=1782165672; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T/gQ3ntMPP6EfemFXgaIpbpbFbx96Dw8LwXDsZ4Ji5w=;
        b=fn3ZWIcsTEYPvm91iOZLSO9ndsdXRb0mJ+SLAvEAO7ffVn0PzHCHTgIJlPzFHx7ZiW
         So9xUtjfNLfhjEBjzl7oNbrDo9WYdKI/vT5+G+w3tRD4x4X0rqaVJ1Zf6CWlvbFogxEl
         r3r7zJmnmkX9rNBOni7TbS4oHywajPZRnQUYpC5FUhdiNlSl8rhyJ4iUpFOwOFQZq/hJ
         EKp+legl3k3tMF67o2ZB8/JwdgKbVa9mSyalxPSsqX0GozQ/C6yZZOc2LimrO7GWi88R
         vIzHdtFOtyeUKDGi/dgqFGJ1l8hlzZwTweDEVZiEaBmNBBfC/KJgJAfU+BFGkOCJjgz+
         mnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781560872; x=1782165672;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/gQ3ntMPP6EfemFXgaIpbpbFbx96Dw8LwXDsZ4Ji5w=;
        b=So/db1639i23LnS2gwrEjTsgznNZNKhGjfPciLGER8o2rRIgXH6bDy4zUqySYiKP/X
         mWCmzA0CY7vvZQKUeYWCeW5mbKzSYcNdp/vWUF55AJdWlSO3kRWG3pfY4eilPd1edCIl
         O+Yw6+lnpop9XAZ8yS/kQHnzArJQf3wHOQQrwbQKE7ETzEsWzJ+hP3eCT1kH3i0MooPS
         6o59jtZMZkZ/q5FkEQjnz1BR1heGwmko5OcpS8HxDffEP5HerbYKrZAOTIkoGzjaGF44
         TVxzyzXhHoEJIRsky7V347DbYNwqoPQ8uuZNm86mqU711WIKjxC9LjkWJCkgfIXDTfBt
         r71Q==
X-Forwarded-Encrypted: i=1; AFNElJ/KJVzdYxXKwElRPyK6Dl9fujtc/85Wk7T3GF2V6wIypKo2xvhySCGuGK8jqz//W8CvMgiHRMLPbUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTwzz+S2cqPnXwDV2x7f5ea3z2l48/XW7TrOF5J9oyBAExTJ1Q
	WDqI7jWanlEwh0dnuMohSEmjnvDDWEO5aCpZE1BTXuwvSoDn8q6l9LoAByKJN/G/qRU=
X-Gm-Gg: Acq92OFn+O/Rl3JyJnDNssGjHCdbEMxDGst7sj7Cq66dlX5AMVbYpOQIcLSk4g4rDGH
	0UjB+nd+JP2B2u31xJzO6umrTBxdO4HsWtic4+x7738ocEnegfj/YtRrTvhpVniwCW1meDsi/+4
	n2OCmOMLqQ2OmUbpPEru/zsMTRFSUB0ApHwuM4LrvSE1x9pJcTLhjfvDIujFKzQuxSZU9BYkhKd
	XRsDRHk06VfyjaP2nAVz+Iq7RuM7MzdKqpWV1upiZ5aubVFebRlwVpcrVOli196vRyIgvqXhnXF
	euCOi/714dBOh/lY26iPj+PFdfCBUtJmYs4a+v4avCNyHDC2eqo5NP63f6XreZ1706cmFkfzBf4
	qrDJ5eFklNgmst1A5ImJNhSgNvuxAfdoVDEpFEBCfbsAv2xTEgp728hXOWVP2j9exhce98Vywdn
	GSf3D37ROMydm+orGNkHMIkL9bv47f
X-Received: by 2002:a05:6870:b9cb:b0:43f:5998:628a with SMTP id 586e51a60fabf-4430b396134mr851387fac.10.1781560871824;
        Mon, 15 Jun 2026 15:01:11 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:16b0:5133:47b1:a939])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44308fd9221sm826145fac.15.2026.06.15.15.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 15:01:11 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Subject: [PATCH 0/4] iio: adc: new ti-ads112c14 driver
Date: Mon, 15 Jun 2026 16:59:58 -0500
Message-Id: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBBFryKzbiAZU8VepbiIyVSnCy0ZFUG8u
 1Ndfd6H93YQykwCr2KHTCsLT6OCexQQhzD2ZDgpA1qs7NN5wzyZkKKZWUccYtQz2a5BXzdl6Ql
 U/WX68HZl3+3NsnRfivO/BcdxAk6Us4d4AAAA
X-Change-ID: 20260514-iio-adc-ti-ads122c14-d0b92479334e
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5166; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=7Wfkqud95evRiUk0tqjEAg0WLmuc8Okjwq4SqA5dYu0=;
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGLIMyljvbOKVebZGRNjZyjNQ9bveXBepZLP04ibLd9z7I
 r7da//VyWjMwsDIxSArpsjyRuLmvCS+5mtzbmTMgBnEygQyhYGLUwAmcuAv+2927v6d98osZ0et
 UPad6fhFKmKNhoDSm+sFfR7RFwQfeYmncDU9uWyVe60r5ZrlKa/8Q8xl38Qev46d5n3UOIEh+Nf
 WjFVSXecmLLz0WHOBy+xlk45znWIROyT/TFA5zv9rn0BuRdaW0r8fE3+pCF2cLxD24y5jUfFBVg
 Ex2elPXZ1kLtbUrBVcWOjS4lb9vOaCdU2toLLZk8cOOWWr3kcJcWd/W/A68FWw2s/tO0x7Vu5//
 SLBY0n4xPLfEc753E6fr22RCMrM68je6mB1JXph2S1RL/8yyYPF9SoJbvGMwV2FD86WfUhPsdH4
 2fatKnxOyUwpAdm1hTJSmt11YjxrPrHlKBuz7PutNs8IAA==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

This adds support for TI ADS112C14 and ADS122C14 ADC chips.

The closest thing we've seen to this in the kernel already is ads124s08.
However, that has a completely different register map and the DT
bindings are incomplete and the driver is extremely basic. So I've just
started from scratch here.

We've also had a similar submission recently for ADS1220 [1]. That chip
is in a similar situation to ads124s08 in that it has a different
register map (but the submitted DT bindings are better than the ones for
ads124s08, even if still a bit incomplete). And literally as I was
writing the previous sentence, another series [2]  was sent for yet
another similar family of chips (ADS1262). That one is even more complex
in the feature set than the ones I am working on. I was going to polish
up the driver a bit more before submitting it, but now it seems more
urgent to coordinate with the other two series to align on how we would
like to handle all of these.

[1]: https://lore.kernel.org/linux-iio/20260610151342.44274-1-zizuzacker@gmail.com/
[2]: https://lore.kernel.org/linux-iio/20260612-ads126x-v1-0-894c788d03ed@gmail.com/

All of these chips have in common that they are designed for use with
RTDs and thermocouples and so they look very similar to each other in
terms of wiring and feature set, even if the register maps are
different. They are in the gray area where we could either keep them
separate because they are just different enough, or we could do like
we've done before with ad_sigma_delta and have a bit of an abstraction
layer for the register differences and otherwise try to share as much
code as possible. Normally, I would lean towards keeping them separate,
but in this case, I'm considering trying to share code because the
devicetree bindings for the inputs is complex and is going to be mostly
the same across all of these chips.

If we decide to go the route of sharing code, we could still merge this
series as-is and then do the refactoring to add the abstraction layer in
a follow-up series that also adds support for the first of the other
chips.

This series includes just basic support for reading single measurements
from the ADC and gain selection via the scale attribute. I plan to
follow this up with additional series to add support for buffered reads,
filtering/oversampling configuration, event support, gpio controller
support and perhaps a few other things that are slipping my mind right
now.

The most interesting part about this (that I alluded to above) is the
way channels are handled. These are multipling ADCs with differential
and single-ended inputs. But what sets them apart from other similar
chips is that since they are designed for use with RTDs, there can also
be a current output required to excite the RTD and this current output
might be different for different channels. So the way I conceptualized
the channels is that the devicetree specifies the conditions needed
to take a particular measurement rather than being purely a physical
channel.

This makes things more flexible, but does make the driver a bit more
complex. For example, knowing when the current output needs to be
enabled or disabled. For now, I have chosen a lazy-enable where they
are not turned on until the first measurement is taken that requires
them, but then they stay on until another measurement is taken that
doesn't require them. This can lead to some oddness with the diagnostic
channels that may be measuring something that indirectly requires the
current output (i.e. the external reference voltage when it is connected
to a resistor rather than a power supply). This means you need to take
a measurement that requires the current output to be enabled before the
diagnostic channels will give accurate readings.

I have also pushed a branch to [3] that contains the start of some
documentation for this driver that can give some more insight into how
the implementation works. It still needs some work and also documents
some things that haven't been implemented yet, so I haven't included it
in this series yet.

[3]: https://github.com/dlech/linux/blob/b4/iio-adc-ti-ads122c14/Documentation/iio/ads112c14.rst

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (TI) (4):
      dt-bindings: iio: adc: add ti,ads122c14
      iio: adc: add ti-ads112c14 driver
      iio: adc: ti-ads112c14: implement gain on internal short SYS_MON channel
      iio: adc: ti-ads112c14: add measurement channel support

 .../devicetree/bindings/iio/adc/ti,ads112c14.yaml  |  224 +++++
 MAINTAINERS                                        |    8 +
 drivers/iio/adc/Kconfig                            |   12 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ti-ads112c14.c                     | 1053 ++++++++++++++++++++
 include/dt-bindings/iio/adc/ti,ads112c14.h         |   11 +
 6 files changed, 1309 insertions(+)
---
base-commit: ec039126b7fac4e3af35ebccaa7c6f9b6875ba81
change-id: 20260514-iio-adc-ti-ads122c14-d0b92479334e

Best regards,
--  
David Lechner (TI) <dlechner@baylibre.com>

