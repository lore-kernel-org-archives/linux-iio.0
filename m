Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.141
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795689131;
	b=rXoZXXFjNpjnLztvx7bgW1DT/370VgbZUsRo/ZLE8GoqB+/fyNQydDLSS/Sb29Ht0qRs
	 Z4Xd/LBAkrK2jGCFz8tb9g8cH/DFCvlC9YYC0gg++l3v1P8Sb70usY80vc4zsLfny6Aji
	 h057AbLMImMCW6IJ+pirW6JPCVWX57kVCRM/yyKhRw/krPePNVSAMeSGM0WW5ZvRkljw0
	 dZf6sVz/kFqSmBNt7760nLUIC/PUMiYj5JXo7KuNQxirr4zp+5X7IsCDgal55By75Z8N2
	 /PT6ospR8TKEAMDd+W3jVCzJfKKs9+IYponNS3CEtzJJcB2viTI1MEiL3I2cHaHLSrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689131;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=zwLpoMTDh+rDsEqSsqnZuSBnBidh5uHQGhBxiSxbmTw=;
	b=m1p5bbySeb5fg39E5bRp+iJaE3xmar2rm1KvB8l6DiOTybL7jUqw80GnFr+VWFisSu7H
	 EvXNgX6PNKxKWItfF4SFzx8T7tGeRZ20vhgezlUnEh3XD40ar5wjLXRfHWmgZlWCWf1PM
	 CXs2g1UHDUUaWRWBhyIJQ7zu1M7b4pDwFg00K0qdboonK+7ORQ2JFrb2uVdCzs946BuZ2
	 hjRvzuHHiyLD2mtOjVAYo328WGTmX2Xr6vi6o5H/SH7ZkF4Vr2JAdmq/vqxSNsyqz7QsJ
	 z2v+Zg+Ym85kCj9b4jxJ4HpHJ60ELumhr29htzWknUYuw8FxCk2XsKNuxf17O038JXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=glider.be;
	spf=pass smtp.mailfrom=glider.be;
	dkim=pass header.d=glider.be header.i=@glider.be header.a=rsa-sha256 header.s=fm1 header.b=IilueBVg;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LBfXY8J+;
	arc=none smtp.remote-ip=103.168.172.141
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1602606A323
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 10:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1602606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glider.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=glider.be header.i=@glider.be header.a=rsa-sha256 header.s=fm1 header.b=IilueBVg;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LBfXY8J+
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailflow.phl.internal (Postfix) with ESMTP id DD2881380253
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 05:32:09 -0500 (EST)
Received: from ams-imap-13 ([10.64.2.33])
  by ams-compute-02.internal (MEProxy); Thu, 26 Nov 2026 05:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glider.be; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1795689124;
	 x=1795692724; bh=zwLpoMTDh+rDsEqSsqnZuSBnBidh5uHQGhBxiSxbmTw=; b=
	IilueBVgdzjicrcAbwIbzrsCJFvKspcf3WV2wiTJYvXNutLxS3LnrR+zMPcQtUTn
	DYm2LE6hYP2sPW1QMezOxJQ9KQVeGFlcklxWDDAVX3X4YlbQKxIkUsd6RRda3OcZ
	byNerrN7AWogGco35qjnPHSzpemrdtq+dLRp8v+dWIZZW8k/m1p9scUAIecRBJu2
	gqvd9kfM+j3Ky0y/x+Oxfvedkz8TJoR6Ev0RJyCQFmSzA1m0zebYHbBt8vImcU/i
	3AZGl7VDi2kWQCmh9sA5iosJpFCEVMbZhnUgOOxM3825AWbBlPIanVwYUjTDxfq+
	skTx8ucLnz8AK55zgqAwTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795689124; x=
	1795692724; bh=zwLpoMTDh+rDsEqSsqnZuSBnBidh5uHQGhBxiSxbmTw=; b=L
	BfXY8J+3QBhpC8LlEnfaUhb+uoTGvbEeGhrXBw+H2Y8Jzac/7AYpPJ0QI9JLDeQE
	q8ecp38RkL5Bw1yXAfpRUzTjUxxSrx2tCS5BPYMIzxN7tiiEkNWKPT+YH6oEJw0F
	+8v6fIBSh30HHPfyvrKnGvlnAHosCT5rJjd/mVMqmSYk9tY+RMieGUI2Uuoq1p9G
	3QQWvaM+ZfOSgT0ArvPZRcxaU1RxIpU7vG8GFkLC+/c8gavGnu/OIlglFOMjH35K
	MpUgmFNitqmU9cyMC1pj+qIjxsQKv3F8HUbb/kqVl5Sx/HKHQR55pAlVpjhKwqBs
	MjMEElK1Z3K3FfgFXkW0g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=glider.be a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795689124; d=glider.be;
	mf=PGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg==;
	rt=PGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ZFL5T4p4y/fDYEXtUKBBP9wZ8uUPKEDIhDosQ2GKS5l2baO
	JRgGLJrbTJgMz4MNUsnKmg6yxtgvL8yh7xRcwwP9V2kYL2jfwGwvk5STgH0uCEiT
	NhPsTO8RgD+n1YdIntOuI/fUxLwlmJzbEXh+/5wLzfyT7CUI1eGBS9b7jgOUqrAw
	YNyW83ujAb80nL4KGa4YYysdvOvqkoqgoQ2Bn6rtEo5DhMMedCIlA35SFz3ObLFo
	W32qJU8aI3As8p23GOQWh3zKf3IJ8CPHhnk1eS+XrZnxpYteLWPJdRRLhfwhzFjj
	WJ791cmM01jI2EJcv23djF8J6YyZIjHagKm+8lg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:e5cy9doLIF5C6wbBkPba6K8PNQINcmhh9dBQqy+XHlY=:bQlHbabK+rwltW9kvGOAlyQRBHqT6rZIVsz7rG1QBUI=;
