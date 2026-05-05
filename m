Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CB239DBC4
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971074; cv=none; b=mBTi5YN2tZkBoZV8Q4wdWQA3avtlBpM9Dwr/QsvhKuTANd8kTyDNa+vrajxD8wPQCr9tCnLEmt8nZO1z9FZLYCLIqPWrj54o0v4iW+sF6OiuiYi5skKiUuSsNETN1ZKDy6AGQmVEqyCIXzTOqEYeE00If7kf6ElL7r2IGf07avk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971074; c=relaxed/simple;
	bh=cEZhW8KYCKixVAk55jy4dkQ/Llkfg0D++tdE4jLIF8I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=T+MDqYaFq91OworMVGaQUnUi0lH55NRhYHMsD90YNPMAN312GVd2W5TmuFAZdGtZ1uJCWaoJLpBDTG32h3E3lrRIEeReV+mv3w0cJhqxXawwTSW8/ejJ8QHKkXEUbqtZPYhH9RUJNCtgSHrYKd0Rdd698YUtIB0LlZUskO/uSlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7Xa/His; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7Xa/His"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b788a98557so41042005ad.2
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 01:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777971070; x=1778575870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=deuvhuoT/PEkTLGroBD2lxRR1IsM8TC5GoUdjRAYDM4=;
        b=E7Xa/HisoMILXaAXn1o2FhXNBDZPgsYeQh5D/Hco4esaMOXLFLegRhxv+XMCZOjZR4
         HFGuDYRVUN1G+H/mUD9LiDaoQNuTESB4NbJooxwd81UtQbMyenOdBPWVvjjJNqbZEATU
         yOThByeiRV7pcbbzQzoGzxYRbnRJd5KsoQ6jKkOBKtbqiGvNelgx16d2VfjB8kA/ibhA
         eQN9kDMG91pEyqxz5NmxqjCwl2RAJ2I25cxM0DU7mUHYTElJvwk8crisZ2LHSLHByBSh
         LuQNJd7Q2OdiAf9CqsLJuFEA+04q8xMNR18Zm2ui1Nnv/W03NOa/CV/HXx/pIobEYpbz
         Ha4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777971070; x=1778575870;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=deuvhuoT/PEkTLGroBD2lxRR1IsM8TC5GoUdjRAYDM4=;
        b=eqJ9L2cgMXudgGqC2E21w+deANsNpq21lDm4+ZwsWJOoPlb/TApvLYDnp6DgAxSNmF
         ecYkUN9F1rc5zgEasLrUhdpxKCtBB1Md+QMnd/THuY4ZMwLR+McelREw3qre63t+Mr4i
         3peTPguMi0zkpWSgXjyP75cGV/x7ALtxBDbv529PDFNEZCe26iVmgirC/g7BTvclSNRa
         W6qHcbVfVDzDswmtUnQ+qzFMPN9CZbgGSVARmTxcIc/osNwvjK4yukS03Ib0UcdreG6A
         zZvJGTCIqEpZ+7S2ryZ/dkYLG7OrxV74moM1bM7dOGGSpxOrd+f7+1sNDMWAKqn3WgYN
         LmXw==
X-Forwarded-Encrypted: i=1; AFNElJ/87ZVhUa2fTdOWNI3FOpVSw/B/hm8tMBICa+pphckEsnLQDmBSzsZ4hMfv88Eu/NMCUjbi8hg5xt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS2iwOrbV0Fgm4/rA1wsg7DVLbA8PtFpRv1YY9pdHuM5yJ5l/A
	5UtNH5Q5/zJg3dTAnkaOo9JwmMGjl9MbaaL6390YrAVOhOyEuXuRNfjSIxR0Mw==
