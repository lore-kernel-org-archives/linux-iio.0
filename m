Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD48C3D34A4
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777361023; cv=pass; b=noHsVRH9J/0CR7FjT/3JjY63cbAcsPwy+3zIybdz9sEqxLEwPcuFM4rk/BR7S5MInexSE517oO5iUJLoElvKZ2p3jiC5Rms45KqnqGdROYEKuCaOX98hJiadnobZSX8O717KJZGs6WUUt0NKvlNRFuwEQinRJk/FKpzPLBTzQdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777361023; c=relaxed/simple;
	bh=RWBACKQGpMdz3IPwXtOD1wHGeNGt7MCiv2zZJ9OKzvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcIpwmgh9OISvpAcNSWvjp66K/9kDSA7rozeUVhSYScpu1ktnlk6dyXsuyfDRTbzbroTRV4gzwlAm0P48663yKMhxuRI2Vz57f8RfZrRByCxyRp91tCxutCJF9ON7ScoOsOWjuKXoBYTfVvNDva2LGsGxNs1Tswioizv9W2u8+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnZOoG+6; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnZOoG+6"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so188476635e9.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 00:23:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777361020; cv=none;
        d=google.com; s=arc-20240605;
        b=Qh09Wtxg3WlzSw8IDemomQ5TEE42/NcTOyQ+y4bsqm21k0C5ObxB8jxhorPnjLsb0S
         r9g+zSSaz300m6hN9pgxkTJxKfFb8uSE0QjRQ7UaTHnAAcPGPp992d3X47eB4LsSOu+M
         7r8EM79X0nFHOO/LxKRGl1J6fiL1U0VUt9uzohf5RUNtfgGQaExqTSydlqXKQvNLK2h1
         oPFWBYbTjSIHlopWFdy6mD8FT+L04X/oh8O2lnWDBM4J4/S8yCRDogWUScKNekF5bZp6
         /nlSnsnydBWCayA3PtNyqO0p6kcQ0OUyHDrGi1G5Br25V7XCYs2eDwLa3dpRgRTKspoR
         PvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MHa1jCvKD91oXyiIc+PgTiwAZsBzp7zJVOpCPQr644I=;
        fh=Dg5zoWqUx76h3UPcxsppTHY72IFDoZZoazTlpye19aI=;
        b=B/VV720dSg+aINnJ+UES2Tgseflms0YxL1gf0+iR/CMMaXDrnCiXh4aLmg07UTa8Yr
         BHqgPsv4sJJvGWFwNwgk+i+YqFhAW90uaEI2/DeGUVmd+qSBhV4SEr+cMfc3gJqiqe7i
         oaeba8IrAI7XRHMW0jgJon4nYmUdXptSwQvBU8sZGXYfwnYXayYXarBJ9j2G16OCMDMT
         SiPILjzSNvhfaGiLe1zS2I0bAyJHaMrUyNvco/uxo9HmxgzAytEBUVSwGqKdPUBsBNHn
         0zn1Keq9ShUM5Njjs0Ut6fzEXJ4Qd+CEAEfd5ImjYrYw9DPQdb29HrVPs9GEe4i8pu2n
         SABw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777361020; x=1777965820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MHa1jCvKD91oXyiIc+PgTiwAZsBzp7zJVOpCPQr644I=;
        b=LnZOoG+6jcbY7nFeJGJEihpHSrryrAY8zJbPVjJlUjsIUvBIwSKm5ujWQQjYEFwK0N
         Z5KK+T7XLrCym7y+dNQwlQOremH0UF5jaDBcxca6M5zCf+lYaJRLhJ7TbwikV3de4Agx
         GCCOoSq+Z9/W7A6TBc1rwJEU3C+naAD9NyCIFuwiDKuwYPtj7C209Bj/JnVRDwugLATj
         cjVGbvPuYQa/8m1Nk3Ut45h/WhGRwhVmpA5pr6cayY4Xa9n5jnB1b0nNMS8e8xGuPqmS
         ZoyIdRib1FEuewu73uptYX7/qjqY+v5LKOU6XajF72onxFrybOV6sx3OKShFn+g7Zygx
         5ujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777361020; x=1777965820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHa1jCvKD91oXyiIc+PgTiwAZsBzp7zJVOpCPQr644I=;
        b=oxu2/VkSlpieLi1fBOLlAdwK5dyeC4f2iomyfNIa54IAdUxoKmQ8idE4ovQWt1/Zx6
         NTxQKBvjvb10MOyydtnCqEhxQcAf0AmYAWH3F+jD+MDQABmw62SEcGE3Q5Xi1yeI6tJW
         ukb650GZRXUo/ZAKXazUTJFSjdTYesl6hNWcHB4nL/m2Ul7zgJVg1sEjPMsoVl8XaVPV
         jKsts5/jlhm3c9WcAbobduWPIK1WbyaMzH3wpWvOLn70eFpLSjD/V70XTUvmGQi3ciqK
         WEdNKe9snsi5PecwHUpR9XhW8FNYyGf007qM1kD11Czx8IiHN5c+pOhi4Z6MR7ef42at
         sKUg==
X-Gm-Message-State: AOJu0YzNd85dBOwJ6DQBZ5QXxe2EURd984ERKkC/7b0SsQfSLYxsA8V4
	JpAHakriGeIkMRWjG6HyTbiXVmhUqlIha5m31EFX7IhtNZ4a+BN8COoRa6mPdWn/sSW8VcdJYLr
	7U0YnEj9kVczAsyXoAkkirm3OtHMfSdg=