X-ME-Sender: <xms:oQoIa2NRa7hQmqTLL6G3bG9NaX3B4hqAODGUfUk45TJQdjm-QHTtkQ>
    <xme:oQoIa_xso63afPBlnDXcpUlnqyvnNPIDVrS3M8bn6tSiSb69WKaJJtL44T5NPQFNq
    ZSYJNfshc-CjrRqGVtDy_W_6AQ0IYtsvZ8OS0tWgfBNZYWvehkjZfom>
X-ME-Proxy-Cause: dmFkZTFqP/5itI8IXg0jtDx1RRhA5+6i9xrlrwkNLGkLPQGfno2so2LZefRssDIodX6/cj
    Rsw/hicadzFHxkGhz2WpHt2yxszTMbDqzlLglErQk18ti87CYykQRRmg4ZD95lMzCUiieM
    w0dqTaLk6JrC1Oju9NPXtc0wLxOmwrznPSQnZlG1ZsnTVS44na1OkN8QVKC1GriP1hydXQ
    GCM0pVwz6upSRk6rtAijuC8D6UqLu9eJk+rzhjUWA14QpWvRUq00b8kK8FS5wKxhFLvs3/
    2a7Z61Ys8KwskpDpbjvypWPn6y9hOZi3vEwQCWk6XqyGXSELvRrfMMvoZXaus5RCanXStX
    I03y+KeHmWwnHUNLap0Toidb1Ti1EwpIQUQzxKRMbG0b23Sf+VZcOrKzI5JvjndnggtW4W
    Ps2HyILsKDXMYI4Csp/NNACHGgCwjpaNmA08eonKeurIhsE6YUkj1DnwV7PjPxRtgXInh0
    uSQLYm4V/ku6a65AXZrS4aZYwX/i3sPaKgKS9bZSOrzPYCsfLhe2WYkaknaILyxvIX1z/N
    mhzwTe5GUKANKLQZrPktQ5M/IJGdvkJ6qSDLJRna0o9/GSwqDZ/F7g7eOozfszKW2a85kP
    zCM5xUNnximjKkAtFZh3hwo+zKzSRI71PmuAz8tUcOIuoBzWtLxz4lQxAzbA
X-ME-Proxy: <xmx:owoIa4njR6Qo75jvN99EjpCjR3Ji0j8txk1-T6CQk-TI7ThweG_QaQ>
    <xmx:owoIa__IU0QsoKtLBiXLxXEZ4OCOgsgqP1ZdL8UY-LiX-c14JB26Xg>
    <xmx:owoIa2K87pSCE6O3zFz8dQgEl0Xslb8RatbgTXrv-A6RLkbvRerPIQ>
    <xmx:owoIa0jAqN9XDDtorfmgc4ry5mZB9vmeOp0f7yxdhLuQ0qh-5ewsIQ>
    <xmx:pAoIa1WpxsyVq-1Tp0H614sK4Wmo1A_vmx0IO3pQeQl76LYncvT2x2Aj>