X-Gm-Gg: AeBDiesLZkUy3Uonh40WJIpGZamEeP8N1dd6YacMi3DehXdQ4UkCFCr8mHJ2CyjnBjq
	su06rVdIE5SsHJZDsqAQ39X5ah6kNVrkdcxLdlfnPDxw2t0nRmPT0sF3w8C0ax5W0SP4PD0veQR
	pEboEm1Jg7L0PUJnbhuGh5EDGsilZS1fbWCjR8hNjha6E0wWN7cdVm8rnBKerW5a7/Gii3HYS3/
	Sh+csfEdgGJumuXyxF0u57TELQZjUHb7U+Pjo/B4bQr3e55MDYuVH8KUx6c9JVSuPrhYQBlckuS
	t0hgyB50/HnsimnCguQ/cK6Oq49dCkpV0tVpydyNnPLQcCb3sIo2MeBRV51izexSYay5xpMrhDI
	4rvqJGKvnthKcCvljrf6SCqKgm3LE+Lxg086lLbLi80D/7pSnr9THPJc3j7DKeEn0QiSr/gP/Ka
	IRUmHwEy/5ZMCGzEroW64XGIFxnUPli4TOueSAzm7DNLoynU6kteCDogb2VA==
X-Received: by 2002:a05:6a20:6a11:b0:3a0:b781:4c80 with SMTP id adf61e73a8af0-3a7f1a1dd55mr13836947637.4.1777971069659;
        Tue, 05 May 2026 01:51:09 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:c034:59f5:b454:66ec:1f0c:a50d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbcac2cfsm11896817a12.32.2026.05.05.01.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 01:51:09 -0700 (PDT)
Date: Tue, 05 May 2026 08:00:23 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: dlechner@baylibre.com, nuno.sa@analog.com, lars@metafoo.de, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] MAINTAINERS: iio: adi: consolidate entries
User-Agent: Thunderbird for Android
In-Reply-To: <20260504172457.4d7c7390@jic23-huawei>
References: <20260430190642.3434650-1-sanjayembedded@gmail.com> <20260430190642.3434650-3-sanjayembedded@gmail.com> <20260504172457.4d7c7390@jic23-huawei>
Message-ID: <AB6B7E29-83E2-4BE8-AF74-1DE8358527E6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 4 May 2026 9:54:57=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel=2Eorg=
> wrote:
>On Fri,  1 May 2026 00:36:39 +0530
>Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom> wrote:
>
>> From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>>=20
>> Remove redundant per-driver entries already covered by wildcard paths
>> under ANALOG DEVICES INC IIO DRIVERS for drivers/iio/adc/ad* drivers=2E
>>=20
>> Keep entries where specific maintainers exist=2E
>
>This seems to be where it's gone wrong - if this were followed
>I'd be fine with it=2E  Actually also applies where there is
>a specific reviewer listed - not sure we have any where there
>isn't also a maintainer though=2E
>
>>=20
>> Suggested-by: Jonathan Cameron <jonathan=2Ecameron@huawei=2Ecom>
>> Acked-by: Nuno S=C3=A1 <nuno=2Esa@analog=2Ecom>
>
>Substantial enough change from anything that I think Nuno would
>have tagged that you should have dropped his Acked-by:
>
Sure, I will drop this tag from all patches in this series=2E

Although tag was added in all patches of series as he mentioned Acked-by o=
n your proposal of catch all common entry=2E

>> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>> ---
>>  MAINTAINERS | 158 +---------------------------------------------------
>>  1 file changed, 3 insertions(+), 155 deletions(-)
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 34b67d010e87=2E=2Ebd14e15f04c9 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -451,17 +451,6 @@ W:	http://wiki=2Eanalog=2Ecom/AD7142
>>  W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>>  F:	drivers/input/misc/ad714x=2Ec
>> =20
>> -AD738X ADC DRIVER (AD7380/1/2/4)
>> -M:	Michael Hennerich <michael=2Ehennerich@analog=2Ecom>
>> -M:	Nuno S=C3=A1 <nuno=2Esa@analog=2Ecom>
>Specific maintainer=2E Why is it going?

I'm assuming that to avoid de-bounce issues from *@analog=2Ecom domain, we=
 are adding linux@analog=2Ecom mailing list as primary contact=2E with that=
 in mind, this series drops all entries which match the wildcard and have a=
nalog domain maintainer or reviewer while keeping the rest as unchanged=2E
>
>> -R:	David Lechner <dlechner@baylibre=2Ecom>

Additionally, When David is list as reviewer in individual driver entries,=
 I consider as redundant part; All IIO subsystem drivers/iio* already cover=
ed by top level entry, which includes Andy and David as reviewer=2E

Summary of changes in series:
- analog domain specific entries are dropped and catch with linux@analog=
=2Ecom under ADI IIO section=2E
- Non analog devices reviewers and maintainer is unchanged for each driver=
 entry=2E

