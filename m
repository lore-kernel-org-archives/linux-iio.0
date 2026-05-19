Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1977A37A486
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779190538; cv=none; b=W6j7gN/I9mwvnnWrocd6jysHAsUw0PllKd4xXxTEYqLXMfgCEE/jtuB+2EgfFhzPyekXNYgUyNYWMKUpoD7BMx1VMfsW978YnVXsL1mltP/cNKgEKexRa79Qoc8SMVJ/Y5KRt9dxeLUp5ecksirDukYzy3CWlVi/3jmvi6QSbxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779190538; c=relaxed/simple;
	bh=IJvmC4+MDzgDR3x1/mmW1jiZo0QKanZz2BpoZIZ7PFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMuoHei0MBvBPzxU6qG8eY9sY2eD4TZ4JjLUcYsEjH9ksRldQr7f1o/GIPSiaoMT7dYgz6GapQwKjs7ZOTQK+irMjm53U3H0w9Pak2PhQbwkldiZpaSKNpBX7ZElo0PVpoqarqkV+0FG//pohgOWqaykxh6RfYt5Qh9heWUZXkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCHnO/kL; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCHnO/kL"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a8e33556c0so4621628e87.0
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 04:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779190535; x=1779795335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VqQsxr0ZnYs3BWly02d5Mve2EarybI6uUYgpZNOCriw=;
        b=YCHnO/kLqqvl8T1wsIuBeskIsrPM+9yMORyhSlcdgUvXzvj9+EzpFQWpd6jk3RejOR
         wV6ozCH9Dp3cCBivqZai9l6nL7j08V2pGVXg7tN0reB4PNyWSi9SFGFcD3AjSkvihdW6
         biuD2O0pT2zE4js8+2fE95cZoMANuFvtAWi7A468VmDMmOhwi+0yiW/gNqzubdRxK4vU
         mlLVkTnUKdU8XYpaxvS8SiVZH8r/EcocEGnuyoTan/NEszqm6/3bys0p55UvQM/t+9BC
         Y3i/dncsISPY1The3dlzONtCYZjh+k0o1C7b5osriOtuwMLdkIKhIfhAkmlJgMfTe3nv
         XcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779190535; x=1779795335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VqQsxr0ZnYs3BWly02d5Mve2EarybI6uUYgpZNOCriw=;
        b=EWN0xsiRvVNBkT9bP7wClquffl17YyTvd+Mc+YqZzzomjFJKIvMrxkk5UkWnPJPRZZ
         wWS5OxegkvcfsktU04nGmSTQhxDilw9hgaQzRLnn16tFqc2v8lw9pOikQEH6bDuq7ous
         0sSwzeVp4dL7UP6wU4Lb13hxy85XAc/r9ZWO+UIIA2I6SfyZajv9m3W3xkQe2wVzjH50
         b2YgX6q4lFKPPnux7jiK8oVojTIGCClBJZbaSdjCGfwhgjONBLImgr0GLgph+owucjay
         k4jsM/Q88M4WRWr8H17/Fx7MedEV59QrtcTyu2HKuXk9OlNSGOeSbeAEtGfbPIMiqpK0
         57cA==
X-Forwarded-Encrypted: i=1; AFNElJ9NIWsknJux7LxAcsA2yoxp6GckZovBce+KqMFNkivg3+ViwFokRmaYs17xnzaSZVAv+GfarNANogk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh5C2Lf+K8wF4uJq0wo1pY/XoaeHwOVofiVi3x5QpSehphmU3p
	p46p5z6v6hJz81Ais62v8XVGV+4JuEyg9OamW4c1ghTVnPB27iiWXrJz
X-Gm-Gg: Acq92OEkbsOR7lqaPzm7Fmf0pMoqQrnSXSTer6FRP7EXOyCel0HtBfEv6irpzh21Lah
	vWRMCwTQ5opFD9BSsAqMIlFHel1HWpArsKIyOh6oTWjmh9xAocum0bKL6c/XzaT+DAV0Boe7wV5
	56+kGOhEpZewRkQI5VXHdF2omVbhnXC78+9dtf67gIKRhWijwttG3GtAwu7IVlNRidq+2TJfHPG
	dd3Dk9I8oyWkisOMink1nInfv/sXFS0MCtY0OoOinqeYj1aFThgRILlRkn9Xe+IUQfpAUGxjpfE
	M5AfbQ12k6UUCsEQphmC3pFo4XSCFSZTtSCgYia0a9AX3hdDEJLo2p8LA5j+xzXLulHaEQrDFKT
	RVN1OP1bx80AWsbbPKJ3aajaxHIAy2xVEEW1vLfBBjZFQlnhS/j7AtRG7hkKlV+hZPjpaB0Itdo
	U06qSZS0xaj+7zQ0rfJ2IbVRjJu+v0Wh73
