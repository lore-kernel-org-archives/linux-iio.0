Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com [34.2.90.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943F43D649C
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 20:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.90.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790628325; cv=none; b=mOQARAwpKsCpIT4UCws2/g7nfszWMkuYojdj4E5RF2T90sEm/KD94tLRLO0FnQ9AwDxJdPLtGi6i+GeKJGkiJTcgGrRMfBe49Z4HHACABglXpqOMEvNm7o9RaqvyqL1Rklm6sXpNBdikGNGiKB4scK0xeJpl/fCj+ZCFHmCEnKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790628325; c=relaxed/simple;
	bh=VdS24L84h0fXSD3hXzf1l02B2vR+0zfJ0VOsd/ItHJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9wuUDoT+sQNzHaX6XrlzRa05zka3f7OutD8pyrpkf2IdRxcrDM3SUyX/KdD5BRqqW720LnGOecCe7/c5hFsgV16t0jzpLr7TtRBR3eSkIF/UnzY8nWUyKVADDdJD1P5udSEeVwLszaIf3xJJDXtRKY/uWe2aY/VLo6i4rHAu9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=RWnA4Iq2; arc=none smtp.client-ip=34.2.90.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RWnA4Iq2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1790628320; bh=L1Fenbcpti08rA81B7mGiCyi+J5H6zLTX6X9mLxrPXU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=RWnA4Iq2voKm4nSiWLkWDZ4CT/Mg/8DOTr7/YFG3FaneDKUxagjZx+NoTIqcveodM/K+sgaH5ALfCPvUPX8S9YqrDZzbw9etU1s7gfkY7HTebNeVRtCVKgIja1ikVbmzFe5pjvwQ+ub5+6DgEog8eEvpZ82riYCcZ+OFkHhLKhpZndzfVfJf7BVVihoGygGUAHH4RkmHoEY1aogetb9CtamJpFa/geqJY7ThnArwcY0drpnMb2iFwY5NMEJHyoYo3HniuTTx/wcd/iMh9E8KgCTf3n0tOzzHm9ov+E6KCJhqK6sv/Z7LXZhX5IXbKSpRxAJ8z+0TWQbUs26OIPKCDA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1790628320; bh=s7AGyREpIS7qkSTC6qnAthPWlYjpTBzxWwVCN2hn9R6=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=eKde/wxr559Ym9qXVYz8UEpSZ+ScBNw4kjJuRD268SbcF4APpVWccUv/8tYTnVr052iZisP7isxIoC72xsIQ8XLTEwAOR/L9CuEfPp3DISU76X8rfvQirzcjZIUWK4XOFkKHl+CTElXUIlpGTHC2tiVBqF0UEs8XNuQun8Ghf5pO7UMBXMfSpCf4Krs+3cwziUP3OXHodVVsgluMqBjJjwDExZyJPI7HDdjojEbDKJ61Ri6kGxZ/oA8/bPBPYvrYESON55vROhDMWzZHAEK1MLTSWIPiySTh6IAhZGU2JEvV/S9xV5NW7HYv304Jgd0vFoOnFoMZtSKmvtqxHOnPGQ==
X-YMail-OSG: 1.lZqBQVM1mqnfPyvOvb7WtfdGFwiedQTez.ZNVCCqjyKJSmmUXF9ApcDXOgO5y
 AIKRBENJxF2cjZQ7NrkwAuMss81NvaqeFmXSg3NdTLqxOTeOv6tIgcDIBumyHHOHyIj2klgGa7Du
 TyzbR2mZ1px5iI7VJ_I4d11ogefI_n0jUr6vPYpJuSVJQkcpeuAwbl5bEBjxfS6Rt8fQ8Mq7tYVE
 0FblVI0sMiefdRLT7UppHdKJ0BJF2qa61oDX17dM9d5Vgep6rFE04MIGI4Dzz202ZHhdIkWRLb3Y
 vXGLZWamhkRLFxEJ9pQ6bv6v00hSoN8ky8e1x80R4F8xfW2l_hSNrFS6dl1ZubjquH3Rzrv4gZA9
 1s.eJtzBZ4.b3BmOlnL0R2LubhLNmaM5Cvt_jIw61brBTTvPIVFC2RqzqQUk3VxlUm3AKsMtXdTW
 hpgHEObXH_rrnVP0UWmPdHZVikhD2Zc.6zb6CihzqLwqfjCOnZyyaJYL5rufEUhl5.7q5QxeJLHt
 0heS0_5rt_S0PicFc8dz7u.jox1wHZSzEtjgOqr8mxSgjfuBjawkd_Jtmo1d5CfvD7BmrzWin_ua
 bPSbG1YX5qwBwPw9IDSRP8kg70EPYr._FNAoXhzxkYvrRMgS9eaF_Xd1juc0nZfIDobt7jWg.EMr
 dZjzs7q8J2lF9n72VPCt_diax2LrtvyvJ4OXqsy4Q29N2tH.S6G1nr.AqUQHJVENdYrSo_DdQriB
 6vwd5YyD548ySLDggeyFPHUYsdSNvM_oWw9JBfddoaNXqV_Tt.1OhH04LLT17CvmF2gB7Rml4hzK
 036x0JNFiZeKMb.4VL0iatrs3apRlVH56DCLPVhmjnMl7k5Cabasgddg9ZKQscyZj4SSzl7_TRdo
 4wnnnG_lnH9O9MzxYY0SPQZArmiN40cPsOvCyPAyJIbwSdAl6Vc81VpKxEhd0wlwAXYQKQ1kHi3L
 NyluyFGLfgFm9_mVY0iYcVywoJShRQWWB_qmydupt2W1BK3UnKAttTewpzqejAtd7HUhGQEBcIqw
 30L5Ea0ENWWhuJwXXVg.S6DaGLafoMWv3OOXvkky2t4slOatv905zrpfyiGoIrFW0lt2Atp4xdwd
 bm2LyIRyj6irfoB1KSFFv5kMQ5nyaBkrmrmyxcsxbMIRbmGCmS7tSaigRkUjyQ5LKJljoPvF6Plq
 9O1HCftGwoj.RWKqkMcJqkAC63U9XNvYv4UeBqONIUWDMcDSek6IXPcDi0XYYpgGAMKHMRpI.PNC
 QNLi5RRN.6c7ZOHmxxpGgyZqmHvJnpwXjBUiOUHg.38kMG27hh_0vRkKtzJ81MtYU5Z83_8Jt3AU
 _CxOGTpsx1N7vw_f_lEpsOVFKgqSF7mhEtaI..Si4HOv17Ei5KkE5i3UedJy2OzWVKFNMybfOQF9
 IrmnWxlNbANu4suuvinHJN7bGB.dqsM6qwiX2815zHCCeCdR_GXIj3HlYCc8cf4JBOJa4dVlPnX5
 3mtUOhpCgoekNmiMYaTrqbULEMQMzHI4.LrkTO6xbi5oMjZtrks_4XbGaZSwMhl5NKiFwwAtDKHO
 .6tej7p6iYA5Hb1S3tfzjUUU9wC.DDDxPSFWIcETPGhKI9BfCW0TLg2c_2cwnMIjWt01bqXh1ypa
 4uY1U8hem2kFYVJd07AFut_B3bgjvAWi7pcZjIddir_TAm3AOSQc8_dWTewVzTzjRyuh7Msl9ePB
 AaalBTv1Nw7pcOmRfdqUqPStXIozYy8qFRmTSpCHb_xbum6ogeG8qgXGbrJMDNmWLsYbQWzKtvt2
 TqdZUu4iCuoylnu74vnUQprZFHXbHM.fEGO5T1Eo_EF.YFTnUFFtxbR4r6_.IgVsoMfGispRi_hq
 RQg247.OJN5TdCf5SoIn2yiidzc3tXvoN9fRgoTGOypbAeG6.2z9eOx8rUaSvzWw8_aVSjovkQLN
 k4j2mar0ckwTekOmE7rzLkUGBxIHWBMxqnjxW8jhG01TzIZ3halgx65BSULBmVzmI.lJhXNJJGp2
 b_JLjUxrKjGvgcZ9w1E_ty27ePF48v6CjFUc.a95HvLk4zw--
X-Sonic-MF: <m.abubakar365@yahoo.com>
X-Sonic-ID: dba5a225-4dfe-448b-b3f3-6bf58f7c24fc
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-101 with HTTP; Mon, 28 Sep 2026 20:45:20 +0000
Received: from dip109.lsn.bf1.yahoo.com ([67.195.177.118])
          by hello (SMTP) with SMTP ID 04ae0d1948292bb83393907dff075e5d;
          Mon, 28 Sep 2026 20:45:18 +0000 (UTC)
From: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m.abubakar365@yahoo.com
Subject: Re: [PATCH 1/2] dt-bindings: iio: pressure: add Sensirion SDP31
Date: Tue, 29 Sep 2026 01:45:10 +0500
Message-ID: <20260928204510.2415-1-m.abubakar365@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260920014032.2cc3c851@jic23-hlaptop>
References: <20260920014032.2cc3c851@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 20 Sep 2026 01:40:32 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

Hi Jonathan,

Apologies - your v1 review replies were going to my spam folder and I
only saw them now. I have fixed that. I agree with all of the feedback
and will address it in v4.

> > +  compatible:
> > +    const: sensirion,sdp31
>
> It looks like there several similar parts that only differ in
> range.  Would be nice to support them all out of the box.  Fine
> to just test on one in a family like this.

The SDP31/SDP32/SDP33 differ only in measurement range, and the driver
already reads the scale factor from the sensor at runtime, so I will add
compatibles for all three (tested on the SDP31).

> > +  vdd-supply: true
>
> Where is the irq?  Even if a driver doesn't yet support all the
> features, the dt binding should describe them if at all possible.

I will add an optional interrupts property in v4.

> > +required:
> > +  - compatible
> > +  - reg
>
> Sashiko correctly points out that devices tend to need vdd-supply to
> work.  Hence it should be in the required.

Agreed - vdd-supply has been in the required list since v2.

I will also address your v3 driver comments (shorter I2C reads for the
normal measurement, and reading the scale factor separately) in v4.

Thanks for your patience, and for flagging the missed replies.

Muhammad Abu Bakar
