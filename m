Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890831DDC35
	for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886706; cv=pass; b=BR+rpDEDxNFk9hE1yI1wIEl9eY6J8krsFkxVzkZFx3nzAANy+hmyVOsNLkd3mSUEgToKwMdZaQbVr0iq65zxcqC8sKc1tUPDPQuh+0S+xLfyL/P8+EtayLm5kSqMLdP/iXG30ua0JnZH52VVJrweBAVp7TBARt9ze0ivgkoI5cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886706; c=relaxed/simple;
	bh=Pj9blmEeMX10mYoR1N5CJ8ypfzWiYPuSOHQb9/RSE2U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YSQrwqqvhz+sLsx+QVhHAyUgyP4Ht99JjuJcil4fYmvO2aE/mt6UDG6kckzyFJcjhJPmXYptovJuqO+KwnvJqnXRfQMIvKCoP5lXoOPgDorkQ/TYe6aw+my8HFyzOCwMesB4fIffHwlY/BpjU6lGzU4HgGjC+LKHEl9FDYDNRh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dp1ar3qV; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dp1ar3qV"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso310687a12.0
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 02:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784886704; cv=none;
        d=google.com; s=arc-20260327;
        b=LA88unppJfXASzsJK1Hub/3rHSMt5xKs0hAP+xi1RaJHmNcuTfCzfa25f2837QCQBI
         s+rsbnRvSTjl6t4VO0s/CDJFGLSNm2ARudyVVpeuL9TipZy4MW3a9fB3FkNcH1A4S942
         0L77+7Vin76iCtMeAnuPtwI4TMr9ZIWP0ma2qPPYSyfxDu9U0iKLKnEJWZChlAKh+W8G
         AqpBWwZDNdfbBCV/aDiSbgdlo+pQxmh9f6EB7tFyC3xsW4ihQMO4aFW6y7EuzlYSTtiO
         2DsccWje3UBC+TMMwwFLhTrCP24KbYiKUJWsYlrwkbGftegiFeMSNKutu0Bfnk0dfQY/
         9dDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Pj9blmEeMX10mYoR1N5CJ8ypfzWiYPuSOHQb9/RSE2U=;
        fh=lwFFhiCdTdpx5mQnz+K9nCc7w1OQJ1W+mwam0Iy7mXE=;
        b=QbZaXDMibUoVsPFezPZUBwfRjoV21prtHytSPUyoiHjiYMBzmHZ8qr144fB9+tlWvv
         Sg/ti+H6naCC+du3Oh4o9u9L0GonWQpRTfWg2+LbzfT2jc9KVvkt71adXIKoUOa7uIKO
         QjrPOgO+hm14VVAab1LdLqsftgyAJAFJxdTCdWKjYH2ovLDubwWu5mgz/IWXaSFojnzk
         U4Lokt/ad9pvNFl3iOSgmSjFq5/F4Er4IwOJgOxfnMF9YS09gFK3dAOY+4BMRhnzwhV2
         5bsKBbOSLsQ7CderFsTPDjBLafairEdg0XC828vcIuJostoumBYI99QGrCsbtos5rVJ7
         x0sQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784886704; x=1785491504; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Pj9blmEeMX10mYoR1N5CJ8ypfzWiYPuSOHQb9/RSE2U=;
        b=Dp1ar3qVuLvbDhXyCC5OPwXpeouBPCWRtRmB0j+ns9EiNRCN/4g3qvI80fsWPyHg6v
         nEkB3pPGIdn6gAywNc4Uz+3xV7Wm+O5q2bCamXNvzTAB3/yEXu6QBNM4a7auOISZpUmP
         CHhZE4uEb+SWTbjjDovb9kx9z5XeN/MKVPuB86SzGfeRgSFuGY4mHcslmzAgcnv5hKNj
         Ef1B50gfYOJrhDojIBZSsqQ/WBALTec5m4v8rcQu8jcmopQhZwS73VIoPAt2Kyzt8aVy
         d+8cwY0RdXQFLmdckowtCMaD8e1J02EZF00vsERYsP4gLcnetBD28J+Pvz6W2nuyfj/p
         mNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784886704; x=1785491504;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pj9blmEeMX10mYoR1N5CJ8ypfzWiYPuSOHQb9/RSE2U=;
        b=HiToQOOozEot3HGI9Cak5oySrLm7eCvZzlgM6pTdHyzd90KpSLUSZpd1mp5VHWBoJa
         HOn7i7GMubFBDzsDEVZFVB6hc9Zc7yj/SXMc8KMI2TyhOcwe94+s7PWC0ZM7Ok6VRvyM
         cxTu5YNsEKjQ2BWR3jJwQ19Tf25zn1jz7XOzrLZkolph0KTBCxIkj1V251IlmFKJacUk
         OW/jc/Q02Bmd6TaS/tLLpvf6Az4SnDaKDg7EAsXB1i9NevgdnlxBETRhqaIqdFmjWI9Y
         yKX/lui6QCuJyM7Byl4VbxdNwwlytZUG1MwUpPZvGunqL+5ZAgKJuqruv7xHrq3UEqTV
         cC3Q==
