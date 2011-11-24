Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58950 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451Ab1KXPUb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Nov 2011 10:20:31 -0500
Received: by ywa9 with SMTP id 9so318824ywa.19
        for <linux-iio@vger.kernel.org>; Thu, 24 Nov 2011 07:20:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1322134040-32382-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1322134040-32382-1-git-send-email-maxime.ripard@free-electrons.com>
	<1322134040-32382-4-git-send-email-maxime.ripard@free-electrons.com>
Date: Thu, 24 Nov 2011 13:20:30 -0200
Message-ID: <CAOMZO5ADJrLCV6ohkraohqJT1aD2hC_pWEsbDezWGchGrvRYvA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: AT91: Add the ADC to the sam9g20ek board
From: Fabio Estevam <festevam@gmail.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Nov 24, 2011 at 9:27 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> +static struct at91_adc_data ek_adc_data =3D {
> + =C2=A0 =C2=A0 =C2=A0 .channels_used =3D BIT(0) | BIT(1) | BIT(2) | =
BIT(3),
> + =C2=A0 =C2=A0 =C2=A0 .vref =3D 3300,
> +};

Don't you need to also pass adc_clock?

Otherwise the probe code will fail:

+
+	if (!pdata->adc_clock) {
+		dev_err(&pdev->dev, "No ADCClock available.\n");
+		ret =3D -EINVAL;
+		goto error_free_clk;
+	}
