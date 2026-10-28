Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.129
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793198342;
	b=4RW7JLUhS5S9a/cVWNiWG15a/0q3WMObc5mPHhrassE2X4O2qXSMWym/q131YdmeNytu
	 NqhF1DLQ4kEyyXBtVojTHwr8bndwIYe17zS/BW/G9R1P7wm47YK3oj+u5wda0mjY6bTDm
	 CUQwKm25XAw5fyeejBmSdtthaFe/e9bD49ERFbaZ/hV7l2k7ZVijCplbMuGWIW3v+yRXP
	 nmK5zLX4gY+vEL8XQhlR7E4TThq/zjFz4CKGi/L7lIATU3oM817vwVlhV8J2+mGq9szfa
	 n4usPyBuATdWh0OkWdZJO0iQX3xlqvS2KnsReq80rcs0S4PMmnE+QRNn7V6gM0OivMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=YffM2+bNXSGxzbIFjdRQB5xkjYVmryZXh9IxVf9SGB0=;
	b=EHsoIZeL6Mdtmakh+GD36Q/k7sEbQ+aI/1+3Ux8qHdrlk/soDOyMCZy+RE5jzgDS4wW8
	 iJnMDdT8GokZQFRCJ9Ckaa4U33AG2gchYZVOcHMexprla64XPcZMNn2oshqypPHeJwFsH
	 EYVCFmU7OzuZ646BocoGpiWFj2RVWSVfKN9Pkyuehwvdz5wphIc2dNxj41ejAv0HYZfJz
	 qC7Nc0+N4JOGCzo2IlQTf5eoA5T80sMtIsd03UX5q0fd/0eGGnuuzoxKlgJBuhyNv4tVM
	 bSKQxbBIAXzT2iOVoU9RdRi9Da6kTO76WWYJeaqCC9fXxjWGU8Azf7FJi1timXfYlTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=frame.work;
	spf=pass smtp.mailfrom=frame.work;
	dkim=pass header.d=frame.work header.i=@frame.work header.a=rsa-sha256 header.s=google header.b=llErKZ8+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.129
Received: from mail-yx2-f1.google.com (mail-yx2-f1.google.com [74.125.224.129])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B85E606A31A
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 14:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B85E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frame.work
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=frame.work header.i=@frame.work header.a=rsa-sha256 header.s=google header.b=llErKZ8+
Received: by mail-yx2-f1.google.com with SMTP id 00721157ae682-8b0b746503fso2479717b3.1
        for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 07:39:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793198341; cv=none;
        d=google.com; s=arc-20260327;
        b=lZY6d9u9qUUIZ/DJqtvr4JI2TLYFRF8Lj5mWjtjjQAquGEwlYSIGgKEyJYLzGTCaGq
         eh94lJlm8qU1LC0d9z+HrauLnbPJPaFhWTCZVa6dMlQa+SltMUVcQuWKtZPN1ie02YU8
         v0/Kea5n5aaAYLksrPvfcaVcwqOz6PVFD0ckFAywJyMrlqoH9+tVEDEXOyoBX9Zx1lwF
         EFIvWM5MtFoKsasTU1rK5jgzINc0jSp1fb+SOtr7O4Wr1bmc5cSZwKjR3KVnTwip2I+T
         tpHcWs7ziGKAPPwDozXlKALOChicBqr+qCgDKqwW/l5FLUKrawtCvfZkhjA2gB1hVCsZ
         1Avw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=YffM2+bNXSGxzbIFjdRQB5xkjYVmryZXh9IxVf9SGB0=;
        fh=hnpalnA0htYphAx1nraAiAaY1cdFzxbRXFUvUKg93HE=;
        b=jbj1aC3nAqqMAv+emCR5MjjZtPNGP4hhpXHvTO3rrU+ZnlQKTuvS2M5xtxrX8nC2Dm
         Yyk8SgMQR162vvVWs0liAzJ9A+NvXOmm41bpxrRoQkZOfv30hW12L2B1awcb6l71Smcm
         vyr+mwwBxvJmqK79SsKhk6M1ATJu+07wZULdErAj5UKjpS/9lWOscuWJJH69Mql012Cr
         6qwj7lnP0uIhCYW5sJc2kG700NWPRf7+R/1dtFDO1v1G8JDPnxlrETShxGCjRVBBO9FY
         j9b/1WFDNbPuu07MujI5NJbRjkWFluo2b3SEioSsHMNu6w9BzDq7C3NFt9LWLKjsDriR
         zi4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=frame.work; s=google; t=1793198341; x=1793803141; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YffM2+bNXSGxzbIFjdRQB5xkjYVmryZXh9IxVf9SGB0=;
        b=llErKZ8+cU1c0A3LaglTHA23qyp6aZosMAa0/JcCynOVB1B1cqihO+9AxXHdC2iXDM
         /lMSA4vIzex6CkHTyzOTwxIeOgVY0VkOVc5ifSdsjyDfl/MG+1lBV+fqeGEisoQhORXq
         ltRcjRhCTstoFAloYxcTF7JfO+4bOM/83vGKfnjGvujD6amqLyX67MQnFFNBUBROkMUf
         tvSCzV4B3VZEtdmo/zUVLr+PLSt9NlZoRhJRDf4WVuVVlJP2BcbptlNlPbB1iTh1lGp7
         0IBQvgGyBOGsGchbtzRev3RoTbqbLzFOlvIDUDyGAk7MkN9qHGE76+l8oDhet8phjO//
         wGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793198341; x=1793803141;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YffM2+bNXSGxzbIFjdRQB5xkjYVmryZXh9IxVf9SGB0=;
        b=TLYIyumu+XJDMSVfkJol0oCVsNuYAfpBs6k9bZrXOXMijUNS136CrCr+SpHC0CDWMA
         TU8NWYRV+oBA5Vuo25g3rWgeo2xY6Xcr0ic7Caxid7RGneV6xJCp4tNIDUwaCv+2/vc2
         98Iz+s7uxerMspZyL+lElhMvBGqJpXX7csOXzONP7w2e0NIoO6CXqAFDiRlU4XoLgaCf
         KmlARcRw2cmkStDy/cDhE2nRdNuDM5xCJ10z8H+SVHjl6uTU/Dwy8JaPZzfwy+Ux9szn
         +fAThYo3Y1OCOM3kXs1OHbzag/WNTjeA/UP/WEq9nU6WsKL0bcdLOlW6wPwOV2HbNJR3
         cEww==
