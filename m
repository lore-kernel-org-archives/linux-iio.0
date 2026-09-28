Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA5E3750A9
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618733; cv=pass; b=qVfclYyqDnCpnZ2BnBcle6V7yJCmCU3CzvIUHwd0whIBAK4yQVNd7UfCm5iBDgzLxOXa4sRcqO2yVqWScLTn/f5WNJ8bQPTut5lN/pFD0Zw2C3d0AR+ESfkCblQxKrsegrRiDE+me5EjUcQnDskd18V0NQ8hnWNQHG2B0TMj5dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618733; c=relaxed/simple;
	bh=MLEfxMlJUEEyVrOmaPHoWm7+PeLEG9uOICpbSXB1A1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8j5iPMztt3kTHS0nW4jlv8+lBhugfgiAqDVmyhu4FOdELAoQe9TRE9IY0E1wTnpO+oV+sU2S0Tut2R9tKHNidvHPKKgXr8ndaqeiZvfmEvwXy95TxT/aRXG/QVdhczzJY3fU14mPGqzEfUd6XgFyT5OHQRvBdzf6bPETbv+OD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhMu2oZr; arc=pass smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhMu2oZr"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2bf3cc16baso300276166b.0
        for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 11:05:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790618730; cv=none;
        d=google.com; s=arc-20260327;
        b=nEC7RMjRWqd3B/SsL/Dv3qsMbpJuuzVKN8rFVs/jcfhVF6QB8ubyp4+oolv3aDEEXy
         bzBOM5CpAjUN8q8ubs64hFzzw94w8isw+O/YgPHgMwahdMxZL8VKlkAOyzR7daetmxNu
         TvGM2zKyOw5tCD2ZCWlPniFhfBiKuF6HOv6CKhe6F8Zt1ysJJL99YIi3ablx/X+5yBgq
         wteO6ZL13cULEMxM6kNoeLe7PEJTaO4M1ZxxwKqQkzQhT0ehS2n6s+lkvkUPhoQH5TNv
         zhm+rCkplBzo5HzRHW2vmlmjZ5MX8Cy0ZR/51Nw9X7B6E1SZ/QBiGBxE2iRepVPlrrPS
         gljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e4jjh+EWYyOIN/12qAGS9jATZa1y64YX2UmnmnShxQM=;
        fh=lHtkM1/9pjsbHXaUanrA2XYm99XmLAnw0BJAd8qaJvU=;
        b=SSlPEmFQgNiyi6xS2ffb9wWDhq9CsmO44itDyGoNbpYM8mEyiwY0ZGiZ5ZhrhMiu+L
         o7bVjc2M8A2zFy3ZRBC057mB4Hu+fTazJooc4CAqCCD844MZiV3uAD0X7LBjEYCLmUCb
         HGa5FTNTUnF/a2MfBChVGNySiVOaImFbLT1D46voTFc4gUWEt/ZMqCMIc+05+cXYuln0
         Lz+EiOJY6QTXr8TAwPZtwhVzEEokyZT/B+qDiyb5PTuMU7xInE8hoKYslMsjCYW4OIJV
         9yDX0n4UUXQHHJX48ePY/tqKl37vHjLppzGr55JWAY7MSnkP77Zw8WKv2Dxacg111yJG
         lPow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790618730; x=1791223530; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e4jjh+EWYyOIN/12qAGS9jATZa1y64YX2UmnmnShxQM=;
        b=AhMu2oZrIOOJ1JGrpB70C9bHZLvV9/XUcuTCqFjDoIWELFz9+owuGd/E5p1YUE+DEO
         aurx44hoUTAqNjc93jKOVaSMVaA/8SxPGOGpIH1SpE2Qf9ssZqVeICQRDTC411Wc2Ebs
         vE4z3Jzl7TbfO29dt2k5pAJKWzNQnWuoWwopCyzB4uDOfqcAqUPJ17NNAR+n+8dQxten
         SGmN//UZr7mzrbQ6Cu9ijA63xsbTTdWN+4hY+lJhwO3NI6f9wEjzMkA1qEzSZVy/ucVZ
         2meQ4q3MTJDGxtR9/IB3/zWihAnrhz5HCNPGUta0NTyT4rzRVQy0tzxE/tiKamrrotAW
         5nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618730; x=1791223530;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e4jjh+EWYyOIN/12qAGS9jATZa1y64YX2UmnmnShxQM=;
        b=k+01Ql+8gQJd1X9JwkYzJ+gRgDbv9H1AKnu2Y6ePtWGN2Eesy3d9bIQMopL63nI8GD
         1iy6NQi5NoPLA7Mw9soHtYUnBYt12ZEx1P8iofg0yUBCxUCQ/WkM1a32dI8D006Wcgex
         ZfoK12/qpdd7BaiueaxK1Dcf4vB683PKJTgAvGyw1+GT4N3RYgVoZ3HK7xgEU4xiZx4e
         ZdP7YUZsqHAb8ePTriYsmuQCcqKoDwtgXpDBooELDYUZVMDtDuDQDIqhoJAdXKi4K6yH
         PuGZBgxG3mwRytnl4mAtMgbx0X70MEysnS49Z+SuhatXOPY3NnC2Ebg8So+c3Gru57x7
         q4dA==
