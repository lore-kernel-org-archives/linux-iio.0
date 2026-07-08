Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DDA37D13D
	for <linux-iio@vger.kernel.org>; Wed,  8 Jul 2026 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518612; cv=none; b=oqs3ScN3JKBxkcYzJ0seyBqAdIREKHDTZX+Zm8YxYSy1E1x8A8sajaEyg0M0b8KWHsuUjXLplRYhCWgmnhxLxulqNi4aIQ7caUtABOmmwZtKl0bgxpNlSjsrhvE6D05/eGEJLRMU0ZikCvGfEjjteZ4qJqsLKLKR2pUuu2xMOao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518612; c=relaxed/simple;
	bh=6gpeLjoCGjWczZSVZXnQb1gK/iGJTjle70SXQ4k62lc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FosfwfATfXJCusdng5F2PZAUbRWTabMq/NdCG8TTpp+sjten5KAdcIrPLNWZZc7DXCccAheyLeuOaNnRefjiyibQZsrXanlU0k3dTjqCEYy9bL5wdx+iKXFphptk2F1NrLk6rfb1t06N4/hKXKtZZwmTayZTpkd125f6RCiW2G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rG7VV9hJ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rG7VV9hJ"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-381216921aaso733507a91.1
        for <linux-iio@vger.kernel.org>; Wed, 08 Jul 2026 06:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783518610; x=1784123410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=buKwQuF9Xb78SedDvaSqFTvNEIsKPttq7Ewic1Ot5jk=;
        b=rG7VV9hJhQ0z5Bjw9t8JgQV40bZxsN9m2aJcmvmOeuFHIHkMVHWehyHAgoa7U2ye0H
         Y2ov4iqmODg3i22YZO3vnxvYyfvZT2gvEm0Lg1WgiM1zK6wt3YwpAT3Pju341sDuJ3GH
         p9mK89xF7GzJ7GaYkGsj+eS3SdgW5deiCoqmA7ao2MDZxGTEh/GPY1hR++VsEdUrI9H2
         oiLkrwuixAO26UIONKBi9nMlxpa53L4DoLVIISujAdSiGL1f0jMmcm9zGVVODVUHdq6y
         9EekOwKPyfd0Xxvt7rya9OTG6Hb/O6J0KWvYMfBC+0BUhSGQMP9biHMrzyNmIwjaajvo
         KBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783518610; x=1784123410;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=buKwQuF9Xb78SedDvaSqFTvNEIsKPttq7Ewic1Ot5jk=;
        b=CXTKMOxC/jqCbkySQA78d/uTS5uUGW4eRD+/SwBViCm8foml5DekxMZRvIcoY+UyWu
         aZ0uZih6dtnHsZqilRiYTSBoDOgQgOnnLH/1B7l/bTUOWnr6xMW5ALBQHL6D/uPox99T
         u+3IPPj/C7UA84TRojkG6Lue3/thWRugx4d+5bmYinVDuUdyxSBPtqUOjwDI8UfPBwsn
         jjJ4zpzfGdkHP0euchR7aL6opb92IyHXfz8RvU3yb93EZcCeiIoHUab/i2WldRWqq4xs
         Mzr4O9jS1ef4i9jq7xg5OOk/TLjnIYis/gB0wzWRTObmPlKN2amkaDHL4KK477mQO08r
         i6Dg==
X-Forwarded-Encrypted: i=1; AHgh+Ro5AFfJmosRbXscHbg26Y4xpZli84JY80r9OH7yhst1JyDSQOwMVezRqR0PO+iLAyw+d3Yy1Tg/uXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwJkYlc/mRtExU+QLhlxEl4PnBc7gZg+PD0qTJkabh8rte3Nn4
	/cTQ5aO4ANTaKCCcht6Zoo95qwDukEHx7HKVSHElkSnthF3dS+VvK3+3
X-Gm-Gg: AfdE7cnmX9Zb5uTK0mZnUq8NpSvWIU2TDk9QUR3QSd3dx671YAqw/0n+MtebUvd6nOp
	0vwwC032NGLkxZb0+e5vWA2vttHijq34B/i3MFTDNaSMb3KfkHPEJF0l8Id5GW/B6rX9eDCEL3e
	xYTbbYkJd982LGx3CtC5LTkpaH3gGPL3bM8R5jxLasWxPuDTex4e0RabAuzzUPLxXOvoGEg/4cP
	vYHIgSffFduQ0CNUjffEMdfxVl8qhTfyj+nTGb20V/J3XkUaog2r/xHyqEdC9Hxa7rw0G5myqqX
	6V0VfQoZMN75OtScBA6Q9wrYzAbwP6xeZFoVgt7jTWTg45AwhnkyQHtnVWvxKhklGqYCwRQ+B/B
	qyIkeWW2qDHwkIwbnka5Q4TUSwt3b3hsM2d7QcKArBURsG3BrwFGxb0vctACZ77pRhG6Flldp/w
	T/89yiuVgzJNhmBLx1NgK/n9zp11wulLgw3ybs
