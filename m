Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E318B3D1AA0
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603520; cv=pass; b=CY7hRkoZXpsGzjZ0zGuFJlRgLAaXrEoK/ik9QhndGzsqRN9ldg/JXSntQmIRQJX0YprC1cA6KsM25+uabkIQJld+j+PEBxxH46GZ8KG6rfof9kLlu21rY7QFmu+UmGJ0JBedZV8RlJMx6PnEF+JrUORtvxUo7/217Nb1cTZydFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603520; c=relaxed/simple;
	bh=mH//tM1Tq9RldE3FZYlmlDWKdTcRpKsQMst3NvX0SEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svp1rW4oSqCl9ap6S25kQBRYuY7wzSfwLUZcN+M7nW8IseeUpx5IgxTiWZMg6g0U9cLhhra6I0Qx3GY/tRQex8asK3vDoLgkuowFjXgyKNqZFMdyk7ly0EwU4sKLD2KRjRgTtqUPe4EUSGSLZHB33F6QdSa0C6zE8cjMj0Wjel0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbGua95/; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbGua95/"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2f0ad52830cso8398647eec.1
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 09:31:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778603517; cv=none;
        d=google.com; s=arc-20240605;
        b=TV6AitvL50FPJCu0vaFOYCwBQh2W5k0vb7uKnVlSKBiacGVbaUWGJ9qi7UrB48HUKj
         QNC16hstZQiknYH/ItOXXVm53QuYTlR8SU2HYszfKj4/RLVXfgsIqNX/wq0Tcrsrf1hU
         IcGjk+QlstLYNkE86XabfyiD/WrtQo4jCCRzWmx59KW0/2YeSnSkVQBhN1KzTZRUPItr
         wlXai8BUTS5LU9XdTfWa9tO0rtfzQydGeugmSPeXO3EZt+te6lXVZSM3gcl6fsBVPNYQ
         bJqEXyM3NJe82KOuda/FUWyEBYnQC9ff5aHDAdMW6OSU/g0r4yh7fLEnl1SZ1LDwK1kx
         mTvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mH//tM1Tq9RldE3FZYlmlDWKdTcRpKsQMst3NvX0SEc=;
        fh=Mm4Irq/BuRMpFePJh5AmZjPNwYOpuQwIfrTc4pv0cTE=;
        b=CoSKMPvFEp4StJxGyry6j2ctt3b3fDbOmuRwtYUP/+9V8Mr36Fpjd+VlT95KSOohLg
         wCKvUoYqWAh26zw6UnuLZHEowadzpndgdDhlT9y7CspYONyvROTsQ2QTHxOZ9ttQX6xG
         0rZ/jFQFj1iMGsg22tJP1UiDnFpZQCXsfwA5XS2SrS7eAEzn1zUNaiinteoAS31UMiq4
         y0GJexT7vTmUpEkYGkeft7GN+EQp4Yy3658tSy4bJDaa+8Mf91yxYrjl0dJyUTSdClqM
         BD7xWcqZZC+iqz19xPHfUSIRas5NXY0ogwSWe1W41BZK7P1C5D8trwT9diMDdzWV+q8Q
         Qeuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778603517; x=1779208317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mH//tM1Tq9RldE3FZYlmlDWKdTcRpKsQMst3NvX0SEc=;
        b=gbGua95/d2S3UD94aR8bTAcpoJ/h4xLcx0CSvIY020fo+5au0bOlS2xXABHNggb1Kk
         fwKmLNOXY5g9NFDNl6zppyxMoCtwT8M5+a1gAopXMT/lAHWohBUQzCX1NDoJJvdrDA5F
         8XlfQemqusrQvxhnqM9ZoA70jlVUZzzO1Or3bVnj4dpXaREbcENdZaKqya+yzOktiect
         S7Vdbzfj1Lr77jcaDRg26KTT+vkkSwP9u5pJNWPiNrYNJErr0V5yj7ThYQ5e9XQC57TP
         L1Pqwbq4AnOvxjdHxuTWVZJCjzfwkjiRKOj9PBae6yZUR7PpbkyxWlSs+RKxfydgAJfK
         ykgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778603517; x=1779208317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mH//tM1Tq9RldE3FZYlmlDWKdTcRpKsQMst3NvX0SEc=;
        b=E+cf4hcWySlJsclvAu7uSDMw0aQfLAUa33LoyTKJbxgJ4EphMv0pGawJRw89+u0Doh
         qcgKizN0BSvqjA4HuoAZf2JG0yxF//mfAX449Z7pHjB8XgfujCn8EUeEtTxBfY17H7o2
         Cy7WDW0coei3I2ge/in2Keu847cmITntQr/+PfAye5Omlyvw8xtG4ihVJRy2AMfnVxQX
         oOHSkNOrriMhSdOrt56pliymxkyEL0otgbhIlMmiJ7m+BGKvAuEDpt1dxuMxby6GhLWL
         bmamADEXwiZRITfgqkFNmccGmy8dJtZuNO0uTN8g0DJJbXus5h7jOujueeQqo7ZExffW
         Ajlg==
