Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27B23DBD5D
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 07:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965999; cv=pass; b=f8zy+IUk7fSVFt/D/OwEG2arE2btC34Exk50be+/mOxoqKunCJDIw90IcaqVRy4TKbQ16ocObXdY/WMpSM46aUUbkVPm3LeiNNh1phJGTxj9unt1u8uOdQmjjFkdfn+30C4BBbRyg9+zjd7t64DtAG5FP15BNt+vPrZXe+VGmLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965999; c=relaxed/simple;
	bh=sFs5szvJf/zunhQ0EkHB/qKvjCp6EFgmVX6OVVanpVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krDMmwGwd6VbqSu6FSOjxZTOzL6evmWU2PKr/Czm/sbaP7mBGGOpN95ubCFOYnFyiF9/KVUplQl8zeBYMzELhDgmynE7oOB7NywwLUl2ns8bC+QSf5ykTKnfkeBy+IjINGokHa5PIXgU0+PEHHYuNX7+BkMROOC/Q79S+iNhB1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZY+pi+C; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZY+pi+C"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-441209fb77eso2829081f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 00:26:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777965996; cv=none;
        d=google.com; s=arc-20240605;
        b=GqmNibfny8gnjYED4cVD0uxCobWUSahLFAzbssNgrLg2OmUbOOAFgWUILO2vYN5dXy
         AjVvmpbuWM16wOSatyXnB6KkTjPHx+jcGZBFNYQFWDBBwTlAmlJ7eNNSKg8TCXlldYC3
         x1ZtFkRfoYgQhLsKrb4Nw1kimC9exkRzkYXDIEOX8/USnoLobeQQdcLjGkWuGPdxx3v5
         nDJfKRjYB5sPzZmAd109ueS6lIP+B8hvE6gNTxsZh6PMDaat8KQ3klb8aS4w9c4XavGY
         qV+LQWqmyONQKyscYIgvRjqNpmSDslRScNKmr9Ru2Ue0O9y1JtWK/58UYGLr9nGBpQOd
         h/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4iXsy0Ph9WfvnMeunGjXcCmD6uL8ClhF/MUxaHRVoOE=;
        fh=1xZywrw3q0wFjS6Pky/krg85sgxIyQz+SgDk0FkmSr8=;
        b=LM9V6jevxtUGe7gnZ4FdAQChw3ECxZogktD3RX/GdV1uZEDoopFm3y1dB/huLchohv
         EIL3TFv3Pir12h27tr2E3b3VfK+QXCvjcdVjoJwMdYjmIM70+C+zh9IRpx770nppMaPT
         uhOgESO5PLKd8rPxG3/Ta3u/46grW5B2UAqZiN2R1x5uvjD3brpbN1I6R9OKEQoU+7bV
         UAOxV1Y0iwvcRSZlQ6TSOOTx3wHnPtCFFY02wJv++xbV2IivlCXBmty9DbwKIox7sp7Y
         CO4v0YOMBNgXKatodejvx3PBLHa+OKe3BkUNh+jqfcGtRC26y6XwkyTNRy5JNar97KpP
         vJzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777965996; x=1778570796; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4iXsy0Ph9WfvnMeunGjXcCmD6uL8ClhF/MUxaHRVoOE=;
        b=HZY+pi+CiEmYOacPSaBjnm77djGtb3Vmm8pkNQw97sYJa55lCjMeGMThPtE36FD/Q8
         i6kUecVLyE3On99W0EJUN6LTcd079XZK05Q1QKXydnjEIO7sNR4RT47Al40UDIpVntis
         6mjJBU6ENMvKfrg/ZffQYA4PtXD0CvAVzP2RowQqetQ9epZO9Nu8+geAxVygk/KrHyHI
         viT6YhBwx5qOy+JdhlY2BIBjSfvtX1aCNPli7OR3tYaajXHov3KlypKImuKlKoor9p9w
         xLK1e9jHOJAXj1azOccJZ12yMSntYXv76gg6CrCmS2tryeWFjTpxPryw0N+6jO9r41Qo
         AsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777965996; x=1778570796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iXsy0Ph9WfvnMeunGjXcCmD6uL8ClhF/MUxaHRVoOE=;
        b=F1WPDzDkra17og782xFXUqQjOk9gC/ffn62NHTQ//M2L2SE3izdD906d0dgaiH+4bc
         j9KbsCzNcRRtqJFk23COZKPkck2ELDA/5BF1umyb7lGdpcOsPak/cDvFCfSG2Vs7mNPM
         7a8Zp0W/qmMOUOgyKkVOSyhi8C8S++Tie/iAf2bIPOilg0nv1J5kTaIxhOyDcHXLb7Qo
         yV/bgGsYfzG4LvhyLQoR8MDN8FydYcj9x8YanzKE13YRUjpB35Fxy4sQm7rSGP5QjbBc
         ac38C/32HeqOWbVKUoodfrrGrPIYXQqmdB3RH2mIL2grBOkdQC9SNW+RsgaOMy67S9So
         aaxg==