Feedback-ID: ia0f84a9e:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 715D7F800A2; Thu, 26 Nov 2026 05:32:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AJ3dJRnBKuuc
Date: Thu, 26 Nov 2026 11:31:41 +0100
From: "Geert Uytterhoeven" <geert+renesas@glider.be>
To: "Biju Das" <biju.das.au@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Biju Das" <biju.das.jz@bp.renesas.com>,
 "Magnus Damm" <magnus.damm@gmail.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Jonathan Cameron" <jic23@kernel.org>,
 linux-iio@vger.kernel.org
Message-Id: <a152df0a-0b0b-4193-b3ac-ee0df0350802@app.fastmail.com>
In-Reply-To: <20261125-usb_rzg3l-v9-1-ea14d3ab8a53@bp.renesas.com>
References: <20261125-usb_rzg3l-v9-0-ea14d3ab8a53@bp.renesas.com>
 <20261125-usb_rzg3l-v9-1-ea14d3ab8a53@bp.renesas.com>
Subject: Re: [PATCH v9 1/4] arm64: dts: renesas: r9a08g046: Enable TSU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Biju,

Cc IIO

On Wed, Nov 25, 2026, at 12:05, Biju Das wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Add #cooling-cells to the CPU nodes, and describe the ADC1 (used
> exclusively by the TSU) and TSU nodes along with a CPU thermal zone
> using passive and critical trip points, with CPU frequency cooling
> maps for thermal mitigation.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi

> @@ -381,6 +385,37 @@ scif5: serial@1004e000 {
>  			status = "disabled";
>  		};
> 
> +		adc1: adc@108c0000 {
> +			compatible = "renesas,r9a08g046-adc1";
> +			reg = <0 0x108c0000 0 0x10000>;
> +			interrupts = <GIC_SPI 378 IRQ_TYPE_EDGE_RISING>;
> +			clocks = <&cpg CPG_MOD R9A08G046_ADC1_ADCLK>,
> +				 <&cpg CPG_MOD R9A08G046_ADC1_PCLK>;
> +			clock-names = "adclk", "pclk";
> +			resets = <&cpg R9A08G046_ADC1_PRESETN>,
> +				 <&cpg R9A08G046_ADC1_ADRST_N>;
> +			reset-names = "presetn", "adrst-n";
> +			power-domains = <&cpg>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#io-channel-cells = <1>;
> +
> +			channel@8 {
> +				reg = <8>;
> +			};
> +		};
> +
> +		tsu: thermal@108d0000 {
> +			compatible = "renesas,r9a08g046-tsu";
> +			reg = <0 0x108d0000 0 0x10000>;
> +			clocks = <&cpg CPG_MOD R9A08G046_TSU_PCLK>;
> +			resets = <&cpg R9A08G046_TSU_PRESETN>;
> +			power-domains = <&cpg>;
> +			#thermal-sensor-cells = <0>;
> +			io-channels = <&adc1 0>;

<&adc1 8>

You cannot have "channel@8" in the ADC node and magically assume
consumers should refer to this using "<&adc1 0>".

I don't buy your rationale in [1]:

   "There is a mapping between internal Linux array index (0) and the actual hardware channel ID (8).

    See the code
    https://elixir.bootlin.com/linux/v7.3-rc3/source/drivers/iio/adc/rzg2l_adc.c#L354"

This mapping is in the driver, and there is no mention of it in the DT bindings.
This means the driver must be fixed first, too.

> +			io-channel-names = "tsu";
> +		};
> +
>  		i2c0: i2c@100ae000 {
>  			compatible = "renesas,riic-r9a08g046", "renesas,riic-r9a09g057";
>  			reg = <0 0x100ae000 0 0x400>;

[1] https://lore.kernel.org/TY3PR01MB11346F7B4718113C76B93362986872@TY3PR01MB11346.jpnprd01.prod.outlook.com/

Gr{oetje,eeting}s,

                                                Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                                            -- Linus Torvalds
