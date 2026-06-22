Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401872F5485
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 19:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782156676; cv=none; b=SI5w6pqIRDsZJLHRVHzOB5NWFzsQKSnFkcZCfnTyXUgPm7E0z0Tajmwi6fPBCKOSXbjFyw3DBJ+BZ5E1TWD87W/VJJy0Qh51pQz1odyt8NsBQy9wYGs1EofGclgMY270Mqcjxa0+jG41gf5f9dPaBjouN6EHP0R3gRpAwqmwPA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782156676; c=relaxed/simple;
	bh=SZnhDRaAj++G9Rfu8I9tt/ZNJq5ftejswAgLE6ndX9U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WjY5VYw9XzZR3SCvtIJwgVViHC/bVqI2q1Gh6cV8sV9+FNU2xyeQJLaADxeHth8lsKmMc9wjFiquFHENF8in/keDaNy4uNGxOC4QbXutdcmfcbFO64z0f87BBLkfG+dxfQ7t+okFxGRKQEV4kJcdootXGnPe0rX8iskPIrQtowk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCJXomwT; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCJXomwT"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-59ebb89109aso3624978e0c.1
        for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 12:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782156674; x=1782761474; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JD/YQ+js7BeAGGBtm6f+AOwaKjGJfPoHFwNm6Y5Qb7w=;
        b=iCJXomwTx0/17ZyOzLqhbYzzqaIdZPQD1apIAD9M0j7RO2XrE4fVdUdkA/juDMmjBl
         sURwWqLGgbXe/PgnplsJAdLUNhlSFbVaKJ5ugw1w4ilJD5NhjCfkjTJpJ9IIPKjw5RgI
         brgUc2aWgmmXjYAtRvMkIWDkUfQO4PID7hAtGW37XBKPvl4btKXiV559/O008q7/VQuO
         1MQ06XWKkpMIDiMaAH9lHUDA/zdw+g2j3vDxPwobuzGeBOkRbSRhKy1BwxqIOIsRkQKp
         4xy/Ad/0xs0qSnXHB/PpP/slel7LmKeJinn3o79OCeuh7ukdUDATNlXUDFxuoGIl+jbv
         An5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782156674; x=1782761474;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JD/YQ+js7BeAGGBtm6f+AOwaKjGJfPoHFwNm6Y5Qb7w=;
        b=aQIE6QGtv26oO9Bv2W+KRqTalswC/uqhroMphCVFHfffR7pj/6wbd/5XNQtivr8tVu
         F5+rr4xgjB0U3wJI7U3gDEBXEBkv5lN2jQ2Cv7InqbvbwfXXvJa7JXjo9J3Hl+mB2goB
         4FKiZpLkDhKHT6m4GnE0EXgcnGlHbp355Y40quEiAATUWby4Qhy+lSFDe1ZwOozurC29
         vxdIYFzbfqaP12yAEVMlcfXCDijVkTXiymuxuXrvQfC8G5axp5sFbA0McjbGr1QSX25Z
         1IkvWyLEN3BzJvyU9bnoVLMk+qwozrc7Oal+rlAbvLkVgIAEu3qow29/VupFfSf3ks2e
         BbbA==
X-Forwarded-Encrypted: i=1; AFNElJ+RUKgS7dSPCXtBHnUfLEKBbXkq9efYBkjpfc34V/MVqrx3eETFcMr1b5hh0C4JgI+EA775vmCjZMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YydFqEHqzwaBNKb8rTEpzzBaw+Vgb/JCrfTYn1ba2qG0bxVTSrt
	5VNz1wQ5jPkqJqFf/kxwHFb6gBp/W/NgjBp1gSkHkE/UEo/on4uhO/6Ri1EXqQ==
X-Gm-Gg: AfdE7ckNT+Jj8a3YHcaDzZ0tvmh8R4oSiNEcS6rCtaCjIt0ZGAUXyLzSfY6W9Rcddj/
	wwGYfTz/hV+d5rhmkgUuS5FNly2kzJY1L2sCCsPwaWntSssxlNJdFxsSOS+X2ywrvzKPDFMzAAw
	i6SeTQw92tyGqDV3+65KoswbxMgLdct5VSuJ6hA/27LqQ2cM8LGZMaFwqTpwcs5v2Dw9qMBbkpI
	c+di+5G0RU4w9wwvXprO8ZIB1lJv8H1sdZJmBjCI2U8oHFbPvKbDzaHOQe8XuDMQgiDRL3HtCuf
	rgxYwbYwWiAZl/vcYYu+tao06U01k3S8inc0a7QOOS7iPS7b6JuoJUZJ5doVFQWam1Plz397FLX
	MLmiyO6aDkiElzC+D2/wdkvgFsPn6KJyyX9/VBqO1W34Eq8JJXBQ65Y4kd6RqWiG+LSVNG6QsDH
	RJSMMBB3MPv9zqk6s=
