Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38174248873;
	Sat, 21 Mar 2026 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774100352; cv=none; b=HoqAJ8KwqILBuK42s+mFel9+VYJxQG8BoitjZJym6XyX+mzKCneN4DU8zhNcwG3z9jSxBCNTQrTVw8dNQww1a5Jny8X8uS4u1WTnmm7Q2JkLPsEYyECfdQVBDvSyHfxQttG+zUKKZ/lq8iPCG93PB46QMfmi0XjCTaYKHLCC8gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774100352; c=relaxed/simple;
	bh=xJ2lQrO0ZwDcMWLil9O0PUiVGgTL0OmU3iujFi/H2JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IiVbTRytR1zo++YM1KBFGXAp+0gAg50+Phlav6EAUu6zcP9ocuHDOr3f9ny0qi2tIkS1BVdteXQvydx+bP1Rzn0F54GJ4K4CbxcgLPFW8sWb/1aJAUUgpBfl9GGSwsSuCM2/R49//Me2Z+xeK0qszWWzJup8VUyhZDTi6/PVaBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjqRKp4u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjqRKp4u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25B3C2BC9E;
	Sat, 21 Mar 2026 13:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774100351;
	bh=xJ2lQrO0ZwDcMWLil9O0PUiVGgTL0OmU3iujFi/H2JY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CjqRKp4uN/O6EvthI+WXozPjjZfqoZq9vwj1axeEVe+oRHgKYZX9ao8JUm1aQSwNs
	 PqZsDl1hkQV+bp6v8eVuzyYz2YHQKifmMPWJjuTUEUCnd5hGC24a9Jaq6QSG1SOkcV
	 pQ21reEYRIdMTtNWS+u9qa3JujGBPq2KpIkzf4L1T1GBsRtuPK2dFJfVBlnc+fCunE
	 pB5lXcd3bJzsx3qEP3382+R8xcE73LkUAeaKTm2ZrsU8mB9TCWMqmheruNHm5oMWCM
	 R6FHBELzjU6SFHKupLO2KZh/Avv8OB6JxSFbm/lZ2gfkfSElEgMeywsY1zOVzLp8ga
	 iwjC7cvexZE3Q==
From: William Breathitt Gray <wbg@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Frank.li@nxp.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	s32@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 1/3] counters: Reorder the Makefile
Date: Sat, 21 Mar 2026 22:38:42 +0900
Message-ID: <20260321133854.146974-1-wbg@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260113165220.1599038-2-daniel.lezcano@linaro.org>
References: 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1864; i=wbg@kernel.org; h=from:subject; bh=xJ2lQrO0ZwDcMWLil9O0PUiVGgTL0OmU3iujFi/H2JY=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJn75vsd4ZiYu0DYp/b7zOsHnmYufXWi/D5T0ZfO5Tcnh utM3sJa2VHKwiDGxSArpsjSa3727oNLqho/XszfBjOHlQlkCAMXpwBM5EAww38/QYdqlVlmnev0 Yu3S8j5LTZx/UUS27PTZ291lJ6oLSloZ/gc5cXhM3lz32sOGg19eJ8WL/+GtGVmOrTIr77UG3pA LYgQA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Tue, Jan 13, 2026 at 05:52:18PM +0100, Daniel Lezcano wrote:
> The next changes provide a new driver. For the sake of clarity,
> reorder the Makefile alphabetically.
> 
> No functional changes intended.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/counter/Makefile | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> index fa3c1d08f706..40e644948e7a 100644
> --- a/drivers/counter/Makefile
> +++ b/drivers/counter/Makefile
> @@ -6,14 +6,16 @@
>  obj-$(CONFIG_COUNTER) += counter.o
>  counter-y := counter-core.o counter-sysfs.o counter-chrdev.o
> 
> -obj-$(CONFIG_I8254)		+= i8254.o
> -obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
> +obj-$(CONFIG_104_QUAD_8)		+= 104-quad-8.o
> +obj-$(CONFIG_FTM_QUADDEC)		+= ftm-quaddec.o
> +obj-$(CONFIG_I8254)			+= i8254.o
> +obj-$(CONFIG_INTEL_QEP)			+= intel-qep.o
>  obj-$(CONFIG_INTERRUPT_CNT)		+= interrupt-cnt.o
> -obj-$(CONFIG_RZ_MTU3_CNT)	+= rz-mtu3-cnt.o
> -obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
> -obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
> -obj-$(CONFIG_TI_EQEP)		+= ti-eqep.o
> -obj-$(CONFIG_FTM_QUADDEC)	+= ftm-quaddec.o
>  obj-$(CONFIG_MICROCHIP_TCB_CAPTURE)	+= microchip-tcb-capture.o
> -obj-$(CONFIG_INTEL_QEP)		+= intel-qep.o
> -obj-$(CONFIG_TI_ECAP_CAPTURE)	+= ti-ecap-capture.o
> +obj-$(CONFIG_RZ_MTU3_CNT)		+= rz-mtu3-cnt.o
> +obj-$(CONFIG_STM32_TIMER_CNT)		+= stm32-timer-cnt.o
> +obj-$(CONFIG_STM32_LPTIMER_CNT)		+= stm32-lptimer-cnt.o
> +obj-$(CONFIG_TI_ECAP_CAPTURE)		+= ti-ecap-capture.o
> +obj-$(CONFIG_TI_EQEP)			+= ti-eqep.o
> +
> +

Those two empty lines at the end look superfluous; if you remove them
and resubmit this patch separately I should be able to pick it up.

William Breathitt Gray
