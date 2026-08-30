Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE33B1D89EF
	for <linux-iio@vger.kernel.org>; Sun, 30 Aug 2026 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788116520; cv=pass; b=j4aL7vxLqTFmrhzGg5ww7PncNCSqiAU+FxOD8Z6H4dtl3Z5IRlWAtnsAGubRWa+gSVWs6c65HZDoh2AicMztNKd3HKDU6c2mn8gdfHTQhkB0j28Ob8+pOthPwqJVGhuuSm6H+PNRLvMcJHXdwZoAy4100eRPCMCRIhEolWBiFH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788116520; c=relaxed/simple;
	bh=Aw69XSiWbGpFsFLtQRZwB1RWfF9glV45DFF9AfI7qow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIqgE7axRAFCfJtwwo3YdMza7JFB/GBPtWtwPiFHZ9Q7fLA0E2GWea4XtWhFr5+aHXOlbUPnFqifaGgZyTp//iAJhqSLm7Ns2dGY9qeU05wCEbW0ykM8iEURMJcOMCHFSj6KxlHlzPyJxYt7KA7aSJSu2cLgfqsvZ8eipotnlh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mI1vRdJk; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI1vRdJk"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aeb98460c6so3737443e87.2
        for <linux-iio@vger.kernel.org>; Sun, 30 Aug 2026 12:01:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788116517; cv=none;
        d=google.com; s=arc-20260327;
        b=Yjv2UyGWLG7i58UyfieuS6cKHVNN+Uk99Y/Sst0BU0ROzSu/hddwDZY7VH3V0vJfGy
         Ldmm/TR3FaRRYgwWvxgM/byGjQJGDY1KDRj6GWGn0pm22iC3fw7j1cVlZ7nfVxk43rnA
         Gwps7OTRUUK/WwnDVfVf5WAeFSBCzeiaPdhOZUZ9pjn+tO6BcEEo1DSdWoZZO5iwo5Gh
         GH7lfl9DUy7JHmjW5s9reUUEgVo6ezvPqF68XEdNeceAb5gMzNiTrFLvx9861aBZEnQK
         iltAeVNKtVn6WtFKCK1iwDDB6x+3nWBmDl4kqBEWHucYXv+S1gULXB2ohqmvl+PngHNI
         VGiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xFCHS9y+rltPZAUUGlotlTizcT/cuz/3d41GnzmltgU=;
        fh=WFkmuZM7OIjI+fSeuseGdqQLR5WLoQZLTCLTIWdddr4=;
        b=YBcnhG1Y4U+INMtXJfD6FwzLLQlIHNYR4f1GghIk7diQROSMNxNKna+8/qxJcPpoiS
         vnqq21qRzufx/QEzBHqfxcUdcAju2dOLbcK045J2jWmAbe3lzCmCarKbdCOLw4rfVYYT
         VVZfHj4efjxVQTcShk1a5saNaesfLROKBL78gADQ7RxhdKfAX+XATekXrEo3mix6PjqT
         A/wKG+EA8pIskbVNWEpoRRXePE6us/bcyEadgG9sNY21oQ3FH0Y0Ks9gbtNGQzEnvnxr
         sHl2UfXOtWzOIMgZd/7YE17yg+P4n8EVWN83plhWIcGaG0a0WtzIac4DV7DsZ29VsT7H
         R73w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788116517; x=1788721317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xFCHS9y+rltPZAUUGlotlTizcT/cuz/3d41GnzmltgU=;
        b=mI1vRdJkRcEVtShqqwSysrw4htE3t/TS3UrqNGsOxMyEXBXMDbaUsjluyHFinjUU29
         +8qVGWk92eKV2b/BBheRf08VKjj13bBX4JdmV4VMOKs+Uojit/vKky4qsZaWkB777ZgM
         LBu1NXhJtWajL1J1vevS6jK/HGEi032F5S7uSUqa4+czw+ZK6wlcMavjcCPmOEHU7Ac1
         u51klvbQ1EZlOyf1EQKEn7Zlap9m7dP/ezw9rC36/p2rffji6F/GkLBp6Ix3iVUg1enE
         3EQR3UGkkzu3S+et1eb3s3szYntcSNYXxItJvHyLRAQMEceYUDldOWpf2M9161E2B1nQ
         5yUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788116517; x=1788721317;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xFCHS9y+rltPZAUUGlotlTizcT/cuz/3d41GnzmltgU=;
        b=iym9nPwTzWa5U/kQfFNDAwrNY4hU4trnO0LO+b+Nm58B5OjRyark34r6Kr5qvLXILP
         fuHliaxJpXhz+dcpZo630v4oDqC3lN0BkKMPtuUryhmyiZP6sgrsW4x0gLEfmLxi3Tup
         CmgSY3HQBqTeFvJztb73x6bBMqfPmVqLF69AQwtOjAENNxbZcWXW+HSp6xd/NVTh+fNN
         qUBBbDdH1AgPsFb5kz2MkUKHOw3vBzZcwkX6Vsua+eFq6d0IXDVhV21TwOOTle8NUc3F
         9b9YrKwLh8d3v7qd2itGpqvbQ95tmVoL2WM6eOG1ZSOsDmpey2GSQzGLOoWcBgKHwz+k
         G8hg==
