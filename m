Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564597;
	b=EXZLNj7s3PyRucMuayCsvH+ICNUKXMYCzmLCAqFQFsuueriWdGglc4Xoij56ipHoh47r
	 rQGSlSauXiZppgctrdyc69AAH+HxQFZhqib4zdxByDrod+6von4QQWCtDVbD5Tpn99ZpT
	 JOxKp3hcoTRcfcaSb2Coij97P/5WseKz9f+FolbnzRhXgZZJVdqEz5SYawwa2O+GyHgx+
	 3nBRdSWUWkxrNJTXovsrDS2Sy1rm0PfdcOn/+Oc++E3FP59C0HsdDjKKvDM4FMct/0ijf
	 7jQ7gB08LGerYuIvYQ41SXKM2HMzGh+V9hmlvlxgK4Jy/UKi+2qKtXQVFP+uX5TcpIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564597;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=DI86z/0Iql/9v/K5OtJPg8rVycvTnslIkr8t7coMOfc=;
	b=v6shfIVgKKSH049NUb31CyVovJm8bn7r8NtyB9NBAc0vjv0E74qfg+eHiajfapkKYXWc
	 TwatiqRdm0ylNtnFfpOTXtXayzKSbXR/jclnG8DHwUht78vWdamLBvu+7IvWS6ouSDtO6
	 Dc5hytRn9Ct4dT6HHya0EP42t313gVqAVxk4gCe1Ch4a8pk+LkusD98XKijUnUKhCKR3n
	 cucFcCLzgZPcm03QXvHDKUC9+ekeFA2decxP1ATPxoX7+qx386gwocckfbljHKWcf8/Lb
	 bKDAOZrRxfie2cYXtj42YxsnfPpTUxrGQr5R3t+dSXtLTmL2B3Y7mtvXNCT9t+PpPVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=p6TyeFko;
	arc=none smtp.remote-ip=74.125.228.139
