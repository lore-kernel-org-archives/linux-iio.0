Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1D32D3225
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780252123; cv=none; b=WKvVR6UyV2tpxlbdy7mVAhtAjFE5Fo2gDdhcEND0CojfVVKIJfwdTE7Vr+fyYQ63dXWlEsf3i6kvZed4hm/EUoYzs3O0RH/tL8Oxola/IoCOHNN4zBeAckWaL8isKYyShSRYSTYHFm8wlsIhgQRjhmn/B4c/P8c2s7PzlG9HNZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780252123; c=relaxed/simple;
	bh=YxqQPaEud5W5uZnQz5rNNG/i+tPqDKFxdAXZqu207Iw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=YoJ5TZxAS7o2F//wvm1tbxVbPwHpLDoBcFPdBwR89M2SyB/wRMdqsQJ4wkGRn9RFwSBM8vSEJ7jvomR5YON5BQRhFpWs/iI2Y0kJQdp/YSLzYPJQsayMDGM8VnMTlsy+CenZ7aijkiOssHEno2vpzj9YP361RmeMyz1WvANCV1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fR7txsxt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR7txsxt"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf22d29dabso17208605ad.2
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 11:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780252122; x=1780856922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0X00mNE3B+jHeKCfg8R0yFdLpEEpxBUKggjw0Bie5vs=;
        b=fR7txsxtdlr9usMSG/6kHfw59FywP7653YdUVU6rgXNbOPA97Fie+NakyIFqBM1Flb
         J1AjHfKPJH+wPspbjZCVSF0PMJSvL9S7+Orj7vl+Of++twLFiJA9xFFdhezsQgrtfDG6
         UNLuMxZNeZ26NZEktyMn+NCGN/Jj7PaVNyoLlTV7YEhVdv5EJsPGtZTfFP2vH5GIFZg2
         GJL0V1eGQIcvmTASjHkmCeqNg/vNza2Zpr+DuXH4+qsC976oI0o/lT9ixfehfw/4jVt9
         RYGC+CDMdYPnC+BL0sRIBsBY8pmuGae2iVs3viwz1mDi3AnL5KevdojfrK+RqGMV/HiB
         ABEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780252122; x=1780856922;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0X00mNE3B+jHeKCfg8R0yFdLpEEpxBUKggjw0Bie5vs=;
        b=dVgTtcQcrzI5+dFOErgiykJjuTQZdd4k3IaWIOFa5x5jtylAIjlSulHui+tso4ERmV
         cBUYXZ7LJ+/nX/7kxIUWGlov9odtFKcTjKbWiRws6x9qyMlpRCw0J5XSNZ3tUpcfiU48
         RUJ5EPpds+G+xfoV+OfTWrDRK2pwW36yLK2FEYPHK9Ex0EMM4SmlGpQoo4dBkfGKzGGR
         sA5IZ7rcAbtGw04plzUfQ8nHvQKwJb32cDFThR6paICTdUCiLKRJWnQmxYy5IX2P3eJN
         AzXSf3uTZOg5mB+p6972FirbPqb1Eb/xo+C3UhSgBtMtyYNHXoLD7NM9cFFuenYaQ5ig
         lO9w==
X-Forwarded-Encrypted: i=1; AFNElJ+cR85pZr3rAH3VCc+tprsbGFFwDqu+jeyz4y8bqLRtQMzbtFdZ56eKeVjpH7kvVJ9SLo3PAidTpKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWqpynVWnSiojvWVMDfaj5e8CH95pYpkEEbmWVbLzorduAd/3v
	viNXLwS7ijV1C06nZm5dFlRg7V2n0G3ae/gZIXGgCYdHvrN8hyqhNHs6sKn20A==
