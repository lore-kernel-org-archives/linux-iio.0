Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44EF4F055E
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892445; cv=pass; b=e8ZnoPpXTvxELGknEECzPa14u9ur6YXYjve6YA3hTtZGxwOig6ovqxfMAcuQyUMtPNRVHny/eH4ZeXnRj9J+ab5qAoIDhMlCQIIcDz3jFZfkqd+NV2YkAeJct4w86HUhuOu/h7USoEt5NdoO7jliastW6rZAW4EJEzOaBfVNbqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892445; c=relaxed/simple;
	bh=8oEKiTeBHaTRi3F7yMJ7yENZE8ADE+WNsHJTSee7X4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGRqROFl3CAiEZHx6hMapz31CJ8BOZx03+C9OSOX36FUQvIF5swf41Qy6GcWPrhqNK0UD8O6OoJH3zJhKgeMBSRSk1f4T83+4fOwA4XYt72OVYzv8zAkj+pXP2vtXsnSCliXt0WQISD9c2a1lcO7/h/jQbfDu5rSunHI+ybBsCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwmVGgkK; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwmVGgkK"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48c4be28b82so2790084f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 04:54:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791892442; cv=none;
        d=google.com; s=arc-20260327;
        b=BtbjdENA2BCWGx4ejbPFzdUiuZ4mTka1VkF+XEDGpOAbhPLB3Fe8gGYihhCPjT4N+g
         b25cRoF3zcDM/kbw+atGCSQjjs2fo2JcEcof7cqOWpnoY41wgHCumqogj0nw/Ji5UQI3
         +Kkn5xOquPOw1Df1as98OdI5hAu5KWi3d/UFEJzoa5LzyjV4Q4BA2qUD+t891qt6tW8h
         3SaJfTuvOM9o5Q6w33vwcjOvz6brWqlnrFqP1C7bMpgYuLvhLXEuljVNVahRHeTIre+v
         GsCKDBfJ6X/lqo+zN6vH86cg+bQd8si/SDv265+p5rKjJOvq4XyH7gF/KDElkGeusEpc
         +fUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vlBithpxv3+SM0u2mf9npK5R1KY9qWHzphcmNHpcqZE=;
        fh=CGJscdhYLzvYxo+ByBdMltwvcBSEPOdWgBHUQhue/g8=;
        b=HpT0YUlBCrsEgHN8nBhkOr/F75djAxLj+5G94FBe5MlExnbXXln+nR/5OSN0EXE7GD
         P+LUsiuviHcT4N/4JVzT0/ef0q4/XdN9a0wzw9U8qD2RDF92RJV0vcNNfynrNoAMQB3R
         WMGoY3q/aHLg3huuyMBgcoJJ1erphU7YvPodQh5iGw6P5o156xe3N5o/MBRZZDN+hQU2
         z7qwrL0VIeFjls3b/lii7neHBFqX5pS0VIiPjBRMammmBAbgc8bMz2Z9MFW2Ox1y48FL
         TKsgA91rGCKV61dZCfO+ojm8yozfwq8Qa4/Gj0JeTkA5fvCRAd9krpQnW9Ln1kSqwaLU
         0hlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791892442; x=1792497242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vlBithpxv3+SM0u2mf9npK5R1KY9qWHzphcmNHpcqZE=;
        b=VwmVGgkKNUYfDldqs0SnHXUuV7IzYAeh0sLoG7CfA2q9OPbQK5+864mBxcSc8Tb8qG
         6KZIzxANjNYChwwP7jjyUPfcOICl7ZCWW/ZhSIBGp1PUMw0kKgSB5BY8AVnMXnwoV3MX
         6x909Hx69RdQJsvhWllG9qPJdRWXfF1h2pIkS8ujteNAdN2p5/lAFxASS/8UPNMVv6/2
         tE8U9FmEcXLrOpBnFbnAeQcKStQKhPGNEEZBBq9QbK5MlZQ0vRRqkU1D3jgj1bmjTrRp
         xk9t5xS2e/sdh2jIn+ueYW2kK8I5xhsOqHuNyiYI8vRMFCt7syf/NXaPqfM+clXKYEwI
         6uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791892442; x=1792497242;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vlBithpxv3+SM0u2mf9npK5R1KY9qWHzphcmNHpcqZE=;
        b=Ju6k6FTcL7Vuv8TAnMp5p3EbAlD5jeOpvJxwbet7R7GFaUYvvdZoTH0UAaj8rLlYbP
         z99XuHKIlUzF/7gHxdtzL9dpL0xTzaHIX7i2JHkPFUTcr9JtNYGuhNw587HK/+NbsLE1
         OnnRh3lpahdRS7uwxGNXvdl6IGIK7pE6SSP5ivqpDEjXTXevWY+0UOcnArgkpXgAhG+e
         USPxaUdBULqw7vrj/vgs8nfzL3XTV7hd+KoZYg7oDOrioLHVORu9E7YHJToxA3M/j+VJ
         /hlDngZM3bL/gt8BNyigY5ZZU1Gfs6I0XyOQj0vyEQUYyEICmjinlc9YgtGFC5WmFHZg
         nPRQ==
