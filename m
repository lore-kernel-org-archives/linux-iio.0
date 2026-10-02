Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D7D2DB79F
	for <linux-iio@vger.kernel.org>; Fri,  2 Oct 2026 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951616; cv=pass; b=YA8p291ZbmYvPJFA2O2At0JYUN4yXlLZpN/O2zLxZ50kvED7GRBz5osqTAZqcbBCJTBHWICA0hD75daqVWyuxKjDn1e4LnPqgxnggXtrPriAjFD37qdguzKywa2HsvZcXbmY0ok1CzMpn4WD60V4tZdFdFRjldBRth2FFQx5w3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951616; c=relaxed/simple;
	bh=PNbOBNyXkRISuH2zKHNjb70SO7pk9MOzRaXz8icfJsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGzCeImxUVXS8SELdgk+GaedZ6z2VewSKInGqFvXvPkF1PIltMcODsK1rYQL0p7cOitXHrc+ddZRptXi3hhddbtlka8KgYKD0hSJMDHkEZ5SreCnXYFiLjUGmaQXuRG4e828wbjJflTxuH7sp8XAM6VcLNLicozuzmLyveDxHNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UrmKBOwJ; arc=pass smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UrmKBOwJ"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-7beb81b2834so816112137.2
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2026 07:33:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790951614; cv=none;
        d=google.com; s=arc-20260327;
        b=iYR3DvVQmzpJEKCMZQUwlMZSxuiY01sw5EZSrqRZEOUCiTqF0WvLUWx19UsczSSAGo
         0j+1qwXX63xiGZ1TjIx/ZcdZr2vjqp30iJS8MFWU1+fe1TpL4M8axJ4HcNWBEZPtxhLl
         bgExAXaaPeAt9uKt0Y4IY41jewLduBwoE3nNSKEvxcAO8ouzSEAuF+B9Rvhm51MDm2VN
         9Uxxt1i7FIpUDR86j5VfTyM+k15Gv3Aj1Pk6rLJr5QZLw3DT1R7n7J4hpOwI5fakWU37
         1LWYI4xv+aJWdaYVqq4uk46Gx9e+tUxZRWmiVzy/12g4eGvdUCBPpzYS1aw61Rp2s1qw
         R6eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aMvSO5P24Ym2wFibt0ipNlW23D4EQZ7yzqETy/c1yNM=;
        fh=QtB6lrYpY8rh7KZb9hoTgpI6dKT34z/G1gQC+bs3NJk=;
        b=E1GSiAq3P/WiO037wTLByE/hj/DzUWVvBR0i50oHkcMPJUIQK5ySvrFeXjq64xLyia
         hDJWpNcvwa34yNUJQRxoEtFw6ed97S8DQv2hp/FLDtWnInzF9U7mtHZxUd8wxVS8KkD7
         c358ykyDPs5ye6acxNA1NOeCWCPfLuTAtDtM3EOf9CtRf+LQ0EYxdJWP2IH06CmleZhs
         JS9ClyaYKnHKDRh+hS3ptbTBM2t9O/89NqS6BbQYJFaiiX1HV5mSVinjYeBEGnAuv3ms
         jiCJEZWziEg/jPo4y5MXUSPam+5C7p+e/OGPhKX6hNTlgsXBUwvX/lKBTwsuvfo2o0eT
         anEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790951614; x=1791556414; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aMvSO5P24Ym2wFibt0ipNlW23D4EQZ7yzqETy/c1yNM=;
        b=UrmKBOwJD7r+45MqNt0a/8g1jZY8qSEomvYl7QfBvV8EBMT9kRew5q9MpDrDD9Bpqk
         yeB20MD8lwLB9OE4YFHjCxacABO3b/wfK52/hBDvzDUTFvFE+q0ZzuyZNlyDx424lF44
         5e4xW7nymLZWDYyG0skw2xLMMWQpS6pU/KbjdgDPhcqMdQsCgNYVr+P3VZoy7FhYX9Q/
         ylhtD5+bWWKNXYsPx7help9iNcNk8B/p3pqGRDXdh+ztRffT8MPwYJTx4yC5rpzrH3Rp
         XLm/6WWydqOk6WsIErXf2Y1khklK/xWEHnwY0bemZcwwbhjzAVVHckmxyLAa5y8zMsz0
         NkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790951614; x=1791556414;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aMvSO5P24Ym2wFibt0ipNlW23D4EQZ7yzqETy/c1yNM=;
        b=rXd0kqEUHtkMZTlG+8a5JA7gogvXsLp8295YPjvD/qFWsx7pUURMhGIjkGchWjKlt+
         OOfXFydI+yGT6U0gTwFiB5OVg/O8wFf8eXW9m8a6dMXp+0hO8kpsEPix3Bclx/NrPqhv
         0/xjaUsMA36DDoNUPkly5LPHpeH1UlQCfXErMHRDv5dudclo7pxspXQAH2ywQ8y4NnOS
         16n4Unvtdx3cFs3VE/gVv9zRyTomIHdM8N41QCVswCxon94kbr04nYn0uIxIDopUeEwv
         AVA7ET0i8MdTZabNf6tYuMgQqQL2+3wbCawxEfhKboiukqZew5P7HvyUO82VlT8fVLAv
         tcDA==
