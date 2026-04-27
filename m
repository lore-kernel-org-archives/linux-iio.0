Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D66034A78E
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 22:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777329547; cv=pass; b=GYqnyujoLkEXMIc3q6oy0YyP6+ExczEEJebHfaevX7N20S89JqiKHNW/UqK94hKpYWASnsb3blwHYLE6ULOODtGf3meA1+g3hYO8uIuo/pYQf1KXF9n7Vg4R3ysyw2iGjrI5hETqV0/Y06G3nykCaTdOW6iQPF2MQUNuMq/Pu1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777329547; c=relaxed/simple;
	bh=1lyRXw2Br8iVqp8I+jWo0tncE5X7WAQeoUM0ZQ6/GT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJC9YObRgZAIbGhTibbOD4Q24pvReszXzRGvuXupWgP7PetIzOzsp3aaQw9NCapLoGnRbTF2pNcCQYAzpZj999fBJRONBvhgxQjpQ4/jHgSf23C6GZFjSR+EZlU22mvnI8DiXBp+rfDIj9grVgMycOazFFzSFnVEqcxu7DXP+r4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWZuTjM4; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWZuTjM4"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38e7d983f50so119096571fa.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 15:39:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777329544; cv=none;
        d=google.com; s=arc-20240605;
        b=V6iiobHUEUnIlK5Wq74izXuIRCGVIc2eNmWbI60AKUX7H0dbU/7yoCrKP0ap4KOfpD
         y8/bfXZIE2JtfwyJak69C4U2Hga0pqD5siC3w8xlcLGqic9DwFNSVI6zGVdwpYKMQ4WN
         appiV7hRR6T6pj8Ey81R52S1Mz4uWAd57ak4qzOeIKKYvyi4HG4DWwTSs7MLmHYp0+gL
         bZkv5usfmoJwqrtRXQNiRuuhz+AmnEYuHX8zvXjYNieSBGTyhv0WkNjWIcSotODhnr5J
         E0+5AWkUGkAVSo8//r2sUd8bkRZK/dcGk7cWm3el7fVOX5ZyrbDWG2xjcPEv7Gp4M9oo
         WQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3vYwwmAdm5UCPWDH/Mw/jP5EYuNFOTrm/hsQP5z9qgM=;
        fh=aPVIKehjSxsksT77ahjpzKWU/fsDBwQ66yMnTTp6SDQ=;
        b=TOY13fpI3x/j443BP3ujMvfHY2QV8BaFLzNAPTFrCrkw1hQunHyf+zofhRWMfxbpMz
         nZD+OfJfM+TxDpZyuBUruN9sJZHtB+DgcbBaCo6rWNJtefHM6+0OmJ87c73LwFjFUt1/
         6A6xkW+y+OTpOGMSYe4wiEHgkbds7HgpbU/5m4bQkMvIa8Xg86fpmE3OT5Cie7MLY+td
         FQwtDN8P1bwylzFsQF91oi7G0Kc4p19GWmW6m3BN9rkCSWMvkzX7ns61eZeP5s0e6svn
         Y0ADC7Bl/zks4Titp3AaLPn+uYChH6Y4C3Kq+Vfvbb6BMvSJJhw1trOrvAm3l1xjNp9x
         bR2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777329544; x=1777934344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vYwwmAdm5UCPWDH/Mw/jP5EYuNFOTrm/hsQP5z9qgM=;
        b=YWZuTjM4Cqcw7P+Y8GF1ctCxITbWKkW7slbZmfsJ7Hu1hBKikqAJhi4+KLbjvG7B6a
         IqHEoJMMlBalDPsc80f7OC9bxz0tQB1Z6EvHFElA3cp2UL0qOtm0X9uMKo4vEA3tNri2
         oNFQ/wyIy+wkUfzcGgp8bNd9LDq1PH7KsRuUMg5QxSrF6sQU41m+NZUkTKnAnUNAOrSr
         lTHusN6KpUFchZf9W6iyTS1wkJaILycazYfc8RaPH9s+XWZIpif9jTWbpMD6R794vX61
         XZ8OfhvBkcMkfEjfxOodcOJ7js4pOxRjUR9f1kATV8oBBUQpL+ZOTVxhsOEzC+ySUnNh
         E+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777329544; x=1777934344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3vYwwmAdm5UCPWDH/Mw/jP5EYuNFOTrm/hsQP5z9qgM=;
        b=I18HIaEO39uXREubKn7VOTDGWaambzsCR7dKVX12cu0SAVUT+xGN56lrhVk15BPSCc
         Dbvb60WMT69pKoEuqg46jmeV48d0EdH02WRXygkdrM4E8JFeoC9KZZJ5vxWxTozoXmki
         qD+orcho8SUrmA7OfH7/ODjzkYOeh2/sPupffUmQ4sztpcqiNeAClVVjJtts14S3pFtS
         HClzbUiiX2vj6Hz0misB6EdpWH+lutL+Zqiof+zUYnoj66KdaJrCwklnbUJ3RhzhGZGl
         2dPmrna7xTEIpPsFV5/3Ifml258knPRtoMT7sDif09ItGuSdBt3Je1uNri7M4PZ8X7Io
         wCTw==
