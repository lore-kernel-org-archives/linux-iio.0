Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2BE277007
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 22:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020477; cv=pass; b=UIMhjqyLZmVP1599Y24mT03foazP34lyU8zlJaZChAh8JVCWzep06Jjsn/zvKfZMbdKldECyCRaSXyw3iYVuIsxQYNQP3xAkjf0NB9/hmmEniAJBCAJ7lMJaCG/ZNjWz5bh87JMcicDUhLQjMolpUcnC4sCCgI/zYdpLfW8DcuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020477; c=relaxed/simple;
	bh=Zcb4HykklT11uvAtEPLmINYM0C8pLXM9eKdj+x51BeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wa7ANcTfcX7IVZswuC2HWrynhNQWAmNNUNObSF9/OqXmvPSFH8ZPpnn9qq4EW+/yv22PCp1hWtYy+srHXboaXIb2iOOew5IxMMDdhB4qd0Od+JltVai7mWc/CjdvBxHbYVmnU3EYpHqbNFHy6L6gnJKVoV/07dhJKpU7AqVxx9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VP1HKJVt; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VP1HKJVt"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44e5624c053so1579396f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 15:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778020475; cv=none;
        d=google.com; s=arc-20240605;
        b=Y3OketAsG719LDsJSBKJLU3Q78AQa3nsYI0FwY4unyHgQxmWZXOzoEPwgDRCenW6qE
         IR/0ian+ziVOE+GE9Wk5KCDGFj7IYCTZmZg/FP2FXcLOJJzQGDfhmOoAGgZq3Jfc3v8d
         Y6FMEM/mt+/hYDaHm7HFI22j7WkvsIh9ViVatg47mBNj/WqYIhbuWQaQYexfwbpSrGy5
         Kmv7VgSDSUR7XYLUrHkGjM33m4jT6nlGbE2CpZpxM4fdsqtvpMhanKuS63e1Yy3dXxYy
         QifNv/pkOWyhqPfljxXC9p3zuBuTeF+ro1MRplcTNGn45LRU6HXYBQappS/6rJd1AfMr
         0nJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LrgyrX5quowO2cwio7vtOn3iYMHHTKApxOi6IxIeCCw=;
        fh=8gCMYvCzPZZcOw0fT0Aq8/jq/PWXI0D29woUs1qPJEk=;
        b=YUMLFuS25QhpTg1W13RL2mBcQcoNgLnRSc3BoQovMqeNZJCBBXt+gIYU2RCHyOuWab
         1pVcl5RZS1mg0dGAOLSuUWdI86ydYvhJOZ6eAFQGayMq1AravYsHBseb0f3mkkZwfBJO
         JpmDlR2LlGiP6cIhlWj6jJ9jlpwQYvnvNHoclqX3oVw3865/k0WQO2QDmqImBQfu5G2Y
         ODkYoFOE41Xig83im2g+v3+SJ1AxsNv3D5/Bfdwlc1r8c3v5KzcCUfpmk4Tj/0nBBcOC
         6t3BVeaFzG7hQLnP1vfXjnYiNkNvULgBz13S7qZDOSERl4mn/OatOMQF04JRnQpEXhsg
         w4pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778020475; x=1778625275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LrgyrX5quowO2cwio7vtOn3iYMHHTKApxOi6IxIeCCw=;
        b=VP1HKJVt6Jxr5OoHn7iZpsaqYhrrP/DauKgTozvFgAAYjB0iLOfpMfXNd+YdEZCq2y
         FHgf2KvMspMh/JIRYqMeHDVkNURxriJsEJIpYzI22t7efh5MKqKWxb+GmRNAdP6a2vB1
         zsUaIjmFOpZokCYbVWnGXVobpTJzBU2wWuV466TBwVqhVkZXgSzdtjKukHoCBSp80ebj
         +oxFx3hCmf2A4QitWWRVgCaQwCAXC3gdXiCfaLtJCqxh0obuo2iYRFdxXyvLDju3M7Nm
         HraxVm2JtImLdipC2hOEKtl5bm2vT+ei256Sarg5QM0kaP+NXi3H1bhMPJfYqgqbApp9
         l/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778020475; x=1778625275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrgyrX5quowO2cwio7vtOn3iYMHHTKApxOi6IxIeCCw=;
        b=gqj4i44aQyUj4pstW9btNCEC8nFIjztKISJbqBGmoj9LUh1stLAcvkJYqXO/PwERju
         cOP+arnkkmG6q+J19csW4kL05xv33AfRIgdd6hRNfT6aeQ3U5E9kwyvRxwrSF0PypPYd
         PoG0XgaEV/PBTh7p0kJnTaEVi0mAOCFzIzKuQ5/T0lgXNmubtazdbJ8zA+n1GAXFTXp5
         Rq3S1+oGK8yAqvNl8bbc/clKeo9kq9FRBZHS2fGfzYhR77viQyAgFpJRWiq5bf8BVSBg
         dEURwNfY52G1OKKs2pe7lJexr0zLV32sYRFCOkThMcx5CeFIftgES/d9sGCKdme7mW3d
         nYZg==
