Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA6046EF64
	for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2026 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789393330; cv=none; b=sC+bT5wWnW/Ds9Pos6VH5bOuiE/HFm283ep5y0Xp/kdVdszQDrKvRnlzmYoDFPQ9TqOHoDBUrQYx83Q0osC3VZzW+g8yVf9eIPJYFawCuDvyU6wh/e+hFb8YAqLuOl38+IWa6QMfAcsaeo9gFnO3kizl7VP6slyNC6YdFLM21QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789393330; c=relaxed/simple;
	bh=CawgkxGKJ3UxmVB/3oUOcDhftc9MGZruLp+O+HF6Ukg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6NVubm4Y8616BE01g7K8Hy7kJDpZEwloradVYZYuc3ZTc5amlslYUcO3FprCbkuy0eyT0RzxuVXnZyPNnwESKlnjLYVUKZSRjSvRsx9i4yAWTHtBWxMXXUkDH4DlYAcEV559uUVjQ39lLnopGoex1cHI7b1M3lI/P24jq2xKqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pT2Ycofu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pT2Ycofu"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49b965570d7so43140285e9.0
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2026 06:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789393326; x=1789998126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8Hg2g/k6LjK6PKUxnUuBlrddBnQ+AWzC6JwaHgy/hfc=;
        b=pT2YcofujVTFumGc9Btch1YhhPmBTZjmEHVA55JnGPjVnbsvSnE9eRriE44vkqIC6U
         IiARbAbQZx3op2aoGs/2KGe/YLOX6wrfFuEC0BE39VIFF1Jj4gzf3zdaWQXnmNpbQlq9
         /fP4oydVkCw7Fld7SqzZL1yGDRmF08cgumOabi2SdCADcHUooo1ad6ipePtwM35Bbxft
         fL8X8zejMmWhasiHDlKZ0irwkDdJ8npVHO0IwYz1vLSyzuNflXtraBSJBDBr82Hrt3iN
         T7jGVCQ+3Bph8EiWqZdEXgKQEzxd+N/XlcswIMcl60tOL0D8OQtqgjSyD2e7iDNp7jxZ
         3EYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789393326; x=1789998126;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Hg2g/k6LjK6PKUxnUuBlrddBnQ+AWzC6JwaHgy/hfc=;
        b=sMf6E5oHgU337WZxms1ATjQwNh0lBjhVqcWeJ5NuQR4hMtl+80i1+p7IVURURVWXZk
         2tmEdYJ143mENO/8v86dxrbgiDlCBCOqAi2BSRl9TnWYNYBomsANFFDMDjhuqX2V58ZB
         qeJNtlWHcsJQYSiRIsYbqqNb8wWAkyTGHPyQouTnX0ZEGzmquxpLW7rz/o/LI9cmmKOG
         YLDt6OIEmTWU7Z1xz8N+B8mQvv2pb7OFQ3Sl8GhPYf+4HnCARSv3sHl+K6ew1T1jd9na
         u887bPbY/LSqpCf8KC0tF1SrgiU+mMFo/hQj8jmR1YX0bva11Z7aTa1eRa0MpfSdG+84
         AnKw==
X-Forwarded-Encrypted: i=1; AKwUvBzUwpPr2MhXGMnbZq3upilL+PCRV0t1wGmVLUplU3N1oNjDotye3YauWWbSh1jCmpcLGsBEOYiP1Os=@vger.kernel.org
X-Gm-Message-State: AFuF++kvGrLFTG4D8FbmgYmBP9ETJygSI0UZACHu5W/U7CbBcOWcP0Db
	hpUxeMFErJkyNRjMFIgShGqzIndTnLcV9xzFKN55G3utv1U0RbUoqQz7
