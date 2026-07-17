Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2543437AA97
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784313518; cv=none; b=XdwxtlnRS/sjEOShMswEmsHe7s5BE/RCNEoBVpEYRzyYNLtviR0pTgjIihQMxX+eBtTW9pJBHQf3sdi4zUvd6uvYfNtOFa84GDsfZT3OtQFW9w+n2QsYsncyaxhGBzWyQ0UEUzKc8qzxupmyElMVm59GId27T7c9IUHuYmGBS94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784313518; c=relaxed/simple;
	bh=kFA8+JpRfL4hz6wnmPF5xh33Ev/27gjiNs5aJbXbQd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKSaCGlPOR383IwO0Tzg4WSZJ3ilbqpep/qNWkX15ieosoKStxaY7eT8eBELEeYcNGuv5vq4YQvNjU+IHq1sqi/fvorJy9feUU8mKFEG2r6QK3mOXuycTspN6kbYLR/wtMKC2opoEKKJitGNbZ/ITTn9lYLuxVvk5WMLoBOYf/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nmifvpnt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c73ulOVm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nmifvpnt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c73ulOVm"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HGnxZO2558595
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 18:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w7xeXeUjDsqowIPU4EoEBnhrjhFKz6OTuTIikIlnuy0=; b=nmifvpnt/4cdjDhd
	eTDYw1cQhHSDWX2fvdy47F0Mqk2DEbUiYBZM6wv1QlNg4zC5YaaSvdKgj7GFSvBo
	xL5ImU8rYrwXLdc1x5eZ/XidQ6c96GvnwMLfzzqv2v8ygXZS2s3fDhKMyO8LIT4f
	bD1NOkmq5hPKHU9Su4ZVINn7EuNPjOncUPmaPNpmoctz4FD8h6ym2DvALsmtmPJ8
	xBgr1F+c5qG21W//BYpNY4VaA7+RrmoyAobN+JCJg+XVqpDL/ghxPf8FHM0DDhDV
	HzEw8isswWgGVyggCUxEMCbgMYKtOknOYLiFXh13Qvikyqr3aGKDfQ6MSBOIeol2
	ZrTdWw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffd3aua67-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 18:38:36 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-388b404eaa4so10691962a91.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 11:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784313515; x=1784918315; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=w7xeXeUjDsqowIPU4EoEBnhrjhFKz6OTuTIikIlnuy0=;
        b=c73ulOVmiT9P/QjVa78RtYD2UI04hfKbyv19yynXzubjoauv3isPqGmH9s6MGIRnkK
         vUuSaJJbM9koWDg0Iv5XCaO3jceEacZ2+SHJwXWm9Xtdj9itwqLtjx+wJTVBU4IzOnVC
         tG4PYZX0tWUmpIQtRkUp/BvnlSbnhO7I9lhF18dsS7BY1qkfNKudqiR3TNutIsycufpo
         i0zAKWZ1UV2UKR00ktIKVv9RPeC4Ce5+i7I9rIkt5vIQeZPG/HGi8I2MMnQdN1Hy0haZ
         41B2Z++3VH10BYklXs4E1LEMMMb1wKkUbb/tk+q3sARuB+9+RMKhbLXFKIJf10fthfFD
         BwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784313515; x=1784918315;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w7xeXeUjDsqowIPU4EoEBnhrjhFKz6OTuTIikIlnuy0=;
        b=n8HvwI9eDAv5aB+h0z7WDisZWya8YiQfrbqa+Gk+cqzg9Lr/yQcgF//tOKdnvsYJkV
         ja9q28yy6k7Q9TgHsVb+hbHizhWl+VVZXuWxoBEt1XfT/gclTMWGIojIc0JDnwySLi3E
         TT6sltPi13okK2UTalQQW5XQeNPz1Fqg3DVKwq3M7VaaZj0VWSHd4dJfCMXeiinmhHPz
         7WGl2FlicCAXoKsOw1/4YxxSkuTrWjaMOg/KrR3axpTvseSQJpYU+qlAPCxDdl3op52O
         0Yxp7o5eY7As/VYpF4bwWB1A6YkfQWhEIHZ2ZKtUzj5PysGe7A3Tx3dLpBJ2vYX7ZqvD
         jU8Q==
