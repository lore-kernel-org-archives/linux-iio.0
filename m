Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A2B447806
	for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784914193; cv=none; b=ABo1k0LRAnxhNoIY2CuMjGzvnCDypIb9Ms1VNdZNUhmWyeMli4pMa/g4mluG62+v4ozsTht7FLFIAB1cKz5V3efLk1z3qW73eMIvOuNM691t4o66cfeV92n0TFJTFjUwUR85C4XbzzJneGMzzIvrGUm1NbVQ7yq9A9I20PTLhXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784914193; c=relaxed/simple;
	bh=JJEtIyEQyEka+FlSFBMFI4h8W4CHxV0vh08WZGFEDvg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=bO4BiAhPMjD1OIFx2hkgsRz5Jp/67QPwuYbxXSXwNlKOpaed30S0HG0M7l3fnL6/jUkB5CLbsmOiHghkDPRXXqvSvQovWamne01u46u024gMH2E4dBQv6TfAaQTO0MqahWzTgJsxKG7xxvnU4XqnxTeky6kGIHhWgt/Kf6HhCLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N029FmAv; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N029FmAv"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so687872a91.3
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 10:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784914190; x=1785518990; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VfLgzMjoDnerpUvZDjj2ZmbAMQJPt14KAgDXLmsqJTY=;
        b=N029FmAvcFJi/SKr3MBbMU44VJdaJ/qebTwCPI5APmRvu3o+PDkX68ZiLt6fpdiTaN
         mYyvJelOfMYXaK4KwXXNCl0eTAwc4vaTcfnskGsSp+Ynvb+cC7D0ZqSAFCvfT3iDyB2s
         ex01FOov+keBo/Si6DIRMO+4Iuqo/NC84RUZ6TLA3Di3Up00WnmmzCX1tAloUvBYJ3TE
         +UyBIkWlOE2/OYLmEupvSH23hAHGnxNJ3qo/wBRK7isf4Hv3kkN/knWmiW0UT0m2GIzL
         TEzqzPiKnxqekrm9UvuHsR67huPHL7kaOgAtkHGQL1Vf8lw+A68o9stgZ7HVIQaHCWWT
         xxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784914190; x=1785518990;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VfLgzMjoDnerpUvZDjj2ZmbAMQJPt14KAgDXLmsqJTY=;
        b=mMyODNEu4RGldz3B9bcNCtBN2FUiLtzerhj9hsdUzHfZNxkxJeaDyIUdfWd7FRIZxw
         wRW4vxDo8PO/YHmanQDM0uNW9i/nORhz333lgNgFLfZlTYEUyA6YyQQl9p+E6YW3JsFw
         G0FWVOLjFfOFndMrQFpyvT7Re2M9L+rW6bY1L4DTlyrtXbS6sS/3fe2XCVWQaCDJRNbO
         C/2hPrWzK189JbVkuUx1m9F5TL4CWg7uKP8yAqn6lkPOTgh5r5NI2nZhCvHrVhh9gVoC
         vHBMj8FwiV4U7F7N6BvIf1lsqshXrqzIq4bpXueR/GTbkIpkQWvsY9mALT8+trmx+SN5
         8o7w==
X-Forwarded-Encrypted: i=1; AHgh+RqSUHXFpCqQXDSPZooOJPtLooXU4d8RPKyEaXJjvR0EnRlIp4cImAEPgcaLv57Q3tV4DCbeHvr11YA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyLCdLXALAW/6T04vJNp7n7R14PGvP76ZPAN1ECDDNZ+eeT/e7
	cm6daj/mLJ6mBPFMBpUfM29EFXNBzBuYETjFrq9lENI3Gj8A8IB5YIjA
X-Gm-Gg: AR+sD10B9/5D55eEqHJ9/WbyCO20P0R/R6BFjjBmLMvP7MJmuvu35BiwcgKPWbOlCr9
	rPBXFsoflnwxzHNzn+4cgRJoLiAL4mahSErXzJwaeIogGVmqSDtj7UUnNWAW+uA40/Jrv8nBDXt
	OAoZ1gxhEOAnI81JaOIX5K/FVwjrs/ER6IDKmJwOcaz/QzDw7BFW4rPMyyo4j2zVsOxTGwJbsxw
	W5NTJplhrhA982fQHidv0VXRmpA3rTtGkrX60A4DBz4UvOdBLkWa1o8JyrwPGeR2jrpRO2/IqFB
	DvKqzQARG+CdmuAm9bBofzAkvuhec+WF6AF1on7WaK/YX6nV/27+bFS2QTxw27CzuTfMQjjA9aF
	xzVlhlA4javE8vRJjWuFsyDc+nqhiEyPiduaKoXkiViAqxGre4xfHWeaQRDrZVP0TBCpH7BsJcd
	Lao3WEKb4XLcfRealOcovt4Nac
X-Received: by 2002:a17:90b:1d48:b0:387:e0db:3d8e with SMTP id 98e67ed59e1d1-38ec665050cmr9132399a91.41.1784914190194;
        Fri, 24 Jul 2026 10:29:50 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:8899:46cc:11c:efe0:55f0:d44b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13014d27sm28485318c88.4.2026.07.24.10.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 10:29:49 -0700 (PDT)
Date: Fri, 24 Jul 2026 22:59:45 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 David Lechner <dlechner@baylibre.com>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
CC: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] HID: iio: gyro: hid-sensor-gyro-3d: probe cleanup
User-Agent: Thunderbird for Android
In-Reply-To: <20260724-24-july-hid-gyro-dev-log-clenaup-v1-0-0c932b77104a@gmail.com>
References: <20260724-24-july-hid-gyro-dev-log-clenaup-v1-0-0c932b77104a@gmail.com>
Message-ID: <81D24001-4CA9-4059-A649-3C92DD51E10C@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kindly ignore this series, I have re-sent v2=2E

Thanks, Sanjay


On 24 July 2026 10:44:29=E2=80=AFpm IST, Sanjay Chitroda via B4 Relay <dev=
null+sanjayembeddedse=2Egmail=2Ecom@kernel=2Eorg> wrote:
>Hi all,
>
>This series cleans up probe error handling in the hid-sensor-gyro-3d
>driver by removing redundant dev_err() calls and replacing remaining
>dev_err() with dev_err_probe() to simplify error handling=2E
>
>Testing:
> - Compiled with W=3D1 for each patch in series
>
>---
>Sanjay Chitroda (2):
>      iio: gyro: hid-sensor-gyro-3d: Remove redundant dev_err()
>      iio: gyro: hid-sensor-gyro-3d: Use dev_err_probe()
>
> drivers/iio/gyro/hid-sensor-gyro-3d=2Ec | 35 ++++++++++++---------------=
--------
> 1 file changed, 12 insertions(+), 23 deletions(-)
>---
>base-commit: 36c12dbda81c284d72f3c64689461647497b643b
>change-id: 20260724-24-july-hid-gyro-dev-log-clenaup-488534e25965
>
>Best regards,
>-- =20
>Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>
>
