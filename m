Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EAA3242D8
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778266201; cv=none; b=OjRIe4QXGwWgDPRuS2ReD45sydZno7eVLIVYIx/V77JL+Xjb/GNWRORcc3PaUZCpDrwd2JFfbMRecHjCwgBnuydxjDV5OcDsZ/VN+gGhH28cuZA7JvF/fCvHhuhpjT3LA83yBYglAbQ3P/BV357D509+gosWpMoLngZ2Hi+Alco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778266201; c=relaxed/simple;
	bh=NWQfL+RWvFHhgn/3dR/94QfbqAXPNlxqchNqVZMynT8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=c5dg9WGrhuFSvYMM5j1FvlwTJ3NYaRlh248DQwesFPd2490t6ezBY80Sjqbfcc62MQqliWbzV07MrnGHV46q/UTCK71THxkcyxiMBmavLQrzplz8zHqdmZaRht7hj+ZGBMVTWtqIi6d1p3LTZcHL85Z2vzS3XNZ0+X3hlB6ntGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUMtiuqQ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUMtiuqQ"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c8026aa4d53so1561001a12.3
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 11:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778266199; x=1778870999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DH7GgBsf5gFTyU9xaGUtTh5y4Nb+5ISn4myl/WQLiQI=;
        b=nUMtiuqQoEmQ0mVXVyOhaM2f1W0xfX9QQqgmrXa4cmXZgilIH2Yp1UH2t6RuVOWaT/
         dofSDTj8wj6R/oiuzi90bTuRpRKfUg2vPU9jW8TymU4NCzwRxToIT1wQlMO5SHAJ2yLj
         6LZt8wCqy3mxXFj53w0USzODDh63zN6+31JkeWNmhkDXRD6/PWzM6M9ltC6+8bqH6hGe
         f8IP322hiPnZi6ocRe+ZnRA+Zkbwy+uI0Rb71tPwQX8qThgcH4yaJ9z8VbH1VCFJxH6j
         b8pMiBr2GEmZt4tWTcL6hXGhxdc0pMPiXjJyJNtpWzBD/w7rbUM7diZgl7oyvjnZiwYs
         T4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778266199; x=1778870999;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DH7GgBsf5gFTyU9xaGUtTh5y4Nb+5ISn4myl/WQLiQI=;
        b=U0kmqS+mTB3Hxd6KJfbIIUDDPiG6oB+bZh2Z4fPUYbklRfl6eAZkRBpDj2k31SOlLB
         oBE1EIhW+4zmbfmtBBTFrYDnv2YVZd6OTOfUzyl/TOU7auA6If/BF7adjuUWmtTwAze5
         YjO+0JbW+YUMP93hWbGU1mGbQsLgI7ngLzFR7OMAhQQnT9P4wSytjld6p6mG8gZ3/VnF
         aOCHLV9yviwENpKXTyF6q8aUT7U0Df8N5ehtj44LeoCBZvbiY/Di4IlaTyWeaMf0wje/
         OsEvrzAjwiISxRq1EVjOFAP35mND4qvUSl+q0cqL2Du8bVH8crYvZ9Gkrbpff3V1r/Ms
         KQ5w==
X-Forwarded-Encrypted: i=1; AFNElJ+X0j+EhbzHjx1M24OUQFfYnLLzMkbucA+wqQnIlUCpmh0lIiXpqWlIL16Dp0MlWY9tg+1pG4Q6uC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXWvSVkF9+OcIVnTTcskVySNi41uNhe9bn9q81uF1B25DK/5I+
	z9vidYr7smrmySLGwbYj8d3iM90kurpP1Z60LRi2MqGOFm2v2l7znbNI
X-Gm-Gg: Acq92OGe1qBD+CXjc/DDwnTJHv2bzcHGqNwIrB/l5UJUINcHQDpiAPt7H6gt2y/vQzw
	fUuugsc9VK4vGKOnrz0J8uurspkBUkolC8t0TTVYX1blCSzBsoK2Ke9WY9RxOppKXrTdoF2ynua
	dFsfTh6ly8FFh47VuZpNdw4BDk5O8d22GvYIV95CglO8Qy3rgcRuy7pzapAIaulKopDk5FU4jPr
	4rmFrnubKe8qMzzOnDYzjWOv4ULRQmtOruYT8c9BL7m+fH1IZJygtwPhygUL3+wFPfHZZs7BBrJ
	FDJhQNUanaPD09pUwlBGekOKYKEDES7tAZTpUto3npeacbWQdsRWESNN/C4k4yqaiUw7kRmX0xA
	MaZiLKpt1DWpJQSiJHtHurm3MUu0T0dFqRusaRt5kB4jJ86nSKi/6fpiN4y76iIi/KuXR9L+BsF
	7IxYjd6NBANR/Qp2VtHhIkKQyQS+tdRz5Pmc3QhzoKNkRDqw==
X-Received: by 2002:a17:903:bd4:b0:2b2:53f5:4627 with SMTP id d9443c01a7336-2ba78f63cadmr106621905ad.4.1778266199122;
        Fri, 08 May 2026 11:49:59 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:7928:da7:2db6:dccd:ce49:67cf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e35ebesm29892475ad.43.2026.05.08.11.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 11:49:58 -0700 (PDT)