Received: from mail-ej2-f11.google.com (mail-ej2-f11.google.com [74.125.228.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868A2606A8BD
	for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 10:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 868A2606A8BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=p6TyeFko
Received: by mail-ej2-f11.google.com with SMTP id a640c23a62f3a-c504c069dcaso50671166b.1
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 02:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794564595; x=1795169395; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DI86z/0Iql/9v/K5OtJPg8rVycvTnslIkr8t7coMOfc=;
        b=p6TyeFkoVOUeZsZn+YShv7EPwTXNl4nm5v+8cd6w4mNijv/76ZHOonPgnttdyGWHSZ
         uIdexMvZ9JRZBPffyXh2pUxZFR4jWSuGrFipiIfD+EG+eg5YTLuoEOXo9FEdqpooZBMC
         rGdSQVMdhAxOa9pGZzVjc3efrhntuBZexoEB+v1b8dbGr+vzSeRSe7zFJnaKeTpnx2Nt
         B590OHIZSOAFKWdHE3H1S5NCMDILzqfTkV77AkZBPtflgccLep9cwQb5FK6Zf+L4F30k
         ry/j3H8g59MVDo+3QQxIWzqBneHeP5D97A/+Jo1ZnDLPRw3bPwE4QoZEeO2FeUb+zx5l
         PJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564595; x=1795169395;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DI86z/0Iql/9v/K5OtJPg8rVycvTnslIkr8t7coMOfc=;
        b=SzufZTuFNpAVdgls85Cx5mysLz9CEL42qyxkMQmYiQZkhbX7aUH3WdkWJL4xZZTlPr
         XpY6k1EstPoqCSfcTnf7MIQyJHawvY7xqOgrnngqAriIyCLvpGxBN+Wgu52YxIOO+PNx
         yj2zJc5uv+j30dxHqYKTE8zMLpsMAmfDAhzZUVUbElQ6IWORK0rV9LfKgvCob8lvqiga
         8hHe4qYNCA6lpRXOyCtcb2HjC2H8+2MALszPmZooFD+OzUXXPeiadhcIgiO0yr3Shj4M
         7IyS9yimjEaRXE4tZPttYth3A4s9fDQ28RBdbZy4WfkP5p6E5JLKYIsU9d79uoQWc+HD
         hWPw==
X-Forwarded-Encrypted: i=1; AL+hErF8ZDZxK/OdbpTkEbDKtIwKHPsaqYH6FNNzPNU6UDaNOFL9+MEii7GL6yd1H93+XZcgY8rnPcsguE8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zrAfRI570PBu1kCLbdFPqSHqMuqVepF8swrsx8PZqIMQVOp+k
	ZF8BZO03JuO/3rh/m0zJcxIU0OKuE1lezVz9vqPafESQNpvGgHYtKdN9GxA323BRaB8=
X-Gm-Gg: AYBFou2Im1U2Vnxb2YxkEqMi4MOV0TAlqSoaovft1iDq9KhnhPqyDDgj2PmvFN8jho8
	RzooXKSpmS9Z5ZedbJHrM8JUD+3qVPNNNxTvrn0yEpSMoUs9r9WHxdQ0UnMf2AF+ZjITzPECQTV
	+mW2kAtPGZWYipnnUpeGM5BcHAjtRmOLTiSMg2wYNfTu1gxVZiEQWTqttxIVAOCdPOSdRJCm3vi
	DRZgDcZjOWN+IlhKrkouJvdPM7lpBHXi5oqF+rVcap6/VDqI4cqS9Dvz4d1FFcWkzhFr3Uk53A/
	Yrt13jGF/Qjg8J7v0s84DrK0ej6hBLQfR4k1JrJhaB9lEXvJWAgMCXYmnixjK/ebVKfkx/LG4S8
	q2GCzyTLxbop+53UxrJ3T74O2p5tZ0V0XGj0k6UYP+0+NKudjJTOKOZaAgtagkJm6yul5L2KvyE
	Vo2HFnYEFlfF55HJUOC0d8kdjJo2UrmEsfDmrrKQN6qJdf0ZzN7NvpMTz4fHlf+YBW1dunsgi9K
	qTPZsf3u7i96pxL/2Gc9sbXWIW2ZBu8G7brsBnCpmt3ggpv8cszvFQeHKB5idtSPWIlP8uC/7Nj
	2M4/0yPNwPPIFZL2TxFfzKNerPv0O89P2y6fdLSXc4IAmLfYixcD5oWCGlgT7cssZFVYx2D39g=
	=
X-Received: by 2002:a17:907:d40d:b0:c25:504a:1e25 with SMTP id a640c23a62f3a-c5096372189mr164295066b.13.1794564594691;
        Fri, 13 Nov 2026 02:09:54 -0800 (PST)
Received: from localhost (144-178-202-142.static.ef-service.nl. [144.178.202.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095a5b93csm75758766b.5.2026.11.13.02.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 02:09:54 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Nov 2026 11:09:53 +0100
Message-Id: <DMU0219YWEL8.35KQSMY192RH4@fairphone.com>
Cc: "Marc Lainez" <marc.lainez@gmail.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>, =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?=
 <barnabas.czeman@mainlining.org>, "Danila Tikhonov" <danila@jiaxyga.com>,
 "Sebastian Reichel" <sre@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>, "Konrad
 Dybcio" <konradybcio@kernel.org>, "Abel Vesa" <abelvesa@kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <phone-devel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] iio: adc: qcom-spmi-adc5: Add
 ADC5_BAT_THERM_100K_PU
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Val Packett" <val@packett.cool>, "Jonathan Cameron" <jic23@kernel.org>,
 "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20261112170841.2189322-1-val@packett.cool>
 <20261112170841.2189322-4-val@packett.cool>
In-Reply-To: <20261112170841.2189322-4-val@packett.cool>

Hi Val,

On Thu Nov 12, 2026 at 6:07 PM CET, Val Packett wrote:
> Even though it existed in bindings for the longest time,
> ADC5_BAT_THERM_100K_PU was never assigned in the driver. Do so.
>
> Signed-off-by: Val Packett <val@packett.cool>
> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi=
-adc5.c
> index d57ba8526e0c..c27ff89429f5 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -542,6 +542,8 @@ static const struct adc5_channels adc5_chans_pmic[ADC=
5_MAX_CHANNEL] =3D {
>  					SCALE_HW_CALIB_DEFAULT)
>  	[ADC5_XO_THERM_100K_PU]	=3D ADC5_CHAN_TEMP("xo_therm", 0,
>  					SCALE_HW_CALIB_XOTHERM)
> +	[ADC5_BAT_THERM_100K_PU]	=3D ADC5_CHAN_TEMP("bat_therm", 0,
> +					SCALE_HW_CALIB_THERM_100K_PULLUP)

While this will work fine for some devices, unfortunately this won't
work for quite some other devices that don't use a 30K, 100K or 400K
NTC in the battery - or when the NTC beta (B) is differing to the
hardcoded lookup table.

For example on Fairphone 4 (pm7250b fwiw), the battery has a 10k=CE=A9 NTC,
so using the ADC5_BAT_THERM_30K_PU with the hard-coded lookup tables
would result in very wrong temperature values. Even ignoring the whole
NTC beta topic.

You can see my proposed patch series at
https://lore.kernel.org/linux-arm-msm/20260220-bat-temp-adc-v2-0-fe34ed4ea8=
51@fairphone.com/

Unfortunately it's from February and I haven't spent more time on this
topic since then, mostly because fuel gauge anyways was downstream, so
pushing just this upstream wouldn't make much difference.

Now it does, so I should get back to it... Let me know your thoughts!

(Fairphone 3 with SDM632/PMI632 would actually be fine-ish as-is because
the battery has a 100k=CE=A9 NTC and the beta probably is close enough to
what's in adcmap_100k_104ef_104fb_1875_vref)

Regards
Luca

>  	[ADC5_BAT_ID_100K_PU]	=3D ADC5_CHAN_TEMP("bat_id", 0,
>  					SCALE_HW_CALIB_DEFAULT)
>  	[ADC5_AMUX_THM1_100K_PU] =3D ADC5_CHAN_TEMP("amux_thm1_100k_pu", 0,


