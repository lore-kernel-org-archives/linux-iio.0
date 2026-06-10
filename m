Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C427030677C
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099905; cv=pass; b=d4Ua3n/UeGgZdEvCccHVCOmc1xnNjK0KAHhiBmQabZoKbNhW8UgrRCOlbJQV4uFLhIz8Bz4QzXqA0Hq/M2512ybtJdBEVfeQ12janM4pMEczlq0m8WjTfuahmY6mTNH4GFTJc1KvppO5Q9F/ivWlC4EXTFmTWlbosJgZEt+WeP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099905; c=relaxed/simple;
	bh=6bo5qaN+sb+n3zBsBIGPgiy/2ousoOA99O108bQjhi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCJGX5sJmVlsuOuToJ3X8bnOOaUCbh4jFpbxWWCz3OCE+9PhJ5hq4Jt4eWRNbekVY2MxVjRVN+yJuk+lTOpRqJhsR2kXYmZ/eZGCBSq3pxob6v4Robox7GZBMPTCvN5ShiB57DCtGx8V6j2RM5FjDurKwZf0uu8pQlgf7h0vSBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n3pR2mot; arc=pass smtp.client-ip=209.85.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3pR2mot"
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-69e4af5a411so4226189eaf.1
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 06:58:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781099903; cv=none;
        d=google.com; s=arc-20240605;
        b=Enu3WAGl1gzo8FWEIlkFjmll5Ds4DepGcYf3SAsghKvzAADBpenSYt3a58gZMVTar9
         /RQwaMOmHqm8uwGwfOJBJZusawYdUeyM/hNcLEGxiND20B/ILVDHQknrN8Zz8HNrBk/d
         6QzpKDVzbwfhRj5cCO85j06TQPpYuvWzG0d7F3shnCj2jd6Wb7Fkx13Jyhw75JHnXEf3
         E9EAu/OReaj+1Gp6yOiw9OR53YUZgeFlDdpSiUYa0f9mVQXc2uTJ/btGcSI3EyUppmwP
         DL4C3I782TimYdvTCNCZSAajQm3ZBBZJpyBzN26vVdXG+Qsc2vmzAEnvaKEEzsFD5ysy
         GxFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Oc5Xp82BE2Wh/LRPm7K3Pua7mW/wTv78fxvZS07Wmrw=;
        fh=fdi7/S97c1zRnjRniz6DMGSGVfY+LIU6fr6qjKQGYsc=;
        b=R5eJEstx8NnbABgrIWzLA2HP99Zs3gX21YBufCgQ9hLEAaWEPyBtNDSj8U8+YfPDoy
         15xmnPF/rDYWlpHchuCG1bktJ/48uG76X7EHyKRnOMjt8PSn/bkS2Nr077yMPVZ8hdfu
         YvBdwgTiGkMVX+UHGUwa92XYlzyvJ+atU25qznVY74Wf6Jyyt9h/CHVKepzsAAC1sQ8U
         1TpQ9HbqtrXnAzgJoUVSBf3SXTalNl4GQQto/0vgeTMRmvPslFt2hCzlIZMJZj2gKsXu
         1JTiGEz3kj3UmXxI2+hELK2PAQTGTZyqS++3rMV86SjJN1CGmy6DAkOXOKTdin29NNUM
         WkZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781099903; x=1781704703; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Oc5Xp82BE2Wh/LRPm7K3Pua7mW/wTv78fxvZS07Wmrw=;
        b=n3pR2motl/esQ8c9k4Z8e65dYNewpftAHhIe97P3SBzz+h+DXCyTpS9r87/EgothWW
         qUALDKf7R3LV/qhxj5Irlt2VRDxNol6W7ZjqumIRHMb5aLdlcZbdCEwpH4kMcHgYNKC1
         raPHtr1h6c7GXj6ti0c8a9rbLY2FyWaq/ZvULBVcbYi++yQTdkSbw2W40TtqbQYfV5PY
         tSwddZ3yGf6FWSMX0BRfaQhRiD2RlXDJzF01BZ9QXgor6Ycy17xvCRk9MWOD3bgpQ6gn
         8exPoYkw3mdBLHKzkLzWUM5MZihAI3sHju6lxRsZ5t1eQ29n12HRn69PlWL5DFFj903J
         uXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781099903; x=1781704703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oc5Xp82BE2Wh/LRPm7K3Pua7mW/wTv78fxvZS07Wmrw=;
        b=NjHscbqjq81NquT9uoC8gWVrSZ+dlAwthhjOs8JKVKRsltSMaTfL2tjRCXlBuz5pZC
         YBgExiqsEXl2LfjV6fW0k7EpnCkcJ9pr2w8IR4aLd+T3loMLtG1sBEPW60ngCWA9J9J5
         7amXBVa0CId4Icl+PmVV1WlGNKHuFN8QVFIRfmI7cJx7VUeKL35nChWEAf4dZ6hXENxK
         HvEMEmDt+Bcytu6BnpYJ50vrjn+qX9HCoooqQkQbvq7FDysecppEn5Gw3lkbZrdBY0qa
         YdGcwMWf+O/v/BN3oty7N34qcWqIEatBH7jVfVqG1sG0bY8ysae2hz/OWz4UbHE2bVLZ
         eAFg==