X-Received: by 2002:a05:6512:1044:b0:5a8:837a:2a98 with SMTP id 2adb3069b0e04-5a8ffc6705bmr7032449e87.14.1779190534830;
        Tue, 19 May 2026 04:35:34 -0700 (PDT)
Received: from [10.38.18.54] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164cce46sm4083047e87.68.2026.05.19.04.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 04:35:34 -0700 (PDT)
Message-ID: <924e453a-e991-4689-8f22-667b71f152f5@gmail.com>
Date: Tue, 19 May 2026 14:35:31 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] iio: Initialize i2c_device_id arrays using member
 names
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>,
 Petre Rodan <petre.rodan@subdimension.ro>,
 Dan Robertson <dan@dlrobertson.com>, Herve Codina
 <herve.codina@bootlin.com>, Francesco Dolcini <francesco@dolcini.it>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Anshul Dalal <anshulusr@gmail.com>,
 Gustavo Silva <gustavograzs@gmail.com>, Andreas Klinger <ak@it-klinger.de>,
 Tomasz Duszynski <tduszyns@gmail.com>,
 Ariana Lazar <ariana.lazar@microchip.com>,
 Rui Miguel Silva <rmfrfs@gmail.com>, Linus Walleij <linusw@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, Li peiyu
 <579lpy@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Alex Lanzano <lanzano.alex@gmail.com>, Jagath Jog J
 <jagathjog1996@gmail.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Remi Buisson <remi.buisson@tdk.com>, Christian Eggers <ceggers@arri.de>,
 Mudit Sharma <muditsharma.info@gmail.com>,
 Kevin Tsai <ktsai@capellamicro.com>, =?UTF-8?Q?Ond=C5=99ej_Jirman?=
 <megi@xff.cz>, Dixit Parmar <dixitparmar19@gmail.com>,
 Gerald Loacker <gerald.loacker@wolfvision.net>,
 Akhilesh Patil <akhilesh@ee.iitb.ac.in>, Eddie James
 <eajames@linux.ibm.com>,
 Petar Stoykov <petar.stoykov@prodrive-technologies.com>,
 Song Qiang <songqiang1304521@gmail.com>, Siratul Islam <email@sirat.me>,
 Crt Mori <cmo@melexis.com>, Waqar Hameed <waqar.hameed@axis.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Gustavo Vaz <gustavo.vaz@usp.br>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Chuang Zhu <git@chuang.cz>, Kyle Hsieh <kylehsieh1995@gmail.com>,
 Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
 Chen-Yu Tsai <wens@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Sander Vanheule <sander@svanheule.net>, David Jander <david@protonic.nl>,
 Andrew Davis <afd@ti.com>, chuguangqing <chuguangqing@inspur.com>,
 Shrikant Raskar <raskar.shree97@gmail.com>, Kurt Borja <kuurtb@gmail.com>,
 Denis Benato <benato.denis96@gmail.com>,
 Ethan Tidmore <ethantidmore06@gmail.com>,
 Tomas Borquez <tomasborquez13@gmail.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Shi Hao <i.shihao.999@gmail.com>, Xichao Zhao <zhao.xichao@vivo.com>,
 Erikas Bitovtas <xerikasxx@gmail.com>, Aldo Conte <aldocontelk@gmail.com>,
 Colin Ian King <colin.i.king@gmail.com>,
 Gabriel Almeida <gabrielsousa230@gmail.com>,
 Gabriela Victor <gabevictor333@gmail.com>,
 Beatriz Viana Costa <beatrizvianacosta16@gmail.com>,
 Frank Li <Frank.Li@nxp.com>, Adrian Fluturel <fluturel.adrian@gmail.com>,
 Antoni Pokusinski <apokusinski01@gmail.com>,
 Yasin Lee <yasin.lee.x@gmail.com>, Felix Gu <ustc.gu@gmail.com>,
 Ben Collins <bcollins@watter.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1779136001.git.u.kleine-koenig@baylibre.com>
 <4b6ea3483356d758a90bfb8970ed0f1df2f31cfc.1779136001.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <4b6ea3483356d758a90bfb8970ed0f1df2f31cfc.1779136001.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/05/2026 11:13, Uwe Kleine-König (The Capable Hub) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
> 
> The mentioned robustness is relevant for a planned change to struct
> i2c_device_id that replaces .driver_data by an anonymous union.
> 
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

I took a look at the ROHM/Kionix stuff. All of it looked good to me, thanks!

So, for rohm-XXXX, bhXXXX, kxXXXX:
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
	-- Matti


-- 
---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