X-Forwarded-Encrypted: i=1; AKwUvBzWMe0x+bfb3wFbmv+tLG0g+UQGKf8K+uEW8cIEWV53uWSFjT/0cMgOHTr7heg88Dus0jh8MZkneHI=@vger.kernel.org
X-Gm-Message-State: AFuF++mU7dqcnM8Mf9WdUpY0fTKTtd4mWjOnFeJ0n4tTomfwh6ye06xu
	uwubS6BbxiLPR1iwYOnRGd6ZPWBIqLIZqvobzS/WK4S/MrgteKG0s+yxhgBQeBTg6JSMJaR6gZO
	fXxIQ4PcFbkh+WyCaaEXIILz4ETL/eGA=
X-Gm-Gg: AYBFou0BAPfz00tCjHUrXRlbp6P0w67o9cbFQokC0sjA89BbgOoX3Hm4emrD2FvwJt5
	NzlqJQZ9Yt4ty90W6adbLXIw8oagOto4H0wyBexBkUHr2GHjQbAmb/5mtmj39W8w/cL140Zy3xj
	utRbxCCIjn5+42AhqraAM+9wF9akmu2EyuYXUaKFRbcMQgGvirW8jJLFYu8CJ1Uz17K7PMunDwg
	ugDUhRlyjy3CgwxBQ6D5X6U9HEsMLdHFVZPO0rr79NgFY3g5LJjibSWXFBe6CgdVWiDgCqGAOVC
	uYGgZmpdZYpFqjKaqCmPjD9suBYQVBNwFXsQxUlaCdc6Q0DPEZiAH6B9e7EN1B4vUxDxrSG61hm
	wtqpoooC6Xu+k9yjzISTol0sNw6BxkL5gDLvj17j4CFlir6i5SOQRDonxlRAqWOjxud6NocBZ51
	6YxbjXyKGoU9YG2vX03zauY2V7y53uvRgMF2ti1hgo
X-Received: by 2002:a17:906:c14a:b0:c2d:bae5:27e0 with SMTP id
 a640c23a62f3a-c2dbae52bcamr568996066b.18.1790618730238; Mon, 28 Sep 2026
 11:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928175049.86941-1-jwuerz@gmail.com> <20260928175049.86941-3-jwuerz@gmail.com>
