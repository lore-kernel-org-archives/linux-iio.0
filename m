Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7F03EF650
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991687; cv=pass; b=mkYgo5ZfRgfJQ+aHSTnOVN38FXCECpWufTvLEAjxTuVgs1OfE2fKkKjG+sVH8MUUtboUR/IYKS03l/Y8KlXRO38bTItZ+sgT6FRQofkh7Zxi08YJpWO3h7L6ZcquLii7qQWzYGKERsXwGImWzwWz595OyH7wFU+3nUHV+dJr38U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991687; c=relaxed/simple;
	bh=uXaEQAfX2sWvMtw9t2ySBr5nZ1DJIJhkb5V45A6GtQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arBeY2EBq6KjCwotZge+TjU39JkpuiHgVnb6DXTACk09z1AmoDu7Iym29iOpBjHC2ztSPXEu7zvY3Y+4cMrBPQpwYEE2F70S70mQorNG7xID/q/swV9lq6u9coln8ZNDoj2YAXvzvFuwo9fgYC32REEeMNF162bdALIDM1g5TQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeVuqrlR; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeVuqrlR"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d7645adbdso3255802f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 07:34:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777991682; cv=none;
        d=google.com; s=arc-20240605;
        b=MqXGODSuguA492aMEu6SdSOdsFwmOosjfU9CJob7pa3w11iUleaWSJmj28QWqTM6Hz
         9mMKraXYrHlIm1Phxmk+FPm3FlEzMQSbgF9zI+fKQ02dKynt1Wiwl7eNm+c8ZFHhuVIR
         u+8zdkXkmwHUQMPZZij4R4e0HxfGwz5ZEa/AxSiTP9Lc+cEzASWNaP7AHsBQmlC9ZDNt
         XWJWJh8qchoLN9g8/c/vHhn3cYBEKO/W8w0957Php/6UNnjymq8SoD/wZIgikmVmtbUn
         +RRaN6kNLMDLIZqt/s0SgiCbQzFPMuB0IA+Z8W+yLYoXTPbegSmYfKLTX5HoTjzqohj6
         hxAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SgsraTPxEZefwS8A0VzVY6/q859woPAmaBnbFtaDG0I=;
        fh=vpzNTkZI73A4LSU96CeTEZfSqAGN4vMv28G2AlLiOp0=;
        b=gKRUOREXS5AUL2gF2PUcVhi9JxMuF5ChPL0G3ZbNQG7sZOizLlFvCDbo1Rdxidn/7B
         YaqValneg4nMHQQdLrTTAg9FgcRMk3vFOefT1cSn9uuD/oF5mSj2g+VTmmasaCQGgveJ
         +1KvdCzZ0Db8gV3NS6zQuVgndSZq0IzA8jKv2tL9G1BLOXTIAELMfGSxSVQqv3O8/+VZ
         sH81qSGojV+8OeDby5nwkna1dpky83gQTbF6kFKUCyBGWwiyUz9QMtAhhDfacSo7fmsl
         zR9Vca6GjeUvtou9uRgTZVomC42rHgk1WgmWvTc4vIeI/hLmFrxVDAdQIzVwubnwGjhO
         RXjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777991682; x=1778596482; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SgsraTPxEZefwS8A0VzVY6/q859woPAmaBnbFtaDG0I=;
        b=WeVuqrlRchfC/YAnNmJWgkwCNmHZvZVR6opZAFCJU/XGBbqyAvFHUM8LyMiDUSNKcm
         8eTXaGy6vVFHWCLVjE3X+OlpLZCTKxrPCEb2XIIUC1d/APp0MjEYU4fMPHzNHNhz80/l
         hqTNPvPFyDNMT+Aw1nhjx4pxBUrqSwsY7AoePk8v6FeVNEcF/RXsaHFy0IxhSmQE6LCi
         qhFn+m6HgU+vA3KuUIHrn+a1SSpxWPPKKgq2GCyyTl4u9cnvW78l3/efwWYQcvlwKyHW
         uIkRGRCtfSsasXkF9LtYrk7CkjfYycpyDB2mMI0EW3G0Gj30XXKWHyvdOkYUKvu7weom
         3haA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777991682; x=1778596482;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgsraTPxEZefwS8A0VzVY6/q859woPAmaBnbFtaDG0I=;
        b=UHqfrHPOOmFCiE30zumMUmt1B1fgAUrQZ5AAeD/eDUF03X6l6VBeoJOejMPj6dguf2
         Tk+XSDqzVQXcPBIkYg/c6F9LR6GAk8AkA2bDkb8KRybhTL0FhQm+3LMzmOEA19IFewsq
         PHokTzrDa+xKJ8Q+JOcUwUNt/d64KLZc6+IdtajD6JMLEra2Sc62MT4MmIl2/4TwRrQt
         Jy37NZZhI2oPw85N5hRuoZ0bCkj5DRkJGslPThTQTtO/21lZWJXO2zG4OsN3PwTO64Uh
         EH4akv+ob8xmH5IXr0VJlqGNXLpEJXzBHfllw51mWOArUgO/PbW45N6/mYHGtheCKajf
         UrHA==