X-Forwarded-Encrypted: i=1; AKwUvByaprfCZ9mtkr79USnymYXSQohWIz9et1lhl3S1ffaeqmOKjH6tsbw6Vw49vPZV0wMAW+C6qMJ8A50=@vger.kernel.org
X-Gm-Message-State: AFuF++k6I2XEyeuvuhPdofxNiBX/GPf1LEDg77A9gt3luUzj34ggpg4C
	+PXh/U4BXhecnGr6l2JBdhkBLyK9uR4rdtVFwN3Z65R8J5Ztkm7BsjB6e/Gb6Quq92F+BNedUFp
	1vSRqbc7o5vBd+z4RiBcir6YqZtnAVA==
X-Gm-Gg: AYBFou3smKtiafUayx7p9bc3LInHDVCsjOIrnsT/l86t2YuptyB0OYb6klB/2gt1pJr
	Sv59nRtvrAOQ02s7Bfo+AtlSY8caKPAhe5Z/1l2P6eERIUGUvSZXPgOVm5tuPcQfHc27uxVIsQO
	dkuYtmrOOB/8Pwy9IxLnqEEAKai6CKmPfHnORtsRyjJOzfps2/qza9LxwseRimygHaqUQWM1UjA
	JS1W3Tbwro4FKeYLJz4CU7fbngYZVv4Z9LIrsiOAM4gLbTR3ABe4JuVCuXLACzg75I9BjLVPy0R
	jJnOyzilcqtSglx0TVRBKcViPAPPE1jxtsCLld8158/jqRwCyUGE2nMjBw5CsBU=
X-Received: by 2002:a05:6512:4605:b0:5b2:a6e6:8d83 with SMTP id
 2adb3069b0e04-5b5e6b07d24mr6613988e87.23.1788116516570; Sun, 30 Aug 2026
 12:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830054237.2147950-1-donggeunyoo.kernel@gmail.com> <20260830174116.36fccbdb@systembl0wer>
In-Reply-To: <20260830174116.36fccbdb@systembl0wer>
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Date: Mon, 31 Aug 2026 04:01:43 +0900
X-Gm-Features: AcwNN1V1FvmhrwbE6PvSdYFPuLz9cA0AaGTHVxRNN4ZJggNHXTVHV3ILC6479Hg
Message-ID: <CAGdSRjkCaEKCcwvZaE+V_jFXdPATJfa0MAW5fybyKU9+pFHGbQ@mail.gmail.com>
Subject: Re: [PATCH] iio: light: vcnl4000: use sysfs_emit() for near_level
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> You should also include <linux/sysfs.h>.

Thanks, added in v2.


On Mon, Aug 31, 2026 at 12:41=E2=80=AFAM Joshua Crofts <joshua.crofts1@gmai=
l.com> wrote:
>
> On Sun, 30 Aug 2026 14:42:36 +0900
> Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:
>
> > Use sysfs_emit() instead of sprintf() for writing to the sysfs
> > output buffer. sysfs_emit() is aware of the buffer's PAGE_SIZE
> > limit and is the preferred helper for sysfs callbacks.
> >
> > Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> > ---
> >  drivers/iio/light/vcnl4000.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.=
c
> > index 336468d59ea7..dac235dd6220 100644
> > --- a/drivers/iio/light/vcnl4000.c
> > +++ b/drivers/iio/light/vcnl4000.c
> > @@ -1504,7 +1504,7 @@ static ssize_t vcnl4000_read_near_level(struct ii=
o_dev *indio_dev,
> >  {
> >       struct vcnl4000_data *data =3D iio_priv(indio_dev);
> >
> > -     return sprintf(buf, "%u\n", data->near_level);
> > +     return sysfs_emit(buf, "%u\n", data->near_level);
>
> You should also include <linux/sysfs.h>.
>
> --
> Kind regards,
> Joshua Crofts