In-Reply-To: <20260928175049.86941-3-jwuerz@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 28 Sep 2026 21:04:54 +0300
X-Gm-Features: AclHuK8_tyw0h9eVQdPiLqhB0QjkWh6KyV3q4_8dXfkNeUGqubfrfMkXQGjY6qM
Message-ID: <CAHp75VfB+cmqWfk-8vuR+1MtF13Z6SJ+-KLovM9kYm=eVnVpZA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: imu: st_lsm6dsx: Add ACPI ID SMOCF05 for LSM6DS3TR-C
To: Jared Wuerzburger <jwuerz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Samuel Dionne-Riel <samuel@dionne-riel.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 8:52=E2=80=AFPM Jared Wuerzburger <jwuerz@gmail.com=
> wrote:
>
> From: Samuel Dionne-Riel <samuel@dionne-riel.com>
>
> The Minisforum V3 and V3 SE tablets declare their ST LSM6DS3TR-C IMU in
> the DSDT with the hardware ID SMOCF05 instead of SMO8B30, so the driver
> never binds and the accelerometer and gyroscope are missing. The
> Windows driver (version 1.0.4.3) binds the LSM6DS3TR-C to both IDs.


> Relevant part of the DSDT, identical on both models:
>
>   Scope (_SB.I2CD) { Device (STS) {
>     Name (_HID, EisaId ("SMOCF05"))
>     Name (_CID, EisaId ("SMOCF05"))
>     _CRS: I2cSerialBusV2 (0x006A, ..., "\\_SB.I2CD")  vendor data "SLA0"
>           I2cSerialBusV2 (0x006A, ..., "\\_SB.I2CD")  vendor data "SLG0"
>           GpioInt (Edge, ActiveHigh, ..., "\\_SB.GPIO") { 9 }  "SLA0"
>     Method (SLA0): "-1 0 0", "0 -1 0", "0 0 -1"
>     Method (SLG0): "1 0 0", "0 1 0", "0 0 1"
>   } }

Drop this paragraph completely, that's what the cover letter already
carried out.

> Both I2C resources describe the same address; the I2C core uses the
> first one.
>
> The vendor-specific SLA0/SLG0 methods are not parsed, because SLA0 is
> not usable as a mount matrix as it is. Its X and Y signs are right, but
> it also negates Z. It follows the Windows sensor convention, which
> reports Z =3D -1g with the screen facing up, while iio-sensor-proxy uses
> the same X and Y signs but expects Z =3D +1g in that posture. Applied as
> a mount matrix, SLA0 gives correct screen rotation, but iio-sensor-proxy
> reports the tilt inverted. The actual mounting is a plain 180 degree
> rotation about Z (-1 0 0; 0 -1 0; 0 0 1), with which orientation and
> tilt are both right. As for SMOCF00, the matrix is therefore provided
> by the systemd hwdb instead.
>
> Tested on:
>  - V3 SE (Ryzen 7 7735U, BIOS 1.03) with this change.
>  - V3 (Ryzen 7 8840U, BIOS 1.06), kernel 7.2.7, with this change and
>    the stock firmware tables. The driver binds to i2c-SMOCF05:00, the
>    WHO_AM_I check passes (0x6a), and both lsm6ds3tr-c_accel and
>    lsm6ds3tr-c_gyro are registered. Screen auto-rotation and tilt work
>    with iio-sensor-proxy and the matrix above (checked with the device
>    renamed to SMO8B30 via a DSDT override, i.e. the same
>    ST_LSM6DS3TRC_ID driver data).
>
> Closes: https://github.com/mudkipme/awesome-minisforum-v3/issues/2
> Signed-off-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
> [Jared Wuerzburger: rewrote

> the changelog with the DSDT excerpt,

This will be dropped :-)

> test  results and mount matrix rationale,

> converted the entry to C99  initializers,

Not sure if it's important enough to be mentioned, but up to you as
it's indeed what was done with the change.

> dropped the mount matrix patch]
> Assisted-by: LLM
> Signed-off-by: Jared Wuerzburger <jwuerz@gmail.com>
> ---
>
> Notes:
>     Jonathan, when applying, could you add a Link: to this series? The
>     cover letter has the full DSDT excerpt, too long for the changelog.

...or even use `b4 shazam -M ...`

So, with the DSDT excerpt dropped from the commit message (and the
respective update in the tag block) feel free to add

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

--
With Best Regards,
Andy Shevchenko
