Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A939324B1F
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393544; cv=pass; b=GpSsw6lQlAVHGnZ8QasUnzhJKeyXsADb9Ilm0V6p8ePUTBBPiHF2jPjEpEXmWdtq/BaRUB0I5DRQdnMnfuhvZYGBVysmi/uGB68QRIQXc3nqIFL3JuC3l0OLNvE7qki7iBtkFsCQc1PDjiGw04Eq87yAgv8apPfQt1xP/IAMGV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393544; c=relaxed/simple;
	bh=M5Kj7eqcnnbnLkjkgaSIa584ocZpcapkTyTet88qdCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RowOgQ86RH3K1crOgHuWQPja24vjeUoarJj6U4zEKP+LC4zIKtGT5eAMtoOin83Ue4yOGPa8MXwuZK9xD5JaQ3Im4IGaihaHeePZP22kfbmTPDDArZQLlpHZihwErSeZU8VHtKLWAH5F8ifTOaa4+JPxprigN8tcw3l/lNV7K0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfIpkLYy; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfIpkLYy"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so7534870f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 09:25:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777393542; cv=none;
        d=google.com; s=arc-20240605;
        b=HbYRWkq2XH0Oog1mcGPfGUSLx6h63SC48pHgFgY3slGd9dCeHL+OJrzJzUJzvF52YX
         ycpVGqABC3emzVeSEcPJL1XRvDrlzhWYs8yKuoyCzEzRPte87uwKkaHl9RkNSTXPSTYZ
         tDhpuU65yJ1Dy3sBNxU0vAXZ9KfLZXkScjWhTh+4GsieBViUZQCVHgDEns699UWyRZkZ
         OUosYE+9ovgi7rYIkofesWTCbXIYVNhIP9AMLWg6OaVFJcgSaopNMNeNDX4kDeaBG9wl
         ihElZgP3F08VjUHbiv+SbH7/eqoM9UNeRzrhh/acIDk4r6+cssc8txseVkUNCRofXtnt
         Mojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BdCEX629QnqIZaQJJjnbOKLxIYa8nF0kI8teVZYPHts=;
        fh=pP/JOSotyOJ8MPvYc4YidqTvQD54pwwtbwfxk82giYM=;
        b=iq3tw++NAFYcpdtkw0HZtBgie/5r3rU0v2R2GkJqzhS7P8m/WiYWTGmqSGnBdDgf+t
         /fiKnFXdC079vbLPxVSA9BFl9zeY4PHaww5ojmxTflQUGjU8R52LkCFJMQyHPbX1/SyT
         +bqv0KXcPPHBH5x5Fdjt1rE/CVAxTIfJ3sixfRN6+/7MzwX6Vz9AgqQZ22jX1ui1VO3q
         Sc2ot/0Wqoa0eH8avU8xbCNMD4GkA4AFbEFHnXbH/CbO0YK7ClpIgUFzXM0rDQKN93qe
         fSMHnQXKyCmjNlNif02yBAgIRC8HDm7kuCQLoUYAOJ7yMRFtBnI9/qKSkXdISXH4UpLc
         EgFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777393542; x=1777998342; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BdCEX629QnqIZaQJJjnbOKLxIYa8nF0kI8teVZYPHts=;
        b=OfIpkLYyn9m+E0YfBHbE6YuBK5T0agMxDuxrIAUFQvbxr62u9lh7waTjAz4Gzq/2kp
         k6iwOTFeZWdq7+993OgVroymEqwQSGGI5HytcEExhZHpE47tAq33XegW7H/yVEkPqTF/
         WCtddkAG7vCDPTvww0HHTL2kQ6F6rljbYwI0J0nb5Ic1cErBpQ3pPLjWqFWyph5+EiaH
         ARSomZbjxpiMa3/o7blklqlAiqmefA8VlMH2xLNkOvyFFhkP9is472MGLDzfNtDFWaf9
         HnXR0tMvcJGyyVB4r+NanG7+GC30FhXF3z6j/mio25JuO2D8BTKCfG8QP2MmaGCayZ5y
         zfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777393542; x=1777998342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdCEX629QnqIZaQJJjnbOKLxIYa8nF0kI8teVZYPHts=;
        b=tHdU6VC4eFTxMq3AY69BFyGMKH5mYLCjKxRUp2H4UlPiCGQrzh/9QW9VJYYs8Vga7z
         bTgFUf1EKCzrc1j1f+Fv5x5tgEEMFuWPuN42SwA95cScNBiIn4uCQDcA8BA6TLjRglJW
         tiVI78cCtCCw6CGwrcrRzktHMZJPFgH7xy9SohHaEbENMp3ava1rEJtZyS/TWQnDR1ow
         G17sIyAsiFwup9ON7o9rv3Xm5adNm5g8G0Bp8VLJwKfE+lQJCwmstsfB6TMCghGXp35o
         dcIABX5QQB26a8316q1ia2DVTKaa3P/2gnTKzfUlJODVWGy4Rk0q5qGlrfmu7Cw3DCTi
         QF+w==
