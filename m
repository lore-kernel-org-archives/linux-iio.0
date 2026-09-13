Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC62636657B;
	Sun, 13 Sep 2026 21:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789333988; cv=none; b=p76C7/Pe+PXyPEv6cAQzXbNDcil1s/RUZEOL0kQUE4PePvBX3zU4QPATZ16eUtMAItPuSVE72GxvV2MfQiK/w/t5PdYNak8mahFuZnx3O8T1S/FdyZcnhLIEresnGFdmNxJyKCkt8ryFpmAhXFSWiDatm3KGJg8jOnxtDLuxR1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789333988; c=relaxed/simple;
	bh=wG4t28xfdli21FP4n2beE34OaehSyflImGPOiJvBPkc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=YfsxcOA3ejg7WNllnCimHfr8daFcphC5g5K0ZCH01dDql12aMNi23Zc9m77gW0PCrpIDZWEx9is14yEyQWM6oNfxXwD4pl5wCXNLD1CZlHUjgd4mtL98EPt5k/aj0FPAVjaq6NjD31iKzcJAUw49jmcrVMR5WBIMZHWpOvVulN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMZ7nKfx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMZ7nKfx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CA51F000FF;
	Sun, 13 Sep 2026 21:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789333987;
	bh=5ulAhEk8zHb4of6DbEZ+M3YqPeLwewwDNAb0fGJJOk0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=LMZ7nKfxheQaR1ijEB/a4c5sZTkIvaICiX4ZAbB0Q5TO8mqHNHCaC++GatlBcWHiI
	 xcdKVoQ4uj1Ri0p4xp/7Mfcn2TV1JdlTJz5CHvJpCl+q698JlasiN5RgT+N3Ya3Tuk
	 J1+JOBaMkGlhB3IUcWLKSZNbYVU5rUAzaRLm5GVh8KSvbGWjInDHpErLpY26+H7mXE
	 meluagdPp/ZdWGczM8Ji0I0ZDXGx2Fpy/WZSbm4PNP6Q7ou548gllcsl0qhDDUj3rw
	 hbdLjwdbVG63N7+kp3G6nvX5xAsMeO5o6XblSmEKtQb8PTqirojZ1YgSgbic6IgXqJ
	 4tdvDRsiuTLUA==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/9] iio: adc: rzt2h: add DMA buffer support
From: Jonathan Cameron <jic23@kernel.org>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260910085430.3173166-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260910085430.3173166-1-cosmin-gabriel.tanislav.xa@renesas.com>
Date: Sun, 13 Sep 2026 22:12:40 +0100
Message-Id: <178933396020.413489.2177537065952288924.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=909;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=wG4t28xfdli21FP4n2beE34OaehSyflImGPOiJvBPkc=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqpxHLnxgeffED8SWILV/NTa9T0OwMVAECOveF7
 jzTTWDT+uOJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCaqcRyxEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiAe3D/0fCOV+JIM1tWaAdCfeh0nQeL8n+Ldz1agIc1SLtJXXWah
 wr0X67DgrW5Z/4jEFo+rfydncZbHells3jlXBl/tFp73C2vqHqzxcr2h/PykWtkUyDfdCC1JfvJ
 2nLUKg5OBh2UPKdT+5zQQ0euZLSN21/Zn+5moMIEo3cxd6R8LquABhDJCC3zldMDt0mR5wcG1Oi
 5iJ1J/PCEgDobAS3elK7vQn5I0tJeKjyuqKFMNuffso2yKtDktzyHQB9NuntwW3PFfls6FMhGDL
 aEtXCakHG3iG+jh05lHhmypmL/hMdYHvugfTT6jweo0T7q8Fe3Fiw1jtw4L9/2bJF0i60tL2xoq
 MwB/5Se7UTyL6hnUmWs7+ghgYMjY4+NBoe/vEObAU5rPOOO5IFxCBdUzwiwHq9lTXWFfAdEY+Jv
 t0uGDW0K7K6KLQt+UeXQTNyjvw2HzVN32qMAssZsBYVHhjG384K4+LwTD3vP7Ec9RY9CIlduXiE
 UBifbuJ9Kikzoq2H3eW2PF5RbTHoEIPaWuwmazK8Ykcy6sgPe1CRKbiZbGRt1WAZ57R/9OlCRFT
 Uyg5zoo4jsoCS/y8C5ikIXnES9et4uTIzchXnEiuxq6zHmHAKL6qokYWLhDGBYhli91nPeoiYy6
 QDviPRSOccp/F6BWCFQYscJUDD9TIJlgE+5tX5g==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add DMA-based buffered capture to the Renesas RZ/T2H and RZ/N2H ADC
> driver and the necessary device-tree properties. Also add a per-channel
> sampling-frequency control.
> 
> Capture uses a cyclic DMA transfer into a non-coherent buffer. The DMA
> controller has no per-descriptor scatter-gather and each transfer needs
> to be of power-of-two width, so the transfer covers the smallest
> power-of-two-aligned group of channel registers spanning the enabled
> channels, and a consumer kthread compacts each completed period down to
> the enabled channels before handing it to the IIO core.

Looks good to me. I did reply to a couple of patchs, but nothing that
requires a v3.  Patches 1-7 applied to the testing branch of iio.git.
I'll send that out as togreg once 0-day has had a look.

Nice little series. Thanks!

Jonathan

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