Date: Sat, 09 May 2026 00:19:46 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Maxwell Doose <m32285159@gmail.com>, salih.erim@amd.com,
 conall.ogriofa@amd.com, jic23@kernel.org, michal.simek@amd.com
CC: David Lechner <dlechner@baylibre.com>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_iio=3A_adc=3A?=
 =?US-ASCII?Q?_xilinx-ams=3A_Replace_spin?=
 =?US-ASCII?Q?=5Flock=28=29_and_unlock=28=29_call?=
 =?US-ASCII?Q?s_with_guard=28spinlock*=29=28=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260508124513.17752-1-m32285159@gmail.com>
References: <20260508124513.17752-1-m32285159@gmail.com>
Message-ID: <F98D1BE6-7B28-4A36-A372-2431EA151E1E@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 8 May 2026 6:15:13=E2=80=AFpm IST, Maxwell Doose <m32285159@gmail=2Ecom=
> wrote:
>Include linux/cleanup=2Eh to take advantage of RAII macros=2E
>
>Replace spin_lock() and unlock() calls with their RAII macro
>counterparts, which modernizes the code and increases readability=2E
>
>Remove "flags" variables where spin_lock_irqsave() has been replaced
>with guard(spinlock_irqsave)()=2E
>
>Signed-off-by: Maxwell Doose <m32285159@gmail=2Ecom>
>---
> v2:
> - Replace guard(spinlock_irq)() in ams_unmask_worker() with
>   scoped_guard() per Jonathan's suggestion=2E
>
> drivers/iio/adc/xilinx-ams=2Ec | 20 +++++++-------------
> 1 file changed, 7 insertions(+), 13 deletions(-)
>
>diff --git a/drivers/iio/adc/xilinx-ams=2Ec b/drivers/iio/adc/xilinx-ams=
=2Ec
>index 124470c92529=2E=2E05bf1444ca7d 100644
>--- a/drivers/iio/adc/xilinx-ams=2Ec
>+++ b/drivers/iio/adc/xilinx-ams=2Ec
>@@ -10,6 +10,7 @@
>=20
> #include <linux/bits=2Eh>
> #include <linux/bitfield=2Eh>
>+#include <linux/cleanup=2Eh>
> #include <linux/clk=2Eh>
> #include <linux/delay=2Eh>
> #include <linux/devm-helpers=2Eh>
>@@ -414,18 +415,16 @@ static void ams_unmask(struct ams *ams)
>=20
> static void ams_update_alarm(struct ams *ams, unsigned long alarm_mask)
> {
>-	unsigned long flags;
>-
> 	if (ams->ps_base)
> 		ams_update_ps_alarm(ams, alarm_mask);
>=20
> 	if (ams->pl_base)
> 		ams_update_pl_alarm(ams, alarm_mask);
>=20
>-	spin_lock_irqsave(&ams->intr_lock, flags);
>+	guard(spinlock_irqsave)(&ams->intr_lock);
>+
> 	ams_update_intrmask(ams, AMS_ISR0_ALARM_MASK, ~alarm_mask);
> 	ams_unmask(ams);
>-	spin_unlock_irqrestore(&ams->intr_lock, flags);
> }
>=20
> static void ams_enable_channel_sequence(struct iio_dev *indio_dev)
>@@ -1060,9 +1059,8 @@ static void ams_unmask_worker(struct work_struct *w=
ork)
> {
> 	struct ams *ams =3D container_of(work, struct ams, ams_unmask_work=2Ewo=
rk);
>=20
>-	spin_lock_irq(&ams->intr_lock);
>-	ams_unmask(ams);
>-	spin_unlock_irq(&ams->intr_lock);
>+	scoped_guard(spinlock_irq, &ams->intr_lock)
>+		ams_unmask(ams);
>=20
> 	/* If still pending some alarm re-trigger the timer */
> 	if (ams->current_masked_alarm)
>@@ -1076,16 +1074,14 @@ static irqreturn_t ams_irq(int irq, void *data)
> 	struct ams *ams =3D iio_priv(indio_dev);
> 	u32 isr0;
>=20
>-	spin_lock(&ams->intr_lock);
>+	guard(spinlock)(&ams->intr_lock);
>=20
> 	isr0 =3D readl(ams->base + AMS_ISR_0);
>=20
> 	/* Only process alarms that are not masked */
> 	isr0 &=3D ~((ams->intr_mask & AMS_ISR0_ALARM_MASK) | ams->current_maske=
d_alarm);
>-	if (!isr0) {
>-		spin_unlock(&ams->intr_lock);
>+	if (!isr0)
> 		return IRQ_NONE;
>-	}
>=20
> 	/* Clear interrupt */
> 	writel(isr0, ams->base + AMS_ISR_0);
>@@ -1099,8 +1095,6 @@ static irqreturn_t ams_irq(int irq, void *data)
> 	schedule_delayed_work(&ams->ams_unmask_work,
> 			      msecs_to_jiffies(AMS_UNMASK_TIMEOUT_MS));
>=20
>-	spin_unlock(&ams->intr_lock);
>-
> 	return IRQ_HANDLED;
>=20
Hi Maxwell,

Thanks for the resource cleanup change=2E

Overall looks good=2E

Also, there is opportunity for guard(mutex)()=2E

Thanks,
Sanjay Chitroda

>=20