X-Gm-Gg: AYBFou1ip/szcRBNB3EtMUdw1IFm9gipXcAMQLBkjcQyTF1cK0xmX7Cpuu5tfuUauJ/
	xCnCT8sQJ7hgmmwlc+6czAq39hXObr3L5kifjbQmmoRLU+5YlMZmgStx1JstMz5AGloFfuVnNgk
	7H55WEiCJlXqymhhmCbkwHaOqtvSilEw94rU1oNkSqgHZzNJoV4BFNIjY493yep9a+DAjlQ0vOS
	l7x0kc8TTjRUdaFsNzH83a1YHsGb/uQNa7dGv8iHitsaCHnaBdPNB4AhY8iGygWgSOarjO+OEMC
	v3CfTPUVGPqWIMZEw2Y+ZTznN95gOQ89H3VVBDh+9ywmR5RMnq6AYndmF3i/+CFtUllNZuwZTXK
	EDySPe5O8omLcybUgdB2I5E1GUrKKarmlJPChXBXPkb9IkackHpafEC2W2IoCP5qsSNEbDgQbSc
	Yq2PHtiiqzqnyRr1T1TLK3yAWGh2krAWhz7Turxn3vy5n/OUxJ/ajTGfhy5zJZARXc0M4KtuSZ5
	FdTJJuZhgwd8+EX8hRN50Mf6xmHJLmOdAQQsHLhjcEXcIlpUDy14VIE2AuVgF5cAYbSa4Dg0mWF
	wJnjJZWGmr5pfIOfhx4+uPFQSc3xoKKsLptx1Fc3velr43UU1Pm/CYu3oZF4ry1QMmWjm3FOafA
	wXReRx9VoVG3Yzl1+yzn5JEeqdJvL/1weN2U9MWaLfkcJTrCHdic/gtYJNBAeg1qKqeH20A5XC9
	zBJMpA
X-Received: by 2002:a05:600c:a012:b0:49e:799a:8952 with SMTP id 5b1f17b1804b1-49e7a67798fmr33274475e9.26.1789393326105;
        Mon, 14 Sep 2026 06:42:06 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e71e300f3sm224253015e9.7.2026.09.14.06.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:42:05 -0700 (PDT)
Date: Mon, 14 Sep 2026 15:42:04 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>, Daniel
 Baluta <daniel.baluta@intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: dummy: free software device on configfs release
Message-ID: <20260914154204.000028fa@gmail.com>
In-Reply-To: <20260914115404.1691763-1-lgs201920130244@gmail.com>
References: <20260914115404.1691763-1-lgs201920130244@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 19:54:04 +0800
Guangshuo Li <lgs201920130244@gmail.com> wrote:

> iio_dummy_probe() allocates struct iio_sw_device with kzalloc_obj().
> The error paths free it, but after successful registration the normal
> removal path only frees the contained IIO device, leaving the software
> device allocation behind.
> 
> The software device embeds a config_group. device_drop_group() calls
> iio_sw_device_destroy() and then drops the config_item reference with
> config_item_put(). Therefore, freeing the software device directly from
> iio_dummy_remove() would free the embedded config_item before that
> final put.
> 
> Configfs requires dynamically allocated config_items to provide a
> release callback which frees the containing object when the reference
> count reaches zero.
> 
> Add a release callback to iio_dummy_type and free the software device
> there.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 3d85fb6f8104 ("iio: dummy: Convert IIO dummy to configfs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/iio/dummy/iio_simple_dummy.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
> index 19fcdbbc11c6..7d2ff1d4a06e 100644
> --- a/drivers/iio/dummy/iio_simple_dummy.c
> +++ b/drivers/iio/dummy/iio_simple_dummy.c
> @@ -23,7 +23,19 @@
>  #include <linux/iio/sw_device.h>
>  #include "iio_simple_dummy.h"
>  
> +static void iio_dummy_release(struct config_item *item)
> +{
> +	struct iio_sw_device *swd = to_iio_sw_device(item);
> +
> +	kfree(swd);
> +}
> +
> +static const struct configfs_item_operations iio_dummy_item_ops = {
> +	.release = iio_dummy_release,
> +};
> +
>  static const struct config_item_type iio_dummy_type = {
> +	.ct_item_ops = &iio_dummy_item_ops,
>  	.ct_owner = THIS_MODULE,
>  };
>  

Seems legit.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

Sashiko also pointed out that the same issue is in industrialio-sw-trigger.c:

https://sashiko.dev/#/patchset/20260914115404.1691763-1-lgs201920130244%40gmail.com

-- 
Kind regards,
Joshua Crofts
