Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A912DF155
	for <linux-iio@vger.kernel.org>; Fri,  6 Feb 2026 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770393473; cv=pass; b=GmH8HI4C/nxnKnekwsZiAtmE7lUJqSXLwiDnMHuvIwjoqFQfYeymkD4k3GOl+ByO2KcwO3aRxTXrXIPgtOaa3D08Y8s7V/FGox7kVWNSD/NxbLJugLKHAW+4n4mflMoo8Vv/msxgQwPzGBhgs2/BLySboZWsYKOcSqi9g4XaKEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770393473; c=relaxed/simple;
	bh=NlYvisWIJbozpJOhCZsZzFPbvAhfxgZ5LdnEW9mGfxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=so6Ao6pnSTS6fAHwVehSSiduxjbBtwi0v2FsxFgB4SQpQHYo6iwjoE6Ru/iMrqj+FBzwF7NMwJzrRUaWW2VJUYZSjz8E474IN1NEYUEZxmHgh9H2PxPXTWyYsRr+bfTfDX3HX4cUfOZUgro0FPu1FrUPSLn3aTYcZhqReCYgEsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7vuN2QG; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7vuN2QG"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8d7f22d405so333112966b.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Feb 2026 07:57:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770393471; cv=none;
        d=google.com; s=arc-20240605;
        b=bdWiDaZhzGpriO2dQxhaGA+4+ldc+Glo7uVTje1CUX+Jjf2W/gAXgc4UnWtHwHMtYH
         hBDi8cLr171bV1ATahnoRzjR0oFafhLI0dlzHPR9pZ5p7BTNDLaRO1mgjA+taoWv8b6p
         gB2HZjOmmLbq5468UlH6ZJ6Y56Omkm5Jukw+PAtX9N2hqEGs+6zEXLW5D8BdR9fSWTmE
         i5vgJI0SXquxGa+F2dT2u2r1nmFcb0L+R1bugQlcYoEe6/W+qp3Lv0LBASgBlYu15sVQ
         lxA/q98BF65KyvJL0t64VePMCDiz93Bon+kivwcS/2+arRuGsLJE/hdZi3YD7AATwivD
         whsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uWRJPxiQR7M8YHfe1tSVUyjYEd+mqMIRGwzbfU2lL6k=;
        fh=aKpY0UL8Lbq/TaBBEZl72nW1FDCsqVZ4Cdy01wBNTo4=;
        b=HLwp8R/mCuhwSGjLuoeMxXqIRinzTXmxAlqQ7JqXlXUQejWR1S3KfyB9uDMlrmJdad
         CgWc3Rt93JAF/sfAkuB+aNDoQsctWRCrhr2kjawJQKvZq/icf0V69UXo9jLl/MVskWjd
         LJTgaP401sjpzxMI8icMjaorBdm4r9MHa2s/Im0owza4rG8x2uAxgPziLKPRiYwcZiYd
         kNpGzolFCIXWL0n4/ftb6AvtuR9k5NJvxphOZw1OiUUmeSiDFNk8MngkALbzsknQSdfY
         t81x6NdvuJcUjtbJeaskL9dotXaU7MnNh8oR3WTZ4GWjlA3c5mQAPm/KQAIUNzeVum5/
         1cEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770393471; x=1770998271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWRJPxiQR7M8YHfe1tSVUyjYEd+mqMIRGwzbfU2lL6k=;
        b=M7vuN2QGsK9V79ywEzBkqU2mUdCTwR6mK8sjVa3I8YRGTCJIoawsk2XBxM5FwVMcoW
         jdJvb1BAaFbR2hvabf3Oa9Jv8CZdxw+kgnfQC9218rZAOwAgi3+JRTWmJ7S3XYovY0BH
         nWoEbYTKLfc9VzMNF5Dt9PZ4jHRjCnshItOwMmmZFq6PzkvIlYsRY8bMoXM27KX3cCDA
         zVFWWuTlOLUmn9dwbb+KKt7UZ0V5flyQpRJ0SafSauNvf0EmTzQ6EY3X0M+VvwZwCoEn
         D1Fcji6JpgLg+51sxS1cK+WsUR6+4XW/dvJmezKTd2nfFy+YfjkS49ec1btwBbI/yF5M
         x6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770393471; x=1770998271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uWRJPxiQR7M8YHfe1tSVUyjYEd+mqMIRGwzbfU2lL6k=;
        b=OANt5wOB6ow1o69O1/+7krPUe79fxt70mqMYX8HNvmDWoT+sMdwKsKLwUP5kZOSFdE
         3+kfrEAZGCTPcJLUk1RHjl+FOiZBmy5QE3fLt+n1KM9RQ+akaNmZoTv5QhjmIbF0LW6A
         hEWWd2dYPia+4H+AUQf+3FfcUKomi+5By4sQ1NFOZuos5vJLSM3G1Zvq+Hz6WGGCCX06
         i05PKKzoqwjCziYQo/+Ltw7rvrTHyx7ViOuk6/rsF04GrhSg2045fWyGze7D+aoRlP2t
         H6yxx1iauPfFrX4jBP0K29/3hpaIBOS0lZ+DdcQk/tUAs6HWzUXAn0Hx7JqIBdNHn+Bv
         j52w==