X-Forwarded-Encrypted: i=1; AFNElJ8rok3hzfaZ+yaLSpq+/VF4g+aODaVuSrO6V9PE/7Wzwxuf1ZbOQASUEl9yr9p1jid+NqiucDa2GjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwafoytmOj+TFyqA19VLee60pwfuC3bMUkld9F7V1s9BAIeVAUT
	fLoeSM2rSf55CC3cO3rxQUzpuREHWuMxfdf1AIOJDUZJSEtGtiVQAD8ociROfS5DlFrPMeyAJJQ
	jOHZqyD3DE0FrbBeYLJZaQs/RdT1RvB8=
X-Gm-Gg: Acq92OEbXyKTDVHBIr5SwvdDCMBBmdWmvBUNZX4WWmM2XGG0x/THsp4Y8N3Rjk00kRw
	Sut3WJ95y9XWm2ppdombAxYBp8fd7lPS4XUH3gI/SdF5QLedOWH/YywxhHu5flogsGDXQgTHGGg
	4nkfnQsXJoInplWgrSPrFWiZCqWw5CwYWOMSlV1+0i70uyjEVGshwucnoj5EwkMEzzFqrJaN6PY
	cjPMPxANc6+Sjx/I/tNcm0jWA6e6bc+RL+6vp2BjNWCvPTMdFWA3ix8lRYQrXAZRHKzlJR28s0z
	wv7Oof+H7XXMxLM6pTP+2ykZnwtvuZ5pWUsZCr6Vk6l8NyKsRYLz5SXhymARwlw=
X-Received: by 2002:a05:6820:168b:b0:69e:49de:680d with SMTP id
 006d021491bc7-69e68b0b23bmr14017044eaf.7.1781099902668; Wed, 10 Jun 2026
 06:58:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610042418.90308-1-dennylin0707@gmail.com>
 <20260610042418.90308-3-dennylin0707@gmail.com> <ailC8uhCen4dQNF_@ashevche-desk.local>
In-Reply-To: <ailC8uhCen4dQNF_@ashevche-desk.local>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Wed, 10 Jun 2026 06:58:11 -0700
X-Gm-Features: AVVi8Cfpk-CpMyj7_9m5PWkL5ZDm2caFkS34BLZ-aukWV899Ihug6NFgroQxdvY
Message-ID: <CAGEkeHfFjEtf9e6vkEKO8WjorsETsfoVAhzgKnSpq5VmzeNG-w@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: magnetometer: bmc150: use FIELD_PREP and
 FIELD_GET helpers
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > -     odr_val = (reg_val & BMC150_MAGN_MASK_ODR) >> BMC150_MAGN_SHIFT_ODR;
> > +
> > +     odr_val = FIELD_GET(BMC150_MAGN_MASK_ODR, reg_val);
>
> Same comment as per previous few versions. I don't understand why you haven't
> addressed it. Did I miss your reply on this?

You didn't miss it.

After sending v4, I noticed that the blank line issue had not
actually been fixed and sent v5 shortly afterwards.

The include grouping issue you pointed out was then addressed
in v6.

Thanks,
Hungyu