X-Gm-Gg: Acq92OEaEZtRSC5pGvrCD+joejbhvFpc6RPgTTtOfLp1H5GBK2c/Q9UJS0DbM7XSsKZ
	rVDSgDEKKWj3pMru8V02sMRSmmmU5ShofqDbVqCFEgcpAHjIcJ/D+eKKcjBGvTDBB6H7ykv9zOp
	6/nWmVCfikD9H1XuutqCn4clA0dmNDXMt3+7LUekgR/A76bBqSUk/Go2i7/DXfx73YQETn56go7
	5svB/hRhPOmyWaEUXe8OAC7fX8yC6mr6f75ceQbo/xyVtLHwCUt829GiXpJiZpOXNM6QmguQW6X
	U6IFW4SN5j/fn9/UctB8aUxbeJ3bDuYrSFcXJxkizNCtHsyMtBpitWaF/GVs5zaMvgsYit5G59B
	dBMk7j+ltbscXYRqeaFe30InopPb8SbG560GSbu1ITPNi/EQPuZqToIlKo+by9aPFsacaNO/n6H
	+TYI+RH8ynB+DKVBUQz1jhJJyHDNJ3CAz/Q7V0a4z1NSy7NN6/cW41jSdqyQ==
X-Received: by 2002:a17:903:390f:b0:2bd:8395:fedd with SMTP id d9443c01a7336-2bf36875f57mr92963375ad.37.1780252121599;
        Sun, 31 May 2026 11:28:41 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:8899:fcac:1e3a:decb:64d8:5209])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c858108940bsm5925116a12.5.2026.05.31.11.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 11:28:41 -0700 (PDT)
Date: Sun, 31 May 2026 23:58:25 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 Jinseob Kim <kimjinseob88@gmail.com>
CC: David Lechner <dlechner@baylibre.com>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 "Reported-by: Sashiko" <sashiko-bot@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_iio=3A_buffer=3A_Ensure_bounce_b?=
 =?US-ASCII?Q?uffer_used_for_unaligned_case_is_zeroed=2E?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260531111605.2411980-1-jic23@kernel.org>
References: <20260531111605.2411980-1-jic23@kernel.org>
Message-ID: <2417EDFF-1ADA-42CC-8D52-C93E90EC4953@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 31 May 2026 4:46:05=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel=2Eor=
g> wrote:
>iio_push_to_buffers_with_ts_unaligned() leaks uninitialized heap memory
>to userspace if the data passed in is not a multiple of 8 bytes and the
>timestamp is enabled=2E  Use memset() to zero it after resizing=2E
>
>Fixes: 95ec3fdf2b79 ("iio: core: Introduce iio_push_to_buffers_with_ts_un=
aligned()")
>Reported-by: Reported-by: Sashiko <sashiko-bot@kernel=2Eorg>

Hi Jonathan,

Looks like "Reported-by:" is duplicated=2E

Thanks, Sanjay

>Closes: https://sashiko=2Edev/#/patchset/20260529121005=2E1470-1-kimjinse=
ob88%40gmail=2Ecom
>Signed-off-by: Jonathan Cameron <jic23@kernel=2Eorg>
>---
>Cc: Jinseob Kim <kimjinseob88@gmail=2Ecom>
>
>This is untested as I don't have any devices that use this and long
>ago dropped whatever hacks I used to test it originally=2E
>
>Jinseob, could you please test this with your OSF driver - at least
>make sure it doesn't stop the data coming out!
>---
> drivers/iio/industrialio-buffer=2Ec | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/iio/industrialio-buffer=2Ec b/drivers/iio/industrial=
io-buffer=2Ec
>index 9d66510a1d49=2E=2Ed930e70e12ff 100644
>--- a/drivers/iio/industrialio-buffer=2Ec
>+++ b/drivers/iio/industrialio-buffer=2Ec
>@@ -2466,6 +2466,7 @@ int iio_push_to_buffers_with_ts_unaligned(struct ii=
o_dev *indio_dev,
> 				   indio_dev->scan_bytes, GFP_KERNEL);
> 		if (!bb)
> 			return -ENOMEM;
>+		memset(iio_dev_opaque->bounce_buffer, 0, indio_dev->scan_bytes);
> 		iio_dev_opaque->bounce_buffer =3D bb;
> 		iio_dev_opaque->bounce_buffer_size =3D indio_dev->scan_bytes;
> 	}