X-Forwarded-Encrypted: i=1; AHgh+RqKSUQW2piHrTNfrYwdgCfTD8N7PG50gUrsev5mk5jchCU5L4pz4s4h6XP/7yKxekosouoRWeHbuvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS7GL/sv7kj8XEhxcKnYWpvFOn2A1lyAam6wRfGuumbhFcPvNC
	uRaQ51X2MYREj5JN2abG0CyvCLum5a9bVl6VV8jYi3IcaEIu6A/1QsfVGp1vzYeMdgKAGYxBjQr
	qXF7TnEErmpk8KymT7S3x+RZXjxaL+tr7skbIbbeuhrWpOLKtNKxbV/SM8wBBLEo=
X-Gm-Gg: AfdE7cnbZUaSeg6KpEAYbfq/c3Lnzm9kSeONwKLB0pG6JCwORdEr7gTEvjBMyzC5FxQ
	M7O3SU5mAuHUDKUw6vVYEjLlTDBgswWITtTFSwKmOqr3pVwselKPZxeTJpjO+VEC9uBymZIsfqw
	s9aUDGNCMPfdX4W/bQw7JBrF63R5pdsvgHfd1X2FCfBMVZ5F6Py00bnun7sCWrP1kWMN6Ut6HuG
	tFEQFr/mnn2ldQze8pGzx1FfTmgRIWZu4ccMgdE+Sc2tfMViW7Bt4R1qytlriCgetCMWP8tyMnH
	tnWB63xhs/jdoRnlZi4hbExY5QZTtuLJNfsxsFBUrz02c/oO00TewEaF2CPyEeqR9THMUtBfaay
	42bUA3FirFvvZRrn0adRislXBbQ==
X-Received: by 2002:a17:90a:e7c1:b0:36b:9e24:c692 with SMTP id 98e67ed59e1d1-38e4b53439emr3328868a91.20.1784313515521;
        Fri, 17 Jul 2026 11:38:35 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c1:b0:36b:9e24:c692 with SMTP id 98e67ed59e1d1-38e4b53439emr3328842a91.20.1784313515006;
        Fri, 17 Jul 2026 11:38:35 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bbab9sm11215882eec.15.2026.07.17.11.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:38:34 -0700 (PDT)
Date: Fri, 17 Jul 2026 11:38:30 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Stefan Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
        jic23@kernel.org, nuno.sa@analog.com, devicetree@vger.kernel.org,
        Ciprian
 Hegbeli <ciprian.hegbeli@analog.com>