X-Forwarded-Encrypted: i=1; AFNElJ/dyo4b1zbrBqYsPzGiMVmxn4pKd1YmasQzo+8ybnCFglQAaIcNU10DFGn1XrYTiKGh38BN5InIPZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsxv+v0axyigM10bCHf3lBmyelrwyfCPqn9dNPDRvjuIB4oK0x
	5xh4BfP5TEvTyO833NluCxMucrUUMTmAZQu9Jn37cioONUkUrWvi4NUgQgLJ5fXM3CobH3Vaww5
	sOYScqAUH4pzUv8e72q8psjOORMAB5n0=
X-Gm-Gg: Acq92OE1LMm8l1VZ3PnqrBsTAF09ktEAMyxta0gLAm7d/Hwyov2pQpFAlFO9iQUaAFM
	9f4np+qAZ3pQ2kiB+f0+0ThQwga/0WzmdIwm8MQ+RbdAG0dNOAXGIrP6Cor3dw5NmdYFXCfyTi/
	DTi8CIy6D2qFCHHhk2s6Pzv3dIPDKiSE2FPi8/cjlTJweNKhiUgbvon6w66XzYDN4w62GBi+CIW
	Q20mwgUFVFh36O4Agdr6xCuPTFpn/NQ6MoM9kQsW055fktGS7YqeKdFpmbeksSVUXnwRgo+0OKj
	XJPWgJCk
X-Received: by 2002:a05:7300:2317:b0:2ed:e12:376c with SMTP id
 5a478bee46e88-2fb5ff85718mr6857994eec.34.1778603516847; Tue, 12 May 2026
 09:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511171255.9668-1-abinashsinghlalotra@gmail.com> <agML51XAy3kSGhpa@ashevche-desk.local>
In-Reply-To: <agML51XAy3kSGhpa@ashevche-desk.local>
From: Abinash Singh <abinashsinghlalotra@gmail.com>
Date: Tue, 12 May 2026 22:01:45 +0530
X-Gm-Features: AVHnY4KABazzCHgHbci2KPH9ABE0xo2esGDhzuW932bOuY0AKY0n2jSPsX9g1tE
Message-ID: <CAMV7Lq4=myKac0hZk=-W4ibjMUwqvCh7LA7KL=QsivHpdtOSXw@mail.gmail.com>
Subject: Re: [PATCH] staging: Documentation: dds: replace frequencyY with frequency
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, gregkh@linuxfoundation.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Abinash Singh <abinashlalotra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 4:45=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, May 11, 2026 at 10:42:55PM +0530, Abinash Singh wrote:
>
> > The documented frequencyY attribute naming is implementation
>
> I'm lost here. What frequencyY? I don't see that in the patch.
> I think this needs to be more specific. Can you rephrase?
>
By "frequencyY", I meant the implementation-specific attribute naming
used in the documentation:
"/sys/bus/iio/devices/.../out_altvoltageX_frequencyY"
 where Y represents the tuning word register
index (for example frequency0/frequency1 corresponding to FREQ0/FREQ1
in devices like AD9834).

> > specific and differs from common IIO sysfs attribute
> > conventions.
> >
> > Replace the non-standard frequencyY attribute documentation with
> > out_altvoltageX_frequency and document tuning word selection
> > through out_altvoltageX_frequencysymbol
>
> Missing space?
Thanks
>
> > This makes the documented ABI naming consistent with standard
> > IIO sysfs attribute conventions and clarifies how tuning word
> > registers are selected and programmed.
> >
> >
>
> (A single blank line is enough.)

acknowledged.
>
> > Signed-off-by: Abinash Singh <abinashlalotra@gmail.com>
> > ---
> >
> > The out_altvoltageX_frequencysymbol and
> > out_altvoltageX_frequency_scale attributes can be added
> > through extended channel attributes (.ext_info in channel_spec struct o=
f IIO)
> >
> > Feedback on this approach would be appreciated, and if
> > there is some other way in your mind. I would like to
> > work on that.
> >
> > I am also interested in working on the sysfs-bus-iio-dds
> > documentation and the ad9834 driver. I recently bought an
> > AD9833 IC for experimentation and testing.
>
> I didn't get is the current documentation wrong or is it that currently
> used ABI is wrong?
>
The current ABI and documentation are consistent with the current driver
implementation

But it uses implementation-specific naming using "IIO_DEVICE_ATTR" ,
such as "frequency0" and "frequency1" for DDS tuning word selection.

As this was in staging. It may be because it is not aligned
with standard IIO ABI naming convention such as "out_altvoltageX_frequency"
This is what I observed. It may be incorrect.

If there are any other
reasons why this is in staging ?, I would love to work on that.

And from Jonathan's reply I realised that I was wrong about
/sys/bus/iio/devices/.../out_altvoltageX_frequencysymbol


> --
> With Best Regards,
> Andy Shevchenko
>
>
Thank You very much for your time
Abinash Singh
