Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2AB2F90C9
	for <linux-iio@vger.kernel.org>; Sun,  5 Jul 2026 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783273664; cv=none; b=jDIwVnPJZuil7ktg9uH9Bo7DdDUFs08JDk+BJbraZxg5qsTJFFgb8qG0AImpa3ewqkaqr4RMmoRVG5UNQZaonLvjJu1xejKyidQBpRxSVts8/LaDh8+/l/kS+oak7QDlfFkSg6SKWQ3odUCl3Hf8rE4cgCZx0oqXSApctbyhBFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783273664; c=relaxed/simple;
	bh=+DWCiJuHtexmYzOgAlNi4lBL2tdyHsr209Svskkd2Rs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=goON6TIQbYQ81a5ITeJQTWLj0wP2M363EWSazRwRZWfWK8eGnecDAqtdmzaaRHnsDwKlFxoib2da4/enQ7KBvYNhWtseSNXj0yeyXfQ5539zF4RrX127w99GhB+J2q1JvtFnV6qU8aYosa1pyEj1G16H1J3L7ifw48hX/ho8dqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RR9EVRVs; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RR9EVRVs"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-69ed219d3ecso1872901eaf.2
        for <linux-iio@vger.kernel.org>; Sun, 05 Jul 2026 10:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783273662; x=1783878462; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=75FEqaRZi7gyVEUOxCRUP71SjurGrXH97prx6jJpO3Y=;
        b=RR9EVRVsmCAw+wcrAKa4ntkKxPOIH9RrIpAy1ENR/V+W4NGiDXFGjZO52kbHPTlV/5
         lXnuIBS+6aYZiccU/hhfLr5wh571ToWp0Vfgpy0XY2bp6nK1j6fHro6pdciCpoCr56sh
         zdzQpGurW1AuVtlQ56rt11qsotsNcVxBRXSAHsDbwPBK/K0bhvLmeC+FtxNYqz1AoS3Z
         vyWEK9HiFkuemMIXcEd3GjymH0ZCe4z4DTp6ba9VNpn8egmWadrPOGb+nGPN4LpYGD2S
         MFq+7VUj/T54+Rnqwc+OzfJ4YU3dR3xTs5e/D8u+3K64Xapud3rE2veJ3V71Xzmk0+vC
         Ub2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783273662; x=1783878462;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=75FEqaRZi7gyVEUOxCRUP71SjurGrXH97prx6jJpO3Y=;
        b=eNJ4yU3q+p1CQI8kfdlx+acmM12ytCO1vQVn0AeZn5FFLOPqINUYEXl7APYXYKHWMB
         vFem9YcPPOBH2SNuUfGqLZCQX7RV8xbs/3XBVjM2fUyyLf2RxfOqk/ivYN8rHhMP/qbT
         29jUk5Y2d0tuUJs2asSCfyE74Yia6IHkJySvaHCYCQz746iFvpZaawT6hC85qG2UFoiS
         ahocDGKV4/Bj6PKpdpvXGV9GFtxnjHL9Lmuj/HIVIVECbv7iXkhW4AZ/WG0rwueFQUPU
         MR/f6av7wqq8oCP7ZMaagzMDTUf1TEq2+4PkPD1cNF1Li2v8giSXJ/4SSbsLlzJAUVxi
         PC/w==
X-Forwarded-Encrypted: i=1; AFNElJ9413XclqrNz24BPiQQsSoCLYrG43lwJqbRiDm1xzsAOTxyOlOLzUEUsDveC/SL5bVJDDWUfNVgtI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8McAzUSPlvj6w4R9jMIVmViZCVmnxA6Pp1mJDIaNZEYdJrDKj
	CLfeDyP3g7aH04dTdW1+0kd2XGN0+ASBjLeSxDsCn7N2RsgL/CG5daCe
X-Gm-Gg: AfdE7clB/i6Ffuo1vlhluNYzZwWWfgKyxvmNbx9X93L/I6X+ZhkIG3I4otytj4oRjlu
	awRukNLU+ONCW+mdb+fIOxcbqcUAcnK2uNicMh7i09JeuBwt7mIb5560N/GG6y3kGQ3/CF5hn4x
	YzLc/rkA+50QXiGPWZ3zRbTFxxKIz+kvVmAXDtPrx8FfBpECcgxUtZ2mnU4kTM+mQ4awPrELGHJ
	EhmlwEF9ocKjhoO+UQBEpvCv7G/147YyQ0iqH2dD2TiWry9IlEKwLrBRORKFvzgPmjX7srvPr3L
	rN+8bqgxaVxxpg7FhsJlWVkVVxoFIk8fbczLNmgpioMm3PsDYwAttM9MnnFO6XEOEDWKV12XXv7
	dYqlBuACKISdQjC4EDoSQ6WdQPe8mAaolXJtf1fflcjdz+Mlmy2lV+NNd/dfh9RaykS9OWrMGlt
	7LfpDl85aJ74QhbbAiMgq70dKuCVhYJUJnElRK44Fj01CTxgOT/w==
X-Received: by 2002:a05:6820:3095:b0:6a1:8192:4d75 with SMTP id 006d021491bc7-6a32f5d6b94mr4075618eaf.64.1783273661937;
        Sun, 05 Jul 2026 10:47:41 -0700 (PDT)
Received: from localhost (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cfb559559sm8482157fac.9.2026.07.05.10.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 10:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Jul 2026 12:47:39 -0500
Message-Id: <DJQTR5SRX5DL.20UJ66ES758CN@gmail.com>
Subject: Re: [PATCH v3 2/3] iio: adc: qcom-spmi-adc5-gen3: Remove an
 unnecessary print
From: "Maxwell Doose" <m32285159@gmail.com>
To: "Jishnu Prakash" <jishnu.prakash@oss.qualcomm.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Amit Kucheria" <amitk@kernel.org>, "Thara Gopinath"
 <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Daniel Lezcano" <daniel.lezcano@kernel.org>, "Zhang Rui"
 <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>
Cc: <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Kamal Wadhwa"
 <kamal.wadhwa@oss.qualcomm.com>, "David Collins"
 <david.collins@oss.qualcomm.com>, "Anjelique Melendez"
 <anjelique.melendez@oss.qualcomm.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Stephan Gerhold" <stephan.gerhold@linaro.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com>
 <20260705-gen3_adc_tm-v3-2-ac62f387dbce@oss.qualcomm.com>
In-Reply-To: <20260705-gen3_adc_tm-v3-2-ac62f387dbce@oss.qualcomm.com>

On Sun Jul 5, 2026 at 11:53 AM CDT
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> devm_request_threaded_irq internally prints an error message using
> dev_err_probe in case of any errors. Remove the error print in the
> devm_request_threaded_irq failure path as it is not needed.
>
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---
>  drivers/iio/adc/qcom-spmi-adc5-gen3.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>

Seems like I'm a bit late to the party, I got distracted messing with
email templates. Oh well.

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

--=20
best regards,
max