X-Forwarded-Encrypted: i=1; AFNElJ8zeDr71LtduZIlOpSB724D4yO0AxtSS2zpVvP8E418odHvKOGzUBTe6cDcy//47aVq7q5/4101n+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWSNs6xJ9z60YHD0uTxwCJdXg66aqOiQ06en63TF1ISPCTmDRh
	agsVsGygVTU+zLKgzOm62MET5TixTotaym1SoGwPOq0nAn1+FZJZfmJX9cDAZMhHFTt0WwcWn7j
	gXee1CT/oLYA/BwzsMdTqkusNK2Yu8oc=
X-Gm-Gg: AeBDietbTAJT6VZHJhVlNVoZ+ErEL++VM1x+uTImvqdOFf57CxmWl+NAJqSLo85ht/M
	2hbgM2afJMs0ffIWPFy197x6Kg7ElP9vId5n9S2o1+YhEvPhJv9VjYB9OtUJjmpbk98DRwskr1I
	XhWrgv4mCcNGnqiC2Iuz6QRvc8yNxZUK10TiHE/OA3Y7gqyo9Ff4SAmcTkaJlxmeMxfLXFEIKBS
	G1Qcnfdc+82SyoABzQNdsQx4TUrQ3jlv1Gah9OxfC4fJIxB3+6YI0V1sI1f64k75MTV3dIqYO0c
	SsUZruqVG8gfbHc0adYhRscHUwJX+NJQWKT2gV5W6FUOAJ9VTYSMykm5Zfjc+N2Pt1+zveCcCNb
	PWSc5SLjkRUV3/+phEwV8dTpp4iDAqWkwTl4k/jxVCYFNolGCJnnWWDFq4Uc2N7jHh0SyIRKhdC
	20jy4XJRnlt6hkJ3RKrUGiPaTIgCiKA1nx4JOU8XfzEULtxzFSBQ==
X-Received: by 2002:a05:6000:2582:b0:43d:7946:badc with SMTP id
 ffacd0b85a97d-4515ce1c8famr1632819f8f.26.1778020474510; Tue, 05 May 2026
 15:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505174640.3998281-1-sanjayembedded@gmail.com> <20260505174640.3998281-7-sanjayembedded@gmail.com>
In-Reply-To: <20260505174640.3998281-7-sanjayembedded@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 6 May 2026 00:34:22 +0200
X-Gm-Features: AVHnY4Id18Lyv1pInQXivVF17PIh3Ln1d23lMufJ9pyTRXkq69Z7wRsNfXb9ino
Message-ID: <CALoEA-xvobdVgDcUdB7PwYA=k8sUutNikG3Pw9fb9VOXyraSaQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] iio: accel: mma8452: convert to bulk regulator usage
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, sakari.ailus@linux.intel.com, 
	christoph.muellner@theobroma-systems.com, martink@posteo.de, 
	mfuzzey@parkeon.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 May 2026 at 19:49, Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:
>
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>
> The "vdd" and "vddio" regulators are always controlled together. Switch
> to the regulator bulk API to handle setup, enable, and disable paths in
> a single call.
>
> No functional change intended.
>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  drivers/iio/accel/mma8452.c | 59 ++++++++++---------------------------
>  1 file changed, 15 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index b49949792190..1c984c708ec3 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -111,8 +111,7 @@ struct mma8452_data {
>         u8 data_cfg;
>         const struct mma_chip_info *chip_info;
>         int sleep_val;
> -       struct regulator *vdd_reg;
> -       struct regulator *vddio_reg;
> +       struct regulator_bulk_data regs[2];
>
>         /* Ensure correct alignment of time stamp when present */
>         struct {
> @@ -1570,25 +1569,15 @@ static int mma8452_probe(struct i2c_client *client)
>         if (ret)
>                 return ret;
>
> -       data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
> -       if (IS_ERR(data->vdd_reg))
> -               return dev_err_probe(&client->dev, PTR_ERR(data->vdd_reg),
> -                                    "failed to get VDD regulator!\n");
> -
> -       data->vddio_reg = devm_regulator_get(&client->dev, "vddio");
> -       if (IS_ERR(data->vddio_reg))
> -               return dev_err_probe(&client->dev, PTR_ERR(data->vddio_reg),
> -                                    "failed to get VDDIO regulator!\n");
> -
> -       ret = regulator_enable(data->vdd_reg);
> +       data->regs[0].supply = "vdd";
> +       data->regs[1].supply = "vddio";
> +       ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->regs), data->regs);

Since you're using ARRAY_SIZE(), it would be good to add a <linux/array_size.h>
include, as it's currently pulling the macro from elsewhere. Perhaps
run the IWYU
tool to check (any header additions/removals stemming from IWYU would go in a
separate patch however).

-- 
Kind regards

CJD