X-Forwarded-Encrypted: i=1; AKwUvBwZR8vHxAkW+UIvPMA/XTrwxWZOBCeJJo+1wnlgznIIklCBgsFY7L/l9RbbaRNzVfYsda2sqe3iB4Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKI3yuwIIzJ2/EO27e3VmpeGSMSrKnIH8yC/+buNl7m1qy2ripa
	4DwbJzFlUjNq70OrgKFS7utkcstyFM+iI9tcKe+bCpvEqx0QH/upxi3gnQc2TrMKjnmLNbRugkZ
	5xHGIfOhOZ66RwKpQX+KTsOaJb5SYPMSI3ds+cEyCFQ==
X-Gm-Gg: AYBFou1OU0cB8dc5iJ5/glibKImXVFWMD5dsSZ+UtSCigFsQumv7AFO0sfIfqnpXfiX
	FJ5MS3lHw4GljCkv4L686kINk4O1ugJBC+SRBLIYRQkHFUyX5w0urXnnyuWZceV33x9HBqU0f5O
	+a4wipRKF2F8RRxogByYyjm7MKLUsRMDgWXFgZDh8N51smZ5ysZ718e9WpCY0kaV0sUHA/qC1Wr
	EJk1JHpJH1CSwsw5l97KKR3rC9kIOSqdrwMpKGUDYCQdv7xNTzrgq42NV96VyNiJ2d+UVT4wid8
	IqaWx6njuTrScYFMV2OoQpbQYwN5Dihrs5T8ErQMEzEyws1AU1zpcBQ+5G+266Ow8kcvvfAzr8j
	bTmB4dEH5MptvAop1KGozHGBWzdKbLJ1UWxtV7hVhTM+Gx0+/+2f6NS6dVD3tl6WM9cbaGiMIe6
	lgel+CpoTof0gC4FMH94/Now==
X-Received: by 2002:a05:690c:f14:b0:8b0:e595:8cc1 with SMTP id
 00721157ae682-8b1b5d4be24mr16738707b3.58.1793198340947; Wed, 28 Oct 2026
 07:39:00 -0700 (PDT)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Daniel Schaefer <dhs@frame.work>
Date: Wed, 28 Oct 2026 22:38:24 +0800
X-Gm-Features: AclHuK8o_-AiuRFYRh4EKMyxmqBI8f97bswVkP-qj0VI3UmPL4F27DibpVK4qwU
Message-ID: <CAAjcXz7fjcH283zHzJSZbKK74HOsOxEr9+W0ydoiYyLJ8y9qVg@mail.gmail.com>
Subject: Request: backport cad928dad9a4 ("iio: hid-sensor: als: scale each
 channel individually")
To: stable@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi stable team,

Could you please cherry-pick commit cad928dad9a4c26aa56b4223dc2a29bca517fb5f
("iio: hid-sensor: als: scale each channel individually") to the
stable trees >=6.9?
Currently that's: 6.12.y, 6.18.y and 7.2.y

v6.9 (3765d426fe86) added color temperature/chromaticity channels, but
they share the
same scale as the illuminance datum, even if the report descriptor
says otherwise.
This makes the sensors report values many orders larger than they should.
Apart from this, color sensor hardware works ok on 6.9+

Reported on Asus ProArt PX13, breaking iio-sensor-proxy:
https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/merge_requests/413

The commit cherry-picks cleanly and builds fine on those trees.

Thanks,
Daniel Schaefer