X-Forwarded-Encrypted: i=1; AFNElJ9xTD/nQ2NzYg0fJO35jQQOvoQ8vRb4L01Y01y5mRcU5m/ga5dMXL+CzqwYNzhxScT3Y7AjTQaXWcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4FIg8leGaY7wfTuwDWSNm4FkpIWw9livgICFu/pz7j+meyP+t
	kdcfqHC7y9sro3o699xx+OGvRqgabUOIVTJ+2OcGAm8G/NWm36K2z4Y+wF1BQq990kirFhH+th5
	w/mDeQj6Pg7p/FaR9U3P4iJ1HouJDWtc=
X-Gm-Gg: AeBDieutbXutz6+1rV1cm8qVcCyQY+la8YwGN/pfzj2QBanV/ni3MKrUf9yVnyZ1eWt
	rRgXxBw+VgsGLi8DZL5m8W0ES5k/TQ2WL93UJnO5Qa4kM7J53JtzOnMgEpyY7o6VAPV4Vu0BLlD
	Iw5qWTPV/L+3g37QXPi4Ivc+Rf/FpGb60i9T4ITB8IOo4HSAiPArQYW5k26rXksgyMRt3JU4/0Q
	ypM7z+I90NZbBP57HdlPJ6k6xSVPEBkp/FbMxNa957BuNWpSh5rCxnz3DLFE7N7CEPABV/jGacH
	04ZbmFT0ldFWSamKfInIP3jnhuL+jCgHLlPkgFpB1B27t0QmoydKRoH6pbGqxejrolCfUX/TNMp
	E6mfkR7Y3pA8GvVpe/s1VnASo2Yn+gPTJA5uZLP3C1p7aYPEXoB2qto5vbVk77VUGTWpP0twrOd
	xfFi8qrHoZnSOWkBMJ
X-Received: by 2002:a05:6000:4403:b0:441:268a:f271 with SMTP id
 ffacd0b85a97d-44fdc4fd546mr2867837f8f.10.1777965996164; Tue, 05 May 2026
 00:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
 <20260504-magnetometer-fixes-v4-6-a291c2a7c71a@gmail.com> <20260504160606.07f87f10@jic23-huawei>
 <afl404iaPbSsK5XF@ashevche-desk.local> <CALoEA-xkOVvGqwWdHMS3HbJSCrSbyBd4GQ2CkczkT9Tn-xO_bw@mail.gmail.com>
 <afmag-hFCs8u6jN7@ashevche-desk.local>
In-Reply-To: <afmag-hFCs8u6jN7@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 5 May 2026 09:26:23 +0200
X-Gm-Features: AVHnY4Ktg-l_VuHu7LIEmzCiXlALlcztoiAIeKQVTw2fRHazPnz8kC5FbF-FcoA
Message-ID: <CALoEA-zs+Qf8QOD6zE32Es3iGOo12KsvtAKYcd3LTQmoBwLw0g@mail.gmail.com>
Subject: Re: [PATCH v4 06/17] iio: magnetometer: ak8975: modernize polling
 loops with iopoll() macros
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 May 2026 at 09:21, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, May 05, 2026 at 09:07:30AM +0200, Joshua Crofts wrote:
> > On Tue, 5 May 2026 at 06:58, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, May 04, 2026 at 04:06:06PM +0100, Jonathan Cameron wrote:
> > > > On Mon, 04 May 2026 11:48:18 +0200
> > > > Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> ...
>
> > > > One question inline on whether it is a good idea to be paranoid about
> > > > gpiod_get_value() potentially returning < 0 to indicate an error.
> > > > Right now that is treated as success.
> > >
> > > > > +   ret = readx_poll_timeout(gpiod_get_value, data->eoc_gpiod, val, val != 0,
> > > > > +                            AK8975_CONVERSION_DONE_POLL_TIME * USEC_PER_MSEC,
> > > > > +                            AK8975_MAX_CONVERSION_TIMEOUT * USEC_PER_MSEC);
> > > > > +   if (ret)
> > > > > +           return ret;
> > > >
> > > > Should we check val as well?   It might be negative if gpiod_get_value()
> > > > returned an error..  Obviously the original code didn't so this would be an
> > > > improvement rather than maintaining what that was doing.
> > >
> > > I agree that this would be a good addition, but since it's a behavioural change
> > > I think the separate patch should be made (perhaps after readx_*() conversion
> > > as it makes it easier to do).
> >
> > Good point, val should definitely be checked. Will send a fix this afternoon.
>
> It's better to integrate it into the series either as a fix (should be first in
> the series) or as just an improvement after readx_*() conversion patch.

Better to do it as an improvement after readx_(), rebasing would be easier. I do
agree with it being added as a separate patch though.

-- 
Kind regards

CJD