X-Forwarded-Encrypted: i=1; AFNElJ/UnbdC6csK9N/MCwaNYZIu3YhGEU3JulULgPC/8np+tlu5HxRMkL0j24xQNa0uCcmucUxka/gpEns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeeoDI4QeitPqWxfK+PmfXtWCWxEJX37ndBAl7NN0RfjfktGsd
	8xSVbWlwnnoQSQ5ZARa2w+ciDcbdsm0SSsyqd59uw1PzA6HzDUGjFxmfvtpPI47reye8yeMQg3r
	yW4WML4bk52a/urn+roJNFrr4Z9AOzpM=
X-Gm-Gg: AeBDietnnnW60JlJn1lNn+qQJUAjxBODUTH7xmVRSsMTvCY/eq9aO9Gd7x+hMIZC2oI
	kLfrOrEP8pNDsaYU0K9KFPCwWu50goEHFur6QW4xHSwYxoWIHCeMJNqaNWpUlwkGohnfw/dKJDn
	gFR3ulNY7DfuhSblGQbQuYm/tRu3Iwm6r1yd09fHrspJ/5/SNOjw6+JWd2bv5d1sXP1v3DKnT5m
	A0buSHHZvDV5OQ8NRvcL2f+AhbC9VeoHKevsb802hAgjhYaSKeeWZuaPM+0HebvZdWrcRT3ndY2
	cH12Cb1xsjRVgpx6iszlbeT2D7KLXfiSDGcmgM/NBKEMvXSSwN6QrTAvP/eI0lMtISGnuG5wxIk
	SZ8pEO3ZHF62TcA3ZWXCk9aRMoq/ZQ9b1EWpL2rGwEbD5oN8bcMrQhN/G4FbGFYFfAiMJZAAPHg
	5xDAdKfJ43ZfIcfXu/5LOeWyuFhHQ=
X-Received: by 2002:a5d:5f82:0:b0:441:1e62:d25 with SMTP id
 ffacd0b85a97d-45003fc674cmr5929231f8f.17.1777991681694; Tue, 05 May 2026
 07:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com> <20260505-magnetometer-fixes-v5-14-831b9b5550fc@gmail.com>
In-Reply-To: <20260505-magnetometer-fixes-v5-14-831b9b5550fc@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 5 May 2026 16:34:29 +0200
X-Gm-Features: AVHnY4LqD5Bt14w8ohD5Mo00bhQNpO8eF1XFNTTKj75cYxSuXRaOEuq3TcIJimo
Message-ID: <CALoEA-x4GGfSeurgMAcOguXRB62ygEj-5suMVhd0x4DjXmTfcg@mail.gmail.com>
Subject: Re: [PATCH v5 14/18] iio: magnetometer: ak8975: switch to using
 managed resources
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 May 2026 at 13:46, Joshua Crofts via B4 Relay
<devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Switch the driver to use managed resources (devm_*) which simplifier
> error handling and allows removing ak8975_remove() method from
> the driver.
>
> Note, on error path we now also set mode to POWER_DOWN state which is
> fine. Even if the device is in that mode, there is no problem to set
> that mode again, it should be no-op.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Co-developed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>

BTW, Sashiko timed out while reviewing this patch, didn't even know that's
possible.

-- 
Kind regards

CJD