X-Forwarded-Encrypted: i=1; AFNElJ8LBeM/MTiwlx2H0RCqFMRojQfYI0jQMqsPliR08PR+0ESqIGDjIjKw4LAQzVobT/GZKvHk/717Vgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYPNnCbxv6dRElKKtaDWmeWtwiLI9Wf1TjiUi9IefkiVTTDjDY
	twbnygEVOoPZ1NhtEozoYsrTshyoBrGElid54fDIqVMCmdhUif5+keiXHgsLZRrBQSFFI4/+k2V
	idYlGlhEjp3pRdURldsohrsBhvAvW4EM=
X-Gm-Gg: AeBDietlzlQwy6O1k+nfwW9CYJNQh9nzIYjguIbO7T46v2wlitkY3waBIHFB0lVCf+0
	/rNZGOXQ9zVh0dT+xlrLJVi50/4Buzd1EWTVoQYTx/Hfpb/8Ou2uQh/j2q/p0I06ZUmoyX0fFrI
	Q66ndDFE/pbp6Sf/Ew0fq+3/2owXt9x2Wc0WFa6KB/geH6qbkCRt9WkJyaWWPtzToOyGPD5YWrT
	xC8awseRaX4NtzyezwFW6vT2zUj52cU7FQ/X/JHTNORBxQX2KmtMorne4m2JGbAK/QqBphdAnoF
	REywCT1omXhv4R1OEmIEuioT/gxz7Tf9AFcTivMmZprBz0hOvHf8YzipFQWYjbdCuMhY181mXac
	Tkls=
X-Received: by 2002:a05:6512:1396:b0:5a2:864a:bebb with SMTP id
 2adb3069b0e04-5a74660ed88mr188878e87.20.1777329543300; Mon, 27 Apr 2026
 15:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427100950.33936-1-piyushpatle228@gmail.com>
 <20260427100950.33936-3-piyushpatle228@gmail.com> <ae9sZonxK7HTXsUT@ashevche-desk.local>
In-Reply-To: <ae9sZonxK7HTXsUT@ashevche-desk.local>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Tue, 28 Apr 2026 04:08:26 +0530
X-Gm-Features: AVHnY4L2tKQeEwjE2kh5QapimnpeLQ3gAeOSo8vfc9e1zowXkFqUOwFxPYY8pQo
Message-ID: <CAMB+xkZQS4qZTafrqJBkZZWR=M4W_L1+1WezgL=Wq8yrXL7W1w@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] iio: adc: hx711: move scale computation to
 per-device storage
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 7:32=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Apr 27, 2026 at 03:39:33PM +0530, Piyush Patle wrote:
> > The gain-to-scale table hx711_gain_to_scale[] is a global array whose
> > .scale fields are overwritten in hx711_probe() using the AVDD voltage
> > read at probe time. When two HX711 sensors are connected to supplies at
> > different voltages, the second probe call overwrites the scale values
> > computed for the first sensor, silently corrupting its readings.
> >
> > Fix this by removing the .scale field from the global table, making the
> > table const, and adding a per-instance gain_scale[] array to hx711_data=
.
> > Populate gain_scale[] in hx711_probe() using the device's own AVDD
> > regulator voltage. Update hx711_get_gain_to_scale() and
> > hx711_get_scale_to_gain() to take the per-instance array as a parameter=
,
> > and update hx711_scale_available_show() to retrieve it via iio_priv().
> >
> > No functional change for single-sensor configurations.
>
> ...
>
> >  /*
> >   * .scale depends on AVDD which in turn is known as soon as the regula=
tor
> > - * is available
> > - * therefore we set .scale in hx711_probe()
> > + * is available; it is stored per device in hx711_data.gain_scale[]
> >   *
> >   * channel A in documentation is channel 0 in source code
> >   * channel B in documentation is channel 1 in source code
> >   */
> > -static struct hx711_gain_to_scale hx711_gain_to_scale[HX711_GAIN_MAX] =
=3D {
> > -     { 128, 1, 0, 0 },
> > -     {  32, 2, 0, 1 },
> > -     {  64, 3, 0, 0 }
> > +static const struct hx711_gain_to_scale hx711_gain_to_scale[HX711_GAIN=
_MAX] =3D {
> > +     { 128, 1, 0 },
> > +     {  32, 2, 1 },
> > +     {  64, 3, 0 }
>
> I would leave trailing comma, as it is semantically is not the terminator=
 entry.
>
Will add trailing commas to all three initializer lines.

> >  };
>
> ...
>
> >  {
> >       struct iio_dev_attr *iio_attr =3D to_iio_dev_attr(attr);
> >       int channel =3D iio_attr->address;
> > +     struct hx711_data *hx711_data =3D
> > +                             iio_priv(dev_to_iio_dev(dev));
>
> First of all, please preserve the reversed xmas tree order.
> Second, it's more than enough room to have it a single line.
Works , will do in v5

>
>         struct hx711_data *hx711_data =3D iio_priv(dev_to_iio_dev(dev));
>
> >       int i, len =3D 0;
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