X-Received: by 2002:a05:6102:5e84:b0:6e7:5c89:3fc0 with SMTP id ada2fe7eead31-72a2000b9b2mr8751418137.25.1782156674142;
        Mon, 22 Jun 2026 12:31:14 -0700 (PDT)
Received: from [192.168.100.222] ([2800:bf0:177:563:8f3c:3421:b12:7a09])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9670c0e484bsm7227910241.2.2026.06.22.12.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 12:31:13 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH RFC v2 0/3] dt-bindings: iio: adc: Add reference,
 excitation and burn-out properties
Date: Mon, 22 Jun 2026 14:30:44 -0500
Message-Id: <20260622-new-channel-props-v2-0-aafd5369f253@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NwQ6CMBBEf8Xs2TVtBaKeTEz8AK+GQykLrIGWt
 Igawr9b8O5xZt7MTBDIMwU4bSbwNHJgZ6NQ2w2YRtuakMuoQQmViUwe0NILl8RSi713fcCkKso
 05qLUCmKv91Txe928w+16gfxnhmfxIDMsawvWcBic/6zPo1zhPyejRIHHbG9kkZoqEfpcd5rbn
 XEd5PM8fwFys2QhyQAAAA==
X-Change-ID: 20260618-new-channel-props-4fbd52020da2
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2506; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=SZnhDRaAj++G9Rfu8I9tt/ZNJq5ftejswAgLE6ndX9U=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFmWvcWS815MLpSSTG42Szq16tjt2Svkp9TYTBTi37Tiz
 M4X8+YLd5SyMIhxMciKKbK0Jyz69igq763fgdD7MHNYmUCGMHBxCsBEtFgZ/gc8vHFM1fnw0/aH
 PbdXZVsFzLfTbHtbFGA3dbGhobHYqjMMfyXLZPkDtE5rr3CasUjp7+dF7Fbe9tHLTz2x1pC+0um
 wjBsA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Hi all,

After submitting a patch series adding support for TI ADS126X ADCs [1],
I was made aware by David [2] that at least two more chip families,
ads1220 [3] and ads1x2c14, share very similar features (though these
chips are not really compatible between them). After that, I found one
more chip with the same features which is already upstream, the
AD4170-4.

As David explained in [2], these chips are intended to be used with
RTDs, thermocouples or other resistive sensors so they share the
following per-channel features:

  - Configurable reference selection
  - Burn-out Current Sources (BOCS) for diagnostic purpuses
  - Excitation current sources (usually called IDACs TI) for sensor
    current biasing

Given that these three features are present in all four devices and
three of these drivers are still under review, my proposal is to have
these features be described in adc.yaml and have this series merged
before the three others [1] [2] [3].

This series is sent as RFC because I still don't have much experience
with dt-bindings and I don't know if this approach or the properties are
general enough to be described like this.

No dependencies between properties were provided because not all devices
may be able to configure each one of them.

[1] https://lore.kernel.org/linux-iio/20260612-ads126x-v1-0-894c788d03ed@gmail.com/
[2] https://lore.kernel.org/linux-iio/20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com/
[3] https://lore.kernel.org/linux-iio/20260610151342.44274-1-zizuzacker@gmail.com/

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
v2:
  - reference-source is now a string-array and now presents a couple of
    quick examples
  - excitation-* properties now do not enforce arbitrary limits
  - Dropped burn-out-current-polarity because it was not general enough
  - I kept burn-out-current-microamp because the discussion around it is
    still ongoing

v1: https://patch.msgid.link/20260618-new-channel-props-v1-0-963c1b5cf40a@gmail.com

---
Kurt Borja (3):
      dt-bindings: iio: adc: Add reference-source property
      dt-bindings: iio: adc: Add excitation current sources properties
      dt-bindings: iio: adc: Add burn-out current properties

 Documentation/devicetree/bindings/iio/adc/adc.yaml | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
---
base-commit: a50909aa46dec46de3c73235fc15a7d6f763d996
change-id: 20260618-new-channel-props-4fbd52020da2

-- 
Thanks, 
 ~ Kurt