X-Forwarded-Encrypted: i=1; AJvYcCXOdgpE3V3+8Lm4P9bV3ArH4TPMXJw/Pgmj2g9C/KXqBCn1uDd+8tmSNBOyokqh1dR1tBKgdTdvtCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjJBhVLa/WLo2Alir9wZdXc3kxKLXgfy/DK0SjagLvQVrhn65E
	T3ZBfKqrBJjmdjPsRemS/TyU/XgfuFfFNAmDMXITzdHmET6L+F4fbp4v12mCGyKjwjDWpf2dMAp
	1EsLx7opJW2y23ohyE5+XqbkMyEbEQl4=
X-Gm-Gg: AZuq6aKcHPyYElIvuqEkFced3z5PI+SArIn5imkCj7r1OQIKAoOV/47FaJJR0VDvKyQ
	fomVisq2RsOAKs/NNreHLqywZdqR9GB71QnDDtf2jvBuosNWsZZPCpy8vX+DuwbQ54G7yXRDy/N
	H/t/rJXMTL+Jr4fyAVi+RVBMN0wNNs/fo8IedNpMu3z8L4CNNzoZ+tiIdR8/sKJ3fvu8RclCLAm
	flwIut/WssZ3QKj9okPUoeJ7zQvSnTlq+N+jmN9CwdIaA4MBGULGOyDmsHMkSmMFVzh3m5UDPS+
	1Fb0DoGd5ONSdtFB1eiLkMEcXzY3A+3Hc5xKcVUBzlZod764M5OOdpXNp7w+CFId8oQRLU8=
X-Received: by 2002:a17:907:3c83:b0:b87:7419:d3a8 with SMTP id
 a640c23a62f3a-b8edf376ef9mr179662066b.34.1770393470985; Fri, 06 Feb 2026
 07:57:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
 <aYXvP5FLA5BvkoVX@stanley.mountain> <aYX016NlTNkJzGdT@smile.fi.intel.com>
 <aYX7tlJ593KBDGW0@stanley.mountain> <aYYFba5-ZV8VuZHM@smile.fi.intel.com> <aYYJc2d5AwJbc_vV@stanley.mountain>