X-Gm-Gg: AeBDietgPbnjhhCSSuuEcR/xi+I3PEkeeH4q96pazEPGLLLtsDD9RnkEd9qwGuVADzr
	Q7jvHMtV/jSX1x1cNZ1+S3vpXsgGzRd+7Ay3pnG/xumxJl1RMSUD2EGuWWTytgJZq9feSr+aYOj
	h8Ix82/QYudxA//Jn0iXqlVj94oua5jYYxPoiFu7PBfOWodv81QEeojtctQ1CRiWQu7aTaduOx3
	A7oblw9+TgWV/oO4amLCsvoY/rt/80U/TSisJes7pmfXIrhAM2TcKMrsd05SVhmx3f2NASgiRMM
	IEK6d7uS1kesPspo4UopZgWWcgJ4n0zeUa3Nh9r+R3f6pEn04twofz9KDik3PMQ2t6sIlqDU6Kr
	obujMr7h6GASqOpVHZsoUaEQBhG7pJp8g/1k1TbKYybgtVUuOK3D9hx1Kivw9HVO6YVp71H1v4Z
	uN7TFMjXuPen9EAPwhax9ns6dEoCU=
X-Received: by 2002:a05:600c:1d0a:b0:488:f453:b976 with SMTP id
 5b1f17b1804b1-48a77b2051fmr30866265e9.27.1777361020237; Tue, 28 Apr 2026
 00:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com> <20260427201412.3067235-15-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260427201412.3067235-15-andriy.shevchenko@linux.intel.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 28 Apr 2026 09:23:28 +0200
X-Gm-Features: AVHnY4KLHw19McgQvuziECjsW3sRav__WqmKpr0zxioEqjT1duJUnsdDMNiVaQ8
Message-ID: <CALoEA-wEC8SPZ8Y__3nWDx1KdyA=96sYCxt4ghK5aA_m9HkxLg@mail.gmail.com>
Subject: Re: [PATCH v0 14/14] iio: magnetometer: ak8975: Make use of the
 macros from bits.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 22:14, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Make use of BIT() and GENMASK() where it makes sense.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/magnetometer/ak8975.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index e6ca30b36965..4e53c61c8d69 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -46,7 +46,7 @@
>
>  #define AK8975_REG_ST1                 0x02
>  #define AK8975_REG_ST1_DRDY_SHIFT      0

Might as well remove these types of macros, as they are
otherwise unused in the code after this patch. Either that
or incorporate them into the BIT() and GENMASK()
macros to prevent magic numbers.

> -#define AK8975_REG_ST1_DRDY_MASK       (1 << AK8975_REG_ST1_DRDY_SHIFT)
> +#define AK8975_REG_ST1_DRDY_MASK       BIT(0)

>  #define AK8975_REG_HXL                 0x03
>  #define AK8975_REG_HXH                 0x04
> @@ -56,14 +56,14 @@
>  #define AK8975_REG_HZH                 0x08
>  #define AK8975_REG_ST2                 0x09
>  #define AK8975_REG_ST2_DERR_SHIFT      2

Here.

> -#define AK8975_REG_ST2_DERR_MASK       (1 << AK8975_REG_ST2_DERR_SHIFT)
> +#define AK8975_REG_ST2_DERR_MASK       BIT(2)
>
>  #define AK8975_REG_ST2_HOFL_SHIFT      3

Here.

> -#define AK8975_REG_ST2_HOFL_MASK       (1 << AK8975_REG_ST2_HOFL_SHIFT)
> +#define AK8975_REG_ST2_HOFL_MASK       BIT(3)
>
>  #define AK8975_REG_CNTL                        0x0A
>  #define AK8975_REG_CNTL_MODE_SHIFT     0

Here.

> -#define AK8975_REG_CNTL_MODE_MASK      (0xF << AK8975_REG_CNTL_MODE_SHIFT)
> +#define AK8975_REG_CNTL_MODE_MASK      GENMASK(3, 0)
>  #define AK8975_REG_CNTL_MODE_POWER_DOWN        0x00
>  #define AK8975_REG_CNTL_MODE_ONCE      0x01
>  #define AK8975_REG_CNTL_MODE_SELF_TEST 0x08
> @@ -96,7 +96,7 @@
>  #define AK09912_REG_ST1                        0x10
>
>  #define AK09912_REG_ST1_DRDY_SHIFT     0

Here.

> -#define AK09912_REG_ST1_DRDY_MASK      (1 << AK09912_REG_ST1_DRDY_SHIFT)
> +#define AK09912_REG_ST1_DRDY_MASK      BIT(0)
>
>  #define AK09912_REG_HXL                        0x11
>  #define AK09912_REG_HXH                        0x12
> @@ -108,7 +108,7 @@
>
>  #define AK09912_REG_ST2                        0x18
>  #define AK09912_REG_ST2_HOFL_SHIFT     3

Here.

> -#define AK09912_REG_ST2_HOFL_MASK      (1 << AK09912_REG_ST2_HOFL_SHIFT)
> +#define AK09912_REG_ST2_HOFL_MASK      BIT(3)
>
>  #define AK09912_REG_CNTL1              0x30
>
> @@ -118,7 +118,7 @@
>  #define AK09912_REG_CNTL_MODE_SELF_TEST        0x10
>  #define AK09912_REG_CNTL_MODE_FUSE_ROM 0x1F
>  #define AK09912_REG_CNTL2_MODE_SHIFT   0

Here.

> -#define AK09912_REG_CNTL2_MODE_MASK    (0x1F << AK09912_REG_CNTL2_MODE_SHIFT)
> +#define AK09912_REG_CNTL2_MODE_MASK    GENMASK(4, 0)

-- 
Kind regards

CJD
