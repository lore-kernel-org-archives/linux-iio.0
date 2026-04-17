Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948BD34A3C5
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776453632; cv=none; b=As6D2BuZ23SS2rJwXVTIJl93St2Xk76icAX24PouJlldef9clTxO7VfQNDvxVHK0zR59BIwcR6Q59EQdAxO0xtG9Gxh3OL9hgaOW50+jQZ7xd8GXrHt/Adqoo1poUrG5Mdvoo+gl8X4l4abYfhqlBU97sMgGan+IzSdCGsDXENE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776453632; c=relaxed/simple;
	bh=AhQ2P0ZW6jv37dh8PeYA5rxTC3ZYK6WkCOfPN0CfbhY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=m4J+vOvFnpgtL9fOBr5ZcpZFl7CulVkwmpwiiAF0Iqo+/jUsg7C0k0Yt3pF/dNOEpbgJjCWj/OrnmG2PY7xHaokBwFmQVanpVTHHkQUMarPmhfdzS6zGnyL7qj6xGmRsMlKtOK7qPMyK7rdktNSDxC8kyF1WxWPvibPP8Eh+UCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7cxiUrY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7cxiUrY"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b458ca2296so7832765ad.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 12:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776453631; x=1777058431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BEIIMeFGRLV2ppfXjLD5mOZum5LaVU5zRLgkJrDi3qM=;
        b=C7cxiUrYKwVMB+/nSnVvPG452KqWtCsDDUxZoFhMbu/RyG24S94qXwS5M2NPzZyI7B
         vddiORnY5S1MUsk8jHnlqHUsdimpym7Vt5c6inEY+GpvGDayGY5nz/8nGwhg4ClFj3VL
         pRfKadpFh55ZTkfRrn/yiY9SZvofwFqIXojwvspXzNjZti6pqTK4SvZVpYdDCUec+iig
         lVOYMdLv1n3itNxpVSwiRfpmJbgMLe9biaYhBPihtShmM71DGORZVCjAy7spo4nCkHcS
         ppgQi2vaQoTB3bpZ3SNtSchUSHz8zgTHLNz5mpg1zV85ipws0t1zH5+xAX9aM+8enHDu
         gdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776453631; x=1777058431;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BEIIMeFGRLV2ppfXjLD5mOZum5LaVU5zRLgkJrDi3qM=;
        b=VPU1/VATGUHLg2rxo3OZSJZ3K09U0Pm3WtSgs8bfX/LM50DxOHGxFtDh9ctOlJzF4k
         ZdT7gLyBMhsRzr5unFiwcZbHxA90P4hLatRsfZSsTzO5zVnfQbUpFifNkt9SWSLU3YGF
         CUSDkA6ns9qfScyzHnvD3IKf5bzCv0LCLru9BSuGIFz6q4pZmQ/fhg3TJLwXUAz0zymY
         9sfiqdJW0TysqEEINUF72VyEOxralVI1uu+hDxK9a81TwGgh0EMhrZxHXTXOZ8v5gSS4
         W9yyVEpK9jeYXq3bvBPVJmzXnIC5XZA0TilqMDUCjuJpmc/oFpkBZGs4/z819ck7KWi0
         1eeQ==
X-Gm-Message-State: AOJu0YyxM2WCRCvgtI9Dna4UuC8zQv/Eqq9IB0XSKCx3COgK6RQtUmlA
	0Yydw0YsBpckkDAG82uhOGT5C8dqlLyhTz14ndmC7wkMgokUWOWvFnBf
X-Gm-Gg: AeBDieui26fqyNIF0cFlBGywaXs/+ddylBZ9mmMMo4axBXQX8lOP/1LwbqGRDaat1yL
	njXT2sCWgW5LwM9jPsJBE3/kUVjcKYtSH4I9RkHJZBk7KYkhYsZ+BnMj17kdphrMNhFRu34/8Qn
	HNTuYjLaneoIuRGgP7iuzDTm5K2SOoRrNiwwpgbn2HIscEBKhlgqk34d8wPDID5BogkDhLtcVnr
	yEf520UuJPMpNBab5sdPVuJDXMgoPsWw5OU1y2EkUGjfmTeeEh8TokdC9MmgnlS32odG5aC7r6j
	wnBDYn2IBkCAC2kIvSOlng+SGyFo+sixYOoGnxd4sUUGH9y0ZonKI5F27gK7KkfBJM8ct2cG6SJ
	2GBGggcMWVd52a7AFlyGe2P7TBt0SSC4XN62qaJBVxTWtNnwBtXsryAGkZcjEILTDhbbIzTuznd
	EE75WAolbdt8hG5L66nJ2enoD1kGkn9CWLdpfhHk0Sr3aVmpFGPm2DiFccUw==
X-Received: by 2002:a17:903:1a88:b0:2b0:5ec1:97c1 with SMTP id d9443c01a7336-2b5f9e85ceemr42488755ad.7.1776453630826;
        Fri, 17 Apr 2026 12:20:30 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:791a:1e7a:b20d:a410:390e:ad9c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa2f129sm25417035ad.29.2026.04.17.12.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 12:20:30 -0700 (PDT)
Date: Sat, 18 Apr 2026 00:50:17 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: jic23@kernel.org, cosmin-gabriel.tanislav.xa@renesas.com,
 demonsingur@gmail.com
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] iio: accel: adxl372: Use dev_err_probe
User-Agent: Thunderbird for Android
In-Reply-To: <20260417124924.353189-9-sanjayembedded@gmail.com>
References: <20260417124924.353189-1-sanjayembedded@gmail.com> <20260417124924.353189-9-sanjayembedded@gmail.com>
Message-ID: <11AEFA5E-58EF-47BA-A533-E996D395CB15@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 17 April 2026 6:19:24=E2=80=AFpm IST, Sanjay Chitroda <sanjayembeddedse=
@gmail=2Ecom> wrote:
>From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>
>dev_err_probe() makes error code handling simpler and handles
>deferred probe nicely (avoid spamming logs)=2E
>
>Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>---
> drivers/iio/accel/adxl372=2Ec | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/iio/accel/adxl372=2Ec b/drivers/iio/accel/adxl372=2E=
c
>index 1a6ba94f54f4=2E=2Ee375d068a3f5 100644
>--- a/drivers/iio/accel/adxl372=2Ec
>+++ b/drivers/iio/accel/adxl372=2Ec
>@@ -1316,10 +1316,8 @@ int adxl372_probe(struct device *dev, struct regma=
p *regmap,
> 	}
>=20
> 	ret =3D adxl372_setup(st);
>-	if (ret < 0) {
>-		dev_err(dev, "ADXL372 setup failed\n");
>-		return ret;
>-	}
>+	if (ret < 0)
>+		return dev_err_probe(dev, ret, "ADXL372 setup failed\n");
>=20
> 	if (chip_info->fifo_supported) {
> 		ret =3D adxl372_buffer_setup(indio_dev);

Hi Cosmin,

Your email address listed in MAINTAINERS (cosmin=2Etanislav@analog=2Ecom) =
appears to be bouncing=2E

I noticed recent commits from you using cosmin-gabriel=2Etanislav=2Exa@ren=
esas=2Ecom and demonsingur@gmail=2Ecom, so I plan to update the entry accor=
dingly=2E

Could you please confirm whether you are still maintaining this subsystem =
with renesas/gmail account ?

Thanks,=20
Sanjay Chitroda
