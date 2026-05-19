Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E36A4028F0
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200436; cv=pass; b=dxa6HT5B2j1imCR7RbsNg0ychDLU+5u0YPk0PF0FX3gz0pE4gxmzKgFBTIc+lNYbo/FA9KddMdYnw/K1BwLPuB0zy8ioKE0PmOt/24nr9gUTzw5FvNQC/A3n678/7Nn0/BNoQiyhGhkVdKB17lHZpNz/GzCIkJzEY1b3TIO14is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200436; c=relaxed/simple;
	bh=Z67ptMys+N0txKzsrvuO8uwf/yKTvhIujA1K1RnDdTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFQ7kO5UUBzlFue+trL+o0vy8NdnnI4O6KtTWAZ2MNCjczk7jmBdehfPjIS8ZBDjIT79uVFfTyNSzGBWHKEQK0n3A6fcI7XnLa9xhghNXka8NpfcDiDXFZagS73D9RUBXV/2yuIkFit4XyzYcuEfLfGST/b2YCtnelJOR8kX3vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s8vp8ZVY; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8vp8ZVY"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-459bf19e87bso2164542f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 07:20:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779200433; cv=none;
        d=google.com; s=arc-20240605;
        b=G8Cdh5FTnIax2I9UC/f1SL/OGlcSsKs6xTtDvbxeXj2c9RNEzmFwMNsy5lIS1K07Ft
         VFkscuqjKHot9O5fkwyxa4DXAVZoY4T8zGUf/ydfYxbaQWD07S34WyTE3Xn+lJIw464s
         UYe6YlzPOJK7slysTxhztr3qJKtDHieHOcn22k+YJgLms97zUG6/I/Dz0Qw2bcoCFxPL
         cDaj1o4DcN+zKK6q2zZC7GUrqxTbOLSu4h8mSuQelseqQtswIjrQrbg3z25qYvdMeyh5
         zl/fJVYbPjBLXLg9wFTJw9CntlSUhhmW6huVksPbnd4oa6/NhSIi0N4U0v+gaMdz6sCs
         uWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z67ptMys+N0txKzsrvuO8uwf/yKTvhIujA1K1RnDdTw=;
        fh=qr9ZGhL+y6nsWY0Kc17+AXlE2YdBcriwoVuZcD0PEQ8=;
        b=Apan3q7MMWytjRCa0Ijr6zrlRarnIfwS3seWV4pgBRylmWe+iiLoloDTeCSxgqIt9/
         l+gtYOR3w7SfOFbJuZYOdISdJMcAs4mixzSP/G6/ay7lUs/Ccpmt6Q5+0ZfuaLDrEIld
         RTWyWnW/M7vssx+Zxlt3lnRc0YIswVnrVw9I385DxHRdcDP1tWrwwvZdBagpgjb4JYWe
         YcR+1Q7MyIRoWn3059PWuNei2sot1yor8RF4XH7VDKOMvSEEdtXAeGvmwD4oAUL3Qudj
         n52exDHV6C9Nd35O/s+yU9ZkyZ9ljVrPGOSuMYmaWMt5fa50QZpT/EWcjYFG6RhsKIvg
         SsIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779200433; x=1779805233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z67ptMys+N0txKzsrvuO8uwf/yKTvhIujA1K1RnDdTw=;
        b=s8vp8ZVYR/fSne0mQ7gNTtZ4bfkXz4O6dbxZzQZurj6U79oAFHHHwNu7GYZAvpAq64
         M/qcn184r7hyzRthjPoiGfYVG/PwT99Pt3gvv4UmW13JlmItTn7gkQnMsnfsj/gZOhsH
         oq9CYJy9xZJS5t3jxUf8LElukiyewm4rXlPHxmkmWwBqsq5Z4Z0kU9u8B3L2u+QIPbhJ
         i2L+OkwACuFCMh8aEhrBdKoj7BGSjB9uEdobRQetIPF48RzXpsjOn4r/K7CYCuWBjI3n
         iygHfvqs8d1vhH5YtPGtfHRz1ZpQKJUQZBavKPhcPsq1rqXR3xn8ZKnn9qsNruLBK2Rb
         CFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779200433; x=1779805233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z67ptMys+N0txKzsrvuO8uwf/yKTvhIujA1K1RnDdTw=;
        b=Ry0qR49JovjO0tGURuCyYHBHTgvo9qLuBAGDwuFOcIfdIFSzSV+OBG9ysVvIlwaffN
         Omg2CDeOoIMBxpZ0P+Vwd+lD3Jjvpf6d711wrD3TCpONkVMz0lK8Q2eL6k2RzjIICvjq
         KUVyIeGgu1DLcppxALr+agxt7OnYYA1v9EBlPi8O8+10DBfCiXiIAZHltWiFyKYFtHbj
         ebigJoe2RrEpV7ocmM9aqH+HvEsujHkoMZ6rbx1lyzew0B7v+iwv4ertLrpglbPE5PNj
         FJoiS+ZYvLahE5x2rt+nJoxZKfXxGLIbZlghtSBxrU3aaZ66L5ZJeaMxrk5DchfMd2CT
         mDdw==