X-Forwarded-Encrypted: i=1; AFNElJ9sKtpXV5tgN3v4H/uaSJGJROoP1Wex5n+RWusBclStsHamPpYqxNyPNkIpM1kJ18q2+F0UaKDYHX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlHH+Nv+DaAzhZVeHpYcsIEcBqFOnJwQizIn02EGhY9x8nscfg
	AJkEKfk6KQc3tqDeINrW5pKvuaP4rldbpFZDXQWF7BOVba/kmiZUielc1UWWx96sNZNdfWy/MVd
	CPnM95ebwVf4qKrjP+plnt4dhwRQC2zg=
X-Gm-Gg: AeBDieuc7BEikn/OFuUPsRIPq6jYpVxengfmqWSjw/roqpn3UhizwHsagEMfzM75un8
	JshXnHqkefuVimD27/ylJTN7sbnwSyzmRms1N8GI7ZbrUg2ciD1bTBqCOkV4EqhvydlLsuMu5Q8
	L3F6X8tuiTvmOcnyONuk0jTojMY/yGBEhqAvkY9dPkeW4hOcSJA+76iJT9eVQ+M25PkBPNHryF7
	rgMiv/JPJ9VXaT7QMtkVjlL+yEUCm1mjqOmrgJCXm4tFKX+f/8oNC8aQJyD4ZAzjUS2/otl/Ztx
	nr/D5nSNenFFZHYIwup/lN42uHwzND3n0iZs58tjBVKFmsGadx0PXAdJoTLGQMGt/JhgAe+zsBc
	XG0FTz8Xee4BgITAELBxSmrKTJJMhAmKdbErsNr/bjJH6HDDjbplr6U5ECR73hcTGMUH7uN38zg
	ckxnQveKtpJTJBUVmCYmSuLyh2q/fk9R6hPznHgpXQysvhrx8MSS3By2bDG0/n
X-Received: by 2002:adf:fcc9:0:b0:441:1d53:cd9e with SMTP id
 ffacd0b85a97d-4464b2ace50mr4335077f8f.37.1777393541676; Tue, 28 Apr 2026
 09:25:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-si1133-checkup-v2-0-70ad14bfefe2@gmail.com>
 <20260428-si1133-checkup-v2-2-70ad14bfefe2@gmail.com> <20260428161203.36575c71@jic23-huawei>
In-Reply-To: <20260428161203.36575c71@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 28 Apr 2026 18:25:28 +0200
X-Gm-Features: AVHnY4KFonhWeogdFlLKdSC_WwkLCAqsPBUJiZTJJWy2cAoyNx34tZlFADZif6E
Message-ID: <CALoEA-zJp3v9NS7AeBOwK-CmWYZzQmcKq3R03oheu06VbUyD-g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] iio: light: si1133: remove unused macros
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Apr 2026 at 17:12, Jonathan Cameron <jic23@kernel.org> wrote:
> Don't update macros then remove them - that's just increasing
> noise in the update patch. Reorder this patch to be before patch 1.

Yeah, my fault, I forgot to do a rebase.

> >  #define SI1133_REG_PART_ID           0x00
> >  #define SI1133_REG_REV_ID            0x01
> >  #define SI1133_REG_MFR_ID            0x02
> > -#define SI1133_REG_INFO0             0x03
> > -#define SI1133_REG_INFO1             0x04
>
> This one isn't in the category of things Andy was referring to.
> It's a hardware register address definition.  We don't have hard rules on whether
> a complete set of these should be defined, or just the ones used but it is definitely
> acceptable to just define them all up front as then easy to check them against
> a datasheet.
>
> >
> >  #define SI1133_PART_ID                       0x33
> >
> > @@ -40,7 +38,6 @@
> >  #define SI1133_CMD_RESET_CTR         0x00
> >  #define SI1133_CMD_RESET_SW          0x01
> >  #define SI1133_CMD_FORCE             0x11
> > -#define SI1133_CMD_START_AUTONOMOUS  0x13
> Similar for this.
>
> >  #define SI1133_CMD_PARAM_SET         0x80
> >  #define SI1133_CMD_PARAM_QUERY               0x40
> >  #define SI1133_CMD_PARAM_MASK                0x3F
> > @@ -86,13 +83,9 @@
> >  #define SI1133_CMD_MINSLEEP_US_LOW   5000
> >  #define SI1133_CMD_MINSLEEP_US_HIGH  7500
> >  #define SI1133_CMD_TIMEOUT_MS                25
> > -#define SI1133_CMD_LUX_TIMEOUT_MS    5000
> > -#define SI1133_CMD_TIMEOUT_US                (SI1133_CMD_TIMEOUT_MS * 1000)
>
> Dropping these and the one below is good as those aren't register or command
> defines. This last one is entirely pointless as better to have the rescale
> inline and only one definition up here.

Sure, I'll send a v2 tomorrow.

-- 
Kind regards

CJD