X-Forwarded-Encrypted: i=1; AKwUvBxk1yuF6Z+GMoB63Z+wpmxwz9B5Q0KYRuxFVwr4hPXFsyDaVxfVp8caj1uYk2tGBAqdfFzCMX3PmEQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKq8if5qbDDrJyhqFnT7OgUIE7nLuRs0N5gLgWyz71EBhn236W6
	z0CkILqlPPVj4dKPlUWUxucGOAgMh8z4Yv4DREWkB3lQIwHoZCm3+jbuvXl85N1ot+/1gPA/mRd
	FxywwvgepZQ2Oo/3ytAQw4ecNSWTeEuQ=
X-Gm-Gg: AYBFou22iaQtYExJQvoMj583Igd+tgn8aWsMOU1CgmcINwJZVslplk2SRRVw0mB7pY3
	UdwWe5TdUgI2Cme6m0ey61cPqSwIG+LB3+aeY78WtXpwvLggM1izQP5UfqFwj0wOKjD08wFWDA+
	808A12WPSx3K0gRLHeswByiiX2ZmpuxLlfnRuV2zW1NbeRlX5AR5mPm/aF+BjhkqKEMjjPp5ChE
	jMy5AE5HxE0IMVO/KvXORPYCB2Kzc5PHoam2wTf8FmEe+1bEJGMqTBdffqebuceb1/NILmknC02
	FeX9HI8t4Ui73+aSpBqZwlppr3VNiUX9wAjjX8zx9SSQgPpCgAKPKWnFZtWYj9eUawWucupVVdN
	gntxlSSi47me+vKGoyaZZibVmAoGWLUoCMbmTjuiJCAyLDgxWI9WMV3H7qUyVAT29nHG8mI5/cA
	==
X-Received: by 2002:a05:6000:186f:b0:488:89ad:56b8 with SMTP id
 ffacd0b85a97d-48de2ba2231mr3749233f8f.0.1791892441488; Tue, 13 Oct 2026
 04:54:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009184122.1378797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261009184122.1378797-9-prabhakar.mahadev-lad.rj@bp.renesas.com> <TY3PR01MB1134605F95A87C6335DA319C4869F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB1134605F95A87C6335DA319C4869F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 13 Oct 2026 12:53:33 +0100
X-Gm-Features: AclHuK_vgE7RX-bhU5EsKuw0wEUNHv3FisPOnuwxTo3XomXHMF6LXgDT8XOl2lo
Message-ID: <CA+V-a8u7ScDHzSmGG-7ObW4HaCRomkLGdvuy2hd5obEBvjF9LA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] iio: adc: rzt2h: Add support for RZ/V2H(P) SoC
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"magnus.damm" <magnus.damm@gmail.com>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Biju,