Further, I also agree with adding Nuno S=C3=A1 as a maintainer in the top-=
level ADI IIO entry, so that all drivers are maintained via the mailing lis=
t with his oversight=2E

>> -S:	Supported
>> -W:	https://wiki=2Eanalog=2Ecom/resources/tools-software/linux-drivers/=
iio-adc/ad738x
>> -W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad7380=2Eyaml
>> -F:	Documentation/iio/ad7380=2Erst
>> -F:	drivers/iio/adc/ad7380=2Ec
>> -
>>  AD7476 ADC DRIVER FOR VARIOUS SIMPLE 1-CHANNEL SPI ADCs
>>  M:	Matti Vaittinen <mazziesaccount@gmail=2Ecom>
>>  S:	Maintained
>> @@ -481,16 +470,6 @@ W:	http://wiki=2Eanalog=2Ecom/AD7879
>>  W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>>  F:	drivers/input/touchscreen/ad7879=2Ec
>> =20
>> -AD7944 ADC DRIVER (AD7944/AD7985/AD7986)
>> -M:	Michael Hennerich <michael=2Ehennerich@analog=2Ecom>
>> -M:	Nuno S=C3=A1 <nuno=2Esa@analog=2Ecom>
>> -R:	David Lechner <dlechner@baylibre=2Ecom>
>> -S:	Supported
>> -W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad7944=2Eyaml
>> -F:	Documentation/iio/ad7944=2Erst
>> -F:	drivers/iio/adc/ad7944=2Ec
>> -
>>  ADAFRUIT MINI I2C GAMEPAD
>>  M:	Anshul Dalal <anshulusr@gmail=2Ecom>
>>  L:	linux-input@vger=2Ekernel=2Eorg
>> @@ -1415,15 +1394,6 @@ F:	Documentation/devicetree/bindings/iio/dac/adi=
,ad3552r=2Eyaml
>>  F:	Documentation/iio/ad3552r=2Erst
>>  F:	drivers/iio/dac/ad3552r=2Ec
>> =20
>> -ANALOG DEVICES INC AD4000 DRIVER
>> -M:	Marcelo Schmitt <marcelo=2Eschmitt@analog=2Ecom>
>> -L:	linux-iio@vger=2Ekernel=2Eorg
>> -S:	Supported
>> -W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad4000=2Eyaml
>> -F:	Documentation/iio/ad4000=2Erst
>> -F:	drivers/iio/adc/ad4000=2Ec
>> -
>>  AD4030 ADC DRIVER (AD4030-24/AD4630-16/AD4630-24/AD4632-16/AD4632-24)
>>  M:	Michael Hennerich <michael=2Ehennerich@analog=2Ecom>
>>  M:	Nuno S=C3=A1 <nuno=2Esa@analog=2Ecom>
>> @@ -1435,78 +1405,6 @@ F:	Documentation/devicetree/bindings/iio/adc/adi=
,ad4030=2Eyaml
>>  F:	Documentation/iio/ad4030=2Erst
>>  F:	drivers/iio/adc/ad4030=2Ec
>> =20
>> -ANALOG DEVICES INC AD4062 DRIVER
>> -M:	Jorge Marques <jorge=2Emarques@analog=2Ecom>
>> -S:	Supported
>> -W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad4062=2Eyaml
>> -F:	Documentation/iio/ad4062=2Erst
>> -F:	drivers/iio/adc/ad4062=2Ec
>> -
>> -ANALOG DEVICES INC AD4080 DRIVER
>> -M:	Antoniu Miclaus <antoniu=2Emiclaus@analog=2Ecom>
>> -L:	linux-iio@vger=2Ekernel=2Eorg
>> -S:	Supported
>> -W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad4080=2Eyaml
>> -F:	drivers/iio/adc/ad4080=2Ec
>> -
>> -ANALOG DEVICES INC AD4130 DRIVER
>> -M:	Cosmin Tanislav <cosmin=2Etanislav@analog=2Ecom>
>> -L:	linux-iio@vger=2Ekernel=2Eorg
>> -S:	Supported
>> -W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> -F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
>> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130=2Eyaml
>> -F:	drivers/iio/adc/ad4130=2Ec
>> -
>> -ANALOG DEVICES INC AD4134 DRIVER
>> -M:	Marcelo Schmitt <marcelo=2Eschmitt@analog=2Ecom>
>> -L:	linux-iio@vger=2Ekernel=2Eorg
>> -S:	Supported
>> -W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad4134=2Eyaml
>> -F:	drivers/iio/adc/ad4134=2Ec
>> -
>> -ANALOG DEVICES INC AD4170-4 DRIVER
>> -M:	Marcelo Schmitt <marcelo=2Eschmitt@analog=2Ecom>
>> -L:	linux-iio@vger=2Ekernel=2Eorg
>> -S:	Supported
>> -W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad4170-4=2Eyaml
>> -F:	drivers/iio/adc/ad4170-4=2Ec
>> -
>> -ANALOG DEVICES INC AD4691 DRIVER
>> -M:	Radu Sabau <radu=2Esabau@analog=2Ecom>
>> -L:	linux-iio@vger=2Ekernel=2Eorg
>> -S:	Supported
>> -W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad4691=2Eyaml
>> -F:	drivers/iio/adc/ad4691=2Ec
>> -F:	drivers/iio/adc/ad4691=2Erst
>> -
>> -ANALOG DEVICES INC AD4695 DRIVER
>> -M:	Michael Hennerich <michael=2Ehennerich@analog=2Ecom>
>> -M:	Nuno S=C3=A1 <nuno=2Esa@analog=2Ecom>
>> -R:	David Lechner <dlechner@baylibre=2Ecom>
>> -L:	linux-iio@vger=2Ekernel=2Eorg
>> -S:	Supported
>> -W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad4695=2Eyaml
>> -F:	Documentation/iio/ad4695=2Erst
>> -F:	drivers/iio/adc/ad4695=2Ec
>> -F:	include/dt-bindings/iio/adc/adi,ad4695=2Eh
>> -
>> -ANALOG DEVICES INC AD4851 DRIVER
>> -M:	Sergiu Cuciurean <sergiu=2Ecuciurean@analog=2Ecom>
>> -M:	Dragos Bogdan <dragos=2Ebogdan@analog=2Ecom>
>> -R:	Antoniu Miclaus <antoniu=2Emiclaus@analog=2Ecom>
>> -L:	linux-iio@vger=2Ekernel=2Eorg
>> -S:	Supported
>> -W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad4851=2Eyaml
>> -F:	drivers/iio/adc/ad4851=2Ec
>> -
>>  ANALOG DEVICES INC AD5706R DRIVER
>>  M:	Alexis Czezar Torreno <alexisczezar=2Etorreno@analog=2Ecom>
>>  L:	linux-iio@vger=2Ekernel=2Eorg
>> @@ -1515,31 +1413,6 @@ W:	https://ez=2Eanalog=2Ecom/linux-software-driv=
ers
>>  F:	Documentation/devicetree/bindings/iio/dac/adi,ad5706r=2Eyaml
>>  F:	drivers/iio/dac/ad5706r=2Ec
>> =20
>> -ANALOG DEVICES INC AD7091R DRIVER
>> -M:	Marcelo Schmitt <marcelo=2Eschmitt@analog=2Ecom>
>> -L:	linux-iio@vger=2Ekernel=2Eorg
>> -S:	Supported
>> -W:	http://ez=2Eanalog=2Ecom/community/linux-device-drivers
>> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r*
>> -F:	drivers/iio/adc/ad7091r*
>> -
>> -ANALOG DEVICES INC AD7191 DRIVER
>> -M:	Alisa-Dariana Roman <alisa=2Eroman@analog=2Ecom>
>> -L:	linux-iio@vger=2Ekernel=2Eorg
>> -S:	Supported
>> -W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad7191=2Eyaml
>> -F:	Documentation/iio/ad7191=2Erst
>> -F:	drivers/iio/adc/ad7191=2Ec
>> -
>> -ANALOG DEVICES INC AD7192 DRIVER
>> -M:	Alisa-Dariana Roman <alisa=2Eroman@analog=2Ecom>
>> -L:	linux-iio@vger=2Ekernel=2Eorg
>> -S:	Supported
>> -W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad7192=2Eyaml
>> -F:	drivers/iio/adc/ad7192=2Ec
>> -
>>  ANALOG DEVICES INC AD7292 DRIVER
>>  M:	Marcelo Schmitt <marcelo=2Eschmitt1@gmail=2Ecom>
>>  L:	linux-iio@vger=2Ekernel=2Eorg
>> @@ -1584,15 +1457,6 @@ F:	Documentation/devicetree/bindings/iio/adc/adi=
,ad7625=2Eyaml
>>  F:	Documentation/iio/ad7625=2Erst
>>  F:	drivers/iio/adc/ad7625=2Ec
>> =20
>> -ANALOG DEVICES INC AD7768-1 DRIVER
>> -M:	Michael Hennerich <Michael=2EHennerich@analog=2Ecom>
>> -L:	linux-iio@vger=2Ekernel=2Eorg
>> -S:	Supported
>> -W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad7768-1=2Eyaml
>> -F:	drivers/iio/adc/ad7768-1=2Ec
>> -F:	include/dt-bindings/iio/adc/adi,ad7768-1=2Eh
>> -
>>  ANALOG DEVICES INC AD7780 DRIVER
>>  M:	Michael Hennerich <Michael=2EHennerich@analog=2Ecom>
>>  M:	Renato Lui Geh <renatogeh@gmail=2Ecom>
>> @@ -1611,16 +1475,6 @@ W:	https://ez=2Eanalog=2Ecom/linux-software-driv=
ers
>>  F:	Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366=2Eyaml
>>  F:	drivers/iio/amplifiers/ad8366=2Ec
>> =20
>> -ANALOG DEVICES INC AD9467 DRIVER
>> -M:	Michael Hennerich <Michael=2EHennerich@analog=2Ecom>
>> -M:	Nuno Sa <nuno=2Esa@analog=2Ecom>
>> -L:	linux-iio@vger=2Ekernel=2Eorg
>> -S:	Supported
>> -W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> -F:	Documentation/ABI/testing/debugfs-iio-ad9467
>> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad9467=2Eyaml
>> -F:	drivers/iio/adc/ad9467=2Ec
>> -
>>  ANALOG DEVICES INC AD8460 DRIVER
>>  M:	Mariel Tinaco <Mariel=2ETinaco@analog=2Ecom>
>>  L:	linux-iio@vger=2Ekernel=2Eorg
>> @@ -1654,14 +1508,6 @@ W:	https://ez=2Eanalog=2Ecom/linux-software-driv=
ers
>>  F:	Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250=2Eyaml
>>  F:	drivers/iio/amplifiers/ada4250=2Ec
>> =20
>> -ANALOG DEVICES INC ADE9000 DRIVER
>> -M:	Antoniu Miclaus <antoniu=2Emiclaus@analog=2Ecom>
>> -L:	linux-iio@vger=2Ekernel=2Eorg
>> -S:	Supported
>> -W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> -F:	Documentation/devicetree/bindings/iio/adc/adi,ade9000=2Eyaml
>> -F:	drivers/iio/adc/ade9000=2Ec
>> -
>>  ANALOG DEVICES INC ADF4377 DRIVER
>>  M:	Antoniu Miclaus <antoniu=2Emiclaus@analog=2Ecom>
>>  L:	linux-iio@vger=2Ekernel=2Eorg
>> @@ -1866,12 +1712,14 @@ L:	linux@analog=2Ecom
>>  S:	Supported
>>  W:	http://wiki=2Eanalog=2Ecom/
>>  W:	https://ez=2Eanalog=2Ecom/linux-software-drivers
>> +F:	Documentation/ABI/testing/debugfs-iio-ad9467
>> +F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
>>  F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
>>  F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
>>  F:	Documentation/devicetree/bindings/iio/*/adi,*
>>  F:	Documentation/devicetree/bindings/iio/adc/lltc,ltc2496=2Eyaml
>>  F:	Documentation/devicetree/bindings/iio/adc/lltc,ltc2497=2Eyaml
>> -F:	Documentation/iio/ad7606=2Erst
>> +F:	Documentation/iio/ad*=2Erst
>>  F:	drivers/iio/*/ad*
>>  F:	drivers/iio/adc/ltc249*
>>  F:	drivers/iio/amplifiers/hmc425a=2Ec
>