X-Forwarded-Encrypted: i=1; AKwUvByrc2h0Wjj0nsa7r3yuL4RmFL6zgfUC/F7C2QxUY5Lzf/8+FPlho2RqN+7hD8rwrz3O9I0mjpxRGnM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIM1EajMAmDpglwfBJN0semWCJ8WJZ1228ryhSyVRP8HVXEmvQN
	YFb3BK1Rj5ttnrvbH5oXvwiJS4TliNKZuW2nh+4B8tpjZ1dKekBFla2CO48Awh9bLEV8UIf0JQJ
	CMgZ7KFldRi0C9j3HYlt2wObMqS3moHucegwzyR8Bsw==
X-Gm-Gg: AYBFou2gvvALjekeWCqm7YernwHg+rr5ATGUBW2ZvO3Qyq3QVTD5VRz+HcQQfr0MVm2
	VtrwC8a6aAwFrzSDo89IuMvfeV2w92oFvco2vz9bVYzgD1lAEvuc/R+6b8d9tTcpnihNW5sDyAq
	g3ltc2CfmEQad8k8/CPgP3eQhiyxQLJx59Cm7nKDUz/XBdAu6/24yT3CDP8smtlrRik8xk0uDnS
	/7OU2QBxNk4uBVC53Otsrb9PXSQVC5Tmptix4bBYA3WmJqNPTTcGDr8QenieILN+wM76h+/gHGT
	UIpJ9PONRAkLvX947mFRj0u8BW0jzB0C0hzLCPTIOVM7EYr3vXWv6TdreyYBW7/Z6ALdAaOHGIZ
	jzsJWi65emgVLCQ==
X-Received: by 2002:a05:6102:6444:b0:7ba:ea54:65a9 with SMTP id
 ada2fe7eead31-7c0f42731b5mr647395137.6.1790951614035; Fri, 02 Oct 2026
 07:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001-exynos850_adc-v1-0-791b3516bb9d@linaro.org> <20261001-exynos850_adc-v1-4-791b3516bb9d@linaro.org>
In-Reply-To: <20261001-exynos850_adc-v1-4-791b3516bb9d@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 2 Oct 2026 15:33:20 +0100
X-Gm-Features: AclHuK_nlsYCw4TsUB6KsMMTGZlzaoT0nlgKI-1tdzuxscLcNJSDMijcKeaoSvg
Message-ID: <CADrjBPpXvW1RVGC=mTO9sQncS3w4zAMKekwVa7Vbrq5OszJMwg@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: exynos850-e850-96: add soc thermistor node
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Oct 2026 at 04:09, Alexey Klimov <alexey.klimov@linaro.org> wrote:
>
> The WinLink E850-96 board has a Murata NCP03WF104 NTC thermistor placed
> near the SoC package die and connected to channel 0 of the CMGP ADC.
>
> Enable the ADC node, define a dummy 1.8V regulator supply for ADC, and
> add the board-level thermistor node linked to channel 0 of exynos_adc.
> Regulator is represented as a dummy one because we lack PMIC support and
> should be replaced with a real one when PMIC support will be implemented.
>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

>  arch/arm64/boot/dts/exynos/exynos850-e850-96.dts | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
> index afef32ad4ee2..1abae8b9fa49 100644
> --- a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
> @@ -126,6 +126,14 @@ reg_dummy: regulator-0 {
>                 regulator-name = "dummy_reg";
>         };
>
> +       /* TODO: Remove this once PMIC is implemented  */
> +       vdd_1v8_dummy: regulator-1v8 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vdd_1v8_dummy";
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;
> +       };
> +
>         reg_usb_host_vbus: regulator-1 {
>                 compatible = "regulator-fixed";
>                 regulator-name = "usb_host_vbus";
> @@ -166,6 +174,20 @@ rtcclk: clock-rtcclk {
>                 #clock-cells = <0>;
>                 clock-frequency = <32768>;
>         };
> +
> +       thermistor-soc {
> +               compatible = "murata,ncp03wf104";
> +               pullup-uv = <1800000>;
> +               pullup-ohm = <100000>;
> +               pulldown-ohm = <0>;
> +               io-channels = <&exynos_adc 0>;
> +               #thermal-sensor-cells = <0>;
> +       };
> +};
> +
> +&exynos_adc {
> +       status = "okay";
> +       vdd-supply = <&vdd_1v8_dummy>;
>  };
>
>  &cmu_hsi {
>
> --
> 2.51.0
>
