Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792689646;
	b=rwXdhl7P0lCXyuL5j5+93hpSe42ZweSXskbYW9lnZdwer4hNEUhq02n3IZfKKqsBVeF/
	 86hwKjD4+Zq4NEtxRStm9okksHVCqTnClayuGW1kw86w6HRLLYo93bIVwBeN/V+5rOqoa
	 1TzW8e6LzpYL38lTKXGaUduFYePG3eSPkm6OTap+y/KbLUT9g7J+4qjxs0L9HTK1bEfZ5
	 d/K3KpiuyVMgUEEjR0D4N3DESkn58HPUXZFSozdE1viWoTi0+XlFaLgfsPSrcLqj9LAud
	 jugDJL92q8MrVAuHJmsJZ5qq7tEyy+Bmw5ZpCcFTk1JvEskODnNhyP35uD8P55NmFFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=H9S66qUYgCAGeh6U4XWLuGK0Cl5W3WmNMPy48UlzzTw=;
	b=jdtIhSXIxhH1FHwWJsoc/u++otfbncu6hNd9EZV6qdYA+DXp6rcSS7ProVxfZNcdj89X
	 wUlrXrtlVXQ1VadvhsQbjeVapu1ezTalcq5c4dTaUOeg7jP4W3rxcTnYcCXtlg4L8CtVW
	 2Exy8OEP9XPw0zuodkbBNZL1/kzP9mP28c4ZC9rZaDhGEZy7elouSTmZx39/SEu4JjKA1
	 bXmo0NvEQNyFAVavggCupCbBcJbA7VGJrb6pNkW7PL5Zki5eG5yCAcp5T/91oYbkSSCAb
	 hgFJTEhCmbHLkg7toaMLDnat2FO03gHrKSSlSl1J0ELYg8PaGXIHJb3xC/bhY8oeH5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gIB166mq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185A3606A319
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 17:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 185A3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gIB166mq
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso33953f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 10:20:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792689644; cv=none;
        d=google.com; s=arc-20260327;
        b=gsGx2zc6BpYItqhZCIcZD5kh6QtNbTbm+ixjHrwGDz1UxhU+c/o7lL3Hz6RSrCOWoD
         ORyOuB8SDKcVwC6+QoCAogXe3y0xNDRo7prCMGXX5PZ/WbB5Pdw+jNEZLau4UMQjcVFV
         1O2SJMhAStu4MHjle6H1dk3xbJkUU4QPkLo+sg33/y7ZFEx7Mb7K+eoH5+R7ec2UVokB
         ZH1SXKOfs/Ddtz9eKzN1rqJhZpRyzn1FPZ7JHEgkbGMIQB+wdeniq18qEB5qe0SdajA9
         ArDxf/j42GyXY9booBbqddkeKxl9hO05q9ZEMSKhInqnnVY5FtXcckPSmSG16QYohJvO
         qw5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=H9S66qUYgCAGeh6U4XWLuGK0Cl5W3WmNMPy48UlzzTw=;
        fh=zHUFJEQu8XkaPbinm8VXe680QCHz7KYqg8/1IdLje80=;
        b=orraO7UrLJVqnvnQp3+WxFLfJkDNXYj2rMDixKbnPF9fkKUONnI2beGucUZbdoeAER
         Ot8CAUvCWemRw6eKZA06HK/r5TWTP4vMQPsolMaxW3bftZWzZZr8A5sdG+++BojJ9ORs
         E71ec8vp5HKqZ0b9wINckuwTGS+DF5onB8O/mJr3ZM0jOmEfOJAnKkdRyHnHJ+KMu7RR
         2p+IYpVbT/f3Y3Ydr5OyMiu9xxFhWJdNBLJC+0Bmq/L8ywhiP9tFKXCYXlhp0bm+Z6jC
         wP0TVNGQ1IdABVQIaK6xueA5zzuyWfT1NiPIz6GpHj5yyJsG7Q5ZBZIA0IXn0XfbbnVU
         FupQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792689644; x=1793294444; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H9S66qUYgCAGeh6U4XWLuGK0Cl5W3WmNMPy48UlzzTw=;
        b=gIB166mq077RL1eF4gICTRLB5kbgcH66jZLcX2cxFPkVMZIYjfpZN3CG0utk9OxkBV
         xFyYwRRd4jCZkYXabPUANNYm3TaLZS2NwR0wH2zG2w+fDErAsZrARFbn8UqDNnb+mPk6
         q901VU5F2i2yVRYkyGV6YkCb3C7+h3ueC5YcagsMlSNJpX7vgkVu6b0za7ikHBfPufBC
         F5YTS0tGPDJrP8eUeqFkbI4kvZ7Evlcfoy06Hba93s9sAougz4W04yDGXt+raVUdxdqA
         Y5IIN2rImGzUYvlVSUtyTulUOGfO/FbeXoLkzmbVlbr/I0q15QQVYeMBZscGHj0tgIzs
         Aa/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792689644; x=1793294444;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H9S66qUYgCAGeh6U4XWLuGK0Cl5W3WmNMPy48UlzzTw=;
        b=r9/vYBoQuRF6GLLwzv78pgQ7Hs/tc1o3TK/BBjTvXqVbPQX0MQmotQAZTci2yHM9uy
         BhBPMJH4HpckMI+hAU5YNHS7YfE4mC9DRmqr/E465rcFjbTsvI8+guJdZiBWMvLoDrQN
         E3IcZ8E0Buv0HCY1wfigQVogvsADGRpR+8zkWLDF3WYRU5CtJ5zQfqu+qAQvZRXJDCwS
         8/T8CtIFoOBXmntjtpKsFjdiH/eIfa7oH2oOkbR98TMDHFs4Pjxs3er43X+0N6AvDIFl
         /Qn7N8Usno6sYx+9OjiisHa8GR6ZRPKYmWwCA3u//qcVw27cu5+t9CrzRF1Gbpw3V6MC
         DtZw==