On Mon, Oct 12, 2026 at 7:36=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
>
> Hi Prabhakar,
>
> > -----Original Message-----
> > From: Prabhakar <prabhakar.csengg@gmail.com>
> > Sent: 09 October 2026 19:41
> > Subject: [PATCH v2 8/8] iio: adc: rzt2h: Add support for RZ/V2H(P) SoC
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add support for the ADC found on the Renesas RZ/V2H(P) SoC, which share=
s the RZ/T2H ADC IP but differs in
> > channel count, sampling, calibration and resolution support.
> >
> > The RZ/V2H(P) ADC provides 8 channels, has a fixed conversion time of
> > 20 ADCLK cycles, does not support calibration, and supports selectable =
12-bit and 8-bit conversion
> > resolution.
> >
> > Expose the fixed sampling frequency as a read-only attribute and allow =
the conversion resolution to be
> > changed through the scale attribute.
> > Use extended scan types so the reported scan type follows the selected =
resolution, and prevent resolution
> > changes while buffered capture is active.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2:
> > - Updated Kconfig description
> > - Included array_size.h
> > - Dropped unnecessary extra line in rzt2h_adc_write_scale
> > ---
> >  drivers/iio/adc/Kconfig     |  10 +-
> >  drivers/iio/adc/rzt2h_adc.c | 201 +++++++++++++++++++++++++++++++++++-
> >  2 files changed, 205 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig index a8=
02d8ee4dd9..9a58f8b5868b 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -1587,14 +1587,18 @@ config RZN1_ADC
> >         module will be called rzn1-adc.
> >
> >  config RZT2H_ADC
> > -     tristate "Renesas RZ/T2H / RZ/N2H ADC driver"
> > +     tristate "Renesas RZ/T2H / RZ/N2H (and similar SoCs) ADC driver"
> >       depends on ARCH_RENESAS || COMPILE_TEST
> >       select IIO_ADC_HELPER
> >       select IIO_BUFFER
> >       select IIO_KFIFO_BUF
> > +     select POWER_SEQUENCING
> >       help
> > -       Say yes here to build support for the ADC found in Renesas
> > -       RZ/T2H / RZ/N2H SoCs.
> > +       Say yes here to build support for the ADC found in Renesas SoCs=
:
> > +       - RZ/N2H
> > +       - RZ/T2H
> > +       - RZ/V2H(P)
> > +       - RZ/V2N
> >
> >         To compile this driver as a module, choose M here: the
> >         module will be called rzt2h_adc.
> > diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c =
index 0703c2025e3f..be8273f3b61d
> > 100644
<snip>
> >  static const struct rzt2h_adc_chip_info rzt2h_adc_info =3D {
> >       .chan_template =3D &rzt2h_adc_chan_template,
> >       .sst_to_freq =3D rzt2h_adc_sst_to_freq,
> > @@ -796,6 +973,7 @@ static const struct rzt2h_adc_chip_info rzt2h_adc_i=
nfo =3D {  };
> >
> >  static const struct of_device_id rzt2h_adc_match[] =3D {
> > +     { .compatible =3D "renesas,r9a09g057-adc", .data =3D &rzv2h_adc_i=
nfo },
> >       { .compatible =3D "renesas,r9a09g077-adc", .data =3D &rzt2h_adc_i=
nfo },
> >       { }
> >  };
> > @@ -804,8 +982,17 @@ MODULE_DEVICE_TABLE(of, rzt2h_adc_match);  static =
int
> > rzt2h_adc_pm_runtime_suspend(struct device *dev)  {
> >       struct rzt2h_adc *adc =3D dev_get_drvdata(dev);
> > +     int ret;
> > +
> > +     ret =3D pwrseq_disable(adc->pwrseq);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D reset_control_assert(adc->rstc);
>
> I guess to apply assert reset, IP needs power.
> So, you need to asset first and then power off.
>
The HW manual doesn't mention any ordering of power and reset,
although it does mention the ordering of power and clock which the
current code adheres to. For example see the below logs where register
RZT2H_ADANSA0_REG is written a value of 0x56 at the begining of the
suspend call and the same register is read back in the suspend call
after turning off the power and in the resume path the same register
is read back at the very end and we can see the value of this register
is reported as 0x0 which is expected to reset to its initial value
(full log can be seen here
https://gist.github.com/prabhakarlad/def672bbca9cc51d0398a6549bcf1b80).
Please let me know if I have misunderstood something here.

Logs:
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<=
<<<<<<<<<<<<<<<
rzv2h-evk login: root

WARNING: Poky is a reference Yocto Project distribution that should be used=
 for
testing and development purposes only. It is recommended that you create yo=
ur
own distribution for production use.

root@rzv2h-evk:~# >>>>>>>>> First Cycle <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
root@rzv2h-evk:~# cat /sys/bus/iio/devices/iio\:device0/in_voltage0_raw
[   46.125340] rzv2h-cpg 10420000.clock-controller: CLK_ON 0x640/adc_0_adcl=
k on
[   46.132399] rzv2h-cpg 10420000.clock-controller: CLK_ON 0x640/adc_0_pclk=
 on
[   46.139386] Resuming ADC
[   46.141915] rzv2h-cpg 10420000.clock-controller: deassert id:110 offset:=
0x93c
[   46.149054] Enabling ADC pwrseq
[   46.152245] ADANSA0_REG: 0x0 in resume
216
root@rzv2h-evk:~# [   46.531171] Suspending ADC
[   46.533951] ADANSA0_REG: 0x56 before power down
[   46.538732] Disabling ADC pwrseq
[   46.542095] ADANSA0_REG: 0x56 after power down
[   46.546681] rzv2h-cpg 10420000.clock-controller: assert id:110 offset:0x=
93c
[   46.553829] rzv2h-cpg 10420000.clock-controller: CLK_ON 0x640/adc_0_pclk=
 off
[   46.560951] rzv2h-cpg 10420000.clock-controller: CLK_ON 0x640/adc_0_adcl=
k off

root@rzv2h-evk:~# ->>>>>>>>> Second Cycle <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
root@rzv2h-evk:~# cat /sys/bus/iio/devices/iio\:device0/in_voltage0_raw
[   50.491213] rzv2h-cpg 10420000.clock-controller: CLK_ON 0x640/adc_0_adcl=
k on
[   50.498271] rzv2h-cpg 10420000.clock-controller: CLK_ON 0x640/adc_0_pclk=
 on
[   50.505242] Resuming ADC
[   50.507785] rzv2h-cpg 10420000.clock-controller: deassert id:110 offset:=
0x93c
[   50.514923] Enabling ADC pwrseq
[   50.518111] ADANSA0_REG: 0x0 in resume
126
root@rzv2h-evk:~# [   50.896990] Suspending ADC
[   50.899881] ADANSA0_REG: 0x56 before power down
[   50.904545] Disabling ADC pwrseq
[   50.907914] ADANSA0_REG: 0x56 after power down
[   50.912504] rzv2h-cpg 10420000.clock-controller: assert id:110 offset:0x=
93c
[   50.919642] rzv2h-cpg 10420000.clock-controller: CLK_ON 0x640/adc_0_pclk=
 off
[   50.926761] rzv2h-cpg 10420000.clock-controller: CLK_ON 0x640/adc_0_adcl=
k off

root@rzv2h-evk:~#
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<=
<<<<<<<<<<<<<<<

Changes made to generate the above logs:
--------------------------------------------------
diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cp=
g.c
index 7ce94680c79a..eab6237dca4c 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -1169,7 +1169,7 @@ static int rzv2h_mod_clock_endisable(struct
clk_hw *hw, bool enable)
        u32 value;
        int error;

-       dev_dbg(dev, "CLK_ON 0x%x/%pC %s\n", reg, hw->clk,
+       dev_err(dev, "CLK_ON 0x%x/%pC %s\n", reg, hw->clk,
                str_on_off(enable));

        if (enabled =3D=3D enable)
@@ -1324,7 +1324,7 @@ static int __rzv2h_cpg_assert(struct
reset_controller_dev *rcdev,
        u32 mon;
        int ret;

-       dev_dbg(rcdev->dev, "%s id:%ld offset:0x%x\n",
+       dev_err(rcdev->dev, "%s id:%ld offset:0x%x\n",
                assert ? "assert" : "deassert", id, reg);

        if (!assert)
diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index be8273f3b61d..36ff6da87138 100644
--- a/drivers/iio/adc/rzt2h_adc.c
+++ b/drivers/iio/adc/rzt2h_adc.c
@@ -984,9 +984,14 @@ static int rzt2h_adc_pm_runtime_suspend(struct device =
*dev)
        struct rzt2h_adc *adc =3D dev_get_drvdata(dev);
        int ret;

+       pr_err("Suspending ADC\n");
+
+       writew(0x56, adc->base + RZT2H_ADANSA0_REG);
+       pr_err("ADANSA0_REG: 0x%x before power down\n",
readw(adc->base + RZT2H_ADANSA0_REG));
        ret =3D pwrseq_disable(adc->pwrseq);
        if (ret)
                return ret;
+       pr_err("ADANSA0_REG: 0x%x after power down\n", readw(adc->base
+ RZT2H_ADANSA0_REG));

        ret =3D reset_control_assert(adc->rstc);
        if (ret)
@@ -1001,6 +1006,8 @@ static int rzt2h_adc_pm_runtime_resume(struct device =
*dev)
        const struct rzt2h_adc_chip_info *chip_info =3D adc->chip_info;
        int ret;

+       pr_err("Resuming ADC\n");
+
        ret =3D reset_control_deassert(adc->rstc);
        if (ret)
                return ret;
@@ -1011,6 +1018,8 @@ static int rzt2h_adc_pm_runtime_resume(struct device =
*dev)
                return ret;
        }

+       pr_err("ADANSA0_REG: 0x%x in resume\n", readw(adc->base +
RZT2H_ADANSA0_REG));
+
        if (!(chip_info->features & RZT2H_ADC_FEATURE_CALIBRATION))
                return 0;

diff --git a/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c
b/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c
index 40760977f7de..b6886dba92a9 100644
--- a/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c
+++ b/drivers/power/sequencing/pwrseq-renesas-pwrrdy.c
@@ -8,6 +8,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pwrseq/consumer.h>
 #include <linux/pwrseq/provider.h>
 #include <linux/regmap.h>

@@ -31,6 +32,7 @@ static int pwrseq_rzv2h_adc_enable(struct
pwrseq_device *pwrseq)
        struct regmap *regmap =3D pwrseq_device_get_drvdata(pwrseq);
        int ret;

+       pr_err("Enabling ADC pwrseq\n");
        ret =3D regmap_clear_bits(regmap, RZV2H_SYS_ADC_CFG,
                                RZV2H_SYS_ADC_CFG_SY_MSTP_ADA);
        if (ret)
@@ -45,6 +47,7 @@ static int pwrseq_rzv2h_adc_disable(struct
pwrseq_device *pwrseq)
 {
        struct regmap *regmap =3D pwrseq_device_get_drvdata(pwrseq);

+       pr_err("Disabling ADC pwrseq\n");
        return regmap_set_bits(regmap, RZV2H_SYS_ADC_CFG,
                               RZV2H_SYS_ADC_CFG_SY_MSTP_ADA);
 }
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------------


Cheers,
Prabhakar
