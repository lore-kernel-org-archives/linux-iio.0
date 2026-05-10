Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036A118050
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 00:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778374086; cv=pass; b=LPaYBibEDgl7IYzEd4G1X/bSlvMrVRFVlG7+2rL0Tagm8mLIPmdP8rvnOzyAONEaWA5Bz1XKzGMtkIA2fF7o5NiVUzTtx1qMn1qmzerUsCO1PV8XIm5M1kmi8bXzFlkYc+3iM+OyYRaQ+32eoipqIxixc5pCSF/UNJQUrO4w31c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778374086; c=relaxed/simple;
	bh=rjISoldo4tgp71kl/aN0hJPUotHDoGIo8Ve7rqocY0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INPqrynwoAgzZM6L9eMPyRyOtAwmvC0bRJKfJc9kuHzfdsf6pBmz24O+i8YXQeUqbNoJqazp28FgqryDcAISQ2LooRF91b5+8WZ/87U89xzp5UFayLNWhg4vwVc869IBojG84nFYW2x9f9KfWe0WoRF5oryX7Jy+6poN50rHAQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qhkR1F5B; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhkR1F5B"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-65c21049dafso3016626d50.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 17:48:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778374084; cv=none;
        d=google.com; s=arc-20240605;
        b=apfiqiDGVsENRm0VZYJ1MDPlxg61z1O3QU5rlDDe03zGrv/iTgJWLFAvlr3NcftsW0
         VK3iUG+QKxGBFeNWf8oh0R5vgNbq7QjWiqjhtRCL8fPpRQVVxILMKHt73FrszUrYIO/p
         9OhaF+kkf5frr89nS/iSwidvtk7ccsDeNPH8pOFs+goFIXAaZyFOogRbqmmUp+1WLZr7
         gmXjRClwXBeB2FK9ZlYhEhb2CIN7/9oiiBrw2rNtzhq9TnBrCUOzAXO4RcoDbWs8xwSK
         Dx2Nc2vk56Ulxq1PiJcdk4e1i2j5qO0eLgNZ9ExA5+4CFG8MVt/WgpIVoJ2j4MjY92NG
         alGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e8ASPPN8Ilp55fZWNPoHi/vcslknxBE7MRwEWTv1AOU=;
        fh=vWFZl4ieqViKnryBYC2DRV7r+TSY/5zoFTBctTkh6QY=;
        b=QX0odXAgtfaJJOWj/vWGIUst71U8gHG+Xn0YEUB7DBxk0b2vfKkf/WdqZ1XfWLHm/6
         DP66bguHR36H/f42125t1AUb17Vp2ZSvDiUAYV4dPNO3Hz0TMMNd59f6/RYQtmwxLfbI
         ZIEx4GtJWOCZQZE5uRxsHGdzkM4Nf2sQGfLFW5NqhUEC0KQmzfWqE6WKDLJL7V+EnPb2
         59w30VM3RHqlxMLrgFYKzGI3AIl8r731EwZQzkLVK/LjpsURlm2QBMy5PFUJrX6lSeVb
         XOkfXrWV43xgpAVuBUpuU69f+7hWtT3N3Ue8syueNFZq1TZGAuEe9R4v9ChiWtgL8cnn
         sNlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778374084; x=1778978884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8ASPPN8Ilp55fZWNPoHi/vcslknxBE7MRwEWTv1AOU=;
        b=qhkR1F5B4w8sLWjz1qf/plWdjtL7JMRxWoYrpny9zjlFCeRwc38Si/uTz4uBogAGIc
         tfFSOngTu1dXp6BnNiNTv79HSKlrXcgUfP6CWYR92129zim//istngJRa2zNjB8/kF4W
         qtMEfNYc77ZdvvqmDmoyrd8Ii9khOPK1R8Er9iO4Y6UAsRS5R7KbNWxCmMUWVVrQIG4g
         clI63pK343aTAjMDuk4iEnG29blaVSJuX7XoYviT+McTlvRSbRrnDTIAKN6utfrIy3ID
         QIVjRp8+LialV1vdAEDkq2GXXO7rsgjzGiHNCpkdGS7E6Rw/iUZsQC8RrP7nGM/bfZAc
         ODEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778374084; x=1778978884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e8ASPPN8Ilp55fZWNPoHi/vcslknxBE7MRwEWTv1AOU=;
        b=ML9PVeCvmgZGtozjlSZI5LEUyC0oSI6qGSuri2mku2FrNbhHvEiOo/QvXRPPlyry0F
         3+FVMmsydRDo8qhBGKkpzwedGSZ3bChFmZwIA15647TEazIf2/y17FSHTMSXWV5auacH
         JK2xj/pmXhJMitHGO8wmioonpIua3mOWxeGPUY7AyzXBr0fR7kIJBJ2rAgW10PiR1+or
         AMXa70R4ZiB6Mqes+xbGimUF+0Vxrdn9LbUZDGMqMo9tTFn/tQ2UKn8ELxdRhNlyYG3p
         kVgSYhlVnxVJdN17UkFZQrm/QHB+f246SOkIlaOVkoHGeS3g8vKvCcO0QpznHUAxfewM
         2DsA==