X-Gm-Message-State: AFq9FYL+eh2nyn1/DzA0OcUBqbS663OpVZEa9ReT+zdmxwe6jtSRPR+A
	jNNlkaBjAWuhUidBx+aIX1LvcRB+x07xrMeO/QTF/at+acJF4clUZbvYNDzcF9wAylvc4Lf3F/a
	ijAelQiwUKdFMNaAyU8X4BKCMQv25wgI=
X-Gm-Gg: AYBFou1sSieOU05zkvKxiU8NmAGCajjA1ikiSdKf8743UAmkJ9xa8+ooExn6jfSVZ2w
	WCbxh2JpJUFum2K4Zehpbo1MqrZv5THRHA+gQdzu/PYwLZF5lKL3JJS1FK1eWLaITTbYKRgwupS
	x9qVWRJIE1C5ncgkeJgmsNDgf5Cc/sdC6SSSmTRakj86Nx1mhm2p7kSrFLlQs1Zw74hMUZ1VezS
	GPpW7jIEmEbCXx/c4wBSO3+qShdQGgweISIblzjmvlk9QpoPyFcKhFerKDzr3VBMpNhtCnzJGtt
	bTqRMxUE6Xy3gJk6iEg6/AEaKVh51mMjS22DHBdbmGiqcBpQIyuNsWA6LPDgrWs2wi1KHhud450
	f3iq7fAvMnNWc87udfTvk5pHS950ZMlTIp2nNkkC45SO3e8Rwj/dShmLJqLY1RFVBlzO6rfmTdq
	unGBrSAz//nNI/U5P7t+W5ROvEKFtg7bECclHV2h/OW5+ZMxBBOn2zARJx76usFUnEedICFftp0
	i6OgYft7tpIBAYAr7LMt2DmvWa6Owd9nVvUOvGB/wy2bwvh5qg+CBmtMEXC2IalD79j4hmhlasm
	LZjtfw==
X-Received: by 2002:a05:6000:98a:b0:48d:f014:63ee with SMTP id
 ffacd0b85a97d-48e264a1d2dmr10995231f8f.20.1792689644186; Thu, 22 Oct 2026
 10:20:44 -0700 (PDT)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018170013.79443-1-nikhilgtr@gmail.com> <20261022150652.4842-1-nikhilgtr@gmail.com>
In-Reply-To: <20261022150652.4842-1-nikhilgtr@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 22 Oct 2026 19:20:33 +0200
X-Gm-Features: AclHuK-YQlLOTUZt4Yjb1PozJmhJ44RVHSrK7WcB8S8nFNSjNPhi76VQeiMPyGo
Message-ID: <CALoEA-zfAgPiOTGSm6okcEq7nZsReyZVeih4nHOKGGH77SgDsA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: chemical: ccs811: Make sampling frequency configurable
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, lkp@intel.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Oct 2026 at 17:09, Nikhil Gautam <nikhilgtr@gmail.com> wrote:
>
> Allow userspace to configure the CCS811 IAQ measurement rate through
> the IIO sampling_frequency attribute.
>
> Support the three IAQ measurement modes with sampling frequencies of
> 1 Hz, 0.1 Hz, and approximately 0.016667 Hz, corresponding to
> measurement intervals of 1, 10, and 60 seconds.
>
> Preserve unrelated bits in the MEAS_MODE register when updating the
> drive mode, and cache the selected mode after a successful register
> write. Expose the supported frequencies through
> sampling_frequency_available.
>
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
> ---

Changelog?

Also, please do not send a new version of a patch as a reply to the previous
version, it can break tooling like b4!

--
Kind regards,
Joshua Crofts