X-Received: by 2002:a17:90a:da8b:b0:380:40b:f30a with SMTP id 98e67ed59e1d1-3893ff630b6mr2629759a91.13.1783518609657;
        Wed, 08 Jul 2026 06:50:09 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:1f3f:c3f5:7690:4ad7:112f:6a41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d12fcd99sm2822926a91.2.2026.07.08.06.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 06:50:09 -0700 (PDT)
Date: Wed, 08 Jul 2026 19:20:04 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com
CC: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 hongyan.song@intel.com, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_iio=3A_temperature=3A_hid-sensor-temp?=
 =?US-ASCII?Q?erature=3A_switch_to_non-devm_iio=5Fdevice=5Fregister=28=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260625121611.2003780-1-sanjayembedded@gmail.com>
References: <20260625121611.2003780-1-sanjayembedded@gmail.com>
Message-ID: <F9175D53-7073-446A-8EA9-C7C06F76CB69@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 25 June 2026 5:46:11=E2=80=AFpm IST, Sanjay Chitroda <sanjayembeddedse@=
gmail=2Ecom> wrote:
>From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>
>Avoid using devm_iio_device_register(), as this driver requires explicit
>error handling and teardown ordering=2E
>
>With devm_iio_device_register(), IIO device remains registered until the
>devres cleanup phase=2E However, driver's remove() callback removes the
>sensor hub callback and trigger support=2E This can create a race window
>where IIO device is still visible and read_raw() requests are issued=2E
>These requests might call sensor_hub_input_attr_get_raw_value(), which
>waits up to 5 seconds for a response from the sensor hub callback that
>has already been removed=2E
>
>Add an explicit iio_device_unregister() call in the teardown path to
>ensure deterministic cleanup, so that userspace can no longer access the
>device once backend resources begin to be dismantled=2E
>
>Fixes: 59d0f2da3569 ("iio: hid: Add temperature sensor support")
>Cc: stable@vger=2Ekernel=2Eorg
>Reviewed-by: Maxwell Doose <m32285159@gmail=2Ecom>
>Reviewed-by: Andy Shevchenko <andriy=2Eshevchenko@intel=2Ecom>
>Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>
Hi Jonathan,

There are two pre-existing issue highlighted by Sashiko which can be analy=
sed and fix in separate change if required=2E

Requesting your valuable input on this fix=2E also, this is pre-requisite =
for HID IIO devm conversation series=2E

Thanks, Sanjay

>---
>Changes in v2:
>- Added review tags of Maxwell and Andy along with stable Cc
>- Based on input from Srinivas and investigation use-after-free
>  explanation was not sufficiently justified so updated the commit
>  message with appropriate information and kept Fixes tag
>- Link to v1: https://lore=2Ekernel=2Eorg/all/20260622052135=2E1804135-1-=
sanjayembedded@gmail=2Ecom
>---
> drivers/iio/temperature/hid-sensor-temperature=2Ec | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/iio/temperature/hid-sensor-temperature=2Ec b/drivers=
/iio/temperature/hid-sensor-temperature=2Ec
>index a8d3a15f9c53=2E=2Eab6ec8f659b8 100644
>--- a/drivers/iio/temperature/hid-sensor-temperature=2Ec
>+++ b/drivers/iio/temperature/hid-sensor-temperature=2Ec
>@@ -244,7 +244,7 @@ static int hid_temperature_probe(struct platform_devi=
ce *pdev)
> 	if (ret)
> 		goto error_remove_trigger;
>=20
>-	ret =3D devm_iio_device_register(indio_dev->dev=2Eparent, indio_dev);
>+	ret =3D iio_device_register(indio_dev);
> 	if (ret)
> 		goto error_remove_callback;
>=20
>@@ -264,6 +264,7 @@ static void hid_temperature_remove(struct platform_de=
vice *pdev)
> 	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> 	struct temperature_state *temp_st =3D iio_priv(indio_dev);
>=20
>+	iio_device_unregister(indio_dev);
> 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE);
> 	hid_sensor_remove_trigger(indio_dev, &temp_st->common_attributes);
> }