Subject: Re: [PATCH v4 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <20260717113830.00007d40@oss.qualcomm.com>
In-Reply-To: <alptURwc08RaBA7H@ashevche-desk.local>
References: <20260717123852.1140893-1-stefan.popa@analog.com>
	<20260717123852.1140893-3-stefan.popa@analog.com>
	<alptURwc08RaBA7H@ashevche-desk.local>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5MCBTYWx0ZWRfX2ECKx7pZRwIW
 2ExkCHXsYJOVlv1eTOkhQIJbCmwwJ5JPsI1OcDcLVZB8GvPCw877f/beoHGERROKFfu8q3bhOhK
 /xgZYsaX5ltFX4akW0wyeIWOGNbD6VA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5MCBTYWx0ZWRfX5L+7ZBVmRszv
 hTh8PyFUpcoUTC9gpb7rZ0I5rqwt019zYUXC0sUKx3eEyqeWMqFezu1IPDT9tGVZj4+GW6W8bkc
 S0apXWJefhO+YY88B0xFVxc0qN7/ZKPzfL5gfc/AwIp3NqHT+PkBAJ6LzQO3IW6QkmIPaxaLr+e
 tSDC7Jv0R374ItZVgiwjbroUlfC+JGg/tGpKruahEgaCOTtq7XtJkJBG8HHxoXiysno7CEAh4qh
 1l9+0UIVs7GltzCrJJ8NOvraKQfI81yUOeA+MPxQJioQVEkcHSF4MilF48FN4X0oD8jKr4PZXvW
 t3x9YwlinL1AYWNzfjDVm5QbSEh86mQZgiEl8XMR5wLdlX7y8s9d/lLvP+EUEYTqzVRvyjxARFG
 BMu01s9iRW0rcpTcjHsl16txJPNmb9U9463REOIRt324QTRZajm4WekQ6LjKHkJOqvCxzuv+M/3
 5gJpOhVm13Pu3N7wrIQ==
X-Proofpoint-GUID: dZcTIwSa_Sh_kxF4osS7XKWWP2hDaMAB
X-Proofpoint-ORIG-GUID: dZcTIwSa_Sh_kxF4osS7XKWWP2hDaMAB
X-Authority-Analysis: v=2.4 cv=e/M2j6p/ c=1 sm=1 tr=0 ts=6a5a76ac cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=QyXUC8HyAAAA:8 a=p1EoV59dKfn0TkCHIRwA:9 a=CjuIK1q_8ugA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170190

On Fri, 17 Jul 2026 20:58:41 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Jul 17, 2026 at 03:38:49PM +0300, Stefan Popa wrote:
> > The MAX40080 is a bidirectional current-sense amplifier with an
> > integrated 12-bit ADC and an I2C/SMBus interface. It measures the
> > voltage across an external shunt resistor and the input bus voltage,
> > storing the results in an internal FIFO.
> > 
> > No existing IIO driver covers this device or a register-compatible part.
> > The closest relatives target different silicon with incompatible register
> > maps and feature sets: max9611 is a unidirectional high-side sensor with a
> > die-temperature channel and MUX-selected gain and no FIFO/PEC, while
> > max34408 is an 8-bit multi-channel current monitor. The MAX40080 has a
> > device-specific register map with bidirectional 13-bit current, a 64-entry
> > FIFO, PEC, a single-measurement mode triggered by an SMBus Quick Command,
> > and two selectable input ranges, so it warrants its own driver.
> > 
> > Add a direct-mode IIO driver exposing the current and voltage channels
> > with raw and scale attributes, a configurable oversampling (digital
> > averaging) ratio, and PEC-protected register access. The two selectable
> > current-sense ranges are exposed through scale/scale_available; the
> > current scale is derived from the shunt-resistor-micro-ohms device-tree
> > property.  
> 
> ...
> 
> > +struct max40080_state {
> > +	struct i2c_client *client;
> > +	/* Serializes read-modify-write access to the CFG register. */
> > +	struct mutex lock;
> > +	u32 shunt_resistor_uOhm;
> > +	/*
> > +	 * Cached configuration, also used to restore the device on resume after
> > +	 * a suspend that may have cut its power: the selected RANGE index and
> > +	 * the oversampling ratio.
> > +	 */
> > +	unsigned int range;
> > +	int oversampling_ratio;
> > +	/*
> > +	 * Precomputed current scale (mA per code) for each RANGE setting, as
> > +	 * {integer, nano} pairs for IIO_VAL_INT_PLUS_NANO. The range is
> > +	 * selected by writing the corresponding scale.
> > +	 */
> > +	int current_scale[ARRAY_SIZE(max40080_csa_gain)][2];  
> 
> > +	/* DMA-safe buffer for i2c_smbus_read_i2c_block_data(). */
> > +	u8 buf[4] ____cacheline_aligned;  
> 
> Why don't you use the specific IIO macro for this?
> Do you have internal reviews for this patch series?

This is also wrong.  Despite the naming ___cacheline_aligned is not
sufficient on some architectures.   It's a performance hint, not
a correctness statement so can often be the size for say the l2 cache but
the l3 cache line is higher and the lack of coherency is beyond that point.
ARCH_DMA_MINALIGN is probably sufficient. The IIO_DMA_MINALIGN defintion
predates that being available on all architectures + ensures the buffers
are always aligned to at least 8 bytes which makes a few other things simpler
for very little cost.

Jonathan

> 
> > +};  
> 