X-Forwarded-Encrypted: i=1; AFNElJ8weXNwQmbdvhj9AjeQG8QPl4Lx97X72E0m1rBLUtJm3MtIf0dqs/nL5Yzshy17pGeDtId9SewgpLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDNqZj0Krh41mHo0ex6SaoQAMWbGir10Q8Qi+EZZK4XwZLbGPD
	CTB/8Gn1jFf/T5HutLuoC4Zt3CfhHN0qzJj8woL7lcf7zl2839BmZZj6nnaaT9bntzqpEQpcmZQ
	IHCv4FCja/4drcQX/5EoyS3bxyUVpgkc=
X-Gm-Gg: Acq92OF5A/zt71zhb7bkjc9a5zSg7YHaPz1FIxHMRYp1CdVe3LeE6nqncvU8LtIsjgg
	QHm91o7/iaW9V0v4hbT9BYHfCzQACfBV59SCwxL1cvWi+trYb/vPF4StHlMK4Glu3kHtxcmu3U/
	R9JCN0zLd0jTioZjRxN9ynm5yKyr0pcrLKrzGNxyChvogcOSG3LganYGWUwxckMj5T8khNmdYaY
	LO6Hk2w+hbdwxcOkQ1PKDVVp2o4F7DyKiCdcEqwcVNuyfXutJvpggaD69NnYwCeco6ko8MphQb6
	DZ1ERvl8CgR5iHGsSC28pcQF3g5r2rBHQrb1MmDExTTSBmOB1iCsw8szogBFeTjP6OTnmJK/ypm
	oyXhRWgMOtKk1m85TYs+QacljHy+I+oi53l0zkfQFbjH2Gcb8H/RahvscdGbUKRBVZLPBR1NIpV
	trZZjrMg==
X-Received: by 2002:a5d:5f44:0:b0:45d:3a84:709c with SMTP id
 ffacd0b85a97d-45e5c5ccac2mr31715019f8f.31.1779200432677; Tue, 19 May 2026
 07:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519140624.1585534-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20260519140624.1585534-2-u.kleine-koenig@baylibre.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 19 May 2026 16:20:19 +0200
X-Gm-Features: AVHnY4LlDW3ubSlPMx0c7gHoDozmlrUrvwNJTXT5K8k4JAnzlwn3Y8_StWRJIeE
Message-ID: <CALoEA-xV3nNhrJsNL7Ge_ym04FMHM+BsTADrriAMKAjpqm4BVw@mail.gmail.com>
Subject: Re: [PATCH v1] staging: iio: Use named initializers for struct i2c_device_id
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 19 May 2026 at 16:17, Uwe Kleine-K=C3=B6nig (The Capable Hub)
<u.kleine-koenig@baylibre.com> wrote:
>
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
>
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

--=20
Kind regards

CJD