X-Forwarded-Encrypted: i=1; AFNElJ+vu82RUCFHhOzg003IcnFH8b/J8/pwbP+PZTeJcrPtDsTHKEMl9sD5fcq4GKKAOcmf4VZQLB4pLIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLSs3o8KCGkfnCYW0RLJfcdkp8kRyug6BD9HEXBWa2m4WxhRV5
	nFiAHwy7wt+W3xxoGfmxSr/4reGgaA8he6a9LSM/b9eC2OjNiCXvLlJ+UJyepqA9e0JjdqZWNHS
	ES0EM9hak26APQXP70rjkXk3f380Vl9U=
X-Gm-Gg: Acq92OGmLNZRXtn78jCzMziYmmgPEIDxRSN56ki4r/VcMEXUWdVhQDadtKN+sEm4JIW
	lrFCzWOe71sHTf0L/9yKHBsY0nWA5qvsqpDQha9XbHSZElE3DJ2ujjnVs2mMpffPQzm2gu2p9zu
	QadJt669ZxnqSmtn+AukIQoMOQesW5K8ERfyW2QGHIXAMnYXre1+a6MHELvUtvxUYDA7b0UGYhL
	HwqQAzdk8CegQ1WX4hUWjmberpB4dccCij1H4FvMALFbzNv6WJWS1q7/6w5zHEbpUUIGZm1eC5r
	fJ5a
X-Received: by 2002:a05:690e:400b:b0:65c:3188:4453 with SMTP id
 956f58d0204a3-65d94afde3emr7861126d50.6.1778374083932; Sat, 09 May 2026
 17:48:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509211921.84969-1-m32285159@gmail.com> <f7c6c9c6-c5d0-446a-bbbf-6991f6994375@baylibre.com>
 <CAKqfh0GXzfUMhp0+-BPpQ3ra3H5jSKUU0g5RnAtKhP88RDocmQ@mail.gmail.com>
 <f3030dd0-123c-4b3d-8b65-148058dfd44f@baylibre.com> <CAKqfh0HUttZhhC1ysiA64rxMztBvfuu+d=m2C8TrnCUuWzT4Gg@mail.gmail.com>
In-Reply-To: <CAKqfh0HUttZhhC1ysiA64rxMztBvfuu+d=m2C8TrnCUuWzT4Gg@mail.gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sat, 9 May 2026 19:47:53 -0500
X-Gm-Features: AVHnY4LlAshV-MuBisxriXW9n9Esx43onFvI9L__Q4DWRguFiq1bIVPj1vttdVk
Message-ID: <CAKqfh0EfaVqUPbhWZ4hVX_mFUN7_CVwir1sAHrR_LC=ZU7fk6g@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: scd30: Prevent potential divide-by-zero error
To: David Lechner <dlechner@baylibre.com>
Cc: jic23@kernel.org, Tomasz Duszynski <tomasz.duszynski@octakon.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 4:53=E2=80=AFPM Maxwell Doose <m32285159@gmail.com> =
wrote:
>
> On Sat, May 9, 2026 at 4:47=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
> > On 5/9/26 4:36 PM, Maxwell Doose wrote:
> > > Yes, we're reading over either SPI or I2C, the sensor supports both.
> > > Hardware failure is going to be the most likely cause of this path
> > > being taken, but I could also see some sort of noise on the bus being
> > > the cause. Perhaps we change it to:
> > >
> > > /* Likely taken if hardware is failing or noise on bus */
> > >
> > > best regards,
> > > max
> >
> > Sounds OK.
> >
> > A more verbose alternative:
> >
> > /*
> >  * Value of 0 is unexpected, but could happen, e.g. due to
> >  * hardware failure.
> >  */
>
> Also works for me, I'm impartial to either. Perhaps we can see if
> Jonathan is willing to change it during merge or if I'll have to go
> back and change it in a v2.
>
> best regards,
> max

Also maybe we update to use dev_err_ratelimited(), sashiko has a good
point here:

https://sashiko.dev/#/patchset/20260509211921.84969-1-m32285159%40gmail.com

best regards,
max
