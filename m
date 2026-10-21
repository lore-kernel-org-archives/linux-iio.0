Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792608849;
	b=eltztFDggjLMmxk13Z06LCFPA6x384vjmqZ8XwQ18VnU8GTR4zIqGwAYul2qJ0LdJvXF
	 LH576k3RcJKqd0vzq+0cExeXg2MvZ0GeQZYmuUDtBTs99N0aHhL1a+qPpO2CZX/KpFuCL
	 +XcxXmvPDBGprgovr8nr4bpEPtbSfVP3RuHVUICxk8w+tCQx3G6WnAtl7XQmERoBvzXsf
	 j5YWZlmHQlhoFkvLpQLk5iGiI+YrE2yy0Q9eA4H5PsMBQ69tsC8hqjtc+FZ276RmwGveP
	 9D6srqg04Uf9Fvg8D0IaP5maT1CRoRjxDhWXarPR+qJdmGflmI4sJHTwQRWB8IxMrAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608849;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fHFDa/JKnVWZak8pH/341HZ4XAyUaMxgOSi8VNpe7Dw=;
	b=WlxSxVjtIbAfWBWrV2AhzO0Vj+gpGTmQVN4m7WlUIiGbTEDkjx1Ztshwoo2wT5gRsmPr
	 8Y9c6nkkyLYOKmQvfRMmxh17AP6r4HLOWiMr3E1d91KFYAFuZsYfheHAWwuE78S8CSTVp
	 5rv8AnZVQV119eZuqh45syV4wUcYx7eUYjkHaBBUjBYwsayhWxyIZCCKqxt23p5VmNtwn
	 wS3UIZYKBLyqmB27Kt/6ZtOa4uaftzz8sKk+WT3FhI2UqCG9v1r+JH7+Ri80sUIChlUvA
	 A4Juf6ud0lS0tQCrPgCeWy+ksgK4Faq5PaWZJV2Nxce6Hu4FCi8csXSytWJ6dsXvoAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RujC+YWn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A5D606A319;
	Wed, 21 Oct 2026 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RujC+YWn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909551F000C1;
	Wed, 21 Oct 2026 18:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792608849;
	bh=fHFDa/JKnVWZak8pH/341HZ4XAyUaMxgOSi8VNpe7Dw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RujC+YWnXVwKQIHx6ps5vOEIyyBjw7qen//E6KbtHV1Ur6xSWTAUof4Cqs7btdedi
	 6HNFe/hC2ka1myqeWW6tunyjS7kiPODZ5r/OWSu8eMDkEo7+2xaqRefvAZfHE8V3qY
	 pVNR3o/XvLzz7GRUK2SUyIZlnmHzLpjNLL+YqSuCqGIUDWy4eHeJYNiwu8Gbm7BvpL
	 eWCKCsGEedpz1bCtREayZrwDeW2sP1GeSZMnm/mzZ7MDRf/7OnmX5wobB0AvQbkNZM
	 niHYqvI5ayMYy5ejb77l7hng8S4sdOK0GGlAXZScIznsq+yNZPMEqld9+BJjXVqlL9
	 +l9Y6yKJFPUdA==
Date: Wed, 21 Oct 2026 19:54:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jishnu Prakash
 <jishnu.prakash@oss.qualcomm.com>, Daniel Lezcano
 <daniel.lezcano@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Dan
 Carpenter <error27@gmail.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, Bartosz Golaszewski <brgl@kernel.org>,
 Dhruvin Rajpura <dhruvin.rajpura@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5-gen3: Allocate unique ADC_TM
 aux device IDs
Message-ID: <20261021195401.6a70fe6a@jic23-hlaptop>
In-Reply-To: <atWzFlOgRICAGM-R@QCOM-aGQu4IUr3Y>
References: <20261008031154.3440632-1-shengchao.guo@oss.qualcomm.com>
	<atWzFlOgRICAGM-R@QCOM-aGQu4IUr3Y>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Oct 2026 14:05:10 +0800
Shawn Guo <shengchao.guo@oss.qualcomm.com> wrote:

> On Thu, Oct 08, 2026 at 11:11:54AM +0800, Shawn Guo wrote:
> > adc5_gen3_add_aux_tm_device() never sets the auxiliary device id, so
> > every ADC5 Gen3 instance with at least one qcom,adc-tm channel tries
> > to register the same device name. With ADC_TM channels on more than
> > one PMIC, the second instance to probe fails:
> > 
> >   sysfs: cannot create duplicate filename '/bus/auxiliary/devices/qcom_spmi_adc5_gen3.adc5_tm_gen3.0'
> >   ...
> >   auxiliary qcom_spmi_adc5_gen3.adc5_tm_gen3.0: adding auxiliary device failed!: -17
> >   qcom-spmi-adc5-gen3 c400000.spmi:pmic@8:adc@7200: error -EEXIST: Failed to add auxiliary TM device
> > 
> > The ADC probe then fails as a whole, so that PMIC loses both its IIO
> > channels and its thermal zones. This shows up on Nord, which has
> > thermistor channels on two PMAU0102 PMICs.
> > 
> > Allocate the id from a driver-wide IDA and release it from the
> > auxiliary device release callback. The ADC_TM driver matches on the
> > device name only, so the instance number does not affect binding.
> >   
> 
> Fixes: baff45179e90 ("iio: adc: Add support for QCOM PMIC5 Gen3 ADC")
> 
> > Assisted-by: LLM
> > Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>  

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