X-Gm-Message-State: AOJu0YzzoTswqY7JHQxZTyiPa1P6aKdPx5kX3CgranZ8bZ/gkd3h0YQH
	am0Ph6krTPBBhdWocT+xXZPyrxr+vjlLDjVc/gnECbBjanqoONi5QBptgu2ah01D7JNIFhCeV/p
	YKQRnjUCDPwo4DzU08Cu7Y+eKDS+dFTkZo4Tj
X-Gm-Gg: AR+sD12zY9stYOGMouZj4WrApqB6K/JjsRTmBO0fLX03aKR4pA/TJHeym1WQx7mHrId
	6ZrsZGDhmqsNvlzwmvNjgM44FzohbUMdTa0rwMoL3y3gZscSfHYdQh1a6e6VoOakE8Dkxlp3c6s
	iEMmq/Rv6VbHdmHRtp/LR84pxc/W858rngOEF6zSw9uPt6QIljhLcak7gX8UThi4amM+QN8IDoj
	Iqo5S2aw+igySvVhDSeUZio9GBLEtoTFGkN2qP1Eoeu29E3Z8PWYjWq7+G418CcAOHPo1YWMWO9
	NJZ6uBUuCesUIuBSFylEtWIOwQ==
X-Received: by 2002:a05:6402:1598:b0:699:39c5:204b with SMTP id
 4fb4d7f45d1cf-69f6b823de5mr2848387a12.18.1784886703612; Fri, 24 Jul 2026
 02:51:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Olivier Tanoh <olivier.tanoh19@gmail.com>
Date: Fri, 24 Jul 2026 11:51:32 +0200
X-Gm-Features: AUfX_myZMSLERVJ4qsuSDtVgVHxv8JEUNgCVeMpPL24iQWrOElhlMCKQrR3dBP4
Message-ID: <CAM49wQtgFL62Qm9LNe-DSwdY5av2uZVZMt3B7MzVg+jz6w-0+g@mail.gmail.com>
Subject: Looking for a sensor driver to contribute
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

I'm an embedded Linux engineer looking to contribute a sensor driver to IIO.

I've already sent a first (trivial) patch to staging to learn the
submission workflow, and I've studied the structure of existing IIO
drivers, si7005.c in particular to understand probe, channel
definitions and read_raw.

Before picking a target, I wanted to ask : are there sensors people
have been asking for that currently have no IIO driver? Or families
where a recent variant is missing?

I have I2C hardware available for testing (Raspberry Pi CM4), so I can
buy a part and validate the driver on real hardware.

Any pointers would be appreciated.

Thanks,
Olivier Tanoh