In-Reply-To: <aYYJc2d5AwJbc_vV@stanley.mountain>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 6 Feb 2026 17:57:14 +0200
X-Gm-Features: AZwV_QiJ_0xfPr8TojR1u5wvPfeBmZbrkeZJsmkMhEsu2ttoHytK2eL2o6lBhso
Message-ID: <CAHp75VdhTEKu2tKC+UKJLs1DcE7079KEbPV0NTFfUAjADBEg_g@mail.gmail.com>
Subject: Re: [bug report] iio: dac: adding support for Microchip MCP47FEB02
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Ariana Lazar <ariana.lazar@microchip.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 5:32=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
> On Fri, Feb 06, 2026 at 05:14:53PM +0200, Andy Shevchenko wrote:
> > On Fri, Feb 06, 2026 at 05:33:26PM +0300, Dan Carpenter wrote:
> > > On Fri, Feb 06, 2026 at 04:04:07PM +0200, Andy Shevchenko wrote:
> > > > > drivers/iio/dac/mcp47feb02.c
> > > > >     712 static int mcp47feb02_init_scales_avail(struct mcp47feb02=
_data *data, int vdd_mV,
> > > > >     713                                         int vref_mV, int =
vref1_mV)
> > > > >     714 {
> > > > >     715         struct device *dev =3D regmap_get_device(data->re=
gmap);
> > > > >     716         int tmp_vref;
> > > > >     717
> > > > >     718         mcp47feb02_init_scale(data, MCP47FEB02_SCALE_VDD,=
 vdd_mV, data->scale);
> > > > >     719
> > > > >     720         if (data->use_vref)
> > > > >     721                 tmp_vref =3D vref_mV;
> > > > >     722         else
> > > > >     723                 tmp_vref =3D MCP47FEB02_INTERNAL_BAND_GAP=
_mV;
> > > > >     724
> > > > >     725         mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN=
_X1, tmp_vref, data->scale);
> > > > >     726         mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN=
_X2, tmp_vref * 2, data->scale);
> > > > >     727
> > > > >     728         if (data->phys_channels >=3D 4) {
> > > > >     729                 mcp47feb02_init_scale(data, MCP47FEB02_SC=
ALE_VDD, vdd_mV, data->scale_1);
> > > > >     730
> > > > >     731                 if (data->use_vref1 && vref1_mV <=3D 0)
> > > > > --> 732                         return dev_err_probe(dev, vref1_m=
V, "Invalid voltage for Vref1\n");
> > > > >                                                           ^^^^^^^=
^
> > > > > vref1_mV is not a valid error code.
> > > >
> > > > Why not? When it's negative I believe the above statement is not tr=
ue.
> > >
> > > I saw this as just sanity checking the input.  vref1_mV is never
> > > actually negative.  I don't know if devm_regulator_get_enable_read_vo=
ltage()
> > > can return less than one millivolt.
> >
> >  * In cases where the supply is not strictly required, callers can chec=
k for
> >  * -ENODEV error and handle it accordingly.
> >  *
> >  * Returns: voltage in microvolts on success, or an negative error numb=
er on failure.
> >
> > What did I miss?
> >
>
> drivers/iio/dac/mcp47feb02.c
>   1157          if (chip_features->have_ext_vref1) {
>   1158                  ret =3D devm_regulator_get_enable_read_voltage(de=
v, "vref1");
>   1159                  if (ret > 0) {
>   1160                          vref1_mV =3D ret / MILLI;
>
> Potentially, if ret is in the 1-999 range then vref1_mV could be zero,
> but it can't be negative.

I see, thanks!

So, it means that the validation should be moved here on ret < 0 and
ret < 1000 (if positive).

>   1161                          data->use_vref1 =3D true;
>   1162                  } else {
>   1163                          dev_dbg(dev, "using internal band gap as =
voltage reference 1.\n");
>   1164                          dev_dbg(dev, "Vref1 is unavailable.\n");

But... ret < 0  is checked here.
Hence the only one left is the range [0..999].

>   1165                  }
>   1166          }
>   1167
>   1168          ret =3D mcp47feb02_init_ctrl_regs(data);
>   1169          if (ret)
>   1170                  return dev_err_probe(dev, ret, "Error initialisin=
g vref register\n");
>   1171
>   1172          ret =3D mcp47feb02_init_ch_scales(data, vdd_mV, vref_mV, =
vref1_mV);
>                                                                        ^^=
^^^^^^
>
>   1173          if (ret)
>   1174                  return ret;


--=20
With Best Regards,
Andy Shevchenko
